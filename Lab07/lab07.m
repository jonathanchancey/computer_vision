% AUTHOR: Jonathan Chancey
% EMAIL: jchancey@ucmerced.edu

% start by closing all figures
close all
% continue by clearing everything to ensure clean runs
clear all

% % -=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-
% % 
% % a 
% % -=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-

images = ["cameraman.png", 'baboon.png', 'checkboard.png'];

% web matlab is throwing infinite warnings when I use this for loop
% for i = 1:3
%     run(images(i))
% end

% please excuse the individual calls
run(images(1));
run(images(2));
run(images(3));


function run(imagename)
    img = im2double(imread(imagename));
    figure, imshow(img); title(sprintf("Original Image - %s", imagename));
    harris_corner_detector(img, imagename);
end

