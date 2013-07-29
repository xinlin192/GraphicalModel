function predictions = CRFPredict(X, theta, modelParams)
    featureSet = GenerateAllFeatures(X, modelParams);

    P = ConstructCliqueTree(X, theta, modelParams, featureSet);
    P = CliqueTreeCalibrate(P, 1);
    
    M = ComputeMarginals(size(X, 1), P, 1);
    predictions = MaxDecoding(M);
end