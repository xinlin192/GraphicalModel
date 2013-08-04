% Copyright (C) Daphne Koller, Stanford University, 2012

function F = NormalizeFactorValues( F )
  
  for i=1:length(F)
    ThisFactor = F(i);
    ThisFactor.val = ThisFactor.val / sum(ThisFactor.val);
    F(i) = ThisFactor;
  end
  