%RECOGNIZE reconizes a word from a wav-file
%   input: file path of the wav-file that has to be recognized (with or
%          without .wav extension
%   output: string representation of the found word (start, stop, left,
%           right.
function [ word ] = recognize( filepath )

% capture data from wav-file
[ data Fs nbits ] = wavread(filepath);

% extract features from data
data = dataPrep(data, Fs);

% train start model
hstart = hmm('start', 5);
train_model(h);


c = classifier;
word = classify(c,data);
