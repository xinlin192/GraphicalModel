function features = ComputeConditionedSingletonFeatures (X, modelParams)
% Creatures feature structs for indicator features on single values on y.
% They are "conditioned," since different elements of the weight vector are
% used depending on the actual observation.
%
% Copyright (C) Daphne Koller, Stanford Univerity, 2012

    [len, featureSize] = size(X);

    K = modelParams.numHiddenStates;
    L = modelParams.numObservedStates;

    numFeatures = len * K * featureSize;
    features(numFeatures) = EmptyFeatureStruct();

    featureIdx = 0;

    for hiddenSt = 1:K
        for featureNum = 1:featureSize
            for v = 1:len
                featureIdx = featureIdx + 1;
                obs = X(v, featureNum);
                features(featureIdx).var = v;
                features(featureIdx).assignment = hiddenSt;
                features(featureIdx).paramIdx = sub2ind([L featureSize K], ...
                    obs, featureNum, hiddenSt);
            end
        end
    end

end
