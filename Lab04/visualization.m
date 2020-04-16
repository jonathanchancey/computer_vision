% figure, imshow(log(abs(freq_map) + 1), []);
img = im2double(imread('new_york.jpg'));
freq_map = fftshift(fft2(img));
figure, imagesc(log(abs(freq_map) + 1)), colormap jet;
imwrite(freq_map,"new_york_frequency.jpg")

img = im2double(imread('flowers.jpg'));
freq_map = fftshift(fft2(img));
figure, imagesc(log(abs(freq_map) + 1)), colormap jet;
imwrite(freq_map,"flowers_frequency.jpg")