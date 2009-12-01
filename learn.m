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

% initialize xi and gamma
xi = [];
gamma = [];

% loop through all t
for t = 1:totalTime-1
	% denominator
	denom = 0;
	for i = 1:N
		for j = 1:N
			denom = denom + alphas(i,t) * hmm.dynModel(i,j) * B(j,t+1) * betas(j,t+1);
		end
	end
	% xi at time t calculations
	for i = 1:N
		for j = 1:N
			xi(i,j,t) = ( alphas(i,t) * hmm.dynModel(i,j) * B(j,t+1) * betas(j,t+1) ) / denom;
		end
		gamma(i,t) = sum(xi(i,:,t));
	end
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
