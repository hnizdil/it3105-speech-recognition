function h = hmm( word,n )
%HMM Summary of this function goes here
%   Detailed explanation goes here
if nargin == 0
   h.myWord = '';
   h.noHidden = [];
   h = class(h,'hmm');
else
   h.myWord = word;
   h.noHidden = n;
   h = class(h,'hmm');
end