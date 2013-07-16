% MHGIBBSTRANS
%
%  MCMC Metropolis-Hastings transition function that
%  utilizes the Gibbs sampling distribution for proposals.
%  A - The current joint assignment.  This should be
%      updated to be the next assignment
%  G - The network
%  F - List of all factors
%
% Copyright (C) Daphne Koller, Stanford University, 2012

function A = MHGibbsTrans(A, G, F)

% Draw proposed new state from Gibbs Transition distribution
A_prop = GibbsTrans(A, G, F);

% Compute acceptance probability
p_acceptance = 1.0;

% Accept or reject proposal
if rand() < p_acceptance
    A = A_prop;
end