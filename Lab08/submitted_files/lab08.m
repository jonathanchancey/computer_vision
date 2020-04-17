% AUTHOR: Jonathan Chancey
% EMAIL: jchancey@ucmerced.edu

% start by closing all figures
close all
% continue by clearing everything to ensure clean runs
clear all

% % -=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-
% %  Given an input image, detect straight lines from the edge
% %  map
% % -=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-

images = ["hill.png", "bridge.png", "lines.png"];


% selects which images to run hough transform on 
run(images(1));
run(images(2));
run(images(3));


function run(imagename)
    img = imread(imagename); % load the current run's name
    % use matlab function to get the imagename the correct way 
    % for later use with saving output images
    [~, img_name, ~] = fileparts(imagename);
    % create an edgemap with canny edge detector
    edge_map = edge(rgb2gray(img), 'canny', 0.1, 3); 
    
    % create figures for debug
    figure, imshow(img); title(sprintf("Original Image - %s", imagename));
    figure, imshow(edge_map); title(sprintf("edge map - %s", imagename));

    % run the first hough transform
    [m, b] = hough_transform(edge_map);
    x = 1:size(img, 2);
    y = m * x + b;
    
    % create a figure with the hough transform line
    figure, imagesc(img); title('mb_line'); hold on;
    plot(x, y, 'LineWidth', 4, 'Color', 'red');
    
    % save current figure
    saveas(gcf, sprintf('%s_mb_line.png', img_name));
    
    % run the polar hough transform
    [r, theta] = hough_transform_polar(edge_map);
    x = 1:size(img, 2);
    y = -(cos(theta)/sin(theta)) * x + (r / sin(theta));
    
    % create a figure with the hough transform line
    figure, imagesc(img); title('polar_line'); hold on;
    plot(x, y, 'LineWidth', 4, 'Color', 'blue');
    
    % save current figure
    saveas(gcf, sprintf('%s_polar_line.png', img_name)); 
    
end

