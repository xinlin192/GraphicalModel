function n = NumParamsForConditionedFeatures (features, numObservedStates)
% Number of parameters "consumed" by a set of conditioned features.
%
% Copyright (C) Daphne Koller, Stanford Univerity, 2012

maxParam = max([features.paramIdx]);
n = maxParam + numObservedStates - 1 - mod(maxParam - 1, numObservedStates);

end
