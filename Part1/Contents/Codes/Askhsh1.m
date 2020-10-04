%% Normalizing image to values 0->255
clear;
f = imread('C:\Users\OrestisDrow\Desktop\ImageProccessing\DIP_MEROS_A\Images\moon.tiff');
normalised_f = uint8(255*mat2gray(f));

%% Applying 2-D FFT with row-column logic plus shifting zero frequency element to center
F = FFT2(normalised_f);
F = FFTshift(F);

%% Linear and logarithmic display of image fourier magnitude
Fmag = FFTmagnitude(F);
FmagLog = 10*log10(Fmag);
FmagLin = Fmag;
%subplot(1,2,1);
%imshow(FmagLog,[0 255]);
%subplot(1,2,2);
%imshow(FmagLin,[0 255]);

%% Low-Pass filtering in Frequency Domain
[x, y] = meshgrid( -128:127, -128:127);
z = sqrt(x.^2 + y.^2);
c = z<20;
filtered_F = F.*c;
%imshow(10*log10(abs(filtered_F)),[0 255]);

%% Retrieving Filtered image
filtered_f = IFFT2(FFTshift(filtered_F));
filtered_f = uint8(filtered_f);
imshow(filtered_f);