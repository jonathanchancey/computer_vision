function [magnitude, orientation] = sobel_feature(img)
    hy = fspecial('sobel');
    hx = rot90(hy);
    
    %hor edge
%     B = imfilter(A,h)
    Gy = imfilter(img, hy);
    
    %vert edge
    Gx = imfilter(img, hx);
    
    % compute gradient magnitude and orientation
    magnitude = sqrt(pow2(Gy) + pow2(Gx));
    orientation = atan2(Gy, Gx);
end



