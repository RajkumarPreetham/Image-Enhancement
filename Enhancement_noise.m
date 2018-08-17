%1) Image Enhancement 
clear all;
clc;

RGB = imread('brain.jpg');
figure(1)
subplot(2,2,1)
imshow(RGB)
title('Original image')

%Plotting a histogram of image based on intenstiy
subplot(2,2,2)
imhist(RGB);

%Linear scaling for contrast adjustment
s1=50;
s2=256;
r1 = min(RGB(:));  %minimum pixel of image RGB
r2 = max(RGB(:));
m = (s2-s1)/(r2-r1);
c = 255 - m*r2;       % find the intercept of the straight line with the axis
D = m*RGB + c; 

subplot(2,2,3)
imshow(D)
title('Linear scaling');
subplot(2,2,4)
imhist(D);

r = double(RGB)/255;              % normalise the image
c = 1;              % constant
gamma = 7;          % to make image dark take value of gamma > 1, to make image bright take vlue of gamma < 1
s = c*(r).^gamma;   % formula to implement power law transformation
figure(2)
subplot(2,2,1)
imshow(s)
title('Power Law Transformed Image');
subplot(2,2,2)
imhist(s);

%Histogram equalization
A = histeq(RGB);
subplot(2,2,3)
imshow(A)
title('Histogram Equalization')
subplot(2,2,4)
imhist(A)

%2)Noise Removal 
%Load the original image
I = imread('Ross.jpg');
B  = im2double(I);
figure(3)
imshow(B)
title('Original image');

b=medfilt2(B);
figure
imshow(b)
title('Median filter');

h = ones(5,5) / 25;
I2 = conv2(b,h);
figure;
imshow(I2); title('Averaging filter');

kernel = [-1, -1, -1; -1, 8, -1; -1, -1, -1]/ 9;
resp = conv2(double(I2), kernel, 'same');

%Normalize the response image
minR = min(resp(:));
maxR = max(resp(:));
resp = (resp - minR) / (maxR - minR);

%Adding to original image now
sharpened = I2 + resp;

% Normalize the result
minA = min(sharpened(:));
maxA = max(sharpened(:));
sharpened = (sharpened - minA) / (maxA - minA);
 
% Change - Perform linear contrast enhancement
c1=10/255;
c2=256/255;
l1 = min(sharpened(:));  %minimum pixel of image RGB
l2 = max(sharpened(:));
n = (c2-c1)/(l2-l1);
E = n*sharpened ; 

figure;
imshow(resp); title('Laplacian filtered image');
figure;
imshow(E); title('Sharpened image');


