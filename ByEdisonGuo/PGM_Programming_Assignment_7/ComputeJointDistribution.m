%ComputeJointDistribution Computes the joint distribution defined by a set
% of given factors
%
%   Joint = ComputeJointDistribution(F) computes the joint distribution
%   defined by a set of given factors
%
%   Joint is a factor that encapsulates the joint distribution given by F
%   F is a vector of factors (struct array) containing the factors 
%     defining the distribution
%
% Copyright (C) Daphne Koller, Stanford Univerity, 2012

function Joint = ComputeJointDistribution(F)

  % Check for empty factor list
  assert(numel(F) ~= 0, 'Error: empty factor list');

if (length(F) == 0)
	% There are no factors, so create an empty factor list
    Joint = struct('var', [], 'card', [], 'val', []);
else    
	Joint = F(1);
	for i = 2:length(F)
		% Iterate through factors and incorporate them into the joint distribution
		Joint = FactorProduct(Joint, F(i));
	end
end
end

