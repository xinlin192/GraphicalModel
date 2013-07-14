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

N = length(P.cliqueList);

map = zeros(N);
for iRow = 1:N
    for iCol = 1:N
        map(iRow, iCol) = ~isempty(messages(iRow, iCol).var);
    end
end

for iCol = 1:N
    
    neighbourIdx = find(P.edges(:, iCol));
    
    for iNh = neighbourIdx'
        if isempty(messages(iCol, iNh).var)
            frmIdx = setdiff(neighbourIdx, iNh);
            if all(map(frmIdx, iCol))
                i = iCol;
                j = iNh;
                return;
            end
        end
        
    end
    
%     neighbourIdx = find(P.edges(:, iCol));
%     
%     nEmptyNghbr = 0;
%     nNonemptyNghbr = 0;
%     iEmptyNghbr = -1;
%     for iNh = neighbourIdx'
%      
%         if isempty(messages(iNh, iCol).var)
%             nEmptyNghbr = nEmptyNghbr + 1;
%             if nEmptyNghbr > 1
%                 break;
%             end
%             
%             iEmptyNghbr = iNh;
%             
%         else
%             nNonemptyNghbr = nNonemptyNghbr + 1;
%         end
%     end
%      
%     if nEmptyNghbr == 1 && nNonemptyNghbr > 0 && isempty(messages(iCol, iEmptyNghbr).var)
%        i = iCol;
%        j = iEmptyNghbr;
%        break;
%     end
    
    
%     isReady = true;
%     for iRow = 1:N
%         if(P.edges(iRow, iCol) ~= ~isempty(messages(iRow, iCol).var))
%             isReady = false;
%             break;
%         end
%     end
%     
%     if(isReady)
%         for iTo = 1:N
%            if P.edges(iCol, iTo) == 1 && isempty(messages(iCol, iTo).var)
%                i = iCol;
%                j = iTo;
%                return;
%            end
%         end
%     end
end

