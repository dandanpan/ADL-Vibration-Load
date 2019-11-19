init;

totalSetNum = 5;
load('P5.mat');
Sensor{1,1} = Table;
Sensor{1,2} = Floor;
Sensor{1,3} = Currents;
Labels{1} = Label;
clear Table Floor Currents Label;


SensorResults = cell(3,1);
load('eval_table_p5.mat');
SensorResults{1,1} = Result;

load('eval_floor_p5.mat');
SensorResults{2,1} = Result;

load('eval_current_p5.mat');
SensorResults{3,1} = Result;

windowSize = Fs/8;

results = [];
results2 = [];

repID{1} = [3,4,5,9,10];

for sensorID = 1:3
    
    ObservLabelTest = [];
    ObservPrediTest = [];
    ObservPrediTest2 = [];
    ObservPrediEvent = [];
    ObservPrediScore = [];
    ObservPrediScore2 = [];
        
    % add all the data length together
    for setID = 1:totalSetNum
        load(['/Users/shijiapan/Box Sync/Activity_Detection/0429/PortLab_20190429_Route_P5_Rep' num2str(repID{1}(setID)) '.mat']);
        dataLens{setID} = length(data);
        clear data;
    end
        
    dataLen = 0;
    for setID = 1:totalSetNum
        dataLen = dataLen + dataLens{setID};
    end
    
    sensorPrediLabel = zeros(1,dataLen); 
    sensorPrediLabel2 = zeros(1,dataLen); 
    sensorEventID = zeros(1,dataLen); 
        
    totalEventStart = [];
    totalEventStop = [];
    offset = 0;
    for setID = 1:totalSetNum
        totalEventStart = [totalEventStart Sensor{1,sensorID}{repID{1}(setID)}.stepStartIdxArray+offset]; 
        totalEventStop = [totalEventStop Sensor{1,sensorID}{repID{1}(setID)}.stepStopIdxArray+offset]; 
        offset = offset + dataLens{setID};
    end
    totalEventStart = totalEventStart(SensorResults{sensorID, 1}.whiteListEventIdx2);
    totalEventStop = totalEventStop(SensorResults{sensorID, 1}.whiteListEventIdx2);

    for eventID = 1:length(totalEventStart)
        % at sample level, label the event id and their
        % prediction label 
        sensorPrediLabel(totalEventStart(eventID):totalEventStop(eventID)) = SensorResults{sensorID, 1}.predicted_label(eventID);
        sensorPrediLabel2(totalEventStart(eventID):totalEventStop(eventID)) = SensorResults{sensorID, 1}.predicted_label2(eventID);
        sensorEventID(totalEventStart(eventID):totalEventStop(eventID)) = eventID;
    end
        
    totalLabel = [];
    for setID = 1:totalSetNum
        if setID <= 5
            totalLabel = [totalLabel Labels{1}{repID{1}(setID)}.label_array(1:dataLens{setID})];
        elseif setID <= 9
            totalLabel = [totalLabel Labels{2}{repID{2}(setID-5)}.label_array(1:dataLens{setID})];
        else
            totalLabel = [totalLabel Labels{3}{repID{3}(setID-9)}.label_array(1:dataLens{setID})];
        end
    end

    % label or collection info at window level
    for sampleID = 1:windowSize:dataLen-windowSize
        ObservLabelTest = [ObservLabelTest, mode(totalLabel(sampleID:sampleID+windowSize*2-1))];
        ObservPrediTest = [ObservPrediTest, mode(sensorPrediLabel(sampleID:sampleID+windowSize*2-1))];
        ObservPrediTest2 = [ObservPrediTest2, mode(sensorPrediLabel2(sampleID:sampleID+windowSize*2-1))];
        windowEventID = mode(sensorEventID(sampleID:sampleID+windowSize*2-1));
        if windowEventID == 0
            ObservPrediScore = [ObservPrediScore, 0.9];
            ObservPrediScore2 = [ObservPrediScore2, 0.9];
        else
            confScore = max(SensorResults{sensorID, 1}.decision_values(windowEventID,:));
            confScore2 = max(SensorResults{sensorID, 1}.decision_values2(windowEventID,:));
            ObservPrediScore = [ObservPrediScore, confScore];
            ObservPrediScore2 = [ObservPrediScore2, confScore2];
        end
    end

    ObservLabelTest(ObservLabelTest == 0) = nullClass;
    ObservPrediTest(ObservPrediTest == 0) = nullClass;
    ObservPrediTest2(ObservPrediTest2 == 0) = nullClass;
    ObservLabelTest(ObservLabelTest == -1) = nullClass;

%     window_level_accuracy = sum(ObservPrediTest == ObservLabelTest)./length(ObservLabelTest);
%     results = [results, window_level_accuracy];
%     window_level_accuracy2 = sum(ObservPrediTest2 == ObservLabelTest)./length(ObservLabelTest);
%     results2 = [results2, window_level_accuracy2];

    figure;
    plot(ObservLabelTest);hold on;
    plot(ObservPrediTest);hold on;
    plot(ObservPrediScore);hold off;

    SensorResults{sensorID, 1}.ObservLabelTest = ObservLabelTest;
    SensorResults{sensorID, 1}.ObservPrediTest = ObservPrediTest;
    SensorResults{sensorID, 1}.ObservPrediScore = ObservPrediScore;
    SensorResults{sensorID, 1}.ObservPrediTest2 = ObservPrediTest2;
    SensorResults{sensorID, 1}.ObservPrediScore2 = ObservPrediScore2;
end

save('eval_p_p5.mat','SensorResults');
return;
