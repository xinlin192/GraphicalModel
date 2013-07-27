function features = ComputeUnconditionedPairFeatures (len, modelParams)
% Creates indicator features on assignments to adjacent variables in the
% sequence.
%
% Copyright (C) Daphne Koller, Stanford Univerity, 2012

if (len < 2)
    features = [];
    return;
end

K = modelParams.numHiddenStates;
nPairFeatures = (len - 1) * K * K;

features(nPairFeatures) = EmptyFeatureStruct();

featureIdx = 0;
for s1 = 1:K
    for s2 = 1:K
        paramVal = sub2ind([K K], s2, s1);
        for v = 1:(len - 1)
            featureIdx = featureIdx + 1;
            features(featureIdx).var = [v v+1];
            features(featureIdx).assignment = [s1 s2];
            features(featureIdx).paramIdx = paramVal;
        end
    end
end


end
