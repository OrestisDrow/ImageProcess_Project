%% Segmenting the original 256x256 image into 64 32x32 images
clear;
f = imread('C:\Users\OrestisDrow\Desktop\ImageProccessing\DIP_MEROS_A\Images\clock.tiff');
F = FDCT2(f);
A = SegmentImage32(f);

%% DCT on segmented 32x32 images
C = zeros(64,32,32);    %DCT's of the segmented sub-images
%B(:,:) = A(1,:,:);
for i = 1:64
    temp(:,:) = A(i,:,:);
    C(i,:,:) = FDCT2(temp);
end


%% Picking the first p% values of the dct transforms using Threshold method
p = 50;
%how many values we have to keep for compression for each window
numOfValues = floor(p/100*32*32);  

iloc = zeros(64, numOfValues);
jloc = zeros(64, numOfValues);
val = zeros(64, numOfValues);

%Threshold method
Thres = (max(max(max(C)))-min(min(min(C))))/1000;
%Thres = min(min(min(C)));
C1 = zeros(64,32,32);
%Keeping #numOfValues values that are above the Thres in the iloc,jloc,val
%data structrures
for i = 1:64
    temp(:,:) = C(i,:,:);
    cntr = 1;
    flag = 0;
    for k1 = 1:32
        for k2 = 1:32
            if temp(k1,k2) >= Thres
                iloc(i,cntr) = k1;
                jloc(i,cntr) = k2;
                val(i,cntr) = temp(k1,k2);
                cntr = cntr + 1;
                if cntr == numOfValues + 1
                    flag = 1;
                    break
                end
                %temp(k1,k2) = 0;
            end
        end
        if flag == 1
                break
        end
    end
            
    %C1(i,:,:) = idct2(temp(:,:));
end

% Using the data structures to reform the DCT matrices with everything to
% zero except the #numOfValues stored elements

C1 = zeros(64,32,32);
for i = 1:64
    for cntr = 1:size(val,2)
        if val(i,cntr) == 0
            break
        end
        C1(i, iloc(i,cntr), jloc(i,cntr)) = val(i,cntr);
    end
end

% IDCT on the compressed dct matrix
C2 = zeros(64,32,32);
for i = 1:64
    temp(:,:) = C1(i,:,:);
    C2(i,:,:) = idct2(temp(:,:));
end

% Reforming the sub-images into the whole
newImage = ReconstructImage32(C2);
imshow(newImage,[0 255]);


C3 = zeros(64,32,32);
for i = 1:64
    temp(:,:) = C(i,:,:);
    C3(i,:,:) = idct2(temp);
end
%% Median square error
medSumErr = sum(sum(abs(newImage.^2 - double(f).^2)))/256/256;

%% Picking the first p% values of the dct transforms using Zone method
p = 25;
numOfValues = floor(p/100*32*32);

            