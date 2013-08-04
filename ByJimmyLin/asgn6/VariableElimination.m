% VariableElimination takes in a list of factors F and a list of variables to eliminate
% and returns the resulting factors after running sum-product to eliminate
% the given variables.  Note that it may return more than one
% factor.  
%
%   Fnew = VariableElimination(F, Z) 
%   F = list of factors
%   Z = list of variables to eliminate
%
% Copyright (C) Daphne Koller, Stanford University, 2012

function Fnew = VariableElimination(F, Z)

% List of all variables
V = unique([F(:).var]);

% Setting up the adjacency matrix.
edges = zeros(length(V));

for i = 1:length(F)
    for j = 1:length(F(i).var)
        for k = 1:length(F(i).var)
            edges(F(i).var(j), F(i).var(k)) = 1;
        end
    end
end

variablesConsidered = 0;

while variablesConsidered < length(Z)
    
    % Using Min-Neighbors where you prefer to eliminate the variable that has
    % the smallest number of edges connected to it. 
    % Everytime you enter the loop, you look at the state of the graph and 
    % pick the variable to be eliminated.
    bestVariable = 0;
    bestScore = inf;
    for i=1:length(Z)
      idx = Z(i);
      score = sum(edges(idx,:));
      if score > 0 && score < bestScore
	bestScore = score;
	bestVariable = idx;
      end
    end

    variablesConsidered = variablesConsidered + 1;
    [F, edges] = EliminateVar(F, edges, bestVariable);
    
end

Fnew = F;
    
