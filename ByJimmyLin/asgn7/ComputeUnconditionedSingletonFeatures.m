function features = ComputeUnconditionedSingletonFeatures (len, modelParams)
% Creates indicator features on assignments to single variables in the
% sequence.
%
% Copyright (C) Daphne Koller, Stanford Univerity, 2012

nSingleFeatures = len * modelParams.numHiddenStates;
features(nSingleFeatures) = EmptyFeatureStruct();

K = modelParams.numHiddenStates;
featureIdx = 0;

for st = 1:K
    paramVal = st;
    for v = 1:len
        featureIdx = featureIdx + 1;
        features(featureIdx).var = v;
        features(featureIdx).assignment = st;
        features(featureIdx).paramIdx = paramVal;

    end
end

end
