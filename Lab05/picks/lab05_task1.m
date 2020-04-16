% AUTHOR: Jonathan Chancey
% EMAIL: jchancey@ucmerced.edu

% start by closing all figures
close all
% continue by clearing everything to ensure clean runs
clear all

% % -=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-
% % Implement Gaussian Pyramid and Laplacian Pyramid 
% % -=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-
imagename = "lena.jpg";
img = im2double(imread(imagename));
figure, imshow(img); title("Original Image")

sigma = 2.0;
hsize = 7;
scale = 5;

% Gaussian Pyramid
I = img; 
for s = 1 : scale

    % Gaussian filter
    H = fspecial('gaussian',hsize,sigma);
    gau = imfilter(I,H,'replicate');
    
    % Laplacian filtering
    L = I - gau;
    
    % Save or show image
    figure, imshow(gau); title("Gaussian_scale");
    imwrite(gau, sprintf('Gaussian_%s_scale_%d.jpg', imagename, s));
    
    figure, imshow(L + 0.5); title("Laplacian_scale");
    imwrite(I + 0.5, sprintf('Laplacian_%s_scale%d.jpg', imagename, s));
    
    % Down-sampling
    I = imresize(gau, 0.5);
%     figure, imshow(I); title("Down-sampled Image  scale: %d",s);
end





