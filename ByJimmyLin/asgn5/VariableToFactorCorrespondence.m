% Copyright (C) Daphne Koller, Stanford University, 2012

function V2F = VariableToFactorCorrespondence(V, F)

V2F = cell(length(V), 1);

for f = 1:length(F)
    for i = 1:length(F(f).var)
        v = F(f).var(i);
        V2F{v} = union(V2F{v}, f);
    end
end
