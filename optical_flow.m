path = 'input';
I1 = imread(strcat(path,'/','cuadro_1','.jpg')); 
I2 = imread(strcat(path,'/','cuadro_2','.jpg')); 

I1 = rgb2gray(I1);
I2 = rgb2gray(I2);


F1 = 1/4 * fspecial('sobel');

F2 = 1/4 * fspecial('prewitt');




C1 = conv2(I1,F1);
C2 = conv2(I2,F2);

Dt = I1-I2;

I1 = I1(:);

%D = gradient(I1);
%Least squares with first derivative equals zero
function W = getOptimumW(x, t, M)
    c = 1;
    %build matrices A and B
    %iteration for each row
    for m = M : 2*M
        %iterates each equation i
        B(c,1) = sum(t .* x .^ (c - 1));
        w = 1;
        %1.m = M
        %2.m = M + 1
        %iteration for each column
        for k = m - M:m
            %1.1 k = M-M=0
            %1.2 k = 1
            %1.3 k = 2 ....
            %2.1
            A(c, w) = sum(x .^ k);
            w = w + 1;
        end
        c = c + 1;
    end
    %solve the linear system, si hay singularidades puede reventar
    W = linsolve(A,B);
end