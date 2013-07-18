%EXTRACTMARGINALSFROMSAMPLES
%
%   ExtractMarginalsFromSamples takes in a probabilistic network G, a list of samples, and a set
%   of indices into samples that specify which samples to use in the computation of the
%   marginals.  The marginals are then computed using this subset of samples and returned.
%
%   Samples is a matrix where each row is the assignment to all variables in
%   the network (samples(i,j)=k means in sample i the jth variable takes label k)
%
% Copyright (C) Daphne Koller, Stanford University, 2012

function M = ExtractMarginalsFromSamples(G, samples, collection_indx)

collected_samples = samples(collection_indx, :);

M = repmat(struct('var', 0, 'card', 0, 'val', []), length(G.names), 1);
for i = 1:length(G.names)
    M(i).var = i;
    M(i).card = G.card(i);
    M(i).val = zeros(1, G.card(i));
end

for s=1:size(collected_samples, 1)
    sample = collected_samples(s,:);
    for j=1:length(sample)
        M(j).val(sample(j)) = M(j).val(sample(j)) + 1/size(collected_samples,1);
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
