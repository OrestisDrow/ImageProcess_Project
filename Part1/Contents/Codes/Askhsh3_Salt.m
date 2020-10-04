%% Salt noise
clear;
f = imread('C:\Users\OrestisDrow\Desktop\ImageProccessing\DIP_MEROS_A\Images\aerial.tiff');
f1 = AddSaltNoise(f,15);
%f1 = MovAvg3Filter(f1);
f1 = Med3Filter(f1);
imshow(f1, [0 255]);