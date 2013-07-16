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

clusterGraph = CreateClusterGraph(F,E);
P = ClusterGraphCalibrate(clusterGraph);

M = struct('var', [], 'card', [], 'val', []);
for i = 1:length(P.clusterList)
    if length(P.clusterList(i).var) == 1
        M(i) = P.clusterList(i);
        M(i).val = M(i).val / sum(M(i).val);
    end
end

