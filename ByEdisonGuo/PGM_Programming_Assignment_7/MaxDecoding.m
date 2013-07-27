%MAXDECODING Finds the best assignment for each variable from the marginals
%passed in. Returns A such that A(i) returns the index of the best
%instantiation for variable i.
%
%   For instance: Let's say we have two variables 1 and 2. 
%   Marginals for 1 = [0.1, 0.3, 0.6]
%   Marginals for 2 = [0.92, 0.08]
%   A(1) = 3, A(2) = 1.
%
%   See also COMPUTEEXACTMARGINALSBP

% Copyright (C) Daphne Koller, Stanford Univerity, 2012

function A = MaxDecoding( M )

% Compute the best assignment for variables in the network.
A = zeros(1, length(M));
for i = 1:length(M)
    % Iterate through variables
    [maxVal, idx] = max(M(i).val);
    A(i) = idx;
end

end

