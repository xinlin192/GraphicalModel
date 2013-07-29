function geneCopyFactor = childCopyGivenFreqsFactor(alleleFreqs, geneCopyVar)
% This function creates a factor whose values are the frequencies of each 
% allele in the population.
%
% Input:
%   alleleFreqs: A list of the frequencies of the alleles in the population
%   genotypeVar: The variable number for the genotype
%
% Output:
%   geneCopyFactor: A factor for the prior probability of genotypeVar (note 
%   that this is the FULL CPD with no evidence observed)

numAlleles = length(alleleFreqs);
geneCopyFactor = struct('var', [], 'card', [], 'val', []);
geneCopyFactor.var(1) = geneCopyVar;
geneCopyFactor.card(1) = numAlleles;
geneCopyFactor.val = alleleFreqs';