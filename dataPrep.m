%DATAPREP prepares audio data for further processing in the SRS
%   data - vector of signed floating point numbers belonging to a discrete signal
%   Fs - sampling frequency/rate
function [ prepData ] = dataPrep( data, Fs )

L = Fs/100; %length of frame (1/100 of a sec)
y = data;

% power of 2 because of FFT algorithm
NFFT = 2^nextpow2(L);

%y=y.*hamming(length(y));

% not sure about this normalization
y = y ./ max(abs(y));

% overlapping is 50%
frames = buffer(y, L, round(L/2), 'nodelay');

dim = size(frames);

% windowing and fft (F has same dimensions as frames)
F = fft(frames .* repmat( hamming(dim(1)),1,dim(2) ), NFFT);

% F is symmetric, so we can cut the lower half
NFFT = NFFT / 2;

F = abs(F(1:NFFT,:)) ./ (2*pi);

% normalized version (for real values *Fs/2)
freq = linspace(0, 1, NFFT);

noFeatures = 5;

% go through all frames
for i=1:dim(2)
	% capture greatest magnitude and according frequency
	for j=1:noFeatures
		[ amp x ] = max(F(:,i));
		% get according frequency
		prepData(j,:,i) = [ amp freq(x) ];
		% remove last max value to find the second next round
		F(x,i) = 0;
	end
end
