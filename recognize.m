function [ word ] = recognize( filepath )
%RECOGNIZE reconizes a word from a wav-file
%   input: file path of the wav-file that has to be recognized (with or
%          without .wav extension
%   output: string representation of the found word (start, stop, left,
%           right.

[data Fs nbits] = wavread(filepath);   %capture data from wav-file
data = dataPrep(data, Fs);  %extract features from data
c = classifier;
word = classify(c,data);

end
