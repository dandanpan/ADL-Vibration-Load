init;

totalSetNum = 4;
load('P1.mat');
Sensor{1,1} = Table;
Sensor{1,2} = Floor;
Sensor{1,3} = Currents;
Labels{1} = Label;
load('P1_4act.mat');
Sensor{2,1} = Table;
Sensor{2,2} = Floor;
Sensor{2,3} = Currents;
Labels{2} = Label;
load('P2.mat');
Sensor{3,1} = Table;
Sensor{3,2} = Floor;
Sensor{3,3} = Currents;
Labels{3} = Label;
load('P2_4act.mat');
Sensor{4,1} = Table;
Sensor{4,2} = Floor;
Sensor{4,3} = Currents;
Labels{4} = Label;
clear Table Floor Currents Label;


SensorResults = cell(3,5);
load('eval_table.mat');
SensorResults(1,:) = Results;

load('eval_floor.mat');
SensorResults(2,:) = Results;

load('eval_current.mat');
SensorResults(3,:) = Results;

windowSize = Fs/8;

results = [];
results2 = [];

repID{1} = [2:6];
repID{2} = [1,2,6,7,8];
repID{3} = [1:4,8];
repID{4} = [1,5,6,8,9];


for sensorID = 1:3
    for resultCount = 1:5

        ObservLabelTest = [];
        ObservPrediTest = [];
        ObservPrediTest2 = [];
        ObservPrediEvent = [];
        ObservPrediScore = [];
        ObservPrediScore2 = [];

        load(['/Users/shijiapan/Box Sync/Activity_Detection/0407/PortLab_20190407_Route_P1_Rep' num2str(repID{1}(resultCount)) '.mat']);
        data1 = data;
        load(['/Users/shijiapan/Box Sync/Activity_Detection/0429/PortLab_20190429_Route_P1_Rep' num2str(repID{2}(resultCount)) '.mat']);
        data2 = data;
        load(['/Users/shijiapan/Box Sync/Activity_Detection/0407/PortLab_20190407_Route_P2_Rep' num2str(repID{3}(resultCount)) '.mat']);
        data3 = data;
        load(['/Users/shijiapan/Box Sync/Activity_Detection/0429/PortLab_20190429_Route_P2_Rep' num2str(repID{4}(resultCount)) '.mat']);
        data4 = data;
        clear data;

        dataLens{1} = length(data1);
        dataLens{2} = length(data2);
        dataLens{3} = length(data3);
        dataLens{4} = length(data4);
        
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
            totalEventStart = [totalEventStart Sensor{setID,sensorID}{repID{setID}(resultCount)}.stepStartIdxArray+offset]; 
            totalEventStop = [totalEventStop Sensor{setID,sensorID}{repID{setID}(resultCount)}.stepStopIdxArray+offset]; 
            offset = offset + dataLens{setID};
        end
        totalEventStart = totalEventStart(SensorResults{sensorID, resultCount}.whiteListEventIdx2);
        totalEventStop = totalEventStop(SensorResults{sensorID, resultCount}.whiteListEventIdx2);

        for eventID = 1:length(totalEventStart)
            % at sample level, label the event id and their
            % prediction label 
            sensorPrediLabel(totalEventStart(eventID):totalEventStop(eventID)) = SensorResults{sensorID, resultCount}.predicted_label(eventID);
            sensorPrediLabel2(totalEventStart(eventID):totalEventStop(eventID)) = SensorResults{sensorID, resultCount}.predicted_label2(eventID);
            sensorEventID(totalEventStart(eventID):totalEventStop(eventID)) = eventID;
        end
        
        totalLabel = [];
        for setID = 1:totalSetNum
            totalLabel = [totalLabel Labels{setID}{repID{setID}(resultCount)}.label_array(1:dataLens{setID})];
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
                confScore = max(SensorResults{sensorID, resultCount}.decision_values(windowEventID,:));
                confScore2 = max(SensorResults{sensorID, resultCount}.decision_values2(windowEventID,:));
                ObservPrediScore = [ObservPrediScore, confScore];
                ObservPrediScore2 = [ObservPrediScore2, confScore2];
            end
        end

        ObservLabelTest(ObservLabelTest == 0) = nullClass;
        ObservPrediTest(ObservPrediTest == 0) = nullClass;
        ObservPrediTest2(ObservPrediTest2 == 0) = nullClass;
        ObservLabelTest(ObservLabelTest == -1) = nullClass;

        window_level_accuracy = sum(ObservPrediTest == ObservLabelTest)./length(ObservLabelTest);
        results = [results, window_level_accuracy];
        window_level_accuracy2 = sum(ObservPrediTest2 == ObservLabelTest)./length(ObservLabelTest);
        results2 = [results2, window_level_accuracy2];

        figure;
        plot(ObservLabelTest);hold on;
        plot(ObservPrediTest);hold on;
        plot(ObservPrediScore);hold off;

        SensorResults{sensorID, resultCount}.ObservLabelTest = ObservLabelTest;
        SensorResults{sensorID, resultCount}.ObservPrediTest = ObservPrediTest;
        SensorResults{sensorID, resultCount}.ObservPrediScore = ObservPrediScore;
        SensorResults{sensorID, resultCount}.ObservPrediTest2 = ObservPrediTest2;
        SensorResults{sensorID, resultCount}.ObservPrediScore2 = ObservPrediScore2;

    end
    mean(results)
    mean(results2)
end

save('eval_pall.mat','SensorResults');
return;
