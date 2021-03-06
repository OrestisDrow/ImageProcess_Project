%% Both noises
clear;
f = imread('C:\Users\OrestisDrow\Desktop\ImageProccessing\DIP_MEROS_A\Images\aerial.tiff');
f1 = imnoise(f,'gaussian', 0, 0.04);
f1 = AddSaltNoise(f1,15);

f1 = Med3Filter(f1);
f1 = uint8(255*mat2gray(f1));

f1 = MovAvg3Filter(f1);
f1 = uint8(255*mat2gray(f1));

for i = 1:2
f1 = Med3Filter(f1);
f1 = uint8(255*mat2gray(f1));
end


imshow(f1);
noise = double(f1) - double(f);
SNR = snr(double(f1), noise)
