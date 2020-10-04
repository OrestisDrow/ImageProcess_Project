%% FFT functions for image proccessing
clear all;

f = imread('Eikona4.jpg');
f = rgb2gray(f);
%imshow(f,[0 255]);





%{
pwr = PowerSpectrum(F);
psd = 10*log10(PowerSpectrum((FFTshift(F))) + 0.01);
psd1 = PowerSpectrum((FFTshift(F)));
imshow(sqrt(psd1), [0 255]);
%}
%f1 = Med3Filter(f);
%f1 = AddSaltNoise(f,0.1);
%f1 = AddGaussianNoise(f,10,400);
%f1 = uint8(f1);
%imshow(f1);

A = [0 1 2 3 1; 4 3 2 1 0; 5 1 2 3 1];
A = A(1,:);

F = FDCT1(A)
Fmat = idct(A)
Fmine = IFDCT1(A)
%{
matlab_fftshift = fftshift(A);
my_fftshift = FFTshift(A);

A1 = A(1,:);
matlabDCT1 = dct(A1);
myDCT1 = FDCT1(A1);
matlabIDCT1 = idct(matlabDCT1);
myIDCT1 = IFDCT1(myDCT1);
D = IFDCT1(A1);

C = FDCT2(f);
C1 = dct2(f);
%imshow(log(abs(C)),[0 255]);
%imshow(abs(C1),[0 255]);
%DNikos = dct2d(f);


%f1 = f(1, : );
%df = dct1(f1);
%dctfr = dct(f);


%imshow(uint8(d));
%}


%{
pwr = PowerSpectrum(F);
spctr = FFTspectrum(F);
phase = FFTphase(F);
totpwr = TotalSignalPower(f);

a = [1 2 3 4 5; 3 2 1 4 5; 1 2 3 4 5];
FFTshift(a);
fftshift(a);
t = [1 2 3 4 5 6; 7 8 9 10 11 12];
T = FFT2(t);
an = LogFFTspectrum(T);
%}
    %Simple fft of image signal
    function func = FFT2(f)
        N1 = size(f,1);
        temp = zeros(N1, size(f,2));
        for n1 = 1:N1
            temp(n1,:) = fft(f(n1,:));
        end
        temp = transpose(temp);
        N2 = size(temp,1);
        for n2 = 1:N2
            temp(n2,:) = fft(temp(n2,:));
        end
        func = transpose(temp);
    end
    
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
    
    %Power spectrum given Signal_FFT
    function func = PowerSpectrum(F)
        func = real(F).^2 + imag(F).^2;
    end
    
    %FFT spectrum given Signal_FFT
    function func = FFTspectrum(F)
        func = sqrt(real(F).^2 + imag(F).^2);
    end
    
    %FFT phase given signal_FFT
    function func = FFTphase(F)
        func = atan(imag(F)./real(F));
    end
    
    %Total signal power
    function func = TotalSignalPower(f)
        func = sumsqr(f);
    end

    %FFT shift
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
    
    %Log of fft spectrum
    function func = LogFFTspectrum(F)
        func = 10*log10(abs(F) + 0.1);  %C = 0.01
    end
    
    %Median filter 3x3 mask
    function func = Med3Filter(f)
        dimentions = size(f);
        d1 = dimentions(1); %Rows
        d2 = dimentions(2); %Columns
        shadowImg = zeros(d1, d2);
        
        %Applying mask
        for row = 2:d1 - 1
            for col = 2:d2 - 1
               
                mask = f(row - 1:row + 1, col - 1: col + 1);
                mask = reshape(mask, 1, 9);
                mask = sort(mask);
                shadowImg(row, col) = mask(5);
                
            end
        end
        %By default edges of the picture will not be masked
        shadowImg(1, :) = f(1, :);
        shadowImg(d1, :) = f(d1, :);
        shadowImg(:, 1) = f(: , 1);
        shadowImg(:, d2) = f(: , d2);
        func = shadowImg;
    end
    
    %Salt and pepper noise
    function func = AddSaltNoise(f, p)
       
        %if Pa == Pb;
        percen=p;
        Prob_den_f=255*percen/100;
        func = f;
        
        Rmatrix = randi( [0, 255], [size(f,1), size(f,2)]);
        
        func(Rmatrix <= Prob_den_f/2) = 0;
        func(Rmatrix > Prob_den_f/2 & Rmatrix < Prob_den_f) = 255;
        
    end
    
    %Gaussian noise
    function func = AddGaussianNoise(f, const, variance)
        gNoise = randn([size(f,1), size(f,2)]) * sqrt(variance) + const;
        func = gNoise + double(f);
    end
    
     
    function func = DCT2_t(f)
        F = fft2(f);
        temp = zeros(size(F));
        N1 = size(f, 1);
        N2 = size(f, 2);
       
        
        for k1 = 1:N1
            for k2 = 1:N2
                sum1 = 0;
                sum2 = 0;
                for n1 = 1:N1
                    for n2 = 1:N2
                        sum2 = sum2 + f(n1, n2) ...
                            * cos((2*n2+1)*k2*pi/(2*N2));
                    end
                    sum1 = sum1 + cos((2*n1+1)*k1*pi/2/N1);
                end
                temp(k1, k2) = 4*sum1*sum2;
            end
        end
         %{
        temp(k1, k2) = exp(-1i*pi/size(F, 1)) ^ (k1/2) ...
                    * exp(-1i*pi/size(F, 2)) ^ (k2/2) ...
                    * F(k1,k2);
       
        for k1 = 1:size(F, 1)
            for k2 = 1:size(F, 2)
                temp(k1, k2) = 4*f(k1, k2) * cos(
            end
        end
        %}
        func = temp;
        
    end
    
    %Discreet cosin transform of 1 dimension without using fft
    function func = DCT1(f)
        N = size(f,2);
        temp = zeros(1,N);
        
        for k = 1:N
            sum = 0;
            for n = 1:N
                sum = sum + f(n) * cos((2*n-1)*(k-1)*pi/2/N);
            end
            temp(k) = 2 * sum;
        end
        func = temp;
    end
 
    function func = DCT2(f)
        N1 = size(f, 1);
        N2 = size(f, 2);
        G = zeros(N1,N2);
        C = zeros(N1, N2);
        
        for n1 = 1:N1
            G(n1,:) = DCT1(f(n1,:));    %DCT of each row
        end
       
        for k1 = 1:N1
            sum = 0;
            for k2 = 1:N2
                sum = 0;
                for n1 = 1:N1
                    sum = sum + G(n1,k2) * cos((2 * n1 - 1)*(k1-1)*pi/2/N1);
                end
                C(k1, k2) = 2 * sum;
            end
        end
        func = C;
    end
    
    
    %1D fast DCT(using fft)
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
    
    %1D fast inverse DCT(using ifft)
    function ress = IFDCT1(x)
        x =x(:).';
        N = length(x);
        y = zeros(1,2*N);
        y(1:N) = x;
        y(N+1:2*N) = fliplr(x);
        Y = ifft(y);
        k=0:N-1;
        res = real(1/(exp(-1i.* pi.*k./(2*N)).*Y(1:N)));

        res(1) = 1/((res(1)*sqrt(1/N))/2);
        for i=2:1:N
            res(i) = 1/((sqrt(2/N)*res(i))/2);
        end
        ress = res';
    end
    
    %2D fast DCT(using 1D fast DCT)
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
    
    