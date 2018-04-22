function crossoverKids = crossover(parents, options, NVARS, FitnessFcn, thisScore, thisPopulation)

nKids = length(parents)/2;
crossoverKids = cell(nKids,1);
i=1;
yesFlag=0;
while (i<=nKids)
        parent1=thisPopulation{parents(2*i)};
        parent2=thisPopulation{parents(2*i-1)};
        xIndex=ceil(NVARS*rand());
        kid=zeros(NVARS,20);
        kid(1:xIndex,:)=parent1(1:xIndex,:);
        kid(xIndex+1:end,:)=parent2(xIndex+1:end,:);
        if(any(sum(kid)>50))
            continue;
        else
            crossoverKids{i} = kid;

            i=i+1;
        end
    end
    
end