%GETNEXTCLUSTERS Takes in a cluster graph and returns the indices
%   of the nodes between which the next message should be passed.
%
%   [i j] = GetNextClusters(P,Messages,oldMessages,m,useSmart)
%
%   INPUT
%     P - our cluster graph
%     Messages - the current values of all messages in P
%     oldMessages - the previous values of all messages in P. Thus, 
%         oldMessages(i,j) contains the value that Messages(i,j) contained 
%         immediately before it was updated to its current value
%     m - the index of the message we are passing (ie, m=0 indicates we have
%         passed 0 messages prior to this one. m=5 means we've passed 5 messages
%     useSmart - indicates whether we should use the Naive or Smart message
%         passing order
%
%
%   Output [i j]
%     i = the origin of the m+1th message
%     j = the destination of the m+1th message
%
% Copyright (C) Daphne Koller, Stanford University, 2012

function [i j] = GetNextClusters(P,Messages,oldMessages,m,useSmart)

if(~exist('useSmart','var')||~useSmart)
  [i j] = NaiveGetNextClusters(P,m);
else
  [i j] = SmartGetNextClusters(P,Messages,oldMessages,m);
end
