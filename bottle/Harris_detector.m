function metric1=Harris_detector()
global A alpha Sigma threshold metric1 Ix Iy  x y R_m;
% the derivative kernel dx and dy
[dx,dy]=meshgrid(-2:2 , -2:2 );

% convolution
Ix=convolve(double(A),dx);
Iy=convolve(double(A),dy);

% Gaussian kernel
%Sigma=0.5;
Gaussian_kernel=gaussian_kernel(Sigma);

% harris detector
% entities in the M matrix
I_x=convolve(Ix.^2,Gaussian_kernel);
I_y=convolve(Iy.^2,Gaussian_kernel);
I_xy=convolve(Ix.*Iy,Gaussian_kernel);

% Auto correlation matrix
A_Matrix=[I_x I_xy;
    I_xy I_y];

% Metric
%alpha=0.06;
R_m= ((I_x .* I_y)-(I_xy.^2))-alpha*(I_x + I_y);


% finding local maxima of the points 
%threshold = 90000000;    % thresholding value
p = 1;

for i = 3:size(Ix, 1) - 2 
    for j =  3:size(Ix, 2) - 2
        if( R_m (i, j)>threshold)
            metric1(i,j) = R_m(i , j);
             %value(p, 1) = metric(i, j);
             x(p) = i;
             y(p) = j;
             p = p+1;
        else
            metric1(i , j) = 0;
        end
    end
end
end 