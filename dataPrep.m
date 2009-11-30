function [ prepData ] = dataPrep( data, Fs )
%DATAPREP prepares audio data for further processing in the SRS
%   data - vector of signed floating point numbers belonging to a discrete signal
%   Fs - sampling frequency/rate
L = Fs/100; %length of frame (1/100 of a sec)
y=data;
NFFT = 2^nextpow2(L);   %power of 2 because of FFT algorithm
y=y./max(abs(y));    %not sure about this normalization
frames=buffer(y,L,round(L/2),'nodelay');    %overlapping is 50%
dim=size(frames);
F=zeros(NFFT,dim(2));
for i=1:dim(2)  %windowing and fft
    F(:,i)=fft(frames(:,i).*hamming(size(frames,1)),NFFT);
end
F = abs(F(1:NFFT/2,:))./(2*pi);
freq = linspace(0,1,NFFT/2); %normalized version (for real values *Fs/2)
noFeatures = 5;
res=zeros(noFeatures,2,dim(2)); %3-D array for feature vectors
for i=1:dim(2)  %go through all frames
    for j=1:noFeatures  %capture greatest magn. and according freq. 
        [amp x] = max(F(:,i));
        f = freq(x);    %get according frequency
        res(j,:,i) = [amp f];
        F(x,i) = 0; %remove last max. value to find the second next round
    end
end    
prepData = res;
end