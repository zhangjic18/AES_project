function output = line_shift(input,distance,flag)
%����λ
%flag == 1:���任��flag == -1:��任
    output = zeros(size(input));
    for i = 1:size(input,1)
        output(i,:) = vector_shift(input(i,:),distance(i),flag);
    end
end

function output_vector = vector_shift(input_vector,distance,flag)
%����λ�������õ��Ӻ���
    if flag == 1
        vector = [input_vector input_vector];
        for i = 1:length(input_vector)
            vector(i) = vector(i+distance);
        end
        output_vector = vector(1:length(input_vector));
    else
        vector = [input_vector input_vector];
        for i = 2*length(input_vector):-1:length(input_vector)+1
            vector(i) = vector(i-distance);
        end
        output_vector = vector(length(input_vector)+1:2*length(input_vector));
    end
end