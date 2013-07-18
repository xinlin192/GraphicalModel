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
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % YOUR CODE HERE
    % For each variable in the network sample a new value for it given everything
    % else consistent with A.  Then update A with this new value for the
    % variable.  NOTE: Your code should call BlockLogDistribution().
    % IMPORTANT: you should call the function randsample() exactly once
    % here, and it should be the only random function you call.
    %
    % Also, note that randsample() requires arguments in raw probability space
    % be sure that the arguments you pass to it meet that criteria
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end
