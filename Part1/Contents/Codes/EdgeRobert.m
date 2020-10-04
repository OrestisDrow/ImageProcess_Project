function [f_thresh,f_mask] = EdgeRobert(f1,f2,thr)
    [M,N] = size(f1);
    f1 = reshape(f1,1,M*N);
    f2 = reshape(f2,1,M*N);
    f_mask = max([f1;f2],[],1);
    f_mask = reshape(f_mask,M,N);
    f_thresh = Thres(f_mask,thr);
    f_thresh = reshape(f_thresh,M,N);
end