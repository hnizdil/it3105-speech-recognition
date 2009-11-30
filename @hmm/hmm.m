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
           %random init values for probabilities
           h.priorHidden = rand(n,1);
           h.priorHidden = h.priorHidden ./ sum(h.priorHidden);
           h.dynModel = rand(n);
           h.obsModel = cell(n,1);
           for i = 1:n  %normalization of every row to fit stochastic constraints
              h.dynModel(i,:) = h.dynModel(i,:) ./ sum(h.dynModel);
              h.obsModel{i} = struct('mu', 0, 'sigma', eye(5));
           end
        end
        end
    end    
end    