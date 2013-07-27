addpath('gaimc');
    %MHSWTrans (v2)
     randi('seed',1);
    
    OUTmat = exampleOUTPUT.t11{1};
    for i = 1:19
       
      OUTmat = [OUTmat; MHSWTrans(OUTmat(end,:), exampleINPUT.t12a1{1}, exampleINPUT.t12a2{1}, 2)];
      exampleOUTPUT.t11{i+1} == OUTmat(end, :)
    end