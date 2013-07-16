% MCMCINFERENCE conducts Markov Chain Monte Carlo Inference.
%  M = MCMCInference(G, F, E, ...) performs inference given a Markov Net or Bayes Net, G, a list
%  of factors F, evidence E, and a list of parameters specifying the type of MCMC to be conducted.
%
%  G is a data structure that represents the variables in the probabilistic graphical network.  In
%  particular, it has fields
%       .names - a list of the names of all variables in the network, in order of variable index
%       .card - a list of the dimensions of all variables
%       .var2factors - a mapping of variables to which factors they are included in
%
%  F is a list of all factors in the network.
%  The factor data structure has the following fields:
%       .var    Vector of variables in the factor, e.g. [1 2 3]
%       .card    Vector of dimensions corresponding to .var, e.g. [2 2 2]
%       .val    Value table of size prod(.card)
%  E is an evidence vector, the same length as G.names, where an entry of 0 means unobserved
%
%  TransName is the name of the MCMC transition type (e.g. "Gibbs")
%
%  mix_time is the number of iterations to wait until samples are collected.  The user should
%  determine mix_time by observing behavior using the visualization framework provided.
%
%  num_samples is the number of additional samples (after the initial sample
%  following mixing) to collect
%
%  sampling_interval is the number of iterations in the chain to wait between collecting samples
%  (after mix_time has been reached). This should ALWAYS be set to 1, unless
%  memory usage is a concern in which case you may want to ignore some samples.
%
%  A0 is the initial state of the Markov Chain.  Note that it is a joint assignment to the
%  variables in G, where element is the value of the variable corresponding to the index.
%
% Copyright (C) Daphne Koller, Stanford University, 2012

function [M, all_samples] = MCMCInference(G, F, E, TransName, mix_time, ...
                                                  num_samples, sampling_interval, A0)

% observe the evidence
for i = 1:length(E),
    if (E(i) > 0),
        F = ObserveEvidence(F, [i, E(i)]);
    end;
end;

% Determine which function to call for Markov Chain transitions
bSwendsenWang = false;
switch TransName
 case 'Gibbs'
  Trans = @GibbsTrans;
 case 'MHUniform'
  Trans = @MHUniformTrans;
 case 'MHGibbs'
  Trans = @MHGibbsTrans;
 case 'MHSwendsenWang1'
  Trans = @MHSWTrans1;
  bSwendsenWang = true;
 case 'MHSwendsenWang2'
  Trans = @MHSWTrans2;
  bSwendsenWang = true;
end

if bSwendsenWang
  % Swendsen-Wang Precomputation of Q matrix (contains q_{i,j}'s)
  E2F = EdgeToFactorCorrespondence(G.names, F);
  [u, v] = find(G.edges);
  q_list = [];  % each row in q_list is of the form [node_i, node_j, q_ij]
  for i = 1:size([u, v], 1)
      % For every non-directed edge (don't want to double count)
      if u(i) > v(i)
          edge_factor = F(E2F{u(i), v(i)}(1));

          q_ij = 0.0;
          if strcmp(TransName, 'MHSwendsenWang1')
              %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
              % YOUR CODE HERE (DO NOT TOUCH UNTIL PART 2)
              % Specify the q_{i,j}'s for Swendsen-Wang for variant 1
              %
              %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

              %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          elseif strcmp(TransName, 'MHSwendsenWang2')
              %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
              % YOUR CODE HERE (DO NOT TOUCH UNTIL PART 2)
              % Specify the q_{i,j}'s for Swendsen-Wang for variant 2
              %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

              %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
          else
              disp('WARNING: unrecognized Swendsen-Wang name');
          end

          assert(q_ij >= 0.0 && q_ij <= 1.0);
          q_list = [q_list; u(i), v(i), q_ij];
      end
  end
  G.q_list = q_list;
end


% Sampling Loop -----------------------------------
% Initialize joint assignment
A = A0;
max_iter = mix_time + num_samples * sampling_interval;
all_samples = zeros(max_iter + 1, length(A));
all_samples(1, :) = A0;
disp('Riding the Markov Chrain... chugga chugga woo woo!');
for i = 1:max_iter
    if mod(i, 25) == 0
        disp(['Iteration ', num2str(i)]);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % YOUR CODE HERE
    % Transition A to the next state in the Markov Chain 
    % and store the new sample in all_samples
    %
    % Note: lines 42-56 use MATLAB's @Function capabilities
    %   this allows binding of function names to a new name
    %   ex:
    %     sol = foo(bar); 
    %     is equivalent to
    %     foo2 = @foo;
    %     sol = foo2(bar);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

M=[];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Extract marginal code has been added for you -- no need to change this
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Extract the marginals
M = ExtractMarginalsFromSamples(G, all_samples, mix_time+1:sampling_interval:size(all_samples, 1));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



function A = MHSWTrans1(A, G, F)
A = MHSWTrans(A, G, F, 1);

function A = MHSWTrans2(A, G, F)
A = MHSWTrans(A, G, F, 2);
