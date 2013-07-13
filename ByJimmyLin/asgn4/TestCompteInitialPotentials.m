function TestCompteInitialPotentials ()

load PA4Sample.mat

% invoke the function you want to test
tmp = ComputeInitialPotentials(InitPotential.INPUT);
factors = tmp.cliqueList;

% floating point comparison threshold
FLT_EPSILON = 1e-6;
% test suites for the factors totally equals to provided solution
for i = 1:length(factors),
    assert(all(factors(i).var == InitPotential.RESULT.cliqueList(i).var), 'Variable tests failed..');
    assert(all(factors(i).card == InitPotential.RESULT.cliqueList(i).card), 'Cardinality tests failed..');
    assert(all(factors(i).val <= (1+FLT_EPSILON) * InitPotential.RESULT.cliqueList(i).val), 'Value test failed..(beyond the upper bound)');
    assert(all(factors(i).val >= (1-FLT_EPSILON) * InitPotential.RESULT.cliqueList(i).val), 'Value test failed..(beyond the lower bound)');
end

% success result display
disp('Congratulation.. TestCompteInitialPotentials passed.')
end
