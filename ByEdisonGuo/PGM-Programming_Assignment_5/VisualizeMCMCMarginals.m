% VISUALIZEMCMCMARGINALS
%
% This function accepts a list of sample lists, each from a different MCMC run.  It then visualizes
% the estimated marginals for each variable in V over the lifetime of the MCMC run.
%
% samples_list - a list of sample lists; each sample list is a m-by-n matrix where m is the
% number of samples and n is the number of variables in the state of the Markov chain
%
% V - an array of variables
% D - the dimensions of the variables in V
% F - a list of factors (used in computing likelihoods of each sample)
% window_size - size of the window over which to aggregate samples to compute the estimated
%               marginal at a given time
% ExactMarginals - the exact marginals of V (optional)
%
% Copyright (C) Daphne Koller, Stanford University, 2012

function VisualizeMCMCMarginals(samples_list, V, D, F, window_size, ExactMarginals, tname)

for i = 1:length(V)
    figure;
    v = V(i);
    d = D(i);
    title(['Marginal for Variable ', num2str(v)]);
    if exist('ExactMarginals') == 1, M = ExactMarginals(i); end;
    for j = 1:length(samples_list)
        samples_v = samples_list{j}(:, v);
        indicators_over_time = zeros(length(samples_v), d);
        for k = 1:length(samples_v)
            indicators_over_time(k, samples_v(k)) = 1;
        end

        % estimated_marginal = cumsum(indicators_over_time, 1);
        estimated_marginal = [];
        for k = 1:size(indicators_over_time, 2)
            estimated_marginal = [estimated_marginal, smooth(indicators_over_time(:, k), window_size)];
        end
        % Prune ends
        estimated_marginal = estimated_marginal(window_size/2:end - window_size/2, :);


        estimated_marginal = estimated_marginal ./ ...
            repmat(sum(estimated_marginal, 2), 1, size(estimated_marginal, 2));
        hold on;
        plot(estimated_marginal, '-', 'LineWidth', 2);
        title(['Est marginals for entry ' num2str(i) ' of samples for ' tname])
        if exist('M') == 1
            plot([1; size(estimated_marginal, 1)], [M.val; M.val], '--', 'LineWidth', 3);
        end
        set(gcf,'DefaultAxesColorOrder', rand(d, 3));
    end
end

% Visualize likelihood of sample at each time step
all_likelihoods = [];
for i = 1:length(samples_list)
    samples = samples_list{i};
    likelihoods = [];
    for j = 1:size(samples, 1)
        likelihoods = [likelihoods; LogProbOfJointAssignment(F, samples(j, :))];
    end
    all_likelihoods = [all_likelihoods, likelihoods];
end
figure;
title('Likelihoods')
plot(all_likelihoods, '-', 'LineWidth', 2);