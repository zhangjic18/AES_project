function output = byte_substitute(input,flag)
%字节代换操作
%flag == 1:正变换；flag == -1:逆变换
    if flag == 1
        load('S.mat');
        S_or_inverse_S = S;
    else
        load('inverse_S.mat');
        S_or_inverse_S = inverse_S;
    end

    
    output = zeros(size(input));
    for i = 1:size(input,1)
        for j = 1:size(input,2)
            initial_number = input(i,j);
            number_str = dec2hex(initial_number,2);
            final_number = S_or_inverse_S(hex2dec(number_str(1))+1,hex2dec(number_str(2))+1);
            output(i,j) = final_number;
        end
    end
end