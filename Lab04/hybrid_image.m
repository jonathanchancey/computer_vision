function img_merged = hybrid_image(img1, img2, ratio)
    
    [lpi1, hpi1] = separate_frequency(img1, ratio);
    
    [lpi2, hpi2] = separate_frequency(img2, ratio);
    
%     i12 = zeros(size(img1));
%     i21 = zeros(size(img1));
    
    i12 = lpi1 + hpi2;
%     i21 = lpi2 + hpi1;
    
    
    
    img_merged = i12;
    
    
end