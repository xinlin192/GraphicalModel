function TestComputeAllSimilarityFactors ()

% load original data
load PA3Data.mat
load PA3Models.mat
% load test data
load PA3SampleCases.mat

% invoke the function you want to test
factors = ComputeAllSimilarityFactors(Part5SampleImagesInput, imageModel.K);

% floating point comparison threshold
FLT_EPSILON = 1e-6;
% test suites for the factors totally equals to provided solution
for i = 1:length(factors),
    assert(all(factors(i).var == Part5SampleFactorsOutput(i).var), 'Variable tests failed..');
    assert(all(factors(i).card == Part5SampleFactorsOutput(i).card), 'Cardinality tests failed..');
    assert(all(factors(i).val <= (1+FLT_EPSILON) * Part5SampleFactorsOutput(i).val), 'Value test failed..(beyond the upper bound)');
    assert(all(factors(i).val >= (1-FLT_EPSILON) * Part5SampleFactorsOutput(i).val), 'Value test failed..(beyond the lower bound)');
end

% success result display
disp('Congratulation.. TestComputeAllSimilarityFactors passed.')
