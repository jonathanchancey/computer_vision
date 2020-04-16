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

I1 = img;

out = zeros();

[shift_v, shift_u, ~] = size(template);

threshold = 10;

for u = 1 + shift_u : size(I1, 2) - shift_u
    for v = 1 + shift_v : size(I1, 1) - shift_v
        
        x1 = u - shift_u; x2 = u-1;
        y1 = v - shift_v; y2 = v-1;
        patch = I1(y1:y2, x1:x2);
        
        % filter the image with eye patch
        
%         value = sum(template(i,j).*patch(u+i,v+j));
        
        for i = 1 : shift_u - 1
            for j = 1 : shift_v - 1
                 value = sum(template(i,j).*I1(v,u));
            end
        end
        
        % SSD
%         for i = 1 : shift_u
%             for j = 1 : shift_v
% %                 value = pow2(patch(u+i-1,v+i-1) - template(i,j));
% %                  value = pow2(patch(i,j) - template(i,j));
%                  %value = pow2(template(i,j) - patch(i,j));
%                  
%                  value = pow2(template(i,j) - patch(i,j));
%             end
%         end
        
        
        %%%%%
%         value = sum(sum(patch(u,v)-template()))

        
        % naive filter applying
        %out(v, u) = sum(sum(template.*patch));
        
        %--- BEST attempt at SSD
%         out(v, u) = sum(sum(pow2(template - patch(1:27,1:27))));
        
        
        
        
%         figure, imshow(patch); title("curr patch")
        
        
        %--- GOAL: filter the image with eye patch
        %-- ME STILL TRYING THINGS
%         value = sum(template(i,j).*patch(u+i,v+j));
        %--- ME TRYING THINGS
%         for i = 1 : shift_u - 1
%             for j = 1 : shift_v - 1
%                  value = sum(template(i,j).*I1(v,u));
%             end
%         end
        %--- lab03 filter implementation 
%         for i = 1:rows-1
%             for j = 1:cols-1
%                 I2(i,j) = sum(sum(kernel.*I2(i:i+s*2,j:j+s*2)));
%             end
%         end
        
%         value = sum(sum(template.*I1(y1:y2,x1:x2)));
        % SSD
%         value = sum(sum(pow2(template - I1(y1:y2,x1:x2))));
        
        % SSD
%         for i = 1 : shift_u
%             for j = 1 : shift_v
% %                 value = pow2(patch(u+i-1,v+i-1) - template(i,j));
% %                  value = pow2(patch(i,j) - template(i,j));
%                  %value = pow2(template(i,j) - patch(i,j));
%                  
%                  value = pow2(template(i,j) - patch(i,j));
%             end
%         end
        
        
        %%%%%
%         value = sum(sum(patch(u,v)-template()))

        out(v, u) = value;
    end
end

figure, imshow(out); title("output PREmatch")
match = (out < threshold);
figure, imshow(match); title("output POSTmatch")


