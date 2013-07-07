function TestFactorMarginalization()
% FACTORS.INPUT(2) contains P(X_2 | X_1)
FACTORS.INPUT(2) = struct('var', [2, 1], 'card', [2, 2], 'val', [0.59, 0.41, 0.22, 0.78]);

% execute the marginalisation
FACTORS.MARGINALIZATION = FactorMarginalization(FACTORS.INPUT(2), [2]);

x = FACTORS.MARGINALIZATION

% test suites
assert( x.var == [1], 'Test 1 failed' )
assert( x.card == [2], 'Test 1 failed' ) 
assert( all(x.val == [1 1]), 'Test 1 failed' )
disp('Test 1 passed..')

