%CREATECLUSTERGRAPH Takes in a list of factors and returns a Bethe cluster
%   graph. It also returns an assignment of factors to cliques.
%
%   C = CREATECLUSTERGRAPH(F) Takes a list of factors and creates a Bethe
%   cluster graph with nodes representing single variable clusters and
%   pairwise clusters. The value of the clusters should be initialized to 
%   the initial potential. 
%   It returns a cluster graph that has the following fields:
%   - .clusterList: a list of the cluster beliefs in this graph. These entries
%                   have the following subfields:
%     - .var:  indices of variables in the specified cluster
%     - .card: cardinality of variables in the specified cluster
%     - .val:  the cluster's beliefs about these variables
%   - .edges: A cluster adjacency matrix where edges(i,j)=1 implies clusters i
%             and j share an edge.
%  
%   NOTE: The index of the cluster for each factor should be the same within the
%   clusterList as it is within the initial list of factors.  Thus, the cluster
%   for factor F(i) should be found in P.clusterList(i) 
%
% Copyright (C) Daphne Koller, Stanford University, 2012

function P = CreateClusterGraph(F, Evidence)

N = length(F);

P.clusterList = struct('var', [], 'card', [], 'val', []);
P.edges = [];

for j = 1:length(Evidence)
    if (Evidence(j) > 0)
        F = ObserveEvidence(F, [j, Evidence(j)]);
    end
end

vars = unique([F(:).var]);

M = length(vars);

P.edges = zeros(M);

for iVar = 1:M
    var = vars(iVar);
    P.clusterList(iVar).var = var;
    for iCls = 1:N
        if any(F(iCls).var == var)
            if length(F(iCls).var) > 1
                P.edges(iVar, iCls) = 1;
                P.edges(iCls, iVar) = 1;
            else 
                P.clusterList(iVar).card = F(iCls).card;
                P.clusterList(iVar).val = F(iCls).val;
            end
        end
    end
end

idx = M + 1;
for i = 1:N
    if length(F(i).var) > 1
        P.clusterList(idx) = F(i);
        idx = idx + 1;
    end
end

end

