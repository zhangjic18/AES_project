function output = g(input,Rconj)
%input为一个4*1的矩阵，10进制
%Rconj为一个4*1的矩阵，10进制
    input = input';
    input_shift_left = line_shift(input,1,1);
    input_byte_substitute = byte_substitute(input_shift_left,1);
    input_byte_substitute = uint8(input_byte_substitute);
    output = bitxor(input_byte_substitute',Rconj,'uint8');
end

