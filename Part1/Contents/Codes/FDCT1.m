    function func = FDCT1(f)
        N = length(f);
        y = zeros(1,2*N);
        y(1:N) = f;
        y(N+1:2*N) = fliplr(f);
        Y = fft(y);
        k=0:N-1;
        temp = real(exp(-1i.* pi.*k./(2*N)).*Y(1:N));
        temp(1) = temp(1) * sqrt(1/N)/2;
        temp(2:N) = temp(2:N) * sqrt(2/N)/2;
        func = temp;
        
    end