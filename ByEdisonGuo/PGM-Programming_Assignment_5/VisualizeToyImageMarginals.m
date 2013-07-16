% Copyright (C) Daphne Koller, Stanford University, 2012

function VisualizeToyImageMarginals(G, M, chain_num, tname)

n = sqrt(length(G.names));
marginal_vector = [];
for i = 1:length(M)
    marginal_vector(end+1) = M(i).val(1);
end
clims = [0, 1];
imagesc(reshape(marginal_vector, n, n), clims);
colormap(gray);
title(['Marginals for chain ' num2str(chain_num) ' ' tname])