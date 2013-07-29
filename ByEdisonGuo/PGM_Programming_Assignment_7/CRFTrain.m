function [logliks theta] = CRFTrain(trainData, theta, maxEpoch, modelParams)
    
    nObs = length(trainData);
    logliks = zeros(1, nObs*maxEpoch);
    
    for i = 1:maxEpoch
        for k = 1:nObs
            [loglik grad] = InstanceNegLogLikelihood(trainData(k).X, trainData(k).y, theta, modelParams);
            
            alpha = 1 / (1 + 0.05*k);
            theta = theta - alpha * grad;
            
            logliks( (i-1)*nObs + k ) = loglik;
            
            if mod(k, 10) == 0
                disp(['Epoch: ', num2str(i), ', samples: ', num2str(k)]);
            end
        end
    end
end