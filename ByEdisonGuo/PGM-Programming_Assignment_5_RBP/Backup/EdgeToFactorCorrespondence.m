% Returns a matrix that maps edges to a list of factors in which both ends partake
%
% Copyright (C) Daphne Koller, Stanford University, 2012

function E2F = EdgeToFactorCorrespondence(V, F)

E2F = cell(length(V), length(V));

for f = 1:length(F)
    for i = 1:length(F(f).var)
        for j = i+1:length(F(f).var)
            u = F(f).var(i);
            v = F(f).var(j);
            E2F{u,v} = union(E2F{u,v}, f);
            E2F{v,u} = union(E2F{v,u}, f);
        end
    end
end