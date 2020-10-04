function func = SobelVer(f)
    [M,N] = size(f);
    func = zeros(M,N);
    mask = [ -1 -2 -1; 0 0 0; 1 2 1];
    for i = 2:M - 1
        for j = 2:N -1
            window = double(f(i-1:i+1,j-1:j+1));
            func(i,j) = sum(sum(window.*mask));
        end
    end
end