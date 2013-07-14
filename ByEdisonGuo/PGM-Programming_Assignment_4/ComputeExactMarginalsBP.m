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


P = CreateCliqueTree(F, E);
P = CliqueTreeCalibrate(P, isMax);

M = repmat(struct('var', [], 'card', [], 'val', []), length(P.cliqueList), 1);

% compute the marginals
for iVar = 1:length(F)
    for iClq = 1:length(P.cliqueList)
        
        if any(P.cliqueList(iClq).var == iVar)
        
            marginalisedVars = setdiff(P.cliqueList(iClq).var, iVar);
            if isMax
                M(iVar) = FactorMaxMarginalization(P.cliqueList(iClq), marginalisedVars);
            else
                M(iVar) = FactorMarginalization(P.cliqueList(iClq), marginalisedVars);
                M(iVar).val = M(iVar).val / sum(M(iVar).val);
            end
            
            break;
        end
    end
  
end

end
