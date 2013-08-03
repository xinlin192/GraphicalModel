% function thetaOpt = StochasticGradientDescent (gradFunc, theta0, maxiter)
% runs gradient descent until convergence, returning the optimal parameters thetaOpt.
%
% Inputs:
% gradFunc      function handle to a function [cost, grad] = gradFunc(theta, i)
%               that computes the LR cost / objective function and the gradient 
%               of the negative log likelihood of the ith data instance, given 
%               parameters theta.
% theta0        initial value of theta to start gradient descent from.
% maxIter       number of iterations to run SGD for.
%
% Output:
% thetaOpt      optimal value of theta.
%
%
% Note - function handles may be new to some of you. Briefly, function handles
% are a way of passing a function to another function as an argument. The
% syntax for calling a function handle is exactly the same as for calling any
% other function. 
%
% For more information, refer to the official documentation:
% Matlab - http://www.mathworks.com/help/techdoc/matlab_prog/f2-38133.html
% Octave - http://www.gnu.org/software/octave/doc/interpreter/Function-Handles.html
%
% Copyright (C) Daphne Koller, Stanford Univerity, 2012


function thetaOpt = StochasticGradientDescent (gradFunc, theta0, maxIter)

    % The grader will accept all answers that are near enough
    % to the optimal value, so don't worry about being off by one 
    % iteration etc.
    
    thetaOpt = zeros(size(theta0));

    %%%%%%%%%%%%%%
    %%% Student code

    %%%%%%%%%%%

end

