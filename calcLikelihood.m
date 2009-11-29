function [ p ] = calcLikelihood( data, model )
%CALCLIKELIHOOD Summary of this function goes here
%   Detailed explanation goes here
mu = model.mu;
%sigma = model.sigma;
p = mvnpdf(data,mu);%,sigma);
p = 0.5*p(1)+0.25*p(2)+0.125*p(3)+0.0625*(p(4)+p(5));

end