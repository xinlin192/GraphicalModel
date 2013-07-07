function CreditWorthiness_Test()
    fileName = 'C:\Users\edison\Desktop\Probabilistic Graphical Models\Assignments\PGM-Programming_Assignment_1\Credit_net.net';
    E{1, 1} = 'DebtIncomeRatio';
    E{1, 2} = 'Low';
    
    disp('Observed evidence: ')
    disp(E)
    M = CheckCreditWorthiness(fileName, E);
    disp(M);
    
    disp('Without observed evidence: ')
    M = CheckCreditWorthiness(fileName, []);
    disp(M);
end

function M = CheckCreditWorthiness(fileName, E)

    [F, names, valNames] = ConvertNetwork(fileName);
   
    evidence = [];
    if ~isempty(E)
        evidence = zeros(size(E));
        for i = 1:size(E, 1)
           ivar = find(strcmp(E(i, 1), names));
           val = find(strcmp(E(i, 2), valNames{ivar}));

           evidence(i, :) = [ivar val];
        end
    end
    
    idx = find(strcmp(names, 'CreditWorthiness'));
    M = ComputeMarginal(idx, F, evidence);
  
end

