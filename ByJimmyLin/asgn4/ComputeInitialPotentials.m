%COMPUTEINITIALPOTENTIALS Sets up the cliques in the clique tree that is
%passed in as a parameter.
%
%   P = COMPUTEINITIALPOTENTIALS(C) Takes the clique tree skeleton C which is a
%   struct with three fields:
%   - nodes: cell array representing the cliques in the tree.
%   - edges: represents the adjacency matrix of the tree.
%   - factorList: represents the list of factors that were used to build
%   the tree. 
%   
%   It returns the standard form of a clique tree P that we will use through 
%   the rest of the assigment. P is struct with two fields:
%   - cliqueList: represents an array of cliques with appropriate factors 
%   from factorList assigned to each clique. Where the .val of each clique
%   is initialized to the initial potential of that clique.
%   - edges: represents the adjacency matrix of the tree. 
%
% Copyright (C) Daphne Koller, Stanford University, 2012


function P = ComputeInitialPotentials(C)

% number of cliques
N = length(C.nodes);

% initialize cluster potentials 
P.cliqueList = repmat(struct('var', [], 'card', [], 'val', []), N, 1);
P.edges = zeros(N);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% YOUR CODE HERE
%
% First, compute an assignment of factors from factorList to cliques. 
% Then use that assignment to initialize the cliques in cliqueList to 
% their initial potentials. 

% C.nodes is a list of cliques.
% So in your code, you should start with: P.cliqueList(i).var = C.nodes{i};
% Print out C to get a better understanding of its structure.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

CLIQUES = [];
for i = 1:N
    CLIQUES(i).VAR = C.nodes{i};
end

for j = 1:length(C.factorList)
    for i = 1:N
        % factor variable should be subset of the scope of assigned clique
        if all(ismember(C.factorList(j).var, CLIQUES(i).VAR))
            % first factor for this clique
            if isempty(P.cliqueList(i).val)
                P.cliqueList(i) = C.factorList(j);
            else % not the first factor, apply factor product
                P.cliqueList(i) = FactorProduct(P.cliqueList(i), C.factorList(j));
            end
            break; % turn to assign the next factor
        end

    end
end

P.edges = C.edges; % directly assign the adjacency matrix to new potential

% rearrange the order of variables
for i = 1:N
    f = P.cliqueList(i);
    oldVar = f.var;
    newVar = sort(oldVar);
    [dummy map] = ismember(newVar, oldVar);
    oldCard = f.card;
    newCard = oldCard(map);
    
    tmpVal = [];
    if prod(f.card) == 1
        continue;
    end

    for j = 1:prod(f.card)
        tmpAsgn = IndexToAssignment(j, oldCard);
        tmpVal(AssignmentToIndex(tmpAsgn(map), newCard)) = f.val(j);
    end

    P.cliqueList(i).var = newVar; % update the variable of factors
    P.cliqueList(i).card = newCard; % update the cardinality of factors
    P.cliqueList(i).val = tmpVal; % update the value of factors
     
end


end

