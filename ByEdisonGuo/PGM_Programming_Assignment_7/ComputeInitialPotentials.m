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
%   - cliqueList: represents an array of cliques with appropriate factors 
%   from factorList assigned to each clique. Where the .val of each clique
%   is initialized to the initial potential of that clique.
%   - edges: represents the adjacency matrix of the tree. 


% Copyright (C) Daphne Koller, Stanford Univerity, 2012

function P = ComputeInitialPotentials(C)

% number of cliques
N = length(C.nodes);

% initialize cluster potentials 
P.cliqueList = repmat(struct('var', [], 'card', [], 'val', []), N, 1);


% Find the values and cards for each clique, compute the initial potential
% for each clique by find the joint distribution over the factors in it,
% and check that the clique tree satisfies family preservation
assignments = zeros(length(C.factorList), 1);
for i = 1:length(C.factorList)
    % Assign each factor to a clique
    for j = 1:N
        % Iterate through nodes until a node with all of the variables in
        % the clique has been found
        if isempty(setdiff(C.factorList(i).var, C.nodes{j}))
            % A clique with the variables has been indentified
            assignments(i) = j;
            break
        end
    end
end
% Determine the cardinaliteis for each node in the clique that will be
% created
cardinalities = zeros(1, length(unique([C.factorList(:).var])));
for i = 1:length(cardinalities)
    % Iterate through variables
    for j = 1:length(C.factorList)
        % Iterate through factors
        if ~isempty(find(C.factorList(j).var == i))
            % If the current variable is in the factor, find its
            % cardinality
            cardinalities(i) = C.factorList(j).card(find(C.factorList(j).var == i));
            break;
        end
    end
end
for i = 1:N
    % Iterate through nodes and put each node into the clique list
    P.cliqueList(i).var = C.nodes{i};
    P.cliqueList(i).card = cardinalities(C.nodes{i});
    P.cliqueList(i).val = ones(1, prod(P.cliqueList(i).card));
end
for i = 1:length(assignments)
    % Iterate through assignments and multiply the appropriate factors
    % in to the clique
    P.cliqueList(assignments(i)) = FactorProduct(P.cliqueList(assignments(i)), C.factorList(i));
end
P.edges = C.edges;
for i = 1:length(C.factorList)
    % Check that every factor has a clique
    factorVars = C.factorList(i).var;
    allVarsInFactor = 0;
    for j = 1:N
        % Find the clique with the variables from the factor
        varNotFound = 0;
        for k = 1:length(factorVars)
            % Find the clique with all of the factorVariables
            if isempty(find(ismember(P.cliqueList(j).var, factorVars(k))))
                % The variable is not in the factor
                varNotFound = 1;
                break
            end
        end
        if varNotFound == 0
            % All of the variables are in the current factor
            allVarsInFactor = 1;
            break
        end
    end
    if allVarsInFactor == 0
        % Family intersection property has been violated
        disp('Family intersection property violated!');
    end
end


end

