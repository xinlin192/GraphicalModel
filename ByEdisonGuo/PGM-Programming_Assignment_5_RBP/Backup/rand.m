% Copyright (C) Daphne Koller, Stanford University, 2012

function [val] = rand(arg1,arg2);
val = -1;
gran = 1e6;

if(nargin>0&&ischar(arg1))
  if(nargin==1)
    arg2=1;
  end
  randi(arg1,arg2);
  val=0;
else
  if(nargin==0)
    val = randi(1e6)/(1e6);
  else
    if(nargin==1)
      if(length(arg1)>1)
        arg2=arg1(2);
        arg1=arg1(1);
      else
        arg2=arg1;
      end
    end
    val = randi(1e6,arg1,arg2)/1e6;
  end
end
