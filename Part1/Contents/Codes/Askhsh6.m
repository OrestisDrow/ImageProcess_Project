%% Edge detection
clear;
f = imread('C:\Users\OrestisDrow\Desktop\ImageProccessing\DIP_MEROS_A\Images\boat.tiff');
f = f(:,:,1);
f1 = SobelHor(f);
f2 = SobelVer(f);
f3 = SobelUL(f);
f4 = SobelDL(f);
f5 = RobertDL(f);
f6 = RobertDR(f);
%imhist(f);
%imshow(f,[0 255]);

%% Thresholding
[f_thres, f_mask] = EdgeRobert(f5,f6,152);
imshow(f_thres, [0 255]);