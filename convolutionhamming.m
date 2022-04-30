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
Ws=(4.5e3/fs*2);
Ap=0.8;
As=50;

%to design the fir low pass filter

%normalized cuff off frequency in rad
Wn=(4e3/(fs*2));
order=((As*22e3)/(22*0.5e3))-1;

%to design 
h=fir1(order,Wn,'low',hamming(order+1));

% Let's print out the periods so we know what to expect.
% The period is just 1 over the frequency.
periods = 1 ./ [.08, .1, .22, .4];
% Let's have the max value of x be large enough to contain 4 cycles of the lowest frequency.
xMax = 1*periods(1);
% Let's have, say, 100 samples over that range [0, xMax].
x = linspace(0, xMax, 100);
% Now we have x, so compute y using the formula.
y = sin(2*pi*0.08*x) + sin(2*pi*0.1*x) + sin(2*pi*0.22*x) + sin(2*pi*0.4*x);

%convolution between sigmal and low pass filter;
con=conv(y,h);
plot(con);
