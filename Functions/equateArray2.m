function [output1,output2] = equateArray2(input1,input2)

if numel(input1) ~= numel(input2)

    n1 = numel(input1);
    n2 = numel(input2);

    if n1 > n2

        input1(n2+1:end) = [];
        output1 = input1;
        output2 = input2;

    end

    if n2 > n1

        input2(n1+1:end) = [];
        output2 = input2;
        output1 = input1;

    end

else

    output1 = input1;
    output2 = input2;

end

end