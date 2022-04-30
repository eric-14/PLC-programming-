clc; %clear the command window
close all; %clear all windows except those of imtods
clear ;
workspace;  % Make sure the workspace panel is showing.
format long g;
format compact;
fontSize = 20;
% Let's print out the periods so we know what to expect.
% The period is just 1 over the frequency.


%We define thr specifications of the filter
fs=22e3;

%normalized frequencies in rad

Wp=(2*4e3/fs);
Ws=2*(4.5e3/fs);
Ap=0.8;
As=50;

%to design the fir low pass filter

%normalized cuff off frequency in rad
Wn=2*(4e3/fs);
order=((As*22e3)/(22*0.5e3))-1;

%to design 
h=fir1(order,Wn,'low');

%need to get the transfer function;
[H,W]=freqz(h,1);
subplot(2,1,1);

%only extract magnitude using absolute command
plot(W/pi,20*log(abs(H)));
xlabel('nf');
ylabel ('mag in db');
title('mag response')
subplot(2,1,2);
plot (W/pi, angle(H));
xlabel('nf'); 
ylabel('angle');
title('phase response');








