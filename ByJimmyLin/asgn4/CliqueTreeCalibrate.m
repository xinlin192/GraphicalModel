%CLIQUETREECALIBRATE Performs sum-product or max-product algorithm for 
%clique tree calibration.

%   P = CLIQUETREECALIBRATE(P, isMax) calibrates a given clique tree, P 
%   according to the value of isMax flag. If isMax is 1, it uses max-sum
%   message passing, otherwise uses sum-product. This function 
%   returns the clique tree where the .val for each clique in .cliqueList
%   is set to the final calibrated potentials.
%
% Copyright (C) Daphne Koller, Stanford University, 2012

function P = CliqueTreeCalibrate(P, isMax)


% Number of cliques in the tree.
N = length(P.cliqueList);

% Setting up the messages that will be passed.
% MESSAGES(i,j) represents the message going from clique i to clique j. 
MESSAGES = repmat(struct('var', [], 'card', [], 'val', []), N, N);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% We have split the coding part for this function in two chunks with
% specific comments. This will make implementation much easier.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% YOUR CODE HERE
% While there are ready cliques to pass messages between, keep passing
% messages. Use GetNextCliques to find cliques to pass messages between.
% Once you have clique i that is ready to send message to clique
% j, compute the message and put it in MESSAGES(i,j).
% Remember that you only need an upward pass and a downward pass.
%
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if isMax == 0, % sum-product message passing for probability inference
    while 1,
        [i, j] = GetNextCliques(P, MESSAGES);
        if i == 0 && j == 0,
            break;
        end
        % accumulator for product of incoming messages
        MAcc = struct('var', [], 'card', [], 'val', []);  
        % derive the product of those incoming messages
        for x = 1:N,
            if P.edges(x,i) ~= 0 && x ~= i && x ~= j, % connection exist
                MAcc = FactorProduct(MAcc, MESSAGES(x,i));
            end
        end
        % multiply the initial potential
        MAcc = FactorProduct(MAcc, P.cliqueList(i));
        % sum out variables that are not in the sepset
        V = intersect(P.cliqueList(i).var, P.cliqueList(j).var);
        MAcc = ComputeMarginal(V, MAcc, []); % with normalisation
        MESSAGES(i,j) = MAcc;
    end
else % max-sum message passing for map inference 

    return;
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% YOUR CODE HERE
%
% Now the clique tree has been calibrated. 
% Compute the final potentials for the cliques and place them in P.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

IP = P.cliqueList; % temporarily record the initial potentials
for k = 1:N, % loop through all the cliques
    beta =  struct('var', [], 'card', [], 'val', []); % initialise the clique belief
    for x = 1:N, % loop through all the neighbours
        if P.edges(x, k) ~= 0 && x ~= k,
            beta = FactorProduct(beta, MESSAGES(x, k));
        end
    end
    % multiply the initial potential
    beta = FactorProduct(beta, IP(k));
    % sum out the variables not in the clique
    beta = FactorMarginalization(beta, setdiff(beta.var, IP(k).var));
    % update the clique beliefs (modified potential)
    P.cliqueList(k) = beta;
end

end

