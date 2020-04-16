function I2 = sobel_filter(img, kernel)
    rows = size(img, 1);
    cols = size(img, 2);
    
    
    s  = round((size(kernel,1) - 1)/2);
    
    
    I2 = zeros(rows+s*2,cols+s*2);
    I2(1+s:rows+s,1+s:cols+s) = img;
    
    for i = 1:rows-1
        for j = 1:cols-1
            I2(i,j) = sum(sum(kernel.*I2(i:i+s*2,j:j+s*2)));
        end
    end
end



