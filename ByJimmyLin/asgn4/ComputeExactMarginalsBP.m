%COMPUTEEXACTMARGINALSBP Runs exact inference and returns the marginals
%over all the variables (if isMax == 0) or the max-marginals (if isMax == 1). 
%
%   M = COMPUTEEXACTMARGINALSBP(F, E, isMax) takes a list of factors F,
%   evidence E, and a flag isMax, runs exact inference and returns the
%   final marginals for the variables in the network. If isMax is 1, then
%   it runs exact MAP inference, otherwise exact inference (sum-prod).
%   It returns an array of size equal to the number of variables in the 
%   network where M(i) represents the ith variable and M(i).val represents 
%   the marginals of the ith variable. 
%
% Copyright (C) Daphne Koller, Stanford University, 2012


function M = ComputeExactMarginalsBP(F, E, isMax)

% initialization
% you should set it to the correct value in your code
M = [];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% YOUR CODE HERE
%
% Implement Exact and MAP Inference.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% if isMax == 0,  sum-product for prob query
% else  max-sum for map query

    % for marginal probability inference, initialise the resulted array
    M = repmat(struct('var', [], 'card', [], 'val', []), 1);
    % create the inferred clique tree based on given factors
    P = CreateCliqueTree(F, E); 
    % apply message passing algorithm to reach calibration
    P = CliqueTreeCalibrate(P, isMax);
    % derive the number of cliques
    N = size(P.cliqueList);
    % initialise the set of variables whose marginal has been derived
    V = [];
    % traverse beliefs of all established cliques
    for i = 1:N,
        % compute for all solved variables in accessed clique
        for v = setdiff(P.cliqueList(i).var, V), 
            % marginalise and normalise
            if ~isMax % sum-product 
                M(v) = ComputeMarginal([v], [P.cliqueList(i)], E);
            else % max-sum
                tmp = ObserveEvidence(P.cliqueList(i), E);
                M(v) = FactorMaxMarginalization(tmp, setdiff(tmp.var, [v]));
            end
        end
    end

end
