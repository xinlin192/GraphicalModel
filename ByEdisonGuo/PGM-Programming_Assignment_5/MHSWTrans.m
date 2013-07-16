% MHSWTRANS
%
%  MCMC Metropolis-Hastings transition function that
%  utilizes the Swendsen-Wang proposal distribution.
%  A - The current joint assignment.  This should be
%      updated to be the next assignment
%  G - The network
%  F - List of all factors
%  variant - a number (1 or 2) indicating the variant of Swendsen-Wang to use.  In variant 1,
%            all the q_{i,j}'s are equal
%
% Copyright (C) Daphne Koller, Stanford University, 2012

function A = MHSWTrans(A, G, F, variant)

%%%%%%%%%%%%%% Get Proposal %%%%%%%%%%%%%%
% Prune edges from q_list if the nodes don't have the same current value
q_list = G.q_list;
q_keep_indx = find(A(q_list(:, 1)) == A(q_list(:, 2)));
q_list = q_list(q_keep_indx, :);
% Select edges at random based on q_list
selected_edges_q_list_indx = find(q_list(:, 3) > rand(size(q_list,1), 1));
selected_edges = q_list(selected_edges_q_list_indx, 1:2);
% Compute connected components over selected edges
SelEdgeMat = sparse([selected_edges(:,1)'; selected_edges(:,2)'],...
                    [selected_edges(:,2)'; selected_edges(:,1)'],...
                    1, length(G.names), length(G.names));

[var2comp, cc_sizes] = scomponents(SelEdgeMat);
num_cc = length(cc_sizes);


% Select a connected component (the book calls this Y)
selected_cc = ceil(rand() * num_cc);
selected_vars = find(var2comp == selected_cc);
% Check that the dimensions are all the same and they have the same current assignment
assert(length(unique(G.card(selected_vars))) == 1);
assert(length(unique(A(selected_vars))) == 1);

% Pick a new label via sampling
old_value = A(selected_vars(1));
d = G.card(selected_vars(1));
LogR = zeros(1, d);
if variant == 1
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % YOUR CODE HERE
    % Specify the log of the distribution (LogR) from 
    % which a new label for Y is selected for variant 1 
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
elseif variant == 2
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % YOUR CODE HERE
    % Specify the log of the distribution (LogR) from 
    % which a new label for Y is selected for variant 2
    %
    % We suggest you read through the preceding code
    % before implementing this, one of the generated
    % data structures may be useful in implementing this section
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
else
    disp('WARNING: Unrecognized Swendsen-Wang Variant');
end

% Sample the new value from the distribution R
new_value = randsample(d, 1, true, exp(LogR));
A_prop = A;
A_prop(selected_vars) = new_value;

% Get the log-ratio of the probability of picking the connected component Y given A_prop over A
log_QY_ratio = 0.0;
for i = 1:size(G.q_list, 1)  % Iterate through *all* edges, not just the ones we selected earlier
    u = G.q_list(i, 1);
    v = G.q_list(i, 2);
    if length(intersect([u, v], selected_vars)) == 1  % the edge is from Y to outside-Y
        if A(u) == old_value && A(v) == old_value
            log_QY_ratio = log_QY_ratio - log(1 - G.q_list(i, 3));
        end
        if A_prop(u) == new_value && A_prop(v) == new_value
            log_QY_ratio = log_QY_ratio + log(1 - G.q_list(i, 3));
        end
    end
end

p_acceptance = 0.0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% YOUR CODE HERE
% Compute acceptance probability
%
% Read through the preceding code to understand
% how to find the previous and proposed assignments
% of variables, as well as some ratios used in computing
% the acceptance probabilitiy.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Accept or reject proposal
if rand() < p_acceptance
    %disp('Accepted');
    A = A_prop;
end



