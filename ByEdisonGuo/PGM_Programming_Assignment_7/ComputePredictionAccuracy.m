function [charAccuracy wordAccuracy] ...
    = ComputePredictionAccuracy(testData, theta, modelParams)
    
    nCharCorrect = 0;
    nCharTotal = 0;

    nWordCorrect = 0;
    nWordTotal = 0;

    for i = 1:length(testData)
        predictions = CRFPredict(testData(i).X, theta, modelParams);

        nCorrect = sum(predictions == testData(i).y);

        nCharCorrect = nCharCorrect + nCorrect;
        nCharTotal = nCharTotal + length(testData(i).y);

        if nCorrect == length(testData(i).y)
            nWordCorrect = nWordCorrect + 1;
        end

        nWordTotal = nWordTotal + 1;

        if mod(i, 10) == 0
            disp(['samples: ', num2str(i)]);
        end
    end

    charAccuracy = nCharCorrect / nCharTotal;
    wordAccuracy = nWordCorrect / nWordTotal;
    
end