function [ word ] = recognize( filepath )
%RECOGNIZE reconizes a word from a wav-file
%   input: file path of the wav-file that has to be recognized (with or
%          without .wav extension
%   output: string representation of the found word (start, stop, left,
%           right.

data = wavread(filepath);   %capture data from wav-file
data = dataPrep(data);  %extract features from data
c = classifier;
word = c.classify(data);

end