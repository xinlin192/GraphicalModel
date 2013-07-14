% Function that sorts the variables in F and returns an equivalent
% factor G.  Used only to standardize output for grading purposes.
function G = StandardizeFactors(F)
G = struct('var', [], 'card', [], 'val', []);
for i = 1:length(F)
    G(i) = StandardizeFactor(F(i));
end

function G = StandardizeFactor(F);

G = struct('var', [], 'card', [], 'val', []);

[G.var, F2G] = sort(F.var);
G.card = F.card(F2G);
G.val = zeros(size(F.val));

fval = [1:length(F.val)];
if isempty(fval); fval = []; end;

F_assn = IndexToAssignment(1:length(F.val), F.card);
idx = AssignmentToIndex(F_assn(:, F2G), G.card);
G.val(idx) = F.val;
