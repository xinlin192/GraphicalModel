function geneCopyFactor = childCopyGivenParentalsFactor(numAlleles, geneCopyVarChild, geneCopyVarOne, geneCopyVarTwo)
% This function makes a factor with the probability of a child inheriting 
% each allele from a parent given each possibility for that parent's 
% maternal copy of the gene and that parent's paternal copy of the gene.
% Note that both copies of the gene come from the same parent, but that
% parent got them from different grandparents.
%
% Input:
%   numAlleles: int that is the number of alleles
%   geneCopyVarChild: Variable number corresponding to the variable for 
%   the child's copy of the gene
%   geneCopyVarOne: Variable number corresponding to the variable 
%   for the first parent's copy of the gene
%   geneCopyVarTwo: Variable number corresponding to the variable 
%   for the second parent's copy of the gene
%
% Output:
%   geneCopyFactor: Factor with values as the probability of child 
%   inheriting each allele given each possibility for the parent's maternal 
%   and paternal copies of the gene (note that this is the FULL CPD with no
%   evidence observed)

geneCopyFactor = struct('var', [], 'card', [], 'val', []);
alleleProbs = zeros(1, numAlleles ^ 3);

% This can be used to keep track of the location in alleleProbs as 
% probabilities of having different alleles are computed so that the 
% probabilities are recorded in the correct locations
alleleProbsCount = 0;

for i = 1:numAlleles
    % Iterate through the alleles that the parent could have gotten from
    % its father
    for j = 1:numAlleles
        % Iterate through the alleles that the parent could have gotten
        % from its mother
        for k = 1:numAlleles
            % Iterate through the child could inherit
            alleleProbsCount = alleleProbsCount + 1;
            if j == k
                % Allele is the same as the current potential maternal
                % allele
                if i == k
                    % Allele is the same as both current potential
                    % parental alleles
                    alleleProbs(alleleProbsCount) = 1;
                else
                    alleleProbs(alleleProbsCount) = .5;
                end
            elseif i == k
                % Allele is the same as the current potential paternal
                % allele
                alleleProbs(alleleProbsCount) = .5;
            end
        end
    end
end

geneCopyFactor.var = [geneCopyVarChild geneCopyVarOne geneCopyVarTwo];
geneCopyFactor.card = ones(1, 3) * numAlleles;
geneCopyFactor.val = alleleProbs;