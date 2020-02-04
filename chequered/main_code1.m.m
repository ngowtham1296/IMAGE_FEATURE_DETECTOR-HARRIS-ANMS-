%% PROBLEM1 
clc
clear all;
global x_cord_new y_cord_new x_cord_rot_new y_cord_rot_new final_mat_rot final_mat count
% Read the image
Im=imread('chessboard.png');
A=rgb2gray(Im);
alpha=0.06;                % constant for auto correlation matrix
Sigma=0.5;                 % sigma value for gaussian kernel
threshold=9000000;         % thresholding value

%% Problem (2): Harris_Detector
% the derivative kernel dx and dy
[dx,dy]=meshgrid(-2:2 , -2:2 );

% convolution
Ix=convolve(double(A),dx)
Iy=convolve(double(A),dy)
size(Ix)
% Gaussian kernel
Gaussian_kernel=gaussian_kernel(Sigma);

% harris detector
% entities in the M matrix
I_x=convolve(Ix.^2,Gaussian_kernel);
I_y=convolve(Iy.^2,Gaussian_kernel);
I_xy=convolve(Ix.*Iy,Gaussian_kernel);

% Auto correlation matrix
Auto_Matrix=[I_x I_xy;
    I_xy I_y];

% Metric value
R_m= ((I_x .* I_y)-(I_xy.^2))-alpha*(I_x + I_y);


% finding local maxima of the points 
p = 1;

for i = 3:size(Ix, 1) - 2 
    for j =  3:size(Ix, 2) - 2
        if( R_m (i, j)>threshold)
            metric1(i,j) = R_m(i , j);
             x(p) = i;
             y(p) = j;
             p = p+1;
        else
            metric1(i , j) = 0;
        end
    end
end
%% Problem (3): Adaptive non maximal Suppession
final_mat=ANMS(metric1);

%% Problem (3) & (4) plots
% Harris detector 
figure(1)
subplot(2,2,1);imshow(metric1);title('Original Image');
subplot(2,2,2);imshow(Ix);title('Ix');
subplot(2,2,3);imshow(Iy);title('Iy');
subplot(2,2,4);imshow(Im);hold on;plot(x, y, 'r*', 'LineWidth', 1, 'MarkerSize', 3); title('harris feauture');
% Adaptive non maximal Suppession
figure(2)
subplot(2,2,1);imshow(Im); title('Original Image')
subplot(2,2,2);imshow(uint8(final_mat)); title('Final image after ANMS')
subplot(2,2,3);imshowpair(final_mat,uint8(metric1(3:size(R_m,1)-2, 3:size(R_m,2)-2)),'montage');title('montage');
subplot(2,2,4);imshowpair(final_mat,uint8(metric1(3:size(R_m,1)-2, 3:size(R_m,2)-2)),'diff');title('diff');

%% Problem (4) & (5): rotate and perform steps 2 and 3
B=imrotate(A,45);

% Harris_Detector
% the derivative kernel dx and dy
[dx,dy]=meshgrid(-2:2 , -2:2 );

% convolution
Ix=convolve(double(B),dx);
Iy=convolve(double(B),dy);
size(Ix)
% Gaussian kernel
%Sigma=0.5;
Gaussian_kernel=gaussian_kernel(Sigma);

% harris detector
% entities in the M matrix
I_x=convolve(Ix.^2,Gaussian_kernel);
I_y=convolve(Iy.^2,Gaussian_kernel);
I_xy=convolve(Ix.*Iy,Gaussian_kernel);

% Auto correlation matrix
Auto_Matrix=[I_x I_xy;
    I_xy I_y];

% Metric
%alpha=0.06;
R_m= ((I_x .* I_y)-(I_xy.^2))-alpha*(I_x + I_y);


% finding local maxima of the points 
p = 1;

for i = 3:size(Ix, 1) - 2 
    for j =  3:size(Ix, 2) - 2
        if( R_m (i, j)>threshold)
            metric1(i,j) = R_m(i , j);
             x(p) = i;
             y(p) = j;
             p = p+1;
        else
            metric1(i , j) = 0;
        end
    end
end
% Adaptive non maximal Suppession
final_mat_rot=ANMS_rot(metric1);

%% Problem (4) & (5) plots:
% Harris detector 
figure(3)
subplot(2,2,1);imshow(B);title('Original Image rotated by 45 degree ');
subplot(2,2,2);imshow(Ix);title('Ix');
subplot(2,2,3);imshow(Iy);title('Iy');
subplot(2,2,4);imshow(B);hold on;plot(x, y, 'r*', 'LineWidth', 1, 'MarkerSize', 3); title('harris feauture');
% Adaptive non maximal Suppession
figure(4)
subplot(2,2,1);imshow(B); title('Original Image roatated by 45 degree')
subplot(2,2,2);imshow(uint8(final_mat_rot)); title('Final image after ANMS')
subplot(2,2,3);imshowpair(final_mat_rot,uint8(metric1(3:size(R_m,1)-2, 3:size(R_m,2)-2)),'montage'); title('montage');
subplot(2,2,4);imshowpair(final_mat_rot,uint8(metric1(3:size(R_m,1)-2, 3:size(R_m,2)-2)),'diff'); title('diff');

%% Problem (6):
% Feautre matching with original and rotated image
[x_cord_new,y_cord_new ]=func();       % function which calculates feauture matching

figure (5);
imshow(Im);
hold on;
plot(x_cord_new, y_cord_new, 'r*','LineWidth', 2, 'MarkerSize', 3);title('Problem (6): Feauture matching');
