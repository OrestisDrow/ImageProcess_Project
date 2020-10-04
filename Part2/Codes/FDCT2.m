    function func = FDCT2(f)
        N1 = size(f,1);
        N2 = size(f,2);
        temp = zeros(N1,N2);
        
        for n1 = 1:N1
            temp(n1,:) = FDCT1(f(n1,:)); 
        end
        
        temp = transpose(temp);
        
        for n2 = 1:N2
            temp(n2,:) = FDCT1(temp(n2,:));
        end
        func = transpose(temp);
        
    end