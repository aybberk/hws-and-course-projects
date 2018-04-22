%% 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% THIS IS THE MAIN CODE FOR SUBMISSION %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
crowdness=input('Crowdness? Low(L)/High(H)','s');

if (crowdness=='l' || crowdness=='L')
    nvars=20;
    else if (crowdness=='h' || crowdness=='H')
    nvars=800;
        else
        disp('invalid input!')
        return
        end
end
%%
popularity=input('Popularity? Balanced(B)/Unbalanced(U)','s');

if (popularity=='B' || popularity=='b') 
    popularityVector=[5,5,5,5]
else if (popularity=='U' || popularity=='u')    
    popularityVector=[1:2:40]
    else
        disp('invalid input!')
        return;
    end
end
   

%%
maxGenNumber=input('How many generations to run optimization?\n');


%%
global fitnessPerGeneration;
fitnessPerGeneration=zeros(1,maxGenNumber);
options = optimoptions('ga');
options = optimoptions(options,'PopulationType', 'custom');
options = optimoptions(options,'CreationFcn', @createPopulation);
options = optimoptions(options,'CrossoverFcn', @crossover);
options = optimoptions(options,'MutationFcn', @mutation);
% options = optimoptions(options,'Display', 'iter');
options = optimoptions(options,'OutputFcn',@gaOutputFunction);
%options = optimoptions(options,'MaxGenerations', maxGenNumber);
%options = optimoptions(options,'MaxStallGenerations', maxGenNumber);
options = optimoptions(options,'PopulationSize', 8000);
options = optimoptions(options,'PlotFcn', { @gaplotbestf });
options = optimoptions(options,'CrossoverFraction', 0.8);
options = optimoptions(options,'SelectionFcn', {@selectiontournament, 400});


preferenceMatrix = createPreferenceMatrix(popularityVector, nvars);
[x,fval,exitflag,output,population,score] = ...
ga(@(resultMatrix)fitnessOfCourseSelection(resultMatrix,preferenceMatrix),nvars,[],[],[],[],[],[],[],[],options);
Course=preferenceMatrix;
preferenceTable=array2table(Course);
Course=preferenceMatrix.*x{1};
CourseTable=array2table(Course);


disp(preferenceTable);
disp(CourseTable);
fprintf('\tGeneration: %d\n', output.generations);
fprintf('\tCost: %d\n', sum(sum(Course-x{1})));





