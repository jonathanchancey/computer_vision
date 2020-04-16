% AUTHOR: Jonathan Chancey
% EMAIL: jchancey@ucmerced.edu

% start by closing all figures
close all
% set(0,'DefaultFigureWindowStyle','normal')
% set(0,'DefaultFigureWindowStyle','docked')

% -=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-
% Ex. transform example
% -=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-

% img = imread('01.jpg');
% 
% I2 = zeros(300,400+50,3,'uint8');
% I2(1:300,51:400+50,:) = img;
% 
% figure, imshow(I2);
% figure, imshow(img);

% % -=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-
% % 1. Rotate 01.jpg by 45 degree using forward warping, and
% % save as rotate_0.jpg
% % -=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-

% load image
img = imread('01.jpg'); 
IMAGEWIDTH = 400;
IMAGEHEIGHT = 300;

I2 = zeros(300,400,3,'uint8');

x0 = IMAGEWIDTH/2;
y0 = IMAGEHEIGHT/2;

rdeg = 45; % rotation degrees

figure, imshow(img); title("Original Image")
for y1 = 1:IMAGEHEIGHT
    for x1 = 1:IMAGEWIDTH
        x2 = round(cosd(rdeg) * (x1 - x0) + sind(rdeg) * (y1 - y0) + x0);
        y2 = round(-sind(rdeg) * (x1 - x0) + cosd(rdeg) * (y1 - y0) + y0);
%         fprintf("%d %d %d %d\n",y2,x2,y1,x1);

        if x2 > 0 && x2 <= IMAGEWIDTH && y2 > 0 && y2 <= IMAGEHEIGHT
%             fprintf("%d %d %d %d\n",y2,x2,y1,x1);
            I2(y2,x2,:) = img(y1,x1,:);
        end
    end
end
figure, imshow(I2); title("Forward Warping");
imwrite(I2,"rotate_0.jpg")

% % -=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-
% % 2. Rotate 01.jpg by 45 degree using backward warping,
% % and save as rotate_1.jpg
% % -=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-

% load image
img = imread('01.jpg');
IMAGEWIDTH = 400;
IMAGEHEIGHT = 300;

I2 = zeros(300,400,3,'uint8');

x0 = IMAGEWIDTH/2;
y0 = IMAGEHEIGHT/2;

rdeg = -45; % rotation degrees

% figure, imshow(img); title("Original Image")
for y2 = 1:IMAGEHEIGHT
    for x2 = 1:IMAGEWIDTH
        x1 = round(cosd(rdeg) * (x2 - x0) + sind(rdeg) * (y2 - y0) + x0);
        y1 = round(-sind(rdeg) * (x2 - x0) + cosd(rdeg) * (y2 - y0) + y0);
        if x1 > 0 && x1 <= IMAGEWIDTH && y1 > 0 && y1 <= IMAGEHEIGHT
%             fprintf("%d %d %d %d\n",y2,x2,y1,x1);
            I2(y2,x2,:) = img(y1,x1,:);
        end
    end
end
figure, imshow(I2); title("Backward Warping");
imwrite(I2,"rotate_1.jpg")

% -=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-
% 3. Implement median_filter.m for lena_noisy.jpg, use patch
% size = 3 and save the image as median_0.jpg
% -=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-

% load image
img = im2double(imread('lena_noisy.jpg'));

% load unmodified image
figure, imshow(img); title('Original Image');

% image dimensions
IMAGEWIDTH = 512;
IMAGEHEIGHT = 512;

% result images init
I2 = zeros(IMAGEHEIGHT,IMAGEWIDTH,1,'double');
I2_vectormedian = zeros(IMAGEHEIGHT,IMAGEWIDTH,1,'double');

% size of patch/submatrix (y, x)
patch_size = [3, 3];

% declares amount of pixels to shift
shift_u = (patch_size(1)-1)/2;
shift_v = (patch_size(2)-1)/2;

for u = 1 + shift_u : size(img, 2) - shift_u
    for v = 1 + shift_v : size(img, 1) - shift_v
        
        x1 = u - shift_u; x2 = u + shift_u;
        y1 = v - shift_v; y2 = v + shift_v; % check index range
%         fprintf("%d,%d  %d,%d\n",x1,x2,y1,y2);
        
        x1 = ignore_oob(x1, IMAGEWIDTH);
        x2 = ignore_oob(x2, IMAGEWIDTH);
        y1 = ignore_oob(y1, IMAGEHEIGHT);
        y2 = ignore_oob(y2, IMAGEHEIGHT);
%         fprintf("%d,%d  %d,%d\n",x1,x2,y1,y2);
        
        patch = img(y1:y2, x1:x2);
        value = median(median(patch));
        I2(v,u) = value;

        patch_vec = patch(:);
        value = median(patch_vec);
        I2_vectormedian(v,u) = value;
    end
end

figure, imshow(I2); title('patch\_size = [3, 3]');
imwrite(I2, "median_0.jpg")

% -=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-
% 4. Use patch size = 5, and save the image as median_1.jpg
% -=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-

% load image
img = im2double(imread('lena_noisy.jpg'));

% image dimensions
IMAGEWIDTH = 512;
IMAGEHEIGHT = 512;

% result image init
I2 = zeros(IMAGEHEIGHT, IMAGEWIDTH,1, 'double');
I2_vectormedian = zeros(IMAGEHEIGHT, IMAGEWIDTH, 1, 'double');

% size of patch/submatrix (y, x)
patch_size = [5, 5];

% declares amount of pixels to shift
shift_u = (patch_size(1)-1)/2;
shift_v = (patch_size(2)-1)/2;

for u = 1 + shift_u : size(img, 2) - shift_u
    for v = 1 + shift_v : size(img, 1) - shift_v
        
        x1 = u - shift_u; x2 = u + shift_u;
        y1 = v - shift_v; y2 = v + shift_v; % check index range
        
%         fprintf("%d,%d  %d,%d\n",x1,x2,y1,y2);
        
        x1 = ignore_oob(x1, IMAGEWIDTH);
        x2 = ignore_oob(x2, IMAGEWIDTH);
        y1 = ignore_oob(y1, IMAGEHEIGHT);
        y2 = ignore_oob(y2, IMAGEHEIGHT);
%         fprintf("%d,%d  %d,%d\n",x1,x2,y1,y2);
        
        patch = img(y1:y2, x1:x2);
        
        value = median(median(patch));
        I2(v,u) = value;

        patch_vec = patch(:);
        value = median(patch_vec);
        I2_vectormedian(v,u) = value;
    end
end

figure, imshow(I2); title('patch\_size = [5, 5]');
imwrite(I2, "median_1.jpg")

% -=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-
% Function Defs
% -=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-

function value = ignore_oob(value, boundary)
    if value < 0
        value = 0;
    end
    
    if value > boundary
        value = boundary;
    end
end
