%GETNEXTCLIQUES Find a pair of cliques ready for message passing
%   [i, j] = GETNEXTCLIQUES(P, messages) finds ready cliques in a given
%   clique tree, P, and current messages. Returns indices i and j
%   such that clique i is ready to transmit a message to clique j.
%   If no such cliques exist, returns i = j = 0
%
%   See also CLIQUETREECALIBRATE

% Copyright (C) Daphne Koller, Stanford Univerity, 2012

function [i, j] = GetNextCliques(P, messages)

ready = 0;

for i = 1:size(P.edges, 1),
    for j = 1:size(P.edges, 2),
        
        % If clique i is ready to send a message to clique j then
        % set 'ready' to 1.   
        % Make sure that message is ready by making sure that the cliques
        % share an edge, that no message has been sent, and that all of the
        % other messages to clique i have been sent
        if P.edges(i,j) == 0
            % There is no edge connecting clique i and clique j, so do not
            % consider sending a message
            continue
        end
        if (~isempty(messages(i,j).var))
            % A message has already been sent from clique i to clique j, so
            % do not consider sending a message
            continue
        end
        messageIndexes = setdiff(find(P.edges(:, i) == 1), j);
        emptyFound = 0;
        for k = 1:length(messageIndexes)
            % Iterate through other incoming edges
            if isempty(messages(messageIndexes(k), i).var)
                % Not ready
                emptyFound = 1;
                break
            end
        end
        if emptyFound == 0
            % All necessary messages have been sent
            ready = 1;
            return;
        end
        
    end;
end;

i = 0;
j = 0;

return
