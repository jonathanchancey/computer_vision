% start by closing all figures
close all

% load image
img = imread('01.jpg');

% displays default image
figure, imshow(img);


% set green channel to zero and save 
greenless = img;
greenless(:,:,2) = 0;
imwrite(greenless,'green.jpg');
figure, imshow(greenless);


% convert image from RGB to grayscale and save 
% greyscale = img(:,:,2); % lazy way

R=img(:,:,1);
G=img(:,:,2);
B=img(:,:,3);

greyscale = 0.2989 * R + 0.5870 * G + 0.1140 * B;

imwrite(greyscale,'gray.jpg');
figure, imshow(greyscale);


% rotate 90 degress and save
img_90 = imrotate(img,90);
imwrite(img_90,'rotate.jpg');
figure, imshow(img_90), 'img_90';


% crop image given the upper left point (30,100)
% and lower left point (270,300) and save as crop.jpg
size(img)
% image(img)
cropped = img(30:270,100:300,:);
imwrite(cropped,'crop.jpg');
figure, imshow(cropped);


% horizontally flip the image and save as flip.jpg
flipped = flip(img,2);
imwrite(flipped,'flip.jpg');
figure, imshow(flipped);

% combine 4 images into one matrix with 2x2 grid and 10 pixels separations
% and save as combine.jpg

canvas = zeros(300*2+10,400*2+10,3,'uint8');

i01 = imread('01.jpg');
i02 = imread('02.jpg');
i03 = imread('03.jpg');
i04 = imread('04.jpg');

canvas(1:300,1:400,:) = i01;
canvas(1:300,411:810,:) = i02;
canvas(311:610,1:400,:) = i03;
canvas(311:610,411:810,:) = i04;

imwrite(canvas,'combine.jpg');
figure, imshow(canvas);


% convert images 05 and 06 to vectors, average them and save as average.jpg
i05 = imread('05.jpg'); 
i05 = i05(:); % i05 = reshape(i05, 1, []); is equivalent 

i06 = imread('06.jpg');
i06 = i06(:);

% average values of both vectors
iavg = i05.*i06/2;

% convert vector back into matrix
iavg = reshape(iavg, 375, 1242, 3);

imwrite(iavg,'average.jpg');
figure, imshow(iavg);

fprintf("End of Lab01")