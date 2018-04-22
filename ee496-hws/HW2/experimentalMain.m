%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% THIS IS THE CODE FOR PARAMETER EXPERIMENTS    %%%%%
%%%%%  THE MAIN CODE FOR CONSOLE I/O IS "main.m"   %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all; clear all
%% ALL EXPERIMENTS ARE DONE FOR WORST CASE -CROWDED STUDENTS-
crowdness='H';
if (crowdness=='l' || crowdness=='L')
    nvars=20;
    else if (crowdness=='h' || crowdness=='H')
    nvars=30;
        else
        disp('invalid input!')
        return
        end
end
%% ALL EXPERIMENTS ARE DONE FOR WORST CASE -UNBALANCED COURSE POPULARITY-
popularity='U';
if (popularity=='B' || popularity=='b') 
    popularityVector=[5,5,5,5];
else if (popularity=='U' || popularity=='u')    
    popularityVector=[10,5,5,2];
    else
        disp('invalid input!')
        return;
    end
end
   

%% 100 GENERATIONS TO RUN FOR ALL EXPERIMENTS
maxGenNumber=150;

%% CONSTANT PARAMETERS
global fitnessPerGeneration;
options = optimoptions('ga');
options = optimoptions(options,'PopulationType', 'custom');
options = optimoptions(options,'CreationFcn', @createPopulation);
options = optimoptions(options,'OutputFcn',@gaOutputFunctionWithoutPrint);
options = optimoptions(options,'MaxGenerations', maxGenNumber);
%options = optimoptions(options,'PlotFcn', { @gaplotbestf });
options = optimoptions(options,'MutationFcn', @mutation);
options = optimoptions(options,'CrossoverFcn', @crossover);
options = optimoptions(options,'MaxStallGenerations', maxGenNumber);

a=1
%% EXPERIMENTED PARAMETERS
for populationSize = [10,50,200,500]
    for crossoverFraction = [0,0.2,0.5,0.8,1]

options = optimoptions(options,'PopulationSize', populationSize);
options = optimoptions(options,'SelectionFcn', {@selectiontournament, ceil(populationSize/10)+1});
options = optimoptions(options,'CrossoverFraction', crossoverFraction);

%% 10 ITERATION WITH 10 INDEPENDENT PREFERENCE MATRICES
fitnessPerGeneration=zeros(1,maxGenNumber);
for n=1:10
    preferenceMatrix = createPreferenceMatrix(popularityVector, nvars);
    [x,fval,exitflag,output,population,score] = ...
    ga(@(resultMatrix)fitnessOfCourseSelection(resultMatrix,preferenceMatrix),nvars,[],[],[],[],[],[],[],[],options);
end
 
fitnessPerGeneration=fitnessPerGeneration/10;
figure
h(a)=plot(fitnessPerGeneration);
a=a+1;
title(sprintf('Average of best fitness over generations for 10 independent GA run \nwith 10 random preference matrix. \nAverage best fitness of last generations: %.2f.\nPopulation Size: %i\nCrossover rate: %.1f\nMutation rate: %.1f', (fitnessPerGeneration(end)), populationSize, crossoverFraction, (1-crossoverFraction)));

       
    end
end

for k=1:a-1
  saveas(h(k),sprintf('figure_%d.jpg',k))
end