function [log_lik fwd_messages] = forwardHMM(hmm, data)
log_lik = 0; totalTime = size(data,2);
fwd_messages = zeros(hmm.noHidden, totalTime);
for t = 0:totalTime-1
% Calculate the observation matrix.
% This amounts to calculating likelihoods based on observation model.
obsVec = zeros(hmm.noHidden,1);
for state = 1:hmm.noHidden
obsVec(state) = calcLikelihood(data(:,t+1), hmm.obsModels{state});
end
% Do ‘forward iterations’:
if t==0
fwd_messages(:, t+1) = diag(obsVec)* hmm.priorHidden;
else
fwd_messages(:, t+1) = diag(obsVec)* hmm.dynModel' * fwd_messages(:,t);
end
% Normalize:
normalizer = sum(fwd_messages(:, t+1));
fwd_messages(:, t+1) = fwd_messages(:, t+1) ./ normalizer;
log_lik = log_lik + log(normalizer);
end