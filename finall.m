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
h=fir1(order,Wn,'low');

% Let's print out the periods so we know what to expect.
% The period is just 1 over the frequency.
periods = 1 ./ [.08, .1, .22, .4];
% Let's have the max value of x be large enough to contain 4 cycles of the lowest frequency.
xMax = 1*periods(1);
% Let's have, say, 500 samples over that range [0, xMax].
x = linspace(0, xMax, 200);
% Now we have x, so compute y using the formula.
y = sin(2*pi*0.08*x) + sin(2*pi*0.1*x) + sin(2*pi*0.22*x) + sin(2*pi*0.4*x);
%change to frequency domain.
%to pass it through filter, first find signal length
nfft=length(y);
nfft2=2.^nextpow2(nfft);

%Transform impulse response of filter
fh=fft(h,nfft2);
fh=fh(1:nfft2/2); %dividing x-axis into half
%converting to frequency domain.
fy=fft(y,nfft2);
fy=fy(1:nfft2/2); %we will only use magnitude response.
%assign axis of frequency domain.
xfft=fs.*(0:nfft2/2-1)/nfft2;
%plot(xfft,abs(fy/max(fy))); %used to plot frequency domain %we have to take the absolute function for magnitude.
mul=fy.*fy; %we multiply in frequency domain to get convolution.

subplot(3,2,1);
plot(xfft,abs(fy/max(fy)));
subplot(3,2,2);
plot(xfft,abs(fh/max(fh)));
subplot(3,2,3);
plot(abs(mul));
