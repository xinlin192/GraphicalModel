function sendToSamiamGeneCopy(pedigree, factorList, alleleList, phenotypeList, positions, outputFileName)
% This function creates a file for Samiam using a list of factors and a
% pedigree.
% Input:
%   pedigree: Data structure that includes names, genders, and parent-child
%   relationships
%   factorList: List of factors
%   alleleFreqs: List of allele frequencies in the population
%   phenotypeList: List of phenotypes
%   positions: List with positions for the nodes for
%   each person in the family -- each row is for a person, and the contents
%   of each row is (parent one gene copy horizontal position, parent one 
%   gene copy vertical position, parent two gene copy horizontal position, 
%   parent two gene copy vertical position, phenotype horizontal position, 
%   phenotype horizontal position, phenotype vertical position)
%   outputFileName: Name of the file that will go to Samiam, should end in
%   .net

numPeople = length(pedigree.names);

outputFileName = strcat(outputFileName, '.net');
fid = fopen(outputFileName, 'w+');
fprintf(fid, '%s', 'net');
fprintf(fid, '\n', '');
fprintf(fid, '%s', '{');
fprintf(fid, '\n', '');
fprintf(fid, '\t', '');
fprintf(fid, '%s', 'node_size = (90 36);');
fprintf(fid, '\n', '');
fprintf(fid, '%s', '}');
fprintf(fid, '\n', '');
fprintf(fid, '\n', '');

for i = 1:numPeople
    % Make a genotype node and a phenotype node for each person
    fprintf(fid, '%s', 'node ');
    name = pedigree.names{i};
    fprintf(fid, '%s', name);
    fprintf(fid, '%s', 'Parent1GeneCopy');
    fprintf(fid, '\n', '');
    fprintf(fid, '%s', '{');
    fprintf(fid, '\n', '');
    fprintf(fid, '\t', '');
    fprintf(fid, '%s', 'label = "');
    fprintf(fid, '%s', name);
    fprintf(fid, '%s', 'Parent1GeneCopy";');
    fprintf(fid, '\n', '');
    fprintf(fid, '\t', '');
    fprintf(fid, '%s', 'position = (');
    fprintf(fid, '%d', positions(i,1));
    fprintf(fid, '%s', ' ');
    fprintf(fid, '%d', positions(i,2));
    fprintf(fid, '%s', ');');
    fprintf(fid, '\n', '');
    fprintf(fid, '\t', '');
    fprintf(fid, '%s', 'states = (');
    for j = 1:length(alleleList)
        % Iterate through alleles
        fprintf(fid, '%s', '"');
        fprintf(fid, '%s', alleleList{j});
        fprintf(fid, '%s', '"');
        if (j ~= length(alleleList))
            % Put in a space because there will be another genotype
            fprintf(fid, '%s', ' ');
        end
    end
    fprintf(fid, '%s', ');');
    fprintf(fid, '\n', '');
    fprintf(fid, '%s', '}');
    fprintf(fid, '\n', '');
    fprintf(fid, '\n', '');
    
    fprintf(fid, '%s', 'node ');
    name = pedigree.names{i};
    fprintf(fid, '%s', name);
    fprintf(fid, '%s', 'Parent2GeneCopy');
    fprintf(fid, '\n', '');
    fprintf(fid, '%s', '{');
    fprintf(fid, '\n', '');
    fprintf(fid, '\t', '');
    fprintf(fid, '%s', 'label = "');
    fprintf(fid, '%s', name);
    fprintf(fid, '%s', 'Parent2GeneCopy";');
    fprintf(fid, '\n', '');
    fprintf(fid, '\t', '');
    fprintf(fid, '%s', 'position = (');
    fprintf(fid, '%d', positions(i,3));
    fprintf(fid, '%s', ' ');
    fprintf(fid, '%d', positions(i,4));
    fprintf(fid, '%s', ');');
    fprintf(fid, '\n', '');
    fprintf(fid, '\t', '');
    fprintf(fid, '%s', 'states = (');
    for j = 1:length(alleleList)
        % Iterate through alleles
        fprintf(fid, '%s', '"');
        fprintf(fid, '%s', alleleList{j});
        fprintf(fid, '%s', '"');
        if (j ~= length(alleleList))
            % Put in a space because there will be another genotype
            fprintf(fid, '%s', ' ');
        end
    end
    fprintf(fid, '%s', ');');
    fprintf(fid, '\n', '');
    fprintf(fid, '%s', '}');
    fprintf(fid, '\n', '');
    fprintf(fid, '\n', '');
    
    fprintf(fid, '%s', 'node ');
    fprintf(fid, '%s', name);
    fprintf(fid, '%s', 'Phenotype');
    fprintf(fid, '\n', '');
    fprintf(fid, '%s', '{');
    fprintf(fid, '\n', '');
    fprintf(fid, '\t', '');
    fprintf(fid, '%s', 'label = "');
    fprintf(fid, '%s', name);
    fprintf(fid, '%s', 'Phenotype";');
    fprintf(fid, '\n', '');
    fprintf(fid, '\t', '');
    fprintf(fid, '%s', 'position = (');
    fprintf(fid, '%d', positions(i,5));
    fprintf(fid, '%s', ' ');
    fprintf(fid, '%d', positions(i,6));
    fprintf(fid, '%s', ');');
    fprintf(fid, '\n', '');
    fprintf(fid, '\t', '');
    fprintf(fid, '%s', 'states = (');
    for j = 1:length(phenotypeList)
        % Iterate through phenotypes
        fprintf(fid, '%s', '"');
        fprintf(fid, '%s', phenotypeList{j});
        fprintf(fid, '%s', '"');
        if j ~= length(phenotypeList)
            fprintf(fid, '%s', ' ');
        end
    end
    fprintf(fid, '%s', ');');
    fprintf(fid, '\n', '');
    fprintf(fid, '%s', '}');
    fprintf(fid, '\n', '');
    fprintf(fid, '\n', '');
