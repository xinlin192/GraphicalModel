% Copyright (C) Daphne Koller, Stanford University, 2012

function [MEU OptimalDecisionRule] = SimpleOptimizeMEU(I)
  
  % We assume there is only one decision rule in this function.
  D = I.DecisionFactors(1);
  
  PossibleDecisionRules = EnumerateDecisionRules(D);

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  %
  % YOUR CODE HERE
  % 1.  You must find which of the decision rules you have enumerated has the 
  %     highest expected utility.  You should use your implementation of 
  %     SimpleCalcExpectedUtility from P1.  Set the values of MEU and OptimalDecisionRule
  %     to the best achieved expected utility and the corresponding decision
  %     rule respectively.
  %
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  
end

  
  
  
      
