
% default data type is uint8
% each pixel has a value between 0 and 255
% img(1,1)

% convert to double will make the pixel range 0 to 1
% img = im2double(img);

% failed attempt at removing green
% greenhateMatrix = [1 0 1; 1 0 1; 1 0 1] 
% greenless = img(img * greenhateMatrix)

fprintf("img(:,:,2) with green")
% img(:,:,2)

% img(:,:,2)

% convert RGB to Y (gray-scale)

% img = flip(img,2);

% % convert to double will make the pixel range 0 to 1
% img = im2double(img);
% 
% img(0.299*1.0, 0.587*1, 0.114*1)
% 
% figure, imshow(img);

% check matrix dimension
% size(img)

%save image
% imwrite(img,'output.jpg');




