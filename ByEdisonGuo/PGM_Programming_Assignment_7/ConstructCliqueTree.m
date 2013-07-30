function P = ConstructCliqueTree(X, theta, modelParams, featureSet)
    nVar = size(X, 1);
    K = modelParams.numHiddenStates;
    
    factors = repmat(struct('var', [], 'card', [], 'val', []), 1, 2*nVar - 1);
    pairVar2factors = zeros(nVar);
    for i = 1:nVar
        factors(i).var = i;
        factors(i).card = K;
        factors(i).val = zeros(1, K);
        
        if i < nVar
            j = i + nVar;
            pairVar2factors(i, i+1) = j;
            factors(j).var = [i i+1];
            factors(j).card = [K K];
            factors(j).val = zeros(1, K^2);
        end
    end
    
    for i = 1:length(featureSet.features)
        feature = featureSet.features(i);
        if length(feature.var) == 1
            factors(feature.var).val(feature.assignment) = ...
                factors(feature.var).val(feature.assignment) + theta(feature.paramIdx);
        elseif length(feature.var) == 2
            iFct = pairVar2factors(feature.var(1), feature.var(2));
            idx = AssignmentToIndex(feature.assignment, factors(iFct).card);
            factors(iFct).val(idx) = factors(iFct).val(idx) + theta(feature.paramIdx);
        end
    end
    
    for i = 1:length(factors)
        factors(i).val = exp(factors(i).val);
    end
    
    P.cliqueList = repmat(struct('var', [], 'card', [], 'val', []), 1, nVar - 1);
    
    for i = 1:nVar - 1
        iFct = pairVar2factors(i, i+1);
        P.cliqueList(i) = factors(iFct);
        
        if i <= 1
            vars = P.cliqueList(i).var;
        else
            vars = P.cliqueList(i).var(2:end);
        end
      
        for j = vars
            P.cliqueList(i) = FactorProduct(P.cliqueList(i), factors(j));
        end
    end
   
    P.edges = zeros(nVar-1);
    for i = 1:nVar - 2
        P.edges(i, i+1) = 1;
        P.edges(i+1, i) = 1;
    end
end