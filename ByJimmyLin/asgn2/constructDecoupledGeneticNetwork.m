function factorList = constructDecoupledGeneticNetwork(pedigree, alleleFreqs, alphaList)
% This function constructs a Bayesian network for genetic inheritance.  It
% assumes that there are only 2 phenotypes.  It also assumes that, in the
% pedigree, either both parents are specified or neither parent is
% specified.
%
% In Matlab, each variable will have a number.  We need a consistent way of
% numbering variables when instantiating CPDs so that we know what
% variables are involved in each CPD.  For example, if IraGenotype is in
% multiple CPDs and IraGenotype is number variable 1 in a CPD, then
% IraGenotype should be numbered as variable 1 in all CPDs and no other
% variables should be numbered 1; thus, every time variable 1 appears in
% our network, we will know that it refers to Ira's genotype.
%
% Here is how the variables should be numbered, for a pedigree with n
% people:
%
% 1.  The first n variables should be the gene copy 1 variables and should
% be numbered according to the index of the corresponding person in
% pedigree.names; the ith person with name pedigree.names{i} has gene copy
% 1 variable number i.  If the parents are specified, then gene copy 1 is the
% copy inherited from pedigree.names{pedigree.parents(i, 1)}.
%
% 2.  The next n variables should be the gene copy 2 variables and should
% be numbered according to the index of the corresponding person in
% pedigree.names; the ith person with name pedigree.names{i} has gene copy
% 2 variable number n+i.  If the parents are specified, then gene copy 2 is the
% copy inherited from pedigree.parents(i, 2).
%
% 3.  The final n variables should be the phenotype variables and should be
% numbered according to the index of the corresponding person in
% pedigree.names; the ith person with name pedigree.names{i} has phenotype
% variable number 2n+i.
%
% Here is an example of how the variable numbering should work: if
% pedigree.names = {'Ira', 'James', 'Robin'} and pedigree.parents = [0, 0;
% 1, 3; 0, 0], then the variable numbering is as follows:
%
% Variable 1: IraGeneCopy1
% Variable 2: JamesGeneCopy1
% Variable 3: RobinGeneCopy1
% Variable 4: IraGeneCopy2
% Variable 5: JamesGeneCopy2
% Variable 6: RobinGeneCopy2
% Variable 7: IraPhenotype
% Variable 8: JamesPhenotype
% Variable 9: RobinPhenotype
%
% Input:
%   pedigree: Data structure that includes the names and parents of each
%   person
%   alleleFreqs: n x 1 vector of allele frequencies in the population,
%   where n is the number of alleles
%   alphaList: m x 1 vector of alphas for different genotypes, where m is
%   the number of genotypes -- the alpha value for a genotype is the 
%   probability that a person with that genotype will have the physical 
%   trait
%
% Output:
%   factorList: struct array of factors for the genetic network (In each
%   factor, .var, .card, and .val are row 1-D vectors.)

numPeople = length(pedigree.names);

% Initialize factors
% We Need 3*numPeople factors because, for each person, there is a factor 
% for the CPD at each of 2 parental copies of the gene and a factor for the 
% CPD at the phenotype Note that the order of the factors in the list does 
% not matter.
factorList(3*numPeople) = struct('var', [], 'card', [], 'val', []);

% Initialize factors
factorList(3*numPeople) = struct('var', [], 'card', [], 'val', []);

numAlleles = length(alleleFreqs); % Number of alleles

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INSERT YOUR CODE HERE
% Variable numbers:
% 1 - numPeople: first parent copy of gene variables
% numPeople+1 - 2*numPeople: second parent copy of gene variables
% 2*numPeople+1 - 3*numPeople: phenotype variables
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  