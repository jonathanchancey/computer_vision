% AUTHOR: Jonathan Chancey
% EMAIL: jchancey@ucmerced.edu

% start by closing all figures
close all
% continue by clearing everything to ensure clean runs
clear all

% % -=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-
% % Implement sobel_feature.m to compute gradient
% % magnitude and orientation from Sobel filtering
% % -=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-

imagename = "lena.jpg";
img = im2double(imread(imagename));
figure, imshow(img); title("Original Image")

[magnitude, orientation] = sobel_feature(img);

% it seems easier to see the effects by subtracting .5 from magnitude
% figure, imshow(magnitude - .5); title("magnitude Image")
figure, imshow(magnitude); title("magnitude Image")
imwrite(magnitude, 'magnitude_image.jpg');
figure, imshow(orientation); title("orientation Image")
imwrite(orientation, 'orientation_image.jpg');

threshold = 0.3;
e = magnitude > threshold;
e1 = edge(img, 'Sobel');
e2 = edge(img, 'Canny');

figure, imshow(e); title("e Image")
figure, imshow(e1); title("Sobel Image")
figure, imshow(e2); title("Canny Image")

imwrite(e1, 'sobel_image.jpg');
imwrite(e2, 'canny_Image.jpg');

% imwrite(gau, sprintf('Gaussian_%s_scale_%d.jpg', imagename, s));