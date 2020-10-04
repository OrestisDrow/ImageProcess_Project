    function func = IFFT2(f)
        N1 = size(f,1);
        temp = zeros(N1, size(f,2));
        for n1 = 1:N1
            temp(n1,:) = ifft(f(n1,:));
        end
        temp = transpose(temp);
        N2 = size(temp,1);
        for n2 = 1:N2
            temp(n2,:) = ifft(temp(n2,:));
        end
        func = transpose(temp);
    end