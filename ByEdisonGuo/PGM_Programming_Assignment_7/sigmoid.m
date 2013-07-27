function s = sigmoid (z)
% Sigmoid function (scalar or element-wise)
%
% Copyright (C) Daphne Koller, Stanford Univerity, 2012

s = 1 ./ (1 + exp (-z));

end
