function [ log_lik alphas B ] = forwardHMM(hmm, data)

log_lik = 0;
totalTime = size(data,3);
alphas = zeros(hmm.noHidden, totalTime);

for t = 0:totalTime-1
	% Calculate the observation matrix.
	% This amounts to calculating likelihoods based on observation model.
	for s = 1:hmm.noHidden
		B(s,t+1) = calcLikelihood(data(:,:,t+1), hmm.obsModel{s});
	end

	% Do forward iterations
	if t==0
		alphas(:, t+1) = diag(B(:,t+1)) * hmm.priorHidden;
	else
		alphas(:, t+1) = diag(B(:,t+1)) * hmm.dynModel' * alphas(:,t);
	end

	% Normalize
	normalizer = sum(alphas(:, t+1));
	log_lik = log_lik + log(normalizer);
	alphas(:, t+1) = alphas(:, t+1) ./ normalizer;
end
