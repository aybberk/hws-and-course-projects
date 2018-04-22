function [state,options,optchanged] = gaOutputFunction(options,state,flag)

global fitnessPerGeneration;
optchanged = false;

switch flag
 case 'init'
        disp('Starting the algorithm');
    case {'iter','interrupt'}
        fprintf('Current generation: %d\n',state.Generation);
        fprintf('Fitness of best individual %d\n',state.Best(end));
        fprintf('Cost of best individual %d\n',state.Best(end)-size(state.Population{1},1));
    case 'done'
        fitnessPerGeneration=fitnessPerGeneration+state.Best;
end
