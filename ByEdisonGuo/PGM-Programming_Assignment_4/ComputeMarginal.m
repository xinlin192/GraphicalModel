%ComputeMarginal Computes the marginal over a set of given variables
%   M = ComputeMarginal(V, F, E) computes the marginal over variables V
%   in the distribution induced by the set of factors F, given evidence E
%
%   M is a factor containing the marginal over variables V
%   V is a vector containing the variables in the marginal e.g. [1 2 3] for
%     X_1, X_2 and X_3.
%   F is a vector of factors (struct array) containing the factors 
%     defining the distribution
%   E is an N-by-2 matrix, each row being a variable/value pair. 
%     Variables are in the first column and values are in the second column.
%
% Copyright (C) Daphne Koller, Stanford University, 2012


function M = ComputeMarginal(V, F, E)

% Check for empty factor list
assert(numel(F) ~= 0, 'Error: empty factor list');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% YOUR CODE HERE:
% M should be a factor
% Remember to renormalize the entries of M!
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  F = ObserveEvidence(F, E);
  Joint = ComputeJointDistribution(F);
  Joint.val = Joint.val ./ sum(Joint.val);
  M = FactorMarginalization(Joint, setdiff(Joint.var, V));
  %M.val = M.val ./ sum(M.val);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
