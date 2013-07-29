function [allelesToGenotypes, genotypesToAlleles] = generateAlleleGenotypeMappers(numAlleles)
% This function creates a map from pairs of allele IDs to genotype
% IDs and from genotype IDs to pairs of allele IDs.
%
% Each allele has an ID that is the index of its location in the allele
% list/the index of its allele frequency in the allele frequency list. Each
% genotype also has an ID that is the index of its alpha in the list of
% alphas.  There is a mapping from a pair of allele IDs to genotype IDs and
% from genotype IDs to a pair of allele IDs below; we compute this mapping 
% using generateAlleleGenotypeMappers(numAlleles). (A genotype consists of
% 2 alleles.)
%
% Input:
%   1.  numAlleles: Number of alleles for the trait
%
% Output:
%
%   1.  allelesToGenotypes: n x n matrix that maps pairs of allele IDs to 
%   genotype IDs -- if allelesToGenotypes(i, j) = k, then the genotype with 
%   ID k comprises of the alleles with IDs i and j
%
%   2.  genotypesToAlleles: m x 2 matrix of allele IDs, where m is the number of 
%   genotypes -- if genotypesToAlleles(k, :) = i, j, then the genotype with ID k 
%   is comprised of the allele with ID i and the allele with ID j

allelesToGenotypes = zeros(numAlleles, numAlleles);
index = 0;
for i = 1:numAlleles
    % Iterate through alleles
    for j = i:numAlleles
        % Iterate through allele pairs
        index = index + 1;
        allelesToGenotypes(i, j) = index;
    end
end
for i = 1:numAlleles
    % Iterate through alleles
    for j = 1:i-1
        % Iterate through entries that have not been properly filled
        allelesToGenotypes(i,j) = allelesToGenotypes(j,i);
    end
end

numGenotypes = (numAlleles * (numAlleles - 1))/2 + numAlleles;
genotypesToAlleles = zeros(numGenotypes, 2);
index = 0;
for i = 1:numAlleles
    % Iterate through alleles
    for j = i:numAlleles
        % Iterate through allele pairs
        index = index + 1;
        genotypesToAlleles(index, :) = [i, j];
    end
end