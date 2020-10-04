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

%% Compression using zone method
C1 = zeros(64,32,32);
cntr = 1;
for l = 22:-1:0
    for i = 1:64
        temp(:,:) = C(i,:,:);
        temp = triu(rot90(temp,3),l);
        temp = rot90(temp);
        C1(i,:,:) = temp(:,:);
    end

    C2 = zeros(64,32,32);
        for i = 1:64
            temp(:,:) = C1(i,:,:);
            C2(i,:,:) = idct2(temp(:,:));
        end

    % Reforming the sub-images into the whole
    newImage = ReconstructImage32(C2);
    %imshow(newImage,[0 255]);
    
   
    medSumErr = sum(sum(abs(newImage.^2 - double(f).^2)))/256/256;
    p = nnz(C1)/256/256;
    P(cntr) = p;
    Err(cntr) = medSumErr;
    cntr = cntr + 1;
end