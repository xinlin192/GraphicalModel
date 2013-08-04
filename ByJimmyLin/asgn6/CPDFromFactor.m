% Copyright (C) Daphne Koller, Stanford University, 2012

function [CPD] = CPDFromFactor(F, Y)
  nvars = length(F.var);

  % Reorder the var, card and val fields of Fnew so that the first var is the 
  % child variable.
  Fnew = F;
  YIndexInF = find(F.var == Y);
  this.card = F.card( YIndexInF );
  
  % Parents is a dummy factor
  Parents.var = F.var(find(F.var ~= Y));
  Parents.card = F.card(find(F.var ~= Y));
  Parents.val = ones(prod(Parents.card),1);

  Fnew.var = [Y Parents.var];
  Fnew.card = [this.card Parents.card];
  for i=1:length(F.val)
    A = IndexToAssignment(i, F.card);
    y = A(YIndexInF);
    A( YIndexInF ) = [];
    A = [y A];
    j = AssignmentToIndex(A, Fnew.card);
    Fnew.val(j) = F.val(i);
  end

  % normalize
  CPD = NormalizeCPDFactors(Fnew);
