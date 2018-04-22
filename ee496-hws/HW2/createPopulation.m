function pop = createPopulation(NVARS,FitnessFcn,options)

popSize=sum(options.PopulationSize);
pop=cell(popSize,1);
i=1;
while (i <= popSize)
    individual=zeros(NVARS,20);
    for n = 1:NVARS
        individual(n,ceil(rand()*20)) =1;
    end
    if any(sum(individual)>50)
        continue;
    else
        pop{i}=individual;
        disp('1 birey olustu');
        disp(i);
        i=i+1;
    end
end
