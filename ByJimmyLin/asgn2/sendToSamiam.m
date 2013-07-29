function sendToSamiam(pedigree, factorList, alleleList, phenotypeList, positions, outputFileName)
% This function creates a file for Samiam using a list of factors and a
% pedigree.
% Input:
%   pedigree: Data structure that includes names and parent-child
%   relationships
%   factorList: List of factors
%	alleleList: List of alleles
%   phenotypeList: List of phenotypes
%   pedigreePositionsFileName: List with positions for the nodes for
%   each person in the family -- each row is for a person, and the contents
%   of each row is (genotype horizontal position, genotype vertical
%   position, phenotype horizontal position, phenotype vertical position)
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
    fprintf(fid, '%s', 'Genotype');
    fprintf(fid, '\n', '');
    fprintf(fid, '%s', '{');
    fprintf(fid, '\n', '');
    fprintf(fid, '\t', '');
    fprintf(fid, '%s', 'label = "');
    fprintf(fid, '%s', name);
    fprintf(fid, '%s', 'Genoytpe";');
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
        for k = j:length(alleleList)
            % Iterate through pairs of alleles
            fprintf(fid, '%s', '"');
            fprintf(fid, '%s', alleleList{j});
            fprintf(fid, '%s', alleleList{k});
            fprintf(fid, '%s', '"');
            if (j ~= length(alleleList)) || (k ~= length(alleleList))
                % Put in a space because there will be another genotype
                fprintf(fid, '%s', ' ');
            end
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
    fprintf(fid, '%d', positions(i,3));
    fprintf(fid, '%s', ' ');
    fprintf(fid, '%d', positions(i,4));
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

for i = 1:2*numPeople
    % Iterate through factors and make a potential for each
    factor = factorList(i);
    fprintf(fid, '%s', 'potential (');
    firstNode = factor.var(1);
    if firstNode <= numPeople
        % Genotype node
        firstName = pedigree.names{firstNode};
        fprintf(fid, '%s', firstName);
        fprintf(fid, '%s', 'Genotype |');
        if pedigree.parents(firstNode, 1) ~= 0
            % Person has parents
            parentOneName = pedigree.names{factor.var(2)};
            parentTwoName = pedigree.names{factor.var(3)};
            fprintf(fid, '%s', ' ');
            fprintf(fid, '%s', parentOneName);
            fprintf(fid, '%s', 'Genotype ');
            fprintf(fid, '%s', parentTwoName);
            fprintf(fid, '%s', 'Genotype');
        end
        fprintf(fid, '%s', ')');
        fprintf(fid, '\n', '');
        fprintf(fid, '%s', '{');
        fprintf(fid, '\n', '');
        fprintf(fid, '\t', '');
        fprintf(fid, '%s', 'data = ');
        fprintf(fid, '%s', '(');
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
        nameNode = factor.var(2);
        name = pedigree.names{nameNode};
        fprintf(fid, '%s', name);
        fprintf(fid, '%s', 'Phenotype | ');
        fprintf(fid, '%s', name);
        fprintf(fid, '%s', 'Genotype)');
        fprintf(fid, '\n', '');
        fprintf(fid, '%s', '{');
        fprintf(fid, '\n', '');
        fprintf(fid, '\t', '');
        fprintf(fid, '%s', 'data = ');
        for k = 1:length(factor.var)
            fprintf(fid, '%s', '(');
        end
        varIndexes = ones(1, length(factor.var));
        for k = 1:length(factor.val)
            % Iterate through the values of the factor
            fprintf(fid, '%f', factor.val(k));
            closedParen = 0;
            j = length(factor.var);
            while j > 0
                % Iterate through variables to see what closed parentheses are
                % necessary
                if varIndexes(j) == factor.card(j)
                    % Need to close parentheses
                    closedParen = closedParen + 1;
                    fprintf(fid, '%s', ')');
                    varIndexes(j) = 1;
                else
                    varIndexes(j) = varIndexes(j) + 1;
                    break
                end
                j = j - 1;
            end
            if (closedParen > 0) && (closedParen < length(factor.var))
                % Need a new line
                fprintf(fid, '\n', '');
                fprintf(fid, '\t', '');
                fprintf(fid, '\t', '');
                for j = 1:closedParen
                    % Make new open parentheses
                    fprintf(fid, '%s', '(');
                end
            elseif closedParen == length(factor.var)
                % At end of factor
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