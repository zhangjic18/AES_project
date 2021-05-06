function plaintext = AES_decryption(ciphertext,password)
%AES解密函数，要求输入密文比特流ciphertext长度为128*n，密码比特流password长度为128
%要求比特流为行向量，例如 ciphertext = randi([0,1],1,128);password = randi([0,1],1,128);
    n = length(ciphertext)/128;
    plaintext = zeros(size(ciphertext));
    for i = 1:n
        ciphertext_block = ciphertext((i-1)*128+1:i*128);
        plaintext_block = plaintext((i-1)*128+1:i*128);
        ciphertext_block_matrix = zeros(4,4);
        password_matrix = zeros(4,4);
        for j = 1:16
            text_fragment = num2str(ciphertext_block((j-1)*8+1:j*8));
            ciphertext_block_matrix(j) = bin2dec(text_fragment);
            password_fragment = num2str(password((j-1)*8+1:j*8));
            password_matrix(j) = bin2dec(password_fragment);
        end
        plaintext_block_matrix = AES_decryption_part(ciphertext_block_matrix,password_matrix);
        plaintext_block_vector = reshape(plaintext_block_matrix,16,1);
        plaintext_block_vector_str = dec2bin(plaintext_block_vector,8);
        for m = 1:16
            for n = 1:8
                plaintext_block((m-1)*8+n) = str2num(plaintext_block_vector_str(m,n));
            end
        end
        plaintext((i-1)*128+1:i*128) = plaintext_block;
    end

end


function plaintext_block_matrix = AES_decryption_part(ciphertext_block_matrix,password_matrix)
%ciphertext_block_matrix为一个4*4的矩阵，10进制
%password_matrix为一个4*4的矩阵，10进制
    %ciphertext_block_matrix = plaintext_block_matrix;
    expanded_key = expand_key(password_matrix);
    expanded_key = uint8(expanded_key);
    ciphertext_block_matrix = uint8(ciphertext_block_matrix);
    password_matrix = uint8(password_matrix);
    
    ciphertext_preprocess = bitxor(ciphertext_block_matrix,expanded_key(:,40-3:40),'uint8');
    ciphertext = ciphertext_preprocess;
    for round_number = 9:-1:1
        ciphertext_1 = line_shift(ciphertext,[0;1;2;3],-1);
        ciphertext_2 = byte_substitute(ciphertext_1,-1);
        ciphertext_2 = uint8(ciphertext_2);
        ciphertext_3 = bitxor(ciphertext_2,expanded_key(:,(round_number-1)*4+1:round_number*4),'uint8');
        ciphertext_4 = inverse_mix_column(ciphertext_3);
        ciphertext = ciphertext_4;
    end
    
    ciphertext_1 = line_shift(ciphertext,[0;1;2;3],-1);
    ciphertext_2 = byte_substitute(ciphertext_1,-1);
    ciphertext_2 = uint8(ciphertext_2);
    plaintext_block_matrix = bitxor(ciphertext_2,password_matrix,'uint8');
    
end