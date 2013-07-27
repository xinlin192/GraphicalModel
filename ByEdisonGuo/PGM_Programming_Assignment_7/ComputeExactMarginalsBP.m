%COMPUTEEXACTMARGINALSBP Runs exact inference and returns the marginals
%over all the variables. 

%   M = COMPUTEEXACTMARGINALSBP(F,E, isMax) Takes a list of factors F,
%   evidence E and a flag isMax and run exact inference and returns the
%   final marginals for the variables in the network. If isMax is 1, then
%   it runs exact MAP inference, otherwise exact inference (sum-prod).
%   It returns an array of size equal to the number of variables in the 
%   network where M(i) represents the ith variable and M(i).val represents 
%   the marginals of the ith variable. 


% Copyright (C) Daphne Koller, Stanford Univerity, 2012

function M = ComputeExactMarginalsBP(F, E, isMax)
% Since we only need marginals at the end, you should M as:
%
% M = repmat(struct('var', 0, 'card', 0, 'val', []), length(N), 1);
%
% where N is the number of variables in the network, which can be determined
% from the factors F.

% Create a clique tree, compute the initial potentails, calibrate the
% clique tree, and find the belief for each varaible at a clique that has
% that variable in its scope
compressedCliqueTree = CreateCliqueTree(F, E);
PCalibrated = CliqueTreeCalibrate(compressedCliqueTree, isMax);
varsList = unique([F(:).var]);
M = repmat(struct('var', 0, 'card', 0, 'val', []), length(varsList), 1);
for i = 1:length(varsList)
    % Iterate through variables and find the marginal for each
    clique = struct('var', 0, 'card', 0, 'val', []);
    currentVar = varsList(i);
    for j = 1:length(PCalibrated.cliqueList)
        % Find a clique with the variable of interest
        if ~isempty(find(ismember(PCalibrated.cliqueList(j).var, currentVar)))
            % A clique with the variable has been indentified
            clique = PCalibrated.cliqueList(j);
            break
        end
    end
    if isMax == 0
        % Do sum-product inference
        M(i) = FactorMarginalization(clique, setdiff(clique.var, currentVar));
        if any(M(i).val ~= 0)
            % Normalize
            M(i).val = M(i).val/sum(M(i).val);
        end
    else
        % Do MAP inference by using FactorMaxMarginalization instead of
        % FactorMarginalization
        M(i) = FactorMaxMarginalization(clique, setdiff(clique.var, currentVar));
    end
end

end
