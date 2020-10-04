clear;
f = imread('C:\Users\OrestisDrow\Desktop\ImageProccessing\DIP_MEROS_A\Images\Eikona4.jpg');

%{
%Split into RGB Channels
Red = f(:,:,1);
Green = f(:,:,2);
Blue = f(:,:,3);
%Get histValues for each channel
[yRed, x] = imhist(Red);
[yGreen, x] = imhist(Green);
[yBlue, x] = imhist(Blue);

%Plot them together in one plot
figure,plot(x, yRed, 'Red', x, yGreen, 'Green', x, yBlue, 'Blue'), title('Histogram before equalization');
%}
f = histeq(f);
%Split into RGB Channels
Red = f(:,:,1);
Green = f(:,:,2);
Blue = f(:,:,3);
%Get histValues for each channel
[yRed, x] = imhist(Red);
[yGreen, x] = imhist(Green);
[yBlue, x] = imhist(Blue);

%Plot them together in one plot
figure,plot(x, yRed, 'Red', x, yGreen, 'Green', x, yBlue, 'Blue'), title('Histogram after equalization');

