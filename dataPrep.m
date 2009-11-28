function [ prepData ] = dataPrep( data )
%DATAPREP Summary of this function goes here
%   Detailed explanation goes here
y=data;
y=y.*hamming(length(y));
y=y./max(y);
frames=buffer(y,80,40,'nodelay');
dim=size(frames);
F=zeros(dim);
for i=1:dim(2)
    F(:,i)=fft(frames(:,i));
end
F=abs(F(1:40,:))./(2*pi);
res=zeros(1,size(F,2));
for i=1:size(F,2)
    res(i)=max(F(:,i));
end
prepData = res;
end