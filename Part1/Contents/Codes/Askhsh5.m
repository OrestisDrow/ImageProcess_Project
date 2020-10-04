%% Finding required variance for 10db noised image
clear;
f = imread('C:\Users\OrestisDrow\Desktop\ImageProccessing\DIP_MEROS_A\Images\factory.jpg');
f = rgb2gray(f);
f1 = imnoise(f,'gaussian', 0, 0.02);
noise = double(f1) - double(f);
SNR = snr(double(f1), noise);
f3 = wiener2(f1,[3 3],0.02);
%[f2, medVar] = WienerFilter(double(f1),0.02);
%[f3 n] = wiener2(f1,[3 3]);
Y = psf(f);
Z = zeros(11);
Z(6,6) = 1;
Y1 = psf(Z);    %Kroustikh apokrish
X = conv2(Y,Z);
%surf Y1;
% weiner deconvolution Y1



