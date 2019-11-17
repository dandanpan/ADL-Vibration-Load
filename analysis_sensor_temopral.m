clear all
close all
clc

load('P1.mat');
load('result_SVM_Table.mat');
Results_Table = Results;
load('result_SVM_floor.mat');
Results_Floor = Results;
load('result_SVM_current.mat');
Results_Current = Results;

addpath('./libsvm-master/matlab/');
addpath('/Users/shijiapan/Documents/MATLAB/SASFunctions/');
Fs = 25600;
personID = 1;

current2Vibration = [10,5,4,6];

%% HMM states is the label, observation is event detection at each sensor
ObservTrain = [];
ObservTest = [];

for repID = 2:6
    repID
    
    ObservLabelTest{repID} = [];
    ObservPrediTable{repID} = [];
    ObservPrediFloor{repID} = [];
    ObservPrediCurrent{repID} = [];
    windowSize = Fs/16;
        

    load(['/Users/shijiapan/Box Sync/Activity_Detection/0407/PortLab_20190407_Route_P' num2str(personID) '_Rep' num2str(repID) '.mat']);

    currentSigLabel = zeros(1,length(data)); 
    currentSigPredi = zeros(1,length(data)); 
    tableSigLabel = zeros(1,length(data)); 
    tableSigPredi = zeros(1,length(data)); 
    floorSigLabel = zeros(1,length(data)); 
    floorSigPredi = zeros(1,length(data)); 
    
    % label for each window
    for eventID = 1:length(Currents{repID}.stepStartIdxArray)
        currentSigLabel(Currents{repID}.stepStartIdxArray(eventID):Currents{repID}.stepStopIdxArray(eventID)) = current2Vibration(Currents{repID}.label(eventID));
    end
    for eventID = 1:length(Table{repID}.stepStartIdxArray)
        tableSigLabel(Table{repID}.stepStartIdxArray(eventID):Table{repID}.stepStopIdxArray(eventID)) = Table{repID}.label(eventID);
    end
    for eventID = 1:length(Floor{repID}.stepStartIdxArray)
        floorSigLabel(Floor{repID}.stepStartIdxArray(eventID):Floor{repID}.stepStopIdxArray(eventID)) = Floor{repID}.label(eventID);
    end
        
    eventCount = 0;
    for eventID = 1:length(Currents{repID}.label)
        if Currents{repID}.label(eventID) <=0
            continue;
        else
            eventCount = eventCount + 1;
            currentSigPredi(Currents{repID}.stepStartIdxArray(eventID):Currents{repID}.stepStopIdxArray(eventID)) = current2Vibration(Results_Current{repID}.predicted_label(eventCount));
        end
    end
    
    eventCount = 0;
    for eventID = 1:length(Table{repID}.label)
        if Table{repID}.label(eventID) <=0
            continue;
        else
            eventCount = eventCount + 1;
            tableSigPredi(Table{repID}.stepStartIdxArray(eventID):Table{repID}.stepStopIdxArray(eventID)) = Results_Table{repID}.predicted_label2(eventCount);
        end
    end
    
    
    eventCount = 0;
    for eventID = 1:length(Floor{repID}.label)
        if Floor{repID}.label(eventID) <=0
            continue;
        else
            eventCount = eventCount + 1;
            floorSigPredi(Floor{repID}.stepStartIdxArray(eventID):Floor{repID}.stepStopIdxArray(eventID)) = Results_Floor{repID}.predicted_label2(eventCount);
        end
    end
    
    for sampleID = 1:windowSize:length(tableSigLabel)-windowSize
        ObservLabelTest{repID} = [ObservLabelTest{repID}, mode(tableSigLabel(sampleID:sampleID+windowSize*2-1))];
        ObservPrediTable{repID} = [ObservPrediTable{repID}, mode(tableSigPredi(sampleID:sampleID+windowSize*2-1))];
        ObservPrediFloor{repID} = [ObservPrediFloor{repID}, mode(floorSigPredi(sampleID:sampleID+windowSize*2-1))];
        ObservPrediCurrent{repID} = [ObservPrediCurrent{repID}, mode(currentSigPredi(sampleID:sampleID+windowSize*2-1))];
    end
    
    figure;
    subplot(3,1,1);
    plot( ObservPrediCurrent{repID} );
    subplot(3,1,2);
    plot( ObservPrediTable{repID} );
    subplot(3,1,3);
    plot( ObservPrediFloor{repID} );
    
end
    
    
    