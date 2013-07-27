%GETNEXTCLIQUES Find a pair of cliques ready for message passing
%   [i, j] = GETNEXTCLIQUES(P, messages) finds ready cliques in a given
%   clique tree, P, and a matrix of current messages. Returns indices i and j
%   such that clique i is ready to transmit a message to clique j.
%
%   We are doing clique tree message passing, so
%   do not return (i,j) if clique i has already passed a message to clique j.
%
%	 messages is a n x n matrix of passed messages, where messages(i,j)
% 	 represents the message going from clique i to clique j. 
%   This matrix is initialized in CliqueTreeCalibrate as such:
%      MESSAGES = repmat(struct('var', [], 'card', [], 'val', []), N, N);
%
%   If more than one message is ready to be transmitted, return 
%   the pair (i,j) that is numerically smallest. If you use an outer
%   for loop over i and an inner for loop over j, breaking when you find a 
%   ready pair of cliques, you will get the right answer.
%
%   If no such cliques exist, returns i = j = 0.
%
%   See also CLIQUETREECALIBRATE
%
% Copyright (C) Daphne Koller, Stanford University, 2012


function [i, j] = GetNextCliques(P, messages)

% initialization
% you should set them to the correct values in your code
i = 0;
j = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% YOUR CODE HERE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Derive the size of square matrix representing objective clique tree
SIZE = size(P.edges);
% Local variable x, y, z, k
% traverse all the entries of the clique-tree matrix with
% pariticular starting search point
for x = SIZE(1):-1:1, 
    for y = 1:SIZE(2),
        if P.edges(x,y) == 0,
            continue; % ignore the unconnected clique pairs
        else 
            % for connected pairs
            if isMessageEmpty(messages(x,y)),
                %% this sepset has no message passing currently but connected
                if isready(x, y, P, messages) == 1, 
                    % clique x is ready, message passing from x to y,
                    i = x; j = y; return;
                end
            end
        end
    end
end
end

% subroutine to evaluate the readiness of certain clique
function readiness = isready(from, to, P, messages)
% initially treat readiness negative
readiness = 0;
% size of the square matrix 
SIZE = size(P.edges);
% loop through all cliques
for x = 1:SIZE(1),
    if P.edges(x, from) == 0 || x == from || x == to,
        % avoid computation for non-existing clique connection and
        % avoid self message passing and 
        % no need to examine the message in reverse direction
        continue;
    else
        if isMessageEmpty(messages(x, from)),
            return; % still lack of one incoming message
        else
            continue; % pass current examination
        end
    end
end
% incoming messages are sufficient to make this clique ready
% to pass message from 'from' clique to 'to' clique
readiness = 1;
end

