function output = line_shift(input,distance,flag)
%行移位
%flag == 1:正变换；flag == -1:逆变换
    output = zeros(size(input));
    for i = 1:size(input,1)
        output(i,:) = vector_shift(input(i,:),distance(i),flag);
    end
end

function output_vector = vector_shift(input_vector,distance,flag)
%行移位函数调用的子函数
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