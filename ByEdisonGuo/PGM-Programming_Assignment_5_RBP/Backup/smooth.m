% Copyright (C) Daphne Koller, Stanford University, 2012

function [YY] = smooth(Y,window)
if(~exist('window','var'))
  window =5;
end
if(mod(window,2)==0)
  window = window+1;
end
mid = (window+1)/2;

len = length(Y);
Smoother =zeros(len); 
for i=1:len
  dev = min([mid-1 min([i-1 len-i])]);
  % dev
  Smoother(i,(i-dev):(i+dev))=1;
end
if(size(Y,2)>size(Y,1))
  Y = Y';
end

col = sum(Smoother,2);
YY = Smoother*Y;
YY = YY./col;
