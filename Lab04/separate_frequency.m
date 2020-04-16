function [low_pass_img, high_pass_img] = separate_frequency(img, RATIO)
    [IMAGEHEIGHT, IMAGEWIDTH, ~] = size(img);
    
    freq_map = fft2(img);
    freq_map_shift = fftshift(freq_map);
    
%     figure, imshow(log(abs(freq_map)+1),[]); title("freqmap")
%     figure, imshow(log(abs(freq_map_shift)+1),[]); title("freqmapshift")
    
    HH = IMAGEHEIGHT/2; % half width
    HW = IMAGEWIDTH/2; % half height
    
    RH = IMAGEHEIGHT * RATIO;
    RW = IMAGEWIDTH * RATIO;
    
    y1 = round(HH - RH/2);
    y2 = round(HH + RH/2);
    
    x1 = round(HW - RW/2);
    x2 = round(HW + RW/2);
    
    mask = zeros(size(img));
    mask(y1 : y2, x1 : x2, :) = 1;
    
    low_freq_map_shift = freq_map_shift .* mask;
    high_freq_map_shift = freq_map_shift .* (1 - mask);
    
    low_freq_map = ifftshift(low_freq_map_shift);
    high_freq_map = ifftshift(high_freq_map_shift);
    
    low_pass_img = real(ifft2(low_freq_map));
    high_pass_img = real(ifft2(high_freq_map));
end