function n = NumParamsForUnconditionedFeatures (features)
% Number of parameters "consumed" by a set of unconditioned features.
%
% Copyright (C) Daphne Koller, Stanford Univerity, 2012

n = max([features.paramIdx]);

end

