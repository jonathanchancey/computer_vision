% AUTHOR: Jonathan Chancey
% EMAIL: jchancey@ucmerced.edu

% start by closing all figures
close all
% continue by clearing everything to ensure clean runs
clear all

% % -=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-
% % 1, 2, and 3. Implement separate_frequency.m and save images with 
% % ratio 0.1 and 0.2
% % -=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-

% load image
img = im2double(imread('lena.jpg')); 
figure, imshow(img); title("Original Image")

RATIO = 0.1;
[low_pass_img, high_pass_img] = separate_frequency(img, RATIO);

figure, imshow(low_pass_img); title("lena\_low\_0.1")
figure, imshow(high_pass_img + 0.5); title("lena\_high\_0.1")

imwrite(low_pass_img,"lena_low_0.1.jpg")
imwrite(high_pass_img,"lena_high_0.1.jpg")

RATIO = 0.2;
[low_pass_img, high_pass_img] = separate_frequency(img, RATIO);

figure, imshow(low_pass_img); title("lena\_low\_0.2")
figure, imshow(high_pass_img + 0.5); title("lena\_high\_0.2")

imwrite(low_pass_img,"lena_low_0.2.jpg")
imwrite(high_pass_img,"lena_high_0.2.jpg")

% % -=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-
% % 4. Implement hybrid_image.m
% % -x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-

% load image
mari = im2double(imread('marilyn.jpg'));
eins = im2double(imread('einstein.jpg'));

ratio = 0.1;

img_merged = hybrid_image(mari, eins, ratio);
figure, imshow(img_merged); title("img_merged")
imwrite(img_merged,"hybrid_1.jpg")

img_merged_2 = hybrid_image(eins, mari, ratio);
figure, imshow(img_merged_2); title("img_merged")
imwrite(img_merged_2,"hybrid_2.jpg")


% -=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-
% Function Defs
% -=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-

