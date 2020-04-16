% AUTHOR: Jonathan Chancey
% EMAIL: jchancey@ucmerced.edu

% start by closing all figures
close all
% continue by clearing everything to ensure clean runs
clear all

% % -=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-
% % Implement template_matching_SSD.m, and try to find
% % the best threshold value for einstein1.jpg and
% % einstein2.jpg
% % -=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-

img = im2double(imread('einstein1.jpg'));
template = im2double(imread('template.jpg'));

figure, imshow(img); title("Original Image")

out = img; % declare output


% I1 = img(1:size(img, 1), 1:size(img, 2));

[shift_v, shift_u, ~] = size(template);
% predeclares working image with padding
I1 = zeros(size(img, 1) + shift_v * 2, size(img, 2) + shift_u * 2);
% places the original image inside I1 
I1(1 + shift_v:size(img, 1) + shift_v, 1 + shift_u:size(img, 2) + shift_u) = img;

% shift_v = round(shift_v/2);
% shift_u = round(shift_u/2);

threshold = 25;

for u = 1 + shift_u : size(I1, 2) - shift_u % width
    for v = 1 + shift_v : size(I1, 1) - shift_v % height
        
        x1 = u - shift_u; x2 = u - 1;
        y1 = v - shift_v; y2 = v - 1;
        patch = I1(y1:y2, x1:x2);
        
%         tests 
%         wack = I1;
%         wack(y1:y2, x1:x2) = I1(y1:y2, x1:x2).*255;
%         figure, imshow(wack); title("curr selection")
        
        value = patch - template;
%         out(v, u) = sum(sum(value(:).^2));

        out(v-shift_v, u-shift_u) = sum(sum(value(:).^2));
    end
end

figure, imshow(out); title("output PREmatch")
match = (out < threshold);
figure, imshow(match); title("output POSTmatch")
imwrite(match, sprintf('template_matching_SSD_einstein1.jpg'));


