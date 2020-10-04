function [func, varEstimation] = WienerFilter(f, variance)
    [M,N] = size(f);
    
    %Add extra zero layer on the portrait of the matrix
    f = [zeros(1,N); f];
    f = [f;zeros(1,N)];
    f = [zeros(M+2,1),f,zeros(M+2,1)];
    
    %Initializing varuiance and mean matrices
    vr = zeros(M,N);
    mn = zeros(M,N);
    
    %filtering begins
    for i = 2:M+1
        for j = 2:N+1
            window = f(i-1:i+1,j-1:j+1);
            vr(i-1,j-1) = var(reshape(window,1,9));
            mn(i-1,j-1) = mean(reshape(window,1,9));
        end
    end
    
    f = f(2:end-1,2:end-1) - mn;
    varEstimation = mean(reshape(vr,1,M*N));
    %varEstimation = mean(mean(vv));
    h = (vr./(vr+variance));
    func = mn + h .* f;
end