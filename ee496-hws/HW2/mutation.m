function mutationChildren = myfun(parents, options, NVARS, FitnessFcn, state, thisScore, thisPopulation)

mutationChildren = cell(length(parents),1);
for i=1:length(parents)
    parent = thisPopulation{parents(i)}; 
    p = ceil(NVARS * rand(1,2));
    child = parent;
    child(p(1),:) = parent(p(2),:);
    child(p(2),:) = parent(p(1),:);
    mutationChildren{i} = child;
end