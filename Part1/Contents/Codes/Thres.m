function func = Thres(f,thr)
    f(f<thr) = 0;
    f(f>thr) = 255;
    func = f;
end