%% Gauss noise
clear;
f = imread('C:\Users\OrestisDrow\Desktop\ImageProccessing\DIP_MEROS_A\Images\aerial.tiff');
f1 = imnoise(f,'gaussian', 0, 0.04);
%f1 = MovAvg3Filter(f1);
%f1 = Med3Filter(f1);
imshow(f1, [0 255]);
noise = double(f1) - double(f);
SNR = snr(double(f1), noise)