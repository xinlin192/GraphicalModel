function M = ComputeMarginals(nVar, P, isMax)
   
    M = repmat(struct('var', [], 'card', [], 'val', []), length(P.cliqueList), 1);
    for iVar = 1:nVar
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