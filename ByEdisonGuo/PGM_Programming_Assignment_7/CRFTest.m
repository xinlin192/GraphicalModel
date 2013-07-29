
theta = zeros(1, 2366);
maxEpoch = 5;

modelParams.numHiddenStates = 26;
modelParams.numObservedStates = 2;
modelParams.lambda = 0.003;

[loglik theta] = CRFTrain(trainData, theta, maxEpoch, modelParams);

plot(1:length(loglik), loglik);
xlabel('iter')
ylabel('negative log-likelihood')
title('Negative log-likelihood vs. iterations')

[trainCharAccuracy trainWordAccuracy] ...
    = ComputePredictionAccuracy(trainData, theta, modelParams);

disp('Test set accuracy')
disp(['  Char accuracy: ', num2str(trainCharAccuracy)])
disp(['  Word accuracy: ', num2str(trainWordAccuracy)])

[testCharAccuracy testWordAccuracy] ...
    = ComputePredictionAccuracy(testData, theta, modelParams);

disp('Test set accuracy')
disp(['  Char accuracy: ', num2str(testCharAccuracy)])
disp(['  Word accuracy: ', num2str(testWordAccuracy)])