function func = SegmentImage32(img)
    d1 = size(img, 1);
    d2 = size(img, 2);
    temp = zeros( (d1/32)^2, 32, 32);
    k = 1;
    %Checking if it can be segmented with 32x32
    if (mod(d1, 32) == 0) && (mod(d2, 32) == 0)
        for i = 1:d1/32
            for j = 1:d1/32
                temp(k,:,:) = img((i-1)*32+1:(i-1)*32+32, (j-1)*32+1:(j-1)*32+32);
                k = k+1;
            end
        end
        
           
        func = temp;
    else
        func = 0;
    end
    
    

end