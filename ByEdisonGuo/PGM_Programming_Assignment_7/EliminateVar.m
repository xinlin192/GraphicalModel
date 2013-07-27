% Function used in production of clique trees
%
% Copyright (C) Daphne Koller, Stanford Univerity, 2012

function [newF C E] = EliminateVar(F, C, E, Z)

useFactors = [];
scope = [];

for i=1:length(F)
    if any(F(i).var == Z)
        useFactors = [useFactors i];
        scope = union(scope, F(i).var);
    end
end

% update edge map
% These represent the induced edges for the VE graph.
for i=1:length(scope)
    for j=1:length(scope)
        
        if i~=j
            E(scope(i),scope(j)) = 1;
            E(scope(j),scope(i)) = 1;
        end
    end
end

E(Z,:) = 0;
E(:,Z) = 0;


nonUseFactors = setdiff(1:length(F),[useFactors]);

for i=1:length(nonUseFactors)
    newF(i) = F(nonUseFactors(i));
    newmap(nonUseFactors(i)) = i;
end

newFactor = struct('var', [], 'card', [], 'val', []);
for i=1:length(useFactors)
    newFactor = FactorProduct(newFactor,F(useFactors(i)));
end

newFactor = FactorMarginalization(newFactor,Z);
newF(length(nonUseFactors)+1) = newFactor;

newC = length(C.nodes)+1;
C.nodes{newC} = scope;
C.factorInds(newC) = length(nonUseFactors)+1;
for i=1:newC-1
    if ismember(C.factorInds(i), useFactors)
        C.edges(i,newC) = 1;
        C.edges(newC,i) = 1;
        C.factorInds(i) = 0;
    else
        if C.factorInds(i) ~= 0
            C.factorInds(i) = newmap(C.factorInds(i));
        end
    end
end
