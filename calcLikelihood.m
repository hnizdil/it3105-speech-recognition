function [ p ] = calcLikelihood( data, model )
%CALCLIKELIHOOD calculates the probability of an observation
%   if model=0 then µ=0
n = size(data,1);
if(~isa(model, 'struct'))
    mu = 0;
else
    mu = model.mu;
end;    
%sigma = model.sigma;
p = mvnpdf(data,mu);%,sigma);
c = logspace(0,1,n);
c = c ./ sum(c);
c = fliplr(c);
res = 0;
for i = 1:n     %weight the different probabilities
    res = res + (p(i)*c(i));
end
p = res;
end