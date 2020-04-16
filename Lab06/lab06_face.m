% AUTHOR: Jonathan Chancey
% EMAIL: jchancey@ucmerced.edu

% start by closing all figures
close all
% continue by clearing everything to ensure clean runs
clear all

% % -=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-
% % Predict the id/labels for 160 testing images
% % -=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-=x=-

% init setup 

% imagename = "lena.jpg";
% img = im2double(imread(imagename));
% figure, imshow(img); title("Original Image")
load('att_face.mat');

num_testing = size(id_testing, 1);
num_training = size(id_training, 1);
id_predict = zeros(num_testing);
scale = 2;

% 1. for each testing image, computer the 40 square 
% errors from the training images.

for i = 1:num_testing
    % extract testing image
    img_test = face_testing(:,:,i);
%     vec_test = img_test(:);
    vec_test = multiscale_sobel_feature(img_test, scale);
    
    
    error = zeros(num_training, 1);
    for j = 1:num_training
        % extract training image
        img_train = face_training(:,:,j);
%         vec_train = img_train(:);
        vec_train = multiscale_sobel_feature(img_train, scale);

        
        %compute the square error between feature vectors
        diff = vec_train - vec_test;
        error(j) = sum(diff.^2);
    end
    % find the image id with minimal error
    [~, min_id] = min(error);
    id_predict(i) = min_id;
end

% 3. Calculate the accuracy betwen your predict 
% labels and the ground truth labels (is_testing)

accuracy = sum(id_testing == id_predict)/num_testing;
fprintf('accuracy = %f\n', accuracy(1));

% It looks like my values could be incorrect. 
% Though after hours of debug, the code looks completely correct.
% If there is something wrong, could you identify the incorrect 
% section so I can understand and fix it?


% Using gradient magnitude as features:
%---------------------------------------%
% Scale | Accuracy
%---------------------------------------%
% 1 | 0.5313 
%---------------------------------------%
% 2 | 0.406250
%---------------------------------------%
% 3 | 0.456250
%---------------------------------------%
%
% Using gradient orientation as features:
%---------------------------------------%
% Scale | Accuracy
%---------------------------------------%
% 1 | 0.5500 % not my value
% 1 | 0.556250 % my value
%---------------------------------------%
% 2 | 0.593750
%---------------------------------------%
% 3 | 0.606250
%---------------------------------------%
