function [img, final_corner_map] = harris_corner_detector(img, imagename)
    % % -=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-
    % compute the gradient of image, and then apply Gaussian filtering
    % % -=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-
    % Ix = imfilter(img, Dx);
    
    % % -=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-
    % Step 1: Image Gradients -- Method 1
    H = fspecial('gaussian', 5, 1);
    H2 = fspecial('gaussian', 5, 2);
    gauimg = imfilter(img, H, 'replicate');
    show_me(gauimg);
    write_me(gauimg, imagename, 'gaussian - sigma 1');
    
    % derivative calculated with convolution/filter with sobel
    % Dy = fspecial('sobel');
    % Dx = rot90(Dy);
    % simple one
    Dx = [1 0 -1];
    Dy = [1;
        0;
        -1];
    
    Ix = imfilter(gauimg, Dx, 'replicate');
    Iy = imfilter(gauimg, Dy, 'replicate');
    
    show_me_5(Ix);
    show_me_5(Iy);
    
    write_me(Ix, imagename, 'Ix');
    write_me(Iy, imagename, 'Iy');
    
    % % -=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-
    % Step 2: Product of Gradients
    
    Ixx = Ix .* Ix;
    Iyy = Iy .* Iy;
    Ixy = Ix .* Iy;
    
    % % -=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-
    % Step 3: Matrix M
    % use gaussian filtering to compute the sum of products of gradients at
    % every pixel
    
    Sxx = imfilter(Ixx, H2, 'replicate');
    Syy = imfilter(Iyy, H2, 'replicate');
    Sxy = imfilter(Ixy, H2, 'replicate');
    
    % % -=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-
    % Step 4: Corner Response
    %
    % M = [Sxx Sxy;
    %      Sxy Syy];
    % detM = det(M);
    
    detM = Sxx .* Syy - Sxy .* Sxy;
    traceM = Sxx + Syy;
    
    
    % compute the corner response
    ALPHA = 0.04;
    R = detM - ALPHA * traceM.^2;

    show_me(R);
    write_me(R, imagename, 'R');
    
    % % -=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-
    % Step 4: Non-maxima suppression
    
    threshold = .00001 * 5;
    R_thresh = R > threshold;
    show_me(R_thresh);
    write_me(R_thresh, imagename, 'R_thresh');
    
    % compute the regional max
    Rmax = imregionalmax(R);
    show_me(Rmax);
    write_me(Rmax, imagename, 'Rmax');
    
    % % -=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-
    % Step 6: Extract Corner Points and Plot
    % use find ot extrat (x,y) of corner points
    final_corner_map = R_thresh & Rmax;
    show_me(final_corner_map);
    write_me(final_corner_map, imagename, 'final_corner_map');
    
    [corner_y, corner_x] = find(final_corner_map);
    figure, imshow(img); hold on;
    plot(corner_x, corner_y, 'ro');
    
    % save the current figure
    saveas(gcf, sprintf('output_%s_%s.jpg', imagename, 'final_result'))
        
    % visualize results
    function show_me(I)
%         figure, imshow(I); title(sprintf("%s", inputname(1)));
    end
    
    function show_me_5(I)
%         figure, imshow(I+0.5); title(sprintf("%s", inputname(1)));
    end
    
    function write_me(I, imagename, comment)
        imwrite(I, sprintf('output_%s_%s.jpg', imagename, comment));
    end
    
end