function output_matrix = inverse_mix_column(input_matrix)
%ÁÐ»ìºÏÄæ±ä»»
    inverse_mix_matrix = [0x0e 0x0b 0x0d 0x09;
                          0x09 0x0e 0x0b 0x0d;
                          0x0d 0x09 0x0e 0x0b;
                          0x0b 0x0d 0x09 0x0e];
    input_matrix = int64(input_matrix);
    load('multiplication_table.mat');
    output_matrix = zeros(size(input_matrix));
    for i = 1:size(input_matrix,1)
        for j = 1:size(input_matrix,2)
            result_part1 = bitxor(multiplication_table(inverse_mix_matrix(i,1),input_matrix(1,j)+1),multiplication_table(inverse_mix_matrix(i,2),input_matrix(2,j)+1),'uint8');
            result_part2 = bitxor(multiplication_table(inverse_mix_matrix(i,3),input_matrix(3,j)+1),multiplication_table(inverse_mix_matrix(i,4),input_matrix(4,j)+1),'uint8');
            output_matrix(i,j) = bitxor(result_part1,result_part2,'uint8');
        end
    end
end