% CLUSTERGRAPHCALIBRATE Loopy belief propagation for cluster graph calibration.
%   P = CLUSTERGRAPHCALIBRATE(P, useSmart) calibrates a given cluster graph, G,
%   and set of of factors, F. The function returns the final potentials for
%   each cluster. 
%   The cluster graph data structure has the following fields:
%   - .clusterList: a list of the cluster beliefs in this graph. These entries
%                   have the following subfields:
%     - .var:  indices of variables in the specified cluster
%     - .card: cardinality of variables in the specified cluster
%     - .val:  the cluster's beliefs about these variables
%   - .edges: A cluster adjacency matrix where edges(i,j)=1 implies clusters i
%             and j share an edge.
%  
%   UseSmart is an indicator variable that tells us whether to use the Naive or Smart
%   implementation of GetNextClusters for our message ordering
%
%   See also FACTORPRODUCT, FACTORMARGINALIZATION
%
% Copyright (C) Daphne Koller, Stanford University, 2012

function P = ClusterGraphCalibrate(P)

N = length(P.clusterList);

messages = repmat(struct('var', [], 'card', [], 'val', []), N, N);
[edgeFromIndx, edgeToIndx] = find(P.edges);

for m = 1:length(edgeFromIndx)
    i = edgeFromIndx(m);
    j = edgeToIndx(m);

     nVar = length(P.clusterList(i).var);
     if nVar == 1
         messages(i, j) = P.clusterList(i);
     end
 
end

tic;
iteration = 1;
thresh = 1.0e-6;

prevMessages = messages;

while (1)
    
    [i, j msgDiff] = GetNextClusters(messages,prevMessages, ...
        edgeFromIndx, edgeToIndx); 
    
    % Check for convergence every m iterations
    if mod(iteration, length(edgeFromIndx)) == 0
        if msgDiff <= thresh
            break;
        end
        disp(['RBP Messages Passed: ', int2str(iteration), '...']);
       
    end
    
    prevMessages(i,j) = messages(i,j);

    neighbourIdx = find(P.edges(:, i));
    neighbourIdx = setdiff(neighbourIdx, j);
    
    belief = P.clusterList(i);
    for iNb = neighbourIdx'
        belief = FactorProduct(belief, messages(iNb, i));
    end
    
    marginalisedVars = setdiff(P.clusterList(i).var, P.clusterList(j).var);
    messages(i, j) = FactorMarginalization(belief, marginalisedVars);
    messages(i, j).val = messages(i, j).val / sum(messages(i, j).val);
    
    iteration = iteration + 1;
end

toc;
disp(['Total number of messages passed: ', num2str(iteration)]);

% Compute final potentials and place them in P
for m = 1:length(edgeFromIndx),
    j = edgeFromIndx(m);
    i = edgeToIndx(m);
    P.clusterList(i) = FactorProduct(P.clusterList(i), messages(j, i));
end


