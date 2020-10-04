
function func = AddGaussianNoise(f, const, variance)
        gNoise = randn([size(f,1), size(f,2)]) * sqrt(variance) + const;
        func = gNoise + double(f);
end