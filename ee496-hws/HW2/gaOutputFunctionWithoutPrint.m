function [state,options,optchanged] = gaOutputFunctionWithoutPrint(options,state,flag)

global fitnessPerGeneration;
optchanged = false;

switch flag
 case 'init'
        disp('Starting the algorithm');
    case {'iter','interrupt'}

    case 'done'
        fitnessPerGeneration=fitnessPerGeneration+state.Best;
end
