% AUTHOR: Jonathan Chancey
% EMAIL: jchancey@ucmerced.edu

% start by closing all figures
close all
% continue by clearing everything to ensure clean runs
clear all

% % -=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-
% % Implement template_matching_normcorr.m, and try to
% % find the best threshold value for einstein1.jpg and
% % einstein2.jpg
% % -=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-

% imagename = "einstein1.jpg";
imagename = "einstein2.jpg";
img = im2double(imread(imagename));
template = im2double(imread('template.jpg'));

figure, imshow(img); title("Original Image")

out = img; % declare output

[shift_v, shift_u, ~] = size(template);

% declare working image with padding
I1 = zeros(size(img, 1) + shift_v * 2, size(img, 2) + shift_u * 2);

% place the original image inside I1 
I1(1 + shift_v:size(img, 1) + shift_v, 1 + shift_u:size(img, 2) + shift_u) = img;

% 0.5 is the best theshold for both einstein1 and einstein2
threshold = 0.5;

for u = 1 + shift_u : size(I1, 2) - shift_u % width
    for v = 1 + shift_v : size(I1, 1) - shift_v % height
        
        x1 = u - shift_u; x2 = u - 1;
        y1 = v - shift_v; y2 = v - 1;
        patch = I1(y1:y2, x1:x2);
        
        % P_uv is a local image patch at u,v
        % H is the template
        
        % convert puv and H to vectors
        P = patch(:);
        H = template(:);
        
        % subtract mean 
        PP = P - mean(P);
        HH = H - mean(H);
        
        % normalize length to 1
        PPP = PP/norm(PP);
        HHH = HH/norm(HH);
        
        % help dot
        value = dot(PPP, HHH);
        out(v-shift_v, u-shift_u) = value;
    end
end

figure, imshow(out); title("output PREmatch")
match = (out > threshold);
figure, imshow(match); title("output POSTmatch")
imwrite(match, sprintf('template_matching_normcorr_%s_threshold_%s.jpg', imagename, string(threshold)));


