    function func = FFTshift(F)
        dimentions = size(F);  
        d1 = dimentions(1); %Rows
        d2 = dimentions(2); %Columns
        med = floor(d2 / 2);
        func = zeros(d1, d2);
        
        func(:,1:med) = F(:,d2 - med + 1:end);
        func(:,med + 1:end) = F(:, 1:d2 - med);
        
        tfunc = transpose(func);
        dimentions = size(tfunc);  
        d1 = dimentions(1); %Rows
        d2 = dimentions(2); %Columns
        med = floor(d2 / 2);
        
        func = zeros(d1, d2);
        
        func( : , 1:med) = tfunc( : , d2 - med + 1:end);
        func( : , med + 1:end) = tfunc( : , 1:d2 - med);
        
        func = transpose(func);
    end