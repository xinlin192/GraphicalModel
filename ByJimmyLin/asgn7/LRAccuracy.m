% function acc = LRAccuracy(GroundTruth, Predictions) compares the 
% vector of predictions with the vector of ground truth values, 
% and returns the accuracy (fraction of predictions that are correct).
%
% Input:
% GroundTruth    (numInstances x 1 vector) 
% Predictions    (numInstances x 1 vector) 
%
% Output:
% err            (scalar between 0 and 1 inclusive)
%
% Copyright (C) Daphne Koller, Stanford Univerity, 2012

function acc = LRAccuracy(GroundTruth, Predictions)

    GroundTruth = GroundTruth(:);
    Predictions = Predictions(:);
    assert(all(size(GroundTruth) == size(Predictions)));
    
    acc = mean(GroundTruth == Predictions);

end
