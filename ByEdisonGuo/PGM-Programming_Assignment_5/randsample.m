%randsample(V,n,true,distribution) returns a set of n values sampled
% at random from the integers 1 through V with replacement using distribution
% 'distribution'
% 
% replacing true with false causes sampling w/out replacement
% omitting the distribution causes a default to the uniform distribution
%
% Copyright (C) Daphne Koller, Stanford University, 2012

function [v] = randsample(vals,numSamp,replace,weightIncrements)

  vals = vals(:);
  if(length(vals)==1)
    maxval = vals;
    vals = 1:maxval;
  else
    maxval = length(vals);
  end

  if(exist('replace','var')~=1)
    replace = true;
  end
  if(exist('weightIncrements','var')~=1)
    weightIncrements = (1/maxval)*ones(maxval,1);
    weights = (1/maxval):(1/maxval):1;
  else
    weightIncrements = weightIncrements(:)/sum(weightIncrements(:));
    weights = zeros(size(weightIncrements));
    weights(1) = weightIncrements(1);
    for i = 2:length(weightIncrements)
      weights(i) = weightIncrements(i)+weights(i-1);
    end
  end
  
  weights = [0; weights(:)];
  
  %now do the sampling
  v = [];
  probs = rand(numSamp,1);
  for i=1:numSamp
    curInd = find((weights(1:end-1)<=probs(i))&(weights(2:end)>=probs(i)));
    v(end+1)=vals(curInd);
    if(replace~=true)
      vals(curInd)=[];
      weightIncrements(curInd)=[];
      weightIncrements = weightIncrements(:)/sum(weightIncrements(:));
      weights = zeros(size(weightIncrements));
      for i = 2:length(weightIncrements)
        weights(i) = weightIncrements(i)+weights(i-1);
      end
    end
  end


end
