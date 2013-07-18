%
% This is a script that constructs the toy network and outputs toy_network and toy_factors into
% the environment.  You should modify this file to change the parameters of the toy network.
%
% In this file, on_diag_weight represents the weight of the on-diagonal elements
% in your pairwise CPDs (weight of agreement) while the off_diag_weight is the
% weight for off-diagonal assignments (weight of disagreement between adjacent nodes)
%
% Copyright (C) Daphne Koller, Stanford University, 2012

function [toy_network, toy_factors] = ConstructToyNetwork(on_diag_weight, off_diag_weight)

n = 4;  % square length
k = 2;  % sub-square length
V = 1:n*n;

G = struct;
G.names = {};
for i = 1:length(V)
    G.names{i} = ['pixel', num2str(i)];
    G.card(i) = 2;    
end
edges = zeros(length(V));
for i = 1:length(V)
    for j = i+1:length(V)
        % Four connected Markov Net
        [r_i, c_i] = ind2sub([n,n],i);
        [r_j, c_j] = ind2sub([n,n],j);
        if sum(abs([r_i, c_i] - [r_j, c_j])) == 1
            edges(i, j) = 1;
        end
    end
end
G.edges = or(edges, edges');

singleton_factors = [];
for i = 1:length(V)
    singleton_factors(i).var = i;
    singleton_factors(i).card = 2;
    if i <= length(V) / 2
        singleton_factors(i).val = [0.4, 0.6];
    else
        singleton_factors(i).val = [0.6, 0.4];
    end
end

pairwise_factors = [];
[r, c] = ind2sub([length(V), length(V)], find(edges));
edge_list = [r, c];
for i = 1:size(edge_list, 1)
    pairwise_factors(i).var = edge_list(i, :);
    pairwise_factors(i).card = [2, 2];
    pairwise_factors(i).val = [on_diag_weight, off_diag_weight, ...
                        off_diag_weight, on_diag_weight];

end

F = [singleton_factors, pairwise_factors];
G.var2factors = VariableToFactorCorrespondence(V, F);

toy_network = G;
toy_factors = [singleton_factors, pairwise_factors];
