close all
clear all 

run('vlfeat-0.9.20/toolbox/vl_setup');

img1 = im2single(imread('prtn13.jpg'));
img2 = im2single(imread('prtn12.jpg'));

% image height and width
[H, W, ~] = size(img1);

% SIFT feature extraction
I1 = rgb2gray(img1);
I2 = rgb2gray(img2);

% extract sift frames (keypoints and descriptors
[f1, d1] = vl_sift(I1);
[f2, d2] = vl_sift(I2);

d1 = double(d1);
d2 = double(d2);

plot_sift(img1, f1, d1);
plot_sift(img2, f2, d2);

[matches, scores] = vl_ubcmatch(d1, d2);
plot_match(img1, img2, f1, f2, matches);

% % RANSAC parameters
% n = 2; % number of selected points
e = 0.2;
s = 2; % number of selected points
p = 0.999;
% after many runs, I've anecdotally found delta of 8 
% to be somewhat reliable as a value for delta
delta = 8;

% P = 1 - (1 - (1 - e)^n)^k;
% k = log(1 - P)/log(1 - (1 - e)^n);
% k = 4; % temp assignment

k = floor(log(1 - p)/log(1 - (1 - e)^s));

disp(k)

% % RANSAC implementation

% pre declaring return variables
best_tx = 0;
best_ty = 0;
max_inlier = 0;

for i = 1 : k
    n = randperm(length(matches)); % randomly generate permutation of the length of matches
    p1 = f1(1:2, matches(1,n(i))); % use the random number to select matches
    p2 = f2(1:2, matches(2,n(i)));
    
    tx_0 = p1(1) - p2(1);
    ty_0 = p1(2) - p2(2);
    
    inlier = 0;
    for j = 1 : n - 1
        p1 = f1(1:2, matches(1,n(j))); 
        p2 = f2(1:2, matches(2,n(j)));

        tx_1 = p1(1) - p2(1);
        ty_1 = p1(2) - p2(2);
        
        % calculate condition for if statement
        cond = (tx_1 - tx_0)^2 + (ty_1 - ty_0)^2;
        if (cond < delta)
            inlier = inlier + 1;
        end
    end
    if (inlier > max_inlier)
        best_tx = tx_0;
        best_ty = ty_0;
    end
end

% % Image Blending/Stitching
disp(best_tx)
disp(best_ty)

% tx and ty have to be integers
tx = round(best_tx);
ty = round(best_ty);

% allocate the output image
output = zeros(H + ty, W + tx, 3);
output(1:H, 1:W, :) = img1;

for y2 = 1:size(img2, 1)
    for x2 = 1:size(img2, 2)
        y1 = y2 + ty; 
        x1 = x2 + tx;
        if (y1 >= 1 && y1 <= H + ty && x1 >= 1 && x1 <= W + tx)
            output(y1, x1, :) = img2(y2, x2, :);
        end
    end
end

figure, imshow(output); title("output") ;
imwrite(output, sprintf('output_d%d_e%.2f.jpg', delta, e));


% % Manual SIFT plotting below 

% % % Image 1
% figure, imshow(img1); title("img1 Image") ;
% 
% perm = randperm(size(f1,2)) ;
% sel = perm(1:50) ;
% h1 = vl_plotframe(f1(:,sel)) ;
% h2 = vl_plotframe(f1(:,sel)) ;
% h3 = vl_plotsiftdescriptor(d1(:,sel),f1(:,sel)) ;
% set(h1,'color','k','linewidth',3) ;
% set(h2,'color','y','linewidth',2) ;
% set(h3,'color','g') ;
% 
% 
% % % Image 2
% figure, imshow(img2); title("img2 Image") ;
% 
% perm = randperm(size(f2,2)) ;
% sel = perm(1:50) ;
% h1 = vl_plotframe(f2(:,sel)) ;
% h2 = vl_plotframe(f2(:,sel)) ;
% h3 = vl_plotsiftdescriptor(d2(:,sel),f2(:,sel)) ;
% set(h1,'color','k','linewidth',3) ;
% set(h2,'color','y','linewidth',2) ;
% set(h3,'color','g') ;