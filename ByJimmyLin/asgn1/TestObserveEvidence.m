function TestObserveEvidence()

% input data 
% FACTORS.INPUT(1) contains P(X_1)
FACTORS.INPUT(1) = struct('var', [1], 'card', [2], 'val', [0.11, 0.89]);

% FACTORS.INPUT(2) contains P(X_2 | X_1)
FACTORS.INPUT(2) = struct('var', [2, 1], 'card', [2, 2], 'val', [0.59, 0.41, 0.22, 0.78]);

% FACTORS.INPUT(3) contains P(X_3 | X_2)
FACTORS.INPUT(3) = struct('var', [3, 2], 'card', [2, 2], 'val', [0.39, 0.61, 0.06, 0.94]);

% invocation of ObserveEvidence
FACTORS.EVIDENCE = ObserveEvidence(FACTORS.INPUT, [2 1; 3 2]);

% test suites
FLT_EPSILON = 1e-6;
% FACTORS.EVIDENCE(1) = struct('var', [1], 'card', [2], 'val', [0.11, 0.89]);
assert( FACTORS.EVIDENCE(1).var == [1], 'test1 failed')
assert( FACTORS.EVIDENCE(1).card == [2], 'test1 failed')
assert( all(FACTORS.EVIDENCE(1).val <= (1+FLT_EPSILON) * [0.11, 0.89]) && all(FACTORS.EVIDENCE(1).val >= (1-FLT_EPSILON) * [0.11, 0.89]), 'test1 failed')

% FACTORS.EVIDENCE(2) = struct('var', [2, 1], 'card', [2, 2], 'val', [0.59, 0, 0.22, 0]);
assert( all(FACTORS.EVIDENCE(2).var == [2 1]), 'test2 failed')
assert( all(FACTORS.EVIDENCE(2).card == [2 2]), 'test2 failed')
assert( all(FACTORS.EVIDENCE(2).val <= (1+FLT_EPSILON) * [0.59, 0, 0.22, 0]) && all(FACTORS.EVIDENCE(2).val >= (1-FLT_EPSILON) * [0.59, 0, 0.22, 0]), 'test2 failed')

% FACTORS.EVIDENCE(3) = struct('var', [3, 2], 'card', [2, 2], 'val', [0, 0.61, 0, 0]);
assert( all(FACTORS.EVIDENCE(3).var == [3 2]), 'test3 failed')
assert( all(FACTORS.EVIDENCE(3).card == [2 2]), 'test3 failed')
assert( all(FACTORS.EVIDENCE(3).val <= (1+FLT_EPSILON) * [0, 0.61, 0, 0]) && all(FACTORS.EVIDENCE(3).val >= (1-FLT_EPSILON) * [0, 0.61, 0, 0]), 'test3 failed')

% statement of success
disp('All test suites passed..')
