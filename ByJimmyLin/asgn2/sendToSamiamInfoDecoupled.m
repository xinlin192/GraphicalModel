% You can create a decoupled network and convert it to a format that can be 
% viewed in Samiam by running this script.

pedigree = struct('parents', [0,0;1,3;0,0;1,3;2,6;0,0;2,6;4,9;0,0]);
pedigree.names = {'Ira','James','Robin','Eva','Jason','Rene','Benjamin','Sandra','Aaron'};
phenotypeList = {'CysticFibrosis', 'NoCysticFibrosis'};
alleleFreqsThree = [0.1; 0.7; 0.2];
alleleListThree = {'F', 'f', 'n'};
alphaListThree = [0.8; 0.6; 0.1; 0.5; 0.05; 0.01];
positionsGeneCopy = [1040, 600, 1170, 600, 1105, 500; 1300, 400, 1430, 400, 1365, 300; 780, 600, 910, 600, 845, 500; 520, 400, 650, 400, 585, 300; 1560, 200, 1690, 200, 1625, 100; 2080, 400, 2210, 400, 2145, 300; 1820, 200, 1950, 200, 1885, 100; 260, 200, 390, 200, 325, 100; 0, 400, 130, 400, 65, 300];

% This will construct a decoupled Bayesian network and convert it into a 
% file that can be viewed in SamIam.

factorListDecoupled = constructDecoupledGeneticNetwork(pedigree, alleleFreqsThree, alphaListThree);
sendToSamiamGeneCopy(pedigree, factorListDecoupled, alleleListThree, phenotypeList, positionsGeneCopy, 'cysticFibrosisBayesNetGeneCopy');