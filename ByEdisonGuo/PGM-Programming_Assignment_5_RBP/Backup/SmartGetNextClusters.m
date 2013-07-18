%SMARTGETNEXTCLUSTERS Takes in a cluster graph and returns the indices
%   of the nodes between which the next message should be passed.
%
%   [i j] = SmartGetNextClusters(P,Messages,oldMessages,m,useSmart)
%
%   INPUT
%     P - our cluster graph
%     Messages - the current values of all messages in P
%     oldMessages - the previous values of all messages in P. Thus, 
%         oldMessages(i,j) contains the value that Messages(i,j) contained 
%         immediately before it was updated to its current value
%     m - the index of the message we are passing (ie, m=0 indicates we have
%         passed 0 messages prior to this one. m=5 means we've passed 5 messages
%
%     Implement any message passing routine that will converge in cases that the
%     naive routine would also converge.  You may also change the inputs to
%     this function, but note you may also have to change GetNextClusters.m as
%     well.
%
% Copyright (C) Daphne Koller, Stanford University, 2012


function [i j] = SmartGetNextClusters(mNew, mOld)

N = size(mNew, 1);

diff = -Inf;

for iFrm = 1:N
    for iTo = 1:N
        if ~isempty(mNew(iFrm, iTo).val) && ~isempty(mOld(iFrm, iTo).val)
            maxDiff = max(abs(mNew(iFrm, iTo).val - mOld(iFrm, iTo).val));
            if maxDiff > diff
                diff = maxDiff;
                i = iFrm;
                j = iTo;
            end
        end
    end
end

end

