path = 'input';
I1 = imread(strcat(path,'/','cuadro_1','.jpg')); 
I2 = imread(strcat(path,'/','cuadro_2','.jpg')); 

I1 = rgb2gray(I1);
I2 = rgb2gray(I2);



% ventana n = 1
%optical_flow_lk(I1,I2,1);


% ventana n = 3
%optical_flow_lk(I1,I2,3);

% ventana n = 9
%optical_flow_lk(I1,I2,9);

% ventana n = 21
%optical_flow_lk(I1,I2, 21);



function x = optical_flow_lk(I1,I2,n)
    %Mascaras
    dx = 1/4 * fspecial('sobel');
    dy = 1/4 * fspecial('prewitt');

    tau = 1;

    c1 = 0.25 * [1 1; 1 1];
    c2 =  -0.25 * [1 1; 1 1];


    It = conv2(I1,c1);
    It1 = conv2(I2,c2);


    %Derivadas Parciales
    Idx = conv2(I1,dx); %parcial en x
    Idy = conv2(I1,dy); %parical en y
    Idt = It + It1;     %parial en t



    vx = zeros(size(I1));
    vy = zeros(size(I1));

    % within window ww * ww
    for i = n+1:size(Idx,1)-n
       for j = n+1:size(Idx,2)-n
          Ix = Idx(i-n:i+n, j-n:j+n);
          Iy = Idy(i-n:i+n, j-w:j+n);
          It = Idt(i-n:i+n, j-w:j+n);

          Ix = Ix(:);
          Iy = Iy(:);
          b = -It(:); %obtiene b

          A = [Ix Iy]; % matriz A
          nu = pinv(A)*b; % velocidad

          vx(i,j)=nu(1);
          vy(i,j)=nu(2);
       end
    end
    
    
    % get coordinate for u and v in the original frame
    [m, n] = size(I1);
    [X,Y] = meshgrid(1:n, 1:m);
    X_deci = X(1:20:end, 1:20:end);
    Y_deci = Y(1:20:end, 1:20:end);
    
    
    x = 0;
end

%Display the OF as a plot of vectors
function display_plot(Vx,Vy)
    figure
    axis equal
    quiver(impyramid(impyramid(medfilt2(flipud(Vx), [5 5]), 'reduce'), 'reduce'), -impyramid(impyramid(medfilt2(flipud(Vy), [5 5]), 'reduce'), 'reduce'));
end