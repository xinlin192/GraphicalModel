% ObserveEvidence Modify a vector of factors given some evidence.
%   F = ObserveEvidence(F, E) sets all entries in the vector of factors, F,
%   that are not consistent with the evidence, E, to zero. F is a vector of
%   factors, each a data structure with the following fields:
%     .var    Vector of variables in the factor, e.g. [1 2 3]
%     .card   Vector of cardinalities corresponding to .var, e.g. [2 2 2]
%     .val    Value table of size prod(.card)
%   E is an N-by-2 matrix, where each row consists of a variable/value pair. 
%     Variables are in the first column and values are in the second column.
%   NOTE - DOES NOT RENORMALIZE THE FACTOR VALUES 
%
% Copyright (C) Daphne Koller, Stanford University, 2012

function F = ObserveEvidence(F, E, normalize)

  % Iterate through all evidence
  for i = 1:size(E, 1),
    v = E(i, 1); % variable
    x = E(i, 2); % value

    % Check validity of evidence
    if (x == 0),
      warning(['Evidence not set for variable ', int2str(v)]);
      continue;
    end;

    % Iterate through the factors
    for j = 1:length(F),
      % Does factor contain variable?
      indx = find(F(j).var == v);

      if (~isempty(indx)),
        
	% Check validity of evidence
	if (x > F(j).card(indx) || x < 0 ),
	  error(['Invalid evidence, X_', int2str(v), ' = ', int2str(x)]);
	end;

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% YOUR CODE HERE
	% Adjust the factor F(j) to account for observed evidence
	% Hint: You might find it helpful to use IndexToAssignment
	%       and SetValueOfAssignment
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% For each value (1-1 map between assignment and values)
	for k = 1:length(F(j).val),

	  % get assignment for this index
	  A = IndexToAssignment(k, F(j).card);

	  % indx = index of evidence variable in this factor
	  if (A(indx) ~= x),
	    F(j).val(k) = 0;
	  end;
	
	end;
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

	% Check validity of evidence / resulting factor
	if (all(F(j).val == 0)),
	  warning(['Factor ', int2str(j), ' makes variable assignment impossible']);
	end;

      end % if (!isempty(index))
      
    end % for j = 1:length(F),
    
  end % for i = 1:size(E, 1),

  if (nargin == 3)
    if (normalize)
      F = NormalizeCPDFactors(F);
    end
  end
  

