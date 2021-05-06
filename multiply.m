function result = multiply(A,B)
%有限域上的乘法
    m = [1 0 0 0 1 1 0 1 1];
    str_A = dec2bin(A,8);
    str_B = dec2bin(B,8);
    p_A = zeros(1,8);
    p_B = zeros(1,8);
    for i = 1:8
        p_A(i) = str2num(str_A(i));
        p_B(i) = str2num(str_B(i));
    end
    product = conv(p_A,p_B);
    product(find(mod(product,2) == 0)) = 0;
    product(find(mod(product,2) == 1)) = 1;
    [~,remainder] = deconv(product,m);
    remainder(find(mod(remainder,2) == 0)) = 0;
    remainder(find(mod(remainder,2) == 1)) = 1;
    result_str = num2str(remainder);
    result = bin2dec(result_str);
end