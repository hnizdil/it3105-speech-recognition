classdef hmm
    properties
        myWord
        noHidden
        dynModel
        obsModel
        priorHidden
    end
    
    methods

        function h = hmm( name, n )
        %HMM Summary of this function goes here
        %   Detailed explanation goes here
        if nargin == 0
           h.myWord = '';
           h.noHidden = [];
        else
           h.myWord = name;
           h.noHidden = n;
        end
        end
    end
end    