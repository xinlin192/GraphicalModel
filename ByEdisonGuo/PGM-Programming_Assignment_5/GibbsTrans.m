% GIBBSTRANS
%
%  MCMC transition function that performs Gibbs sampling.
%  A - The current joint assignment.  This should be
%      updated to be the next assignment
%  G - The network
%  F - List of all factors
%
% Copyright (C) Daphne Koller, Stanford University, 2012

function A = GibbsTrans(A, G, F)

for i = 1:length(G.names)
    dist = BlockLogDistribution(i, G, F, A);
    A(i) = randsample(1:G.card(i), 1, true, exp(dist));
end
