function TestComputeTripletFactors ()

load PA3Data.mat
load PA3Models.mat
load PA3SampleCases.mat

factors = ComputeTripletFactors(Part3SampleImagesInput, tripletList, imageModel.K);

% test suites for the factors totally equals to provided solution

FLT_EPSILON = 1e-10;
for i = 1:length(factors),
    assert(all(factors(i).var == Part3SampleFactorsOutput(i).var), 'Variable tests failed..');
    assert(all(factors(i).card == Part3SampleFactorsOutput(i).card), 'Cardinality tests failed..');
    %assert(length(factors(i)) == length(Part3SampleFactorsOutput(i).val))
    assert(all(factors(i).val <= (1+FLT_EPSILON) * Part3SampleFactorsOutput(i).val), 'Value test failed..(beyond the upper bound)');
    assert(all(factors(i).val >= (1-FLT_EPSILON) * Part3SampleFactorsOutput(i).val), 'Value test failed..(beyond the lower bound)');
end

disp('Congratulation.. All testing cases passed.')