end

for i = 1:3*numPeople
    % Iterate through factors and make a potential for each
    factor = factorList(i);
    fprintf(fid, '%s', 'potential (');
    firstNode = factor.var(1);
    if firstNode <= numPeople
        % Gene copy 1 node
        firstName = pedigree.names{firstNode};
        fprintf(fid, '%s', firstName);
        fprintf(fid, '%s', 'Parent1GeneCopy |');
        if pedigree.parents(firstNode, 1) ~= 0
            % Person has parents
            parentOne = pedigree.parents(firstNode, 1);
            parentOneName = pedigree.names{parentOne};
            if factor.var(2) < factor.var(3)
                % The first parent's first parent comes before the first
                % parent's second parent in the factor
                fprintf(fid, '%s', ' ');
                fprintf(fid, '%s', parentOneName);
                fprintf(fid, '%s', 'Parent1GeneCopy ');
                fprintf(fid, '%s', parentOneName);
                fprintf(fid, '%s', 'Parent2GeneCopy');
            else
                fprintf(fid, '%s', ' ');
                fprintf(fid, '%s', parentOneName);
                fprintf(fid, '%s', 'Parent2GeneCopy ');
                fprintf(fid, '%s', parentOneName);
                fprintf(fid, '%s', 'Parent1GeneCopy');
            end
        end
        fprintf(fid, '%s', ')');
        fprintf(fid, '\n', '');
        fprintf(fid, '%s', '{');
        fprintf(fid, '\n', '');
        fprintf(fid, '\t', '');
        fprintf(fid, '%s', 'data = (');
        varIndexes = ones(1, length(factor.var));
        for k = 1:length(factor.val)
            % Iterate through the values of the factor
            fprintf(fid, '%f', factor.val(k));
            if k == length(factor.val)
                % At end of factor
                fprintf(fid, '%s', ')');
                fprintf(fid, '%s', ';');
                fprintf(fid, '\n', '');
                fprintf(fid, '%s', '}');
                fprintf(fid, '\n', '');
                fprintf(fid, '\n', '');
            else
                fprintf(fid, '%s', ' ');
            end
        end
    elseif firstNode <= 2 * numPeople
        % Gene copy 2 node
        firstName = pedigree.names{firstNode-numPeople};
        fprintf(fid, '%s', firstName);
        fprintf(fid, '%s', 'Parent2GeneCopy |');
        if pedigree.parents(firstNode-numPeople, 2) ~= 0
            % Person has parents
            parentTwo = pedigree.parents(firstNode-numPeople, 2);
            parentTwoName = pedigree.names{parentTwo};
            if factor.var(2) < factor.var(3)
                % The first parent's first parent comes before the first
                % parent's second parent in the factor
                fprintf(fid, '%s', ' ');
                fprintf(fid, '%s', parentTwoName);
                fprintf(fid, '%s', 'Parent1GeneCopy ');
                fprintf(fid, '%s', parentTwoName);
                fprintf(fid, '%s', 'Parent2GeneCopy');
            else
                fprintf(fid, '%s', ' ');
                fprintf(fid, '%s', parentTwoName);
                fprintf(fid, '%s', 'Parent2GeneCopy ');
                fprintf(fid, '%s', parentTwoName);
                fprintf(fid, '%s', 'Parent1GeneCopy');
            end
        end
        fprintf(fid, '%s', ')');
        fprintf(fid, '\n', '');
        fprintf(fid, '%s', '{');
        fprintf(fid, '\n', '');
        fprintf(fid, '\t', '');
        fprintf(fid, '%s', 'data = (');
        for k = 1:length(factor.val)
            % Iterate through the values of the factor
            fprintf(fid, '%f', factor.val(k));
            if k == length(factor.val)
                % At end of factor
                fprintf(fid, '%s', ')');
                fprintf(fid, '%s', ';');
                fprintf(fid, '\n', '');
                fprintf(fid, '%s', '}');
                fprintf(fid, '\n', '');
                fprintf(fid, '\n', '');
            else
                fprintf(fid, '%s', ' ');
            end
        end
    else
        nameNode = min(factor.var(2), factor.var(3));
        name = pedigree.names{nameNode};
        fprintf(fid, '%s', name);
        fprintf(fid, '%s', 'Phenotype | ');
        if factor.var(2) < factor.var(3)
            fprintf(fid, '%s', name);
            fprintf(fid, '%s', 'Parent1GeneCopy ');
            fprintf(fid, '%s', name);
            fprintf(fid, '%s', 'Parent2GeneCopy)');
        else
            fprintf(fid, '%s', name);
            fprintf(fid, '%s', 'Parent2GeneCopy ');
            fprintf(fid, '%s', name);
            fprintf(fid, '%s', 'Parent1GeneCopy)');
        end
        fprintf(fid, '\n', '');
        fprintf(fid, '%s', '{');
        fprintf(fid, '\n', '');
        fprintf(fid, '\t', '');
        fprintf(fid, '%s', 'data = (');
        for k = 1:length(factor.val)
            % Iterate through the values of the factor
            fprintf(fid, '%f', factor.val(k));
            if k == length(factor.val)
                % At end of factor
                fprintf(fid, '%s', ')');
                fprintf(fid, '%s', ';');
                fprintf(fid, '\n', '');
                fprintf(fid, '%s', '}');
                fprintf(fid, '\n', '');
                fprintf(fid, '\n', '');
            else
                fprintf(fid, '%s', ' ');
            end
        end
    end
end

fclose(fid);