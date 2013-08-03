% [cost, grad] = LRCostSGD(X, y, theta, lambda, i) calculates the LR cost / objective
% function with respect to data instance (i mod n), given the LR classifier parameterized 
% by theta and where n = the number of data instances.  Also returns the gradient of 
% the cost function with respect to data instance (i mod n).
% The aim of LR training is to find the theta that minimizes this function.
%
% Inputs:
% X         data.                           (numInstances x numFeatures matrix)
%           X(:,1) is all ones, i.e., it encodes the intercept/bias term.
% y         data labels.                    (numInstances x 1 vector)
% theta     LR parameters.                  (numFeatures x 1 vector)
% lambda    (L2) regularization parameter.  (scalar)
% i         index of a data sample.         (integer from 1:size(X,1))
%
% Outputs:
% cost      cost function of the LR classifier evaluated on (X,y). (scalar)
% grad      gradient of the cost function.  (numFeatures x 1 vector)
%
% Copyright (C) Daphne Koller, Stanford Univerity, 2012


function [cost, grad] = LRCostSGD(X, y, theta, lambda, i)
    i = mod(i, size(X,1)) + 1;
  
    h = sigmoid (X(i,:) * theta);

    % Calculate cost function
    cost = sum((-y(i) .* log(h)) - ((1 - y(i)) .* log(1 - h))) + 0.5 * lambda * sum(theta(2:end) .^ 2);

    % Calculate gradient
    grad =  X(i,:)' * (h - y(i));

    % Apply regularization to the weights (but not the bias term)
    grad(2:end) = grad(2:end) +  lambda * theta(2:end);

end
