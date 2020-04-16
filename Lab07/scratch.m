
% % -=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-
% % method 2
% Ix = imfilter(gauimg, Dx);
% Iy = imfilter(gauimg, Dy);
% 
% show_me_5(Ix);
% show_me_5(Iy);
% 
% Ix = imfilter(img, Ix);
% Iy = imfilter(img, Iy);
% 
% show_me_5(Ix);
% show_me_5(Iy);
% % -=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-
% imfilter(img, H, 'replicate');

% derivative of gaussian DoG to compute image gradients

% Ix = conv(Dx, img);
% Iy = conv(Dy, img);
% 
% show_me(Ix)

% function show_me(I)
% %     hold on;
%     figure, imshow(I); title(sprintf("%s", inputname(1)));
% %     colormap summer
% %     hold off;
% end
% 
% function show_me_5(I)
%     figure, imshow(I+0.5); title(sprintf("%s", inputname(1)));
% end


% Ix = g/x 
% Iy = G/y 

% [magnitude, orientation] = sobel_feature(img);
% 
% figure, imshow(magnitude); title("magnitude Image")
% imwrite(magnitude, 'magnitude_image.jpg');
% 
% threshold = 1;
% e = magnitude > threshold;
% e1 = edge(img, 'Sobel');
% e2 = edge(img, 'Canny');
% 
% figure, imshow(e); title("e Image")
% figure, imshow(e1); title("Sobel Image")
% figure, imshow(e2); title("Canny Image")
% 
% imwrite(e1, 'sobel_image.jpg');
% imwrite(e2, 'canny_Image.jpg');

% imwrite(gau, sprintf('Gaussian_%s_scale_%d.jpg', imagename, s));