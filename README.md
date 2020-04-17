# computer_vision
CSE-185 Matlab projects


## Lab01
Introduction to Image Processing in Matlab

original | zeroed green channel | covert to greyscale from RGB with formula 
:---:|:---:|:---:
![](./Lab01/01.jpg) |![](./Lab01/green.jpg) |![](./Lab01/gray.jpg) 

rotate 90 deg | crop image | flip image
:---:|:---:|:---:
![](./Lab01/rotate.jpg) |![](./Lab01/crop.jpg) |![](./Lab01/flip.jpg) 

### combine images manually with boarder

```matlab
canvas = zeros(300*2+10,400*2+10,3,'uint8'); % create the image

% read the input images
i01 = imread('01.jpg');
i02 = imread('02.jpg');
i03 = imread('03.jpg');
i04 = imread('04.jpg');

% place each image on the output canvas
canvas(1:300,1:400,:) = i01;
canvas(1:300,411:810,:) = i02;
canvas(311:610,1:400,:) = i03;
canvas(311:610,411:810,:) = i04;
```

![](./Lab01/combine.jpg)





## Lab02 
Translation, rotation, forward warping, backward warping, and median filter. 

original | forward warping | backward warping  
:---:|:---:|:---:
![](./Lab02/01.jpg) |![](./Lab02/rotate_0.jpg) |![](./Lab02/rotate_1.jpg) 

original | noisy | median filter patch size 3   | median filter patch size 5  
:---:|:---:|:---:|:---:
![](./Lab02/lena.jpg) | ![](./Lab02/lena_noisy.jpg) | ![](./Lab02/median_0.jpg) |![](./Lab02/median_1.jpg) 

## Lab03 
Spatial Filters

Implement sobel and gaussian filters

lena | sobel x | sobel y | gaussian 
:---:|:---:|:---:|:---:
![](./Lab03/lena.jpg) |![](./Lab03/sobel_x.jpg) |![](./Lab03/sobel_y.jpg) | ![](./Lab03/gaussian_9.jpg)

## Lab04 

Split images into low and high frequency and create hybrid images

lena | lena low | lena high 
:---:|:---:|:---:
![](./Lab04/lena.jpg) | ![](./Lab04/lena_low_0.1.jpg) |![](./Lab04/lena_high_0.1.jpg) 

einstein | marilyn | hybrid mary low | hybrid einstein low 
:---:|:---:|:---:|:---:
![](./Lab04/einstein.jpg) |![](./Lab04/marilyn.jpg) |![](./Lab04/hybrid_1.jpg) |![](./Lab04/hybrid_2.jpg) 


## Lab05

Implement Gaussian Pyramid and Laplacian Pyramid and template matching with Sum of Square Distance (SSD) and Normalized Cross-Correlation (NormCorr)

### Lena Gaussian Pyramid
scale 1 | scale 2 | scale 3 | scale 4 | scale 5
:---:|:---:|:---:|:---:|:---:|
![](./Lab05/Gaussian_lena.jpg_scale_1.jpg) | ![](./Lab05/Gaussian_lena.jpg_scale_2.jpg) | ![](./Lab05/Gaussian_lena.jpg_scale_3.jpg) | ![](./Lab05/Gaussian_lena.jpg_scale_4.jpg) | ![](./Lab05/Gaussian_lena.jpg_scale_5.jpg) 

### Einstein Laplacian Pyramid
scale 1 | scale 2 | scale 3 | scale 4 | scale 5
:---:|:---:|:---:|:---:|:---:|
![](./Lab05/Laplacian_scale1.jpg) | ![](./Lab05/Laplacian_scale2.jpg) | ![](./Lab05/Laplacian_scale3.jpg) | ![](./Lab05/Laplacian_scale4.jpg) | ![](./Lab05/Laplacian_scale5.jpg) 


### Template Matching NormCorr 

#### Performs better with intensity changes than SSD

original | template | result
:---:|:---:|:---:
![](./Lab05/einstein2.jpg) | ![](./Lab05/template.jpg) |![](./Lab05/template_matching_normcorr_einstein2.jpg_threshold_0.5.jpg) 

## Lab06 

Implement `sobel_feature.m` to compute gradient magnitude and orientation from Sobel Filtering

Original | Canny Edge | Sobel Edge
:-------------:|:-------------:|:-------------:
![](./Lab06/lena.jpg) | ![](./Lab06/canny_edge_detection_image.jpg) | ![](./Lab06/sobel_edge_detection_image.jpg)

Original | Magnitude | Orientation
:-------------:|:-------------:|:-------------:
![](./Lab06/lena.jpg) | ![](./Lab06/magnitude_image_-0.5.jpg) | ![](./Lab06/orientation_image.jpg)


## Lab07 
Implement Harris_corner_detector

### Steps
1. Use derivative of Gaussian to compute image gradients
   - Compute the derivative of Gaussian and the apply filtering to the image
2. Compute the products of gradients at every pixel
3. Use gaussian filtering to compute the sum of products of gradients at every pixel
4. Compute the determinant and the trace of M 
<img src="https://render.githubusercontent.com/render/math?math=R = det(M) - \alpha(trace(M))^2 ">
5. Non-maxima suppression
6. Extract corner points and plot

### Results

baboon.png           |  cameraman.png | checkboard.png 
:-------------:|:-------------:|:-------------:
![](./Lab07/output_baboon.png_final_result.jpg)   | ![](./Lab07/output_cameraman.png_final_result.jpg) | ![](./Lab07/output_checkboard.png_final_result.jpg)


## Lab08 

Implementation of Hough Transform Cartesian and Hough Transform Polar

In this lab, we detect straight lines from an image using the image's edge map.

### Example of Hough Transform Cartesian applied on bridge.png

Bridge Cartesian Line             |  Bridge Cartesian Space 
:--------------------------------:|:--------------------------------:
![](./Lab08/bridge_mb_space.png)   | ![](./Lab08/bridge_mb_line.png)

### Example of Hough Transform Polar applied on bridge.png

Bridge Polar Line                 |  Bridge Polar Space 
:--------------------------------:|:--------------------------------:
![](./Lab08/bridge_polar_space.png)| ![](./Lab08/bridge_polar_line.png)

> More figures with their corresponding images can be found in the lab folder.