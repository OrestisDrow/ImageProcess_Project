function func = ReconstructImage32(C)
    k = 1;
    for i = 1:8
        for j=1:8
            temp((i-1)*32+1:(i-1)*32+32, (j-1)*32+1:(j-1)*32+32) = C(k,:,:);
            k = k +1;
        end
    end
    func = temp;
end
