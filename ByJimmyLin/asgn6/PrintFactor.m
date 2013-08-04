% Copyright (C) Daphne Koller, Stanford University, 2012

function [] = PrintFactor(F)
  % Pretty print the factor F.
  % The first row lists the variables and subsequent rows are
  % the joint assignment and their associated factor value in
  % the last column.
  
  for i=1:length(F.var)
    fprintf(1, '%d\t', F.var(i));
  end
  fprintf(1, '\n');
  
  for i=1:length(F.val)
    A = IndexToAssignment(i, F.card);
    for j=1:length(A)
      fprintf(1, '%d\t', A(j));
    end
    fprintf(1, '%f\n', F.val(i));
  end
  
  
end