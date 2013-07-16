% Copyright (C) Daphne Koller, Stanford University, 2012

rand('seed', 1);

% Construct the toy network
[toy_network, toy_factors] = ConstructToyNetwork(0.3, 1);
toy_evidence = zeros(1, length(toy_network.names));
%toy_clique_tree = CreateCliqueTree(toy_factors, []);
%toy_cluster_graph = CreateClusterGraph(toy_factors,[]);

% Exact Inference
ExactM = ComputeExactMarginalsBP(toy_factors, toy_evidence, 0)
figure, VisualizeToyImageMarginals(toy_network, ExactM);

% Comment this in to run Approximate Inference on the toy network
% Approximate Inference
% % ApproxM = ApproxInference(toy_cluster_graph, toy_factors, toy_evidence);
% figure, VisualizeToyImageMarginals(toy_network, ApproxM);



% MCMC Inference
transition_names = {'Gibbs', 'MHUniform', 'MHGibbs', 'MHSwendsenWang1', 'MHSwendsenWang2'};

for j = 1:length(transition_names)
    samples_list = {};

    num_chains_to_run = 3;
    for i = 1:num_chains_to_run
        % Random Initialization
        A0 = ceil(rand(1, length(toy_network.names)) .* toy_network.card);

        % Initialization to all ones
        % A0 = i * ones(1, length(toy_network.names));

        [M, all_samples] = ...
            MCMCInference(toy_network, toy_factors, toy_evidence, transition_names{j}, 0, 4000, 1, A0);
        samples_list{i} = all_samples;
        figure, VisualizeToyImageMarginals(toy_network, M, i, transition_names{j});
    end
 
    vis_vars = [3];
    VisualizeMCMCMarginals(samples_list, vis_vars, toy_network.card(vis_vars), toy_factors, ...
      500, ExactM(vis_vars),transition_names{j});
    disp(['Displaying results for MCMC with transition ', transition_names{j}]);
    disp(['Hit enter to continue']);
    pause;
end