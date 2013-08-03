%CREATECLIQUETREE Takes in a list of factors F, Evidence and returns a 
%clique tree after calling ComputeInitialPotentials at the end.
%
%   C = CREATECLIQUETREE(F) Takes a list of factors and creates a clique
%   tree . The value of the cliques should be initialized to 
%   the initial potential. 
%   It returns a clique tree that has the following fields:
%   - .edges: Contains indices of the nodes that have edges between them.
%   - .factorList: Contains the list of factors used to build the Clique
%   tree.
%

% Copyright (C) Daphne Koller, Stanford Univerity, 2012

function P = CreateCliqueTree(F)


C.nodes = {};

V = unique([F(:).var]);

% Setting up the cardinality for the variables since we only get a list 
% of factors.
C.card = zeros(1, length(V));
for i = 1 : length(V),

    for j = 1 : length(F)
        if (~isempty(find(F(j).var == i)))
            C.card(i) = F(j).card(find(F(j).var == i));
            break;
        end
    end
end

C.factorList = F;

% Setting up the adjaceny matrix.
edges = zeros(length(V));

for i = 1:length(F)
    for j = 1:length(F(i).var)
        for k = 1:length(F(i).var)
            edges(F(i).var(j), F(i).var(k)) = 1;
        end
    end
end

cliquesConsidered = 0;

while cliquesConsidered < length(V)
    
    % Using Min-Neighbors where you prefer to eliminate the variable that has
    % the smallest number of edges connected to it. 
    % Everytime you enter the loop, you look at the state of the graph and 
    % pick the variable to be eliminated.
    
    bestClique = 0;
    bestScore = inf;
    for i=1:size(edges,1)
        score = sum(edges(i,:));
        if score > 0 && score < bestScore
            bestScore = score;
            bestClique = i;
        end
    end

    cliquesConsidered = cliquesConsidered + 1;
    [F, C, edges] = EliminateVar(F, C, edges, bestClique);
    
end

% Pruning the tree.
C = PruneTree(C);

% Assume that C now has correct cardinality, variables, nodes and edges. 
% Here we make the function call to assign factors to cliques and compute the
% initial potentials for clusters.

P = ComputeInitialPotentials(C);

