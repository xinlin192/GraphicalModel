% thetaOpt = LRTrainSGD(X, y, lambda) trains a logistic regression
% classifier using stochastic gradient descent. It returns the optimal theta values. 
%
% Inputs:
% X         data.                           (numInstances x numFeatures matrix)
%           X(:,1) is all ones, i.e., it encodes the intercept/bias term.
% y         data labels.                    (numInstances x 1 vector)
% lambda    (L2) regularization parameter.  (scalar)
%
% Outputs:
% thetaOpt  optimal LR parameters.          (numFeatures x 1 vector)
%
% Copyright (C) Daphne Koller, Stanford Univerity, 2012


function thetaOpt = LRTrainSGD(X, y, lambda)

    numFeatures = size(X, 2);
    
    % This sets up an anonymous function gradFn
    % such that gradFn(theta, i) = LRCostSGD(X, y, theta, lambda, i).
    % We need to do this because GradientDescent takes in a function
    % handle gradFunc(theta, i), where gradFunc only takes two input params.
    %
    % For more info, you may check out the official documentation:
    % Matlab - http://www.mathworks.com/help/techdoc/matlab_prog/f4-70115.html
    % Octave - http://www.gnu.org/software/octave/doc/interpreter/Anonymous-Functions.html
    gradFn = @(theta, i)LRCostSGD(X, y, theta, lambda, i);

    % Calculate optimal theta values
    thetaOpt = StochasticGradientDescent(gradFn, zeros(numFeatures, 1), 5000);

end
