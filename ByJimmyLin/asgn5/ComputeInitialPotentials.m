%COMPUTEINITIALPOTENTIALS Sets up the cliques in the clique tree that is
%passed in as a parameter.

%   P = COMPUTEINITIALPOTENTIALS(C) Takes the clique tree C which is a
%   struct with three fields:
%   - nodes: represents the cliques in the tree.
%   - edges: represents the adjacency matrix of the tree.
%   - factorList: represents the list of factors that were used to build
%   the tree. 
%   
%   It returns a compact form of a clique tree P that we will use through 
%   the rest of the assigment. P is struct with two fields:
%   - cliqueList: represents a list of cliques with appropriate factors 
%   from factorList assigned to each clique.
%   - edges: represents the adjacency matrix of the tree. 
%
% Copyright (C) Daphne Koller, Stanford University, 2012

function P = ComputeInitialPotentials(C)

P.cliqueList = C.factorList;

% number of cliques
N = length(C.nodes);

% compute assignment of factors to cliques
alpha = zeros(length(C.factorList),1);

% Setting up the cardinality 
V = unique([C.factorList(:).var]);

% Setting up the cardinality for the variables since we only get a list 
% of factors.
C.card = zeros(1, length(V));
for i = 1 : length(V),

    for j = 1 : length(C.factorList)
        if (~isempty(find(C.factorList(j).var == i)))
            C.card(i) = C.factorList(j).card(find(C.factorList(j).var == i));
            break;
        end
    end
end

for i = 1:length(C.factorList),
    for j = 1:N,

        % does clique contain all variables in factor
        if (isempty(setdiff(C.factorList(i).var, C.nodes{j}))),
            alpha(i) = j;
            break;
        end;
    end;
end;

if (any(alpha == 0)),
    warning('Clique Tree does not have family preserving property');
end;

P.edges = C.edges;

% initialize cluster potentials 
P.cliqueList = repmat(struct('var', [], 'card', [], 'val', []), N, 1);

for i = 1:N,
    P.cliqueList(i).var = C.nodes{i};
    P.cliqueList(i).card = C.card(P.cliqueList(i).var);
    P.cliqueList(i).val = ones(1,prod(P.cliqueList(i).card));
end;

for i = 1:length(alpha),
    P.cliqueList(alpha(i)) = FactorProduct(P.cliqueList(alpha(i)), C.factorList(i));    
end;


end

