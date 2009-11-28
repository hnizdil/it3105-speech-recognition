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
        
        end    
    end
end    