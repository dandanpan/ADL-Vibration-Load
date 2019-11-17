function [ svmstruct, gc ] = svmTrainModel( trainingLabels, trainingFeatures )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    accBase = 0;
    gc = 0;
    cc = 0;
    for ci = [1,10,100,1000]
        for gi = [100:50:1000]
            gi
            tempStruct = svmtrain(trainingLabels, trainingFeatures, ['-s 0 -t 2 -b 1 -g ' num2str(gi) ' -c ' num2str(ci)]);
            [predicted_label, accuracy, decision_values] = svmpredict(trainingLabels, trainingFeatures, tempStruct,'-b 1')
            if accuracy(1) > accBase
                svmstruct = tempStruct;
                accBase = accuracy(1);
                gc = gi;
                cc = ci;
            end
        end
    end   
end

