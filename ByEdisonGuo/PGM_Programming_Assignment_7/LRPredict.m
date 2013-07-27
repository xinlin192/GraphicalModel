% pred = LRPredict(X, theta) uses the LR classifier encoded by theta
% to predict the labels on data X.
%
% Inputs:
% X         data.                      (numInstances x numFeatures matrix)
% theta     LR parameters.             (numFeatures x 1 vector)
%
% Outputs:
% pred      predicted labels for X.    (numInstances x 1 binary vector).
%
% Copyright (C) Daphne Koller, Stanford Univerity, 2012

function pred = LRPredict (X, theta)

    thresh = 0.5;
    h = sigmoid (X * theta);
    pred = h > thresh;

end

