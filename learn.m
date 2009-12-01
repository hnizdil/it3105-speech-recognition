function [] = learn (hmm, data)

N = hmm.noHidden;
totalTime = size(data, 3);

%
% part A
%

% do forward passes
[ log_lik alphas B ] = forwardHMM(hmm, data);

% do backward passes
[ betas ] = backwardHMM(hmm, B);

%
% part B
%

% loop through all t
for t = 1:totalTime-1
	% xi
	xi(:,:,t) = hmm.dynModel ...
		.* repmat( alphas(:,t),   1, N ) ...
		.* repmat( B(:,t+1)',     N, 1 ) ...
		.* repmat( betas(:,t+1)', N, 1 );

	xi(:,:,t) = xi(:,:,t) / sum(sum(xi(:,:,t)));

	% gamma
	gamma(:,t) = sum(xi(:,:,t), 2);
end

%
% part C
%

% reestimate prior distribution
hmm.priorHidden = gamma(:,1);

% reestimate transition model
for i = 1:N
	denom = sum(gamma(i,1:totalTime-1));
	for j = 1:N
		hmm.dynModel(i,j) = sum(xi(i,j,1:totalTime-1)) / denom;
	end

	% normalization
	hmm.dynModel(i,:) = hmm.dynModel(i,:) ./ sum(hmm.dynModel);
end
%
% part D
%

% no mixture

%
% part E
%

% update mu
for i = 1:N
	denom = sum(gamma(i,:));
	hmm.obsModel{i}.mu = sum(gamma(i,:) .* B(i,1:totalTime-1)) / denom;
	%TODO
	hmm.obsModel{i}.sigma = eye(2);
end
