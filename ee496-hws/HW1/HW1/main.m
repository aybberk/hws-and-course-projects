clear all
%initialization
load('Movements_And_Targets.mat');
target_class=target_class';
Movements=Movements';
trainingTime=zeros(1,25);
validationAccuracy=zeros(1,25);
trainAccuracy=zeros(1,25);
counter=0;

%For all hidden neuron number given-->2^k
for k= -4:0
    for hiddenUnits=[2 4 8 16 32]
        counter=counter+1;
        net=feedforwardnet(hiddenUnits);
        net.trainFcn='traingd';
        net.trainParam.epochs=100;
        %Only the scaled data is used for training, MATLAB itself handles
        %the classification if the parameters and classification method is
        %given. Note that the classification method id 'divideblock', which
        %is dividing the data as blocks (not random) for consistency between all
        %training trials. The randomnes is already provided in movements.m file 
        net.divideFcn='divideblock';
        %Classification parameters to divide data as 50% 25% 25%
        net.divideParam.trainRatio=0.5;
        net.divideParam.valRatio=0.25;
        net.divideParam.testRatio=0.25;
        %Learning rate
        net.trainParam.lr=10^k;
        [net,tr] = train(net,Movements,target_class);
        outputs = net(Movements);
        for n=1:size(outputs,2)
            [Max,outputs(:,n)] = max(outputs(:,n));
        end
        for n=1:size(outputs,1)
            outputs(n,:)=outputs(n,:)==n;
        end
        
        %Since the divided data at movements.m is not used, output and
        %target data is extracted from the index of all
        %classified data to calculate accuracy etc. 
        trainOut = outputs(:,tr.trainInd);
        validationOut = outputs(:,tr.valInd);
        testOut = outputs(:,tr.testInd);
        
        trainTarg = target_class(:,tr.trainInd);
        validationTarg = target_class(:,tr.valInd);
        testTarg = target_class(:,tr.testInd);
        
        %Calculation of number of each class samples for Table 1
        for n=1:8
            trainSum(1,n)=sum(trainTarg(n,:));
            testSum(1,n)=sum(testTarg(n,:));
            validationSum(1,n)=sum(validationTarg(n,:));
        end
        trainingTime(counter)=tr.time(end);
        
        %Accuracy is calculated as a vector(1x25) then is is converted to a
        %5x5 matrix
        validationAccuracy(counter)=(sum(sum(validationTarg==validationOut))/numel(validationTarg)-0.75)*400;
        trainAccuracy(counter)=(sum(sum(trainTarg==trainOut))/numel(trainTarg)-0.75)*400;
    end
end
%1x25 to 5x5
trainingTime=round(vec2mat(trainingTime,5),2);
validationAccuracy=round(vec2mat(validationAccuracy,5),2);
trainAccuracy=round(vec2mat(trainAccuracy,5),2);
comparison=[trainAccuracy(5,:);validationAccuracy(5,:)]

clear net;
clear tr;


%Best results are obtained with 32 hidden units, 1 learning rate.
%Now, trying it with 1000 epochs

        net=feedforwardnet(32);
        net.trainFcn='traingd';
        net.trainParam.epochs=1000;
        net.divideFcn='divideblock';
        net.divideParam.trainRatio=0.5;
        net.divideParam.valRatio=0.25;
        net.divideParam.testRatio=0.25;
        net.trainParam.lr=1;
        [net,tr] = train(net,Movements,target_class);
        outputsBest = net(Movements);
        for n=1:size(outputsBest,2)
            [Max,outputsBest(:,n)] = max(outputsBest(:,n));
        end
        for n=1:size(outputsBest,1)
            outputsBest(n,:)=outputsBest(n,:)==n;
        end
        
        testOutBest = outputsBest(:,tr.testInd);
        testTargBest = target_class(:,tr.testInd);
        testOutBest=[1,2,3,4,5,6,7,8]*testOutBest;
        testTargBest=[1,2,3,4,5,6,7,8]*testTargBest;
        [confMat,~] = confusionmat(testTargBest,testOutBest);
        clear net;
        clear tr;
        
       
  %Training with momentum term(1)
        
        net=feedforwardnet(32);
        net.trainFcn='traingdm';
        net.trainParam.epochs=1000;
        net.divideFcn='divideblock';
        net.divideParam.trainRatio=0.5;
        net.divideParam.valRatio=0.25;
        net.divideParam.testRatio=0.25;
        net.trainParam.lr=1;
        net.trainParam.mc=0.9;
        [net,tr] = train(net,Movements,target_class);
        outputsBest = net(Movements);
        for n=1:size(outputsBest,2)
            [Max,outputsBest(:,n)] = max(outputsBest(:,n));
        end
        for n=1:size(outputsBest,1)
            outputsBest(n,:)=outputsBest(n,:)==n;
        end
        
        testOutBest = outputsBest(:,tr.testInd);
        testTargBest = target_class(:,tr.testInd);
        testOutBest=[1,2,3,4,5,6,7,8]*testOutBest;
        testTargBest=[1,2,3,4,5,6,7,8]*testTargBest;
        
        [confMatMomentum,~] = confusionmat(testTargBest,testOutBest);
 
% All plots are created in command window (except the MSE figures, those 
% are created by plotperform command) by following commands
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% imagesc(trainingTime)
% title('Effect of hidden unit number and learning rate to training time')
% xlabel('Number of hidden units(2^n)')
% ylabel('Learning rate(10^k)')
% 
% imagesc(trainAccuracy)
% title('Effect of hidden unit number and learning rate to accuracy on the training set')
% xlabel('Number of hidden units(2^n)')
% ylabel('Learning rate(10^k)')
% 
% imagesc(validationAccuracy)
% title('Effect of hidden unit number and learning rate to accuracy on the validation set')
% xlabel('Number of hidden units(2^n)')
% ylabel('Learning rate(10^k)')
% 
% plot(comparison')
% legend('Training set accuracy','Validation set accuracy')
% xlabel('Number of hidden units')
% ylabel('Accuracy(%)')
% title('Effect of hidden unit number to accuracy')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%