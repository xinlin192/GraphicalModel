% Copyright (C) Daphne Koller, Stanford University, 2012

function [F] = NormalizeCPDFactors(F)
  
  NumFactors = length(F);
  for i=1:NumFactors

    f = F(i);
    dummy.var = f.var(2:end);
    dummy.card = f.card(2:end);
    dummy.val = zeros(1,prod(dummy.card));
    
    % Now for each joint assignment to parents, renormalize the 
    % values for that joint assignment to sum to 1.  

    for a=1:length(dummy.val)
      A = IndexToAssignment(a, dummy.card);
      Indices = [];
      for d=1:f.card(1)
          Indices = [Indices AssignmentToIndex([d A], f.card);];
      end
      if sum(f.val(Indices)) == 0
          % Set f.val(Indices) to 0
          f.val(Indices) = 0;
      else
          f.val(Indices) = f.val(Indices) / sum(f.val(Indices));
      end
    end

    f.val(find(isnan(f.val))) = 0;
    
    F(i) = f;
  
  end
  
