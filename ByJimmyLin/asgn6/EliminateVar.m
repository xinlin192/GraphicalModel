% Function used in production of clique trees
% F = list of factors
% E = adjacency matrix for variables
% Z = variable to eliminate
%
% Copyright (C) Daphne Koller, Stanford University, 2012

function [newF E] = EliminateVar(F, E, Z)

  % Index of factors to multiply (b/c they contain Z)
  useFactors = [];

  % Union of scopes of factors to multiply
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

  % Remove all adjacencies for the variable to be eliminated
  E(Z,:) = 0;
  E(:,Z) = 0;


  % nonUseFactors = list of factors (not indices!) which are passed through
  % in this round
  nonUseFactors = setdiff(1:length(F),[useFactors]);

  for i=1:length(nonUseFactors)
    
    % newF = list of factors we will return
    newF(i) = F(nonUseFactors(i));
    
    % newmap = ?
    newmap(nonUseFactors(i)) = i;
  
  end

  % Multiply factors which involve Z -> newFactor
  newFactor = struct('var', [], 'card', [], 'val', []);
  for i=1:length(useFactors)
    newFactor = FactorProduct(newFactor,F(useFactors(i)));
  end

  newFactor = FactorMarginalization(newFactor,Z);
  newF(length(nonUseFactors)+1) = newFactor;

