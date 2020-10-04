function func = RobertDL(f)
    [M,N] = size(f);
    func = zeros(M,N);
    mask = [ -1 0; 0 1 ];
    for i = 1:M - 1
        for j = 1:N -1
            window = double(f(i:i+1,j:j+1));
            func(i,j) = sum(sum(window.*mask));
        end
    end
end