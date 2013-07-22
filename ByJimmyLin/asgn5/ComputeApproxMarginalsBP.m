% COMPUTEAPPROXMARGINALSBP Computation of approximate marginals using Loopy BP
%   M = COMPUTEAPPROXMARGINALSBP(F,E ) returns the approximate marginals over
%       each variable in F given the evidence E.
%   . 
%   The Factor list F has the following fields:
%     - .var:  indices of variables in the specified cluster
%     - .card: cardinality of variables in the specified cluster
%     - .val:  the cluster's beliefs about these variables
%   - .edges: Contains indices of the clusters that have edges between them.
%
%   The Evidence E is a vector of length equal to the number of variables in the
%   factors where 0 stands for unobserved and other values are an observed 
%   assignment to that variable. It can be left empty (E=[]) if there is no evidence
%  
%   M should be an array of factors with one factor for each variable and 
%   M(i).val should be filled in with the marginal of variable i.
%
%
% Copyright (C) Daphne Koller, Stanford University, 2012

function M = ComputeApproxMarginalsBP(F,E)

    % returning approximate marginals.
    
    clusterGraph = CreateClusterGraph(F,E);
    
    P = ClusterGraphCalibrate(clusterGraph);
    
    N = unique([P.clusterList(:).var]);
    
    % compute marginals on each variable
    M = repmat(struct('var', 0, 'card', 0, 'val', []), length(N), 1);

    % Populate M so that M(i) contains the marginal probability over
    % variable i
    for i = 1:length(N),
    
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % YOUR CODE HERE
        %
        % Populate M(i) such that M(i) contains a factor representation of
        % the marginal proability over the variable with index i.
        % (ie. M(i).val is the actual marginal)
        %
        % You may want to use the helper function 'FindPotentialWithVariable'
        % which is defined at the bottom of this file.  Read through it
        % to make sure you understand its functionality.
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end



return;

% Helper function:
function indx = FindPotentialWithVariable(P, V)

indx = 0;
for i = 1:length(P.clusterList),
    if (any(P.clusterList(i).var == V)),
        indx = i;
        return;
    end;
end;

return;
