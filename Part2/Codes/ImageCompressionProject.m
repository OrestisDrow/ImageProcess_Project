clear;
clc;

%% Task1
x = load('Fruits.mat');
x = struct2cell(x);
x = cell2mat(x);
X = FDCT2(x);

%small elements replaced by zeroes
X(abs(X) < 0.0001) = 0;         

%Nonzero Percentage
Nonzeros = nnz(X);
Nzpercent = Nonzeros/(128*128);
imshow(X);

%% Task2
N = 128;
K = N^2;
k = 6000;
F = normrnd(0,1,[k K]);		%F ~ N(0,1) -> k x N^2
i = reshape(X,K,1);         %i -> N^2 x 1
y = F*i;                    %y -> k x N^2 x N^2 x 1 = k x 1

[i_,residueErr] = OMP(y,F,400,0.05);
Z = reshape(i_,N,N);
z = idct2(Z);
imshow(z);
%[q=400,k=4000/5000/6000]
function [ i_, residueErr] = OMP(y,F,q,err) 
    [k,K] = size(F);
    i_= zeros(K,1);
    r=y;
    T=[];
    cntr = 1;
    residueErr = 1;     %for 100%
    while cntr < q && residueErr > err
        [~,jj] = max(abs(transpose(F)* r)); 
        T = union(T,jj);
        i_(T)=pinv(F(:,T)) * y;  %%coeffecient update
        r=y-F*i_;                %%residu update
        cntr = cntr + 1;
        residueErr = norm(r)/norm(y);
    end
end


