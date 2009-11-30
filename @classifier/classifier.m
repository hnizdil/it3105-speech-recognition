classdef classifier
    properties
        words
    end
    
    methods
        function c = classifier()
            c.words = [hmm('start',5) , hmm('stop',4) , ...
                       hmm('left',4) , hmm('right',3)];
        end
        
        function word = classify(data)
            maxP = 0.25;    %threshold for recognizing a word (?)
            hmmIndex = 0;
            for i = 1:size(words,2) %go through all hmm and compare probability
                P = forwardHMM(words(i), data);
                if(P > maxP)
                    maxP = P;
                    hmmIndex = i;
                end;
            end
            if(hmmIndex > 0)
                word = words(hmmIndex).myWord;
            else
                word = 'not found';
            end;    
        end    
    end
end    