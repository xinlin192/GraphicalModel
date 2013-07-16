% Copyright (C) Daphne Koller, Stanford University, 2012

function [num mv] = randi(arg1,arg2,arg3)

num = -1;
persistent x_i;
persistent p1;
persistent p2;
if(isempty(x_i))
  x_i = 1;
  p1 = 160481183;
  p2 = 179424673;
end
mv=p2;
if(ischar(arg1)==1)
  if(strcmp(arg1,'seed'))
    if(nargin>1)
      x_i = arg2;
      num = 0;
    else
      x_i=1;
      num=0;
    end
  else
    'Unrecognized option. The only accepted option to this random library is -seed-.'
  end
else
  if(arg1>p2)
    'Max too high, range cutoff at 1 million'
  end
  if(nargin>1)
    if(nargin==2)
      arg3=arg2;
    end
    num = zeros(arg2,arg3);
    for i=1:arg2
      for j = 1:arg3
        x_i = mod(x_i*(p1+1)+p1,p2);
        num(i,j) = mod(x_i,arg1)+1;
      end
    end
  else
    x_i = mod(x_i*(p1+1)+p1,p2);
    num=mod(x_i,arg1)+1;
  end
end

