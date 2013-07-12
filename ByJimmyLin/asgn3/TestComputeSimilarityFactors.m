function TestComputeSimilarityFactor ()

load PA3Data.mat
load PA3Models.mat
load PA3SampleCases.mat

factor = ComputeSimilarityFactor(Part4SampleImagesInput, imageModel.K, 1, 2);

% test suites for the factors totally equals to provided solution

FLT_EPSILON = 1e-6;
assert(all(factor.var == Part4SampleFactorOutput.var), 'Variable tests failed..');
assert(all(factor.card == Part4SampleFactorOutput.card), 'Cardinality tests failed..');
assert(all(factor.val <= (1+FLT_EPSILON) * Part4SampleFactorOutput.val), 'Value test failed..(beyond the upper bound)');
assert(all(factor.val >= (1-FLT_EPSILON) * Part4SampleFactorOutput.val), 'Value test failed..(beyond the lower bound)');

disp('Congratulation.. TestComputeSimilarityFactor passed.')
