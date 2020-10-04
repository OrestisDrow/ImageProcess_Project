clear;
%Simple script that plots out my outputs
SQRT = [14.14 12.40 8.01 6.18 6.45 7.18];
Res = [24.24 26.13 15.64 11.33 11.18 10.53];
k = [1000 6000 6000 6000 5000 4000];
Q = [50 50 200 400 400 400];

subplot(2,1,1)
plot3(k,Q,Res),xlabel('k'),ylabel('q'),zlabel('Res%');
title('ResPlot')
subplot(2,1,2)
plot3(k,Q,SQRT),xlabel('k'),ylabel('q'),zlabel('SQRT');
title('SQRTPlot')