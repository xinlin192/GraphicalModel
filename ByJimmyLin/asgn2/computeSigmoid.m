function sigVal = computeSigmoid(z)
% This function computes the value of the sigmoid of all of the numbers in 
% an n x 1 vector, where n is the length of z.
%
% Input:
%   z: The n x 1 vector, where n is the length of z, of values whose 
%   sigmoids need to be found
%
% Output:
%   sigVal: The value of the sigmoid

expz = exp(z);
sigVal = expz ./ (1 + expz);