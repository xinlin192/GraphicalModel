% This function is called by InstanceNegLogLikelihood.
% Its input/output is specified there.
% If you're interested in the implementation details of CRFs,
% feel free to read through this code!
% For the purposes of this assignment, though, you don't
% have to understand how this code works.
%
% Copyright (C) Daphne Koller, Stanford Univerity, 2012

function featureSet = GenerateAllFeatures(X, modelParams)

    unconditionedFFs = {@ComputeUnconditionedSingletonFeatures, @ComputeUnconditionedPairFeatures};
    conditionedFFs = {@ComputeConditionedSingletonFeatures};

    numUnconditionedFFs = length(unconditionedFFs);
    numConditionedFFs = length(conditionedFFs);

    for i = 1:numUnconditionedFFs
        if (~isa(unconditionedFFs{i}, 'function_handle'))
            error('Non-function variable in unconditionedFFs argument to GenerateAllFeatures');
        end
    end
    for i = 1:numConditionedFFs
        if (~isa(conditionedFFs{i}, 'function_handle'))
            error('Non-function variable in conditionedFFs argument to GenerateAllFeatures');
        end

    end
    
    len = size(X, 1);

    conditionedCell = cell(1, numConditionedFFs);
    for i = 1:numConditionedFFs
        fn = conditionedFFs{i};
        conditionedCell{i} = fn(X, modelParams);
    end

    unconditionedCell = cell(1, numUnconditionedFFs);
    for i = 1:numUnconditionedFFs
        fn = unconditionedFFs{i};
        unconditionedCell{i} = fn(len, modelParams);
    end

    if (numConditionedFFs > 0)
        prevMaxParam = NumParamsForConditionedFeatures(conditionedCell{1}, modelParams.numObservedStates);
    else
        prevMaxParam = 0;
    end

    for i = 2:1:numConditionedFFs
        conditionedCell{i} = IncrementFeatureParams(conditionedCell{i}, prevMaxParam);
        prevMaxParam = NumParamsForConditionedFeatures(conditionedCell{i});
    end

    for i = 1:1:numUnconditionedFFs
        unconditionedCell{i} = IncrementFeatureParams(unconditionedCell{i}, prevMaxParam);
        prevMaxParam = NumParamsForUnconditionedFeatures(unconditionedCell{i});
    end
    finalMaxParam = prevMaxParam;


    allFeatures = horzcat(conditionedCell{:}, unconditionedCell{:});

    featureSet.numParams = finalMaxParam;
    featureSet.features = allFeatures;

end

% Helper function to increment the 'param' val of each entry in a feature
% array.
function features = IncrementFeatureParams(features, incr)

    for i = 1:length(features)
        features(i).paramIdx = features(i).paramIdx + incr;
    end

end
