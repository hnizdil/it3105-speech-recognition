function [log_lik fwd_messages obsVec] = forwardHMM(hmm, data)

totalTime = size(data,3);
fwd_messages = zeros(hmm.noHidden, totalTime);

for t = 0:totalTime-1
	% Calculate the observation matrix.
	% This amounts to calculating likelihoods based on observation model.
	for state = 1:hmm.noHidden
		obsVec(state, t+1) = calcLikelihood(data(:,:,t+1), hmm.obsModel{state});
	end

	% Do forward iterations
	if t==0
		fwd_messages(:, t+1) = diag(obsVec(:, t+1)) * hmm.priorHidden;
	else
		fwd_messages(:, t+1) = diag(obsVec(:, t+1)) * hmm.dynModel' * fwd_messages(:,t);
	end

	% Normalize:
	normalizer = sum(fwd_messages(:, t+1));
	log_lik = log(normalizer);
	fwd_messages(:, t+1) = fwd_messages(:, t+1) ./ normalizer;
end
