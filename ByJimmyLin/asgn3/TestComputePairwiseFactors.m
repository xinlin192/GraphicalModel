function TestComputePairwiseFactors ()

load PA3Data.mat
load PA3Models.mat
load PA3SampleCases.mat

factors = ComputePairwiseFactors(Part2SampleImagesInput, pairwiseModel, imageModel.K);
% test suites for the factors totally equals to provided solution

FLT_EPSILON = 1e-6;
for i = 1:length(factors),
    assert(all(factors(i).var == Part2SampleFactorsOutput(i).var), 'Variable tests failed..');
    assert(all(factors(i).card == Part2SampleFactorsOutput(i).card), 'Cardinality tests failed..');
    assert(all(factors(i).val <= (1+FLT_EPSILON) * Part2SampleFactorsOutput(i).val), 'Value test failed..(beyond the upper bound)');
    assert(all(factors(i).val >= (1-FLT_EPSILON) * Part2SampleFactorsOutput(i).val), 'Value test failed..(beyond the lower bound)');
end

disp('Congratulation.. All testing cases passed.')
