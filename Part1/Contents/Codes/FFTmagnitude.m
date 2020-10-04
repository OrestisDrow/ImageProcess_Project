function func = FFTmagnitude(F)
        func = sqrt(real(F).^2 + imag(F).^2);
    end