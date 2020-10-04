
    function func = AddSaltNoise(f, p)
       
        %if Pa == Pb;
        percen=p;
        Prob_den_f=255*percen/100;
        func = f;
        
        Rmatrix = randi( [0, 255], [size(f,1), size(f,2)]);
        
        func(Rmatrix <= Prob_den_f/2) = 0;
        func(Rmatrix > Prob_den_f/2 & Rmatrix < Prob_den_f) = 255;
        
    end