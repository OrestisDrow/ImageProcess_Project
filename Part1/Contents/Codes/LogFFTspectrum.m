
    function func = LogFFTspectrum(F)
        func = 10*log10(abs(F) + 0.1);  %C = 0.01
    end