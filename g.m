function output = g(input,Rconj)
%inputΪһ��4*1�ľ���10����
%RconjΪһ��4*1�ľ���10����
    input = input';
    input_shift_left = line_shift(input,1,1);
    input_byte_substitute = byte_substitute(input_shift_left,1);
    input_byte_substitute = uint8(input_byte_substitute);
    output = bitxor(input_byte_substitute',Rconj,'uint8');
end

