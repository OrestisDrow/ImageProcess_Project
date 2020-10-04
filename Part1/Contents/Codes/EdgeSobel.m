function [f_thresh,f_mask] = EdgeSobel(f1,f2,f3,f4,thr)
    [M,N] = size(f1);
    f1 = reshape(f1,1,M*N);
    f2 = reshape(f2,1,M*N);
    f3 = reshape(f3,1,M*N);
    f4 = reshape(f4,1,M*N);
    f_mask = max([f1;f2;f3;f4],[],1);
    f_mask = reshape(f_mask,M,N);
    f_thresh = Thres(f_mask,thr);
    f_thresh = reshape(f_thresh,M,N);
end