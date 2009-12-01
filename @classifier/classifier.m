classdef classifier
	properties
		words
		dummy
	end

	methods
		function c = classifier
			c.words = [ ...
				hmm('start', 5), hmm('stop',  4), ...
				hmm('left',  4), hmm('right', 3) ...
			];
		end

		function word = classify(obj, data)
			% threshold for recognizing a word (?)
			maxP = 0;
			hmmIndex = 0;
			% go through all hmm and compare probability
			for i = 1:size(obj.words,2)
				h = obj.words(i);
				h.myWord;
				[l f] = forwardHMM(h, data);
				P = exp(l);
				if (P > maxP)
					maxP = P;
					hmmIndex = i;
				end
			end

			if (hmmIndex > 0)
				word = obj.words(hmmIndex).myWord;
			else
				word = 'not found';
			end
		end
	end
end
