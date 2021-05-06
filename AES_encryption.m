function ciphertext = AES_encryption(plaintext,password)
%AES加密函数，要求输入明文比特流plaintext长度为128*n，密码比特流password长度为128
%要求比特流为行向量，例如 plaintext = randi([0,1],1,128);password = randi([0,1],1,128);
    n = length(plaintext)/128;
    ciphertext = zeros(size(plaintext));
    password_matrix = zeros(4,4);
    for j = 1:16
            password_fragment = num2str(password((j-1)*8+1:j*8));
            password_matrix(j) = bin2dec(password_fragment);
    end
    
    for i = 1:n
        plaintext_block = plaintext((i-1)*128+1:i*128);
        ciphertext_block = ciphertext((i-1)*128+1:i*128);
        plaintext_block_matrix = zeros(4,4);
        for j = 1:16
            text_fragment = num2str(plaintext_block((j-1)*8+1:j*8));
            plaintext_block_matrix(j) = bin2dec(text_fragment);
        end
        ciphertext_block_matrix = AES_encryption_part(plaintext_block_matrix,password_matrix);
        ciphertext_block_vector = reshape(ciphertext_block_matrix,16,1);
        ciphertext_block_vector_str = dec2bin(ciphertext_block_vector,8);
        for m = 1:16
            for n = 1:8
                ciphertext_block((m-1)*8+n) = str2num(ciphertext_block_vector_str(m,n));
            end
        end
        ciphertext((i-1)*128+1:i*128) = ciphertext_block;
    end

end

function ciphertext_block_matrix = AES_encryption_part(plaintext_block_matrix,password_matrix)
%plaintext_block_matrix为一个4*4的矩阵，10进制
%password_matrix为一个4*4的矩阵，10进制
    %ciphertext_block_matrix = plaintext_block_matrix;
    
    expanded_key = expand_key(password_matrix);
    expanded_key = uint8(expanded_key);
    plaintext_block_matrix = uint8(plaintext_block_matrix);
    password_matrix = uint8(password_matrix);
    plaintext_preprocess = bitxor(plaintext_block_matrix,password_matrix,'uint8');
    plaintext = plaintext_preprocess;
    for round_number = 1:9
        plaintext_1 = byte_substitute(plaintext,1);
        plaintext_2 = line_shift(plaintext_1,[0;1;2;3],1);
        plaintext_3 = mix_column(plaintext_2);
        plaintext_3 = uint8(plaintext_3);
        plaintext_4 = bitxor(plaintext_3,expanded_key(:,(round_number-1)*4+1:round_number*4),'uint8');
        plaintext = plaintext_4;
    end
    
    plaintext_1 = byte_substitute(plaintext,1);
    plaintext_2 = line_shift(plaintext_1,[0;1;2;3],1);
    plaintext_2 = uint8(plaintext_2);
    ciphertext_block_matrix = bitxor(plaintext_2,expanded_key(:,(10-1)*4+1:10*4),'uint8');
    
end