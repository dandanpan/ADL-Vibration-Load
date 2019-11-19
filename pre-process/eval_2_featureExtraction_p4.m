%% Table 
init;

load('P4.mat');
personID = 4;
numClass = 14;
validRep = [2:5,9];

for repID = validRep
    repID
    load(['/Users/shijiapan/Box Sync/Activity_Detection/0429/PortLab_20190429_Route_P' num2str(personID) '_Rep' num2str(repID) '.mat']);
    FeatureSet{repID}.Feature = [];
    FeatureSet{repID}.Feature2 = [];
    FeatureSet{repID}.Feature3 = [];
    FeatureSet{repID}.Label = [];
    
    % for each event, find out ground truth    
    for eventID = 1:length(Table{repID}.stepStartIdxArray)
        plot([Table{repID}.stepStartIdxArray(eventID),Table{repID}.stepStartIdxArray(eventID)],[0,5],'g');
        plot([Table{repID}.stepStopIdxArray(eventID),Table{repID}.stepStopIdxArray(eventID)],[0,5],'r');
        
        eventID
        gt_labels = Label{repID}.label_array(Table{repID}.stepStartIdxArray(eventID):Table{repID}.stepStopIdxArray(eventID));
        the_label = mode(gt_labels(gt_labels > 0));
        if isnan(the_label)
            the_label = 11;
        end
        
        tempSig = data(4,Table{repID}.stepStartIdxArray(eventID):Table{repID}.stepStopIdxArray(eventID));
        tempSig = signalNormalization(tempSig);
        tempFea = frequencyFeature( tempSig, Fs, 0, 10 );
        
        tempSig2 = data(5,Table{repID}.stepStartIdxArray(eventID):Table{repID}.stepStopIdxArray(eventID));
        tempSig2 = signalNormalization(tempSig2);
        tempFea2 = frequencyFeature( tempSig2, Fs, 0, 10 );
        
        tempSig3 = data(3,Table{repID}.stepStartIdxArray(eventID):Table{repID}.stepStopIdxArray(eventID));
        tempSig3 = signalNormalization(tempSig3);
        tempFea3 = frequencyFeature( tempSig3, Fs, 0, 10 );
                
        FeatureSet{repID}.Feature = [FeatureSet{repID}.Feature; tempFea(1:100,2)'];
        FeatureSet{repID}.Feature2 = [FeatureSet{repID}.Feature2; tempFea2(1:100,2)'];
        FeatureSet{repID}.Feature3 = [FeatureSet{repID}.Feature3; tempFea3(1:100,2)'];
        FeatureSet{repID}.Label = [FeatureSet{repID}.Label; the_label];      
    end
end

save('feature_table_p4.mat','FeatureSet');

%% Floor 
init;

load('P4.mat');
personID = 4;
numClass = 14;
validRep = [2:5,9];

for repID = validRep
    repID
    load(['/Users/shijiapan/Box Sync/Activity_Detection/0429/PortLab_20190429_Route_P' num2str(personID) '_Rep' num2str(repID) '.mat']);
    FeatureSet{repID}.Feature = [];
    FeatureSet{repID}.Feature2 = [];
    FeatureSet{repID}.Feature3 = [];
    FeatureSet{repID}.Label = [];
    
    % for each event, find out ground truth
    
    for eventID = 1:length(Floor{repID}.stepStartIdxArray)
        eventID
        gt_labels = Label{repID}.label_array(Floor{repID}.stepStartIdxArray(eventID):Floor{repID}.stepStopIdxArray(eventID));
        the_label = mode(gt_labels(gt_labels > 0));
        if isnan(the_label)
            the_label = 11;
        end
        
        tempSig = data(4,Floor{repID}.stepStartIdxArray(eventID):Floor{repID}.stepStopIdxArray(eventID));
        tempSig = signalNormalization(tempSig);
        tempFea = frequencyFeature( tempSig, Fs, 0, 10 );
        
        tempSig2 = data(5,Floor{repID}.stepStartIdxArray(eventID):Floor{repID}.stepStopIdxArray(eventID));
        tempSig2 = signalNormalization(tempSig2);
        tempFea2 = frequencyFeature( tempSig2, Fs, 0, 10 );
        
        tempSig3 = data(3,Floor{repID}.stepStartIdxArray(eventID):Floor{repID}.stepStopIdxArray(eventID));
        tempSig3 = signalNormalization(tempSig3);
        tempFea3 = frequencyFeature( tempSig3, Fs, 0, 10 );
                
        FeatureSet{repID}.Feature = [FeatureSet{repID}.Feature; tempFea2(1:100,2)'];
        FeatureSet{repID}.Feature2 = [FeatureSet{repID}.Feature2; tempFea(1:100,2)'];
        FeatureSet{repID}.Feature3 = [FeatureSet{repID}.Feature3; tempFea3(1:100,2)'];
        FeatureSet{repID}.Label = [FeatureSet{repID}.Label; the_label];      
    end
end

save('feature_floor_p4.mat','FeatureSet');


%% Current 
init;

load('P4.mat');
personID = 4;
numClass = 14;
validRep = [2:5,9];


for repID = validRep
    repID
    load(['/Users/shijiapan/Box Sync/Activity_Detection/0429/PortLab_20190429_Route_P' num2str(personID) '_Rep' num2str(repID) '.mat']);
    FeatureSet{repID}.Feature = [];
    FeatureSet{repID}.Feature2 = [];
    FeatureSet{repID}.Feature3 = [];
    FeatureSet{repID}.Label = [];
    
    % for each event, find out ground truth
    
    for eventID = 1:length(Currents{repID}.stepStartIdxArray)
        eventID
        gt_labels = Label{repID}.label_array(Currents{repID}.stepStartIdxArray(eventID):Currents{repID}.stepStopIdxArray(eventID));
        the_label = mode(gt_labels(gt_labels > 0));
        if isnan(the_label)
            the_label = 11;
        end
        
        tempSig = data(3,Currents{repID}.stepStartIdxArray(eventID):Currents{repID}.stepStopIdxArray(eventID));
        tempSigStd = std(tempSig);
        tempSig = signalNormalization(tempSig);
        
        tempSig2 = data(4,Currents{repID}.stepStartIdxArray(eventID):Currents{repID}.stepStopIdxArray(eventID));
        tempSig2 = signalNormalization(tempSig2);
        tempFea2 = frequencyFeature( tempSig2, Fs, 0, 10 );
        
        tempFea = frequencyFeature( tempSig, Fs, 0, 10 );
        FeatureSet{repID}.Feature = [FeatureSet{repID}.Feature; tempFea(1:200,2)'];
%         FeatureSet{repID}.Feature = [FeatureSet{repID}.Feature; tempFea(1:200,2)', tempSigStd];
        FeatureSet{repID}.Feature2 = [FeatureSet{repID}.Feature2; tempFea2(1:200,2)'];
        FeatureSet{repID}.Label = [FeatureSet{repID}.Label; the_label];      
    end
end
save('feature_current_p4.mat','FeatureSet');


