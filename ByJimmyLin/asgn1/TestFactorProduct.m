function TestFactorProduct
% Load the test data first
% FACTORS.INPUT(1) contains P(X_1)
FACTORS.INPUT(1) = struct('var', [1], 'card', [2], 'val', [0.11, 0.89]);

% FACTORS.INPUT(2) contains P(X_2 | X_1)
FACTORS.INPUT(2) = struct('var', [2, 1], 'card', [2, 2], 'val', [0.59, 0.41, 0.22, 0.78]);

% Execute the FactorProduct module
FACTORS.PRODUCT = FactorProduct(FACTORS.INPUT(1), FACTORS.INPUT(2));

% Test suites
FLT_EPSILON = 1e-6 ;
assert(all(FACTORS.PRODUCT.var == [1 2]), 'VARIABLE element test failed..') ;
assert(all(FACTORS.PRODUCT.card == [2 2]), 'CARDINALITY element test failed..') ;
assert(all(FACTORS.PRODUCT.val >=  (1 - FLT_EPSILON) * [0.0649, 0.1958, 0.0451, 0.6942]), 'VALUE element test failed..') ;
assert(all(FACTORS.PRODUCT.val <=  (1 + FLT_EPSILON) * [0.0649, 0.1958, 0.0451, 0.6942]), 'VALUE element test failed..') ;
disp('Congratulations. All tests suites passed..')
