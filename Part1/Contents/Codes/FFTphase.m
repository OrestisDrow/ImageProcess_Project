    function func = FFTphase(F)
        func = atan(imag(F)./real(F));
    end