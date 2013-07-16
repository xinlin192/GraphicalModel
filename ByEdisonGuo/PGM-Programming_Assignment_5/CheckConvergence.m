% CHECKCONVERGENCE Ascertain whether the messages indicate that we have converged
%   converged = CHECKCONVERGENCE(MNEW,MOLD) compares lists of messages MNEW
%   and MOLD.  If the values listed in any message differs by more than the 
%   value 'thresh' then we determine that convergence has not occured and 
%   return converged=0, otherwise we have converged and converged=1
%
%   The 'message' data structure is an array of structs with the following 3 fields:
%     -.var:  the variables covered in this message
%     -.card: the cardinalities of those variables
%     -.val:  the value of the message w.r.t. the message's variables
%
%   MNEW and MOLD are the message where M(i,j).val gives the values associated
%   with the message from cluster i to cluster j.
%
% Copyright (C) Daphne Koller, Stanford University, 2012

function converged = CheckConvergence(mNew, mOld)

thresh = 1.0e-6;

N = size(mNew, 1);

diff = -Inf;

for i = 1:N
    for j = 1:N
        if ~isempty(mNew(i, j).val) && ~isempty(mOld(i, j).val)
            maxDiff = max(abs(mNew(i, j).val - mOld(i, j).val));
            if maxDiff > diff
                diff = maxDiff;
            end
        end
    end
end

converged = diff <= thresh;
