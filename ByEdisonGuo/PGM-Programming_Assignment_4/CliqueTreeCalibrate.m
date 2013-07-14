%CLIQUETREECALIBRATE Performs sum-product or max-product algorithm for 
%clique tree calibration.

%   P = CLIQUETREECALIBRATE(P, isMax) calibrates a given clique tree, P 
%   according to the value of isMax flag. If isMax is 1, it uses max-sum
%   message passing, otherwise uses sum-product. This function 
%   returns the clique tree where the .val for each clique in .cliqueList
%   is set to the final calibrated potentials.
%
% Copyright (C) Daphne Koller, Stanford University, 2012

function P = CliqueTreeCalibrate(P, isMax)

% Number of cliques in the tree.
N = length(P.cliqueList);

% Setting up the messages that will be passed.
% messages(i,j) represents the message going from clique i to clique j. 
messages = repmat(struct('var', [], 'card', [], 'val', []), N, N);

if isMax
    for i = 1:N
        P.cliqueList(i).val = log(P.cliqueList(i).val);
    end
end

% initialise the messages from the leaf nodes
leafIdx = find(sum(P.edges, 2) == 1);
for i = leafIdx'
    iParent = find(P.edges(i, :));
    
    messages(i, iParent) = computeMarginal(P.cliqueList(i), ...
        P.cliqueList(iParent), P.cliqueList(i), isMax);

end

% perform clique tree calibration
while(true)
   [iFrm iTo] = GetNextCliques(P, messages);
   if iFrm == 0 && iTo == 0
       break;
   end
   
   neighbourIdx = find(P.edges(:, iFrm));
   neighbourIdx = setdiff(neighbourIdx, iTo);

   factorProd = computeBelief(P.cliqueList(iFrm), neighbourIdx', ...
       messages, iFrm, isMax);
   
   messages(iFrm, iTo) = computeMarginal(P.cliqueList(iFrm), ...
       P.cliqueList(iTo), factorProd, isMax);

end

% compute the beliefs for each clique
for i = 1:N
    neighbourIdx = find(P.edges(:, i));
    P.cliqueList(i) = computeBelief(P.cliqueList(i), neighbourIdx', ...
        messages, i, isMax);
end


function belief = computeBelief(currentClique, neighbourIdx, messages, iFrm, isMax)

belief = struct('var', [], 'card', [], 'val', []);
for iNh = neighbourIdx
    if isMax
        belief = FactorSum(belief, messages(iNh, iFrm));
    else
        belief = FactorProduct(belief, messages(iNh, iFrm));
    end
    
end

if isMax
    belief = FactorSum(belief, currentClique);
else
    belief = FactorProduct(belief, currentClique);
end

function marginal = computeMarginal(cliqueFrom, cliqueTo, factor, isMax)

marginalVar = intersect(cliqueFrom.var, cliqueTo.var);
marginalisedVar = setdiff(cliqueFrom.var, marginalVar);

if isMax
    marginal = FactorMaxMarginalization(factor, marginalisedVar);
else
    marginal = FactorMarginalization(factor, marginalisedVar);
    marginal.val = marginal.val / sum(marginal.val);
end
