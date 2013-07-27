function C = PruneTree(C)
% Logic:
% Start with a clique, scan through its neighbors. If you find a neighbor
% such that it is a superset of the clique you started with, then you know
% that you can prune the tree. For instance, let's take the following
% clique tree:
% ABE -- AB ---AD
% Let's say we started with AB. We scan through its neighbors and find that
% AB is a subset of ABE. So we cut off the edges connected to AB and add an
% edge between ABE and all of AB's other neighbors. This maintains the
% running intersection property and gives us a more compact clique tree
% which looks like: ABE -- AD.
%
% Copyright (C) Daphne Koller, Stanford Univerity, 2012

toRemove = [];
for i=1:length(C.nodes)
    
    if ismember(i,toRemove), continue, end;
    
    neighborsI = find(C.edges(i,:));
    
    for c = 1: length(neighborsI),
        
        j = neighborsI(c);
        
        assert(i ~= j);
        
        if ismember(j,toRemove), continue, end;
        
        if (sum(ismember(C.nodes{i}, C.nodes{j})) == length(C.nodes{i}))
            
            
            for nk = neighborsI
                
                % find neighbors and connect with that.
                if length(intersect(C.nodes{i}, C.nodes{nk})) == length(C.nodes{i})
                    
                    
                    C.edges(setdiff(neighborsI,[nk]),nk) = 1;
                    C.edges(nk,setdiff(neighborsI,[nk])) = 1;

                    break;
                end
            end
            
            % kill the edges for the clique that is to be removed.
            C.edges(i,:) = 0;
            C.edges(:,i) = 0;
            toRemove = [i toRemove];
        end
    end
end

toKeep = setdiff(1:length(C.nodes),toRemove);

C.nodes(toRemove) = [];

if isfield(C, 'edges')
    C.edges = C.edges(toKeep,toKeep);
else
    C.edges = [];
end

end

