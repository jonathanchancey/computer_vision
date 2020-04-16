% AUTHOR: Jonathan Chancey
% EMAIL: jchancey@ucmerced.edu

% start by closing all figures
close all
% continue by clearing everything to ensure clean runs
clear all

% % -=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-
% % 1. and 2. Implement sobel_filter.m, use H_y filter and save the
% % image as sobel_y.jpg. Do the same with H_x and sobel_x.jpg.
% % -=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-

% load image
img = im2double(imread('lena.jpg')); 
figure, imshow(img); title("Original Image")

IMAGEWIDTH = img(size(1));
IMAGEHEIGHT = img(size(2));

% Horizontal edge Sobel Filter
Hx = [1,  0, -1;
     2,  0, -2;
     1,  0, -1];
% Vertical edge Sobel Filter
% Hy = Hx';
Hy = [1,  2,  1;
     0,  0,  0;
    -1, -2, -1];
% disp("rows,cols,chan",rows,cols,channels)
% figure, imshow(expected_result); title("expected\_result")
 
img_sobel_x = sobel_filter(img, Hx);
figure, imshow(img_sobel_x); title("Horizontal edge Sobel filter")
imwrite(img_sobel_x,"sobel_x.jpg")

img_sobel_y = sobel_filter(img, Hy);
figure, imshow(img_sobel_y); title("Vertical edge Sobel filter")
imwrite(img_sobel_y,"sobel_y.jpg")


% % -=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-
% % 3. Break 2D filter (H_y) to 1D filter, use column-wise filter
% % first and then row-wise filter, save the image as
% % sobel_cr.jpg
% % -=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-
img = im2double(imread('lena.jpg')); 

Hx1 = [1 1 1; 2 2 2; 1 1 1];
Hx2 = [1 0 -1];
Hy1 = [1 1 1; 0 0 0 ; -1 -1 -1];
Hy2 = [1 2 -1];

% set kernel to H_y
k1 = Hy1;
k2 = Hy2;

rows = size(img, 1);
cols = size(img, 2);

I2 = zeros(rows+2,cols+2);
I2(1+1:rows+1,1+1:cols+1) = img;

output = zeros(rows+2, cols+2);
output2 = zeros(rows, cols);

for i = 1:rows
    for j = 1:cols
        output(i,j:j+2) = sum(k1.*I2(i:i+2,j:j+2), 1);
        output2(i,j) = sum(k2.*output(i,j:j+2));
%         if i == 10 && j == 10
%             disp(sum(Hx2.*I2(i,j:j+2)))
%             disp(sum(Hx1.*output(i:i+2,j:j+2)))
%             disp('\n')
%         end
    end
end

% figure, imshow(output); title("1D pre CR Sobel filter")
figure, imshow(output2); title("1D CR Sobel filter")
imwrite(output2,"sobel_cr.jpg")

% % -=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-
% % 4. Use row-wise filter first and then column-wise filter,
% % save the image as sobel_rc.jpg
% % -=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-
img = im2double(imread('lena.jpg')); 

Hx1 = [1 1 1; 2 2 2; 1 1 1];
Hx2 = [1 0 -1];
Hy1 = [1 1 1; 0 0 0 ; -1 -1 -1];
Hy2 = [1 2 -1];

% set kernel to H_y
k1 = Hy1;
k2 = Hy2;

rows = size(img, 1);
cols = size(img, 2);

I2 = zeros(rows+2,cols+2);
I2(1+1:rows+1,1+1:cols+1) = img;

output = zeros(rows+2, cols+2);
output2 = zeros(rows, cols);

for i = 1:rows
    for j = 1:cols
        % column-wise then row-wise filter WORKING :D
        % output(i,j:j+2) = sum(k1.*I2(i:i+2,j:j+2), 1);
        % output2(i,j) = sum(k2.*output(i,j:j+2));
        
        % row-wise then column-wise filter ATTEMPT D:
        output(i,j+2) = sum(Hx2.*I2(i,j:j+2));
        output2(i,j:j+2) = sum(Hx1.*output(i:i+2,j:j+2));
%         if i == 10 && j == 10
%             disp(sum(Hx2.*I2(i,j:j+2)))
%             disp(sum(Hx1.*output(i:i+2,j:j+2)))
%             disp('\n')
%         end
    end
end

% figure, imshow(output); title("pre 1D RC Sobel filter")
figure, imshow(output2); title("1D RC Sobel filter")
imwrite(output2,"sobel_rc.jpg")

% % -=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-
% % 5. Use row-wise filter first and then column-wise filter,
% % save the image as sobel_rc.jpg
% % -=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-
img = im2double(imread('lena.jpg')); 

hsize = 5; sigma = 2;

H = fspecial('gaussian', hsize, sigma);

kernel = H;

rows = size(img, 1);
cols = size(img, 2);

I2 = zeros(rows+hsize,cols+hsize);
s = round(hsize/2);
I2(1+s:rows+s,1+s:cols+s) = img;


for i = 1:rows-1
    for j = 1:cols-1
        I2(i,j) = sum(sum(kernel.*I2(i:i+hsize-1,j:j+hsize-1)));
    end
end
% slice off the extra pixels
I2 = I2(1:rows,1:cols);

figure, imshow(I2); title("gaussian hsize = 5; sigma = 2;")

% I = imfilter(img, H);
% figure, imshow(I); title("expected gaussian result")
imwrite(I2,"gaussian_5.jpg")

% % -=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-
% % 6. Use row-wise filter first and then column-wise filter,
% % save the image as sobel_rc.jpg
% % -=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-
img = im2double(imread('lena.jpg'));

hsize = 9; sigma = 4;

H = fspecial('gaussian', hsize, sigma);

kernel = H;

rows = size(img, 1);
cols = size(img, 2);

I2 = zeros(rows+hsize,cols+hsize);
s = round(hsize/2); % make a variable for the offset
I2(1+s:rows+s,1+s:cols+s) = img;

for i = 1:rows + 1
    for j = 1:cols + 1
        I2(i,j) = sum(sum(kernel.*I2(i:i+hsize-1,j:j+hsize-1)));
    end
end

% slice off the extra pixels
I2 = I2(1:rows,1:cols);

figure, imshow(I2); title("gaussian hsize = 9; sigma = 4;")

imwrite(I2,"gaussian_9.jpg")

% -=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-
% Function Defs
% -=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-

