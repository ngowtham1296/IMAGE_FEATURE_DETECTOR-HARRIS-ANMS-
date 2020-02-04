clc;
clear all;
% read the image
global A alpha Sigma threshold Ix Iy metric1 x y R_m final_mat final_mat_rot x_cord_new y_cord_new count;
A=imread('box.bmp');
alpha=0.06;
Sigma=0.5;                 
threshold=900000000;         % thresholding value
%% Problem (2): Harris detector
H=Harris_detector();
%% Problem (3): Adaptive non maximal suppression
final_mat=ANMS();

%% plot (3)&(4)
% Harris_detector
figure(1)
subplot(2,2,1);imshow(A);title('Original Image');
subplot(2,2,2);imshow(Ix);title('Ix');
subplot(2,2,3);imshow(Iy);title('Iy');
subplot(2,2,4);imshow(A);hold on;plot(x, y, 'r*', 'LineWidth', 1, 'MarkerSize', 2); title('harris feauture');

% Adaptive non maximal suppression
figure(2)
subplot(2,2,1);imshow(A); title('Original Image')
subplot(2,2,2);imshow(uint8(final_mat)); title('Final image after ANMS')
subplot(2,2,3);imshowpair(final_mat,uint8(metric1(3:size(R_m,1)-2, 3:size(R_m,2)-2)),'montage');title('montage');
subplot(2,2,4);imshowpair(final_mat,uint8(metric1(3:size(R_m,1)-2, 3:size(R_m,2)-2)),'diff');title('diff');

%% Problem (4)&(5)
A=imrotate(A,45);

% Harris detector
G=Harris_detector();

% Adaptive non maximal suppression 
final_mat_rot=ANMS_rot();

%% plot (4)&(5)
% Harris_detector
figure(3)
subplot(2,2,1);imshow(A);title('Original Image');
subplot(2,2,2);imshow(Ix);title('Ix');
subplot(2,2,3);imshow(Iy);title('Iy');
subplot(2,2,4);imshow(A);hold on;plot(x, y, 'r*', 'LineWidth', 1, 'MarkerSize', 2); title('harris feauture');

% Adaptive non maximal suppression
figure(4)
subplot(2,2,1);imshow(A); title('Original Image')
subplot(2,2,2);imshow(uint8(final_mat_rot)); title('Final image after ANMS')
subplot(2,2,3);imshowpair(final_mat_rot,uint8(metric1(3:size(R_m,1)-2, 3:size(R_m,2)-2)),'montage');title('montage');
subplot(2,2,4);imshowpair(final_mat_rot,uint8(metric1(3:size(R_m,1)-2, 3:size(R_m,2)-2)),'diff');title('diff');

%% Problem (6)
[x_cord_new, y_cord_new]=func();   % func which matches the feautures
% plot
A=imread('box.bmp');
figure (5);imshow(A);
hold on;plot(x_cord_new, y_cord_new, 'r*','LineWidth', 2, 'MarkerSize', 1);title('Problem (6)');
fprintf('The number of common feautres are');
disp(count);