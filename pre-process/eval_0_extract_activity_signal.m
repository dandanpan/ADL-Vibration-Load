init;

label_start_set{1,1} = 0*60+6;
label_start_set{1,2} = 0*60+7;
label_start_set{1,3} = 0*60+4.5;
label_start_set{1,4} = 0*60+4.5;
label_start_set{1,5} = 0*60+3.5;
label_start_set{1,6} = 0*60+7;
label_start_set{1,7} = 0*60+2;
label_start_set{1,8} = 0*60+2;
label_start_set{1,9} = 0*60+7;
label_start_set{1,10} = 0*60+5.5;

label_start_set{2,1} = 0*60+0;
label_start_set{2,2} = 0*60+0;
label_start_set{2,3} = 0*60+5;
label_start_set{2,4} = 0*60+3;
label_start_set{2,5} = 0*60+3.5;
label_start_set{2,6} = 0*60-3;
label_start_set{2,7} = 0*60+5.5;
label_start_set{2,8} = 0*60+2;
label_start_set{2,9} = 0*60+4.5;
label_start_set{2,10} = 0*60+6.5;

for j = 1:2
    for i = 1:10
        event_start_set{j,i} = 1;
    end
end
event_start_set{2,1} = 2;
event_start_set{2,6} = 2;

noise_idx_set{1,1} = 1:40000;
noise_idx_set{1,2} = 1:60000;
noise_idx_set{1,3} = 1:60000;
noise_idx_set{1,4} = 1:50000;
noise_idx_set{1,5} = 130000:170000;
noise_idx_set{1,6} = 1:30000;
noise_idx_set{1,7} = 90000:140000;
noise_idx_set{1,8} = 1:60000;
noise_idx_set{1,9} = 1:50000;
noise_idx_set{1,10} = 1:40000;

noise_idx_set{2,1} = 1375000:1410000;
noise_idx_set{2,2} = 1:50000;
noise_idx_set{2,3} = 25000:65000;
noise_idx_set{2,4} = 1:30000;
noise_idx_set{2,5} = 1:45000;
noise_idx_set{2,6} = 90000:130000;
noise_idx_set{2,7} = 1:30000;
noise_idx_set{2,8} = 1:40000;
noise_idx_set{2,9} = 1:50000;
noise_idx_set{2,10} = 1:30000;


noise_idx_set{3,1} = 25000:42000;
noise_idx_set{3,2} = 1:40000;
noise_idx_set{3,3} = 1:40000;
noise_idx_set{3,4} = 1:60000;

for personID = 1:2
    for repID = 1:10
    repID
        load(['/Users/shijiapan/Box Sync/Activity_Detection/0407/PortLab_20190407_Route_P' num2str(personID) '_Rep' num2str(repID) '.mat']);
        % for manually label the noise duration
%         figure;
%         plot(data(4,:));hold on;
%         plot(data(5,:));hold off;
%         continue;

        Fs = 25600;
        label_start = label_start_set{personID, repID};
        event_start = event_start_set{personID, repID};
        noise_idx = noise_idx_set{personID, repID};

        figure;
        subplot(3,1,3);
        [ stepEventsIdx, stepEventsVal, ...
                stepStartIdxArray, stepStopIdxArray, ... 
                windowEnergyArray, noiseMu, noiseSigma, noiseRange ] = SEDetectionFlex( data(5,:), data(5,noise_idx), Fs/4, 24);%16
        [ stepStartIdxArray, stepStopIdxArray ] = mergeOverlapEvents( stepStartIdxArray, stepStopIdxArray );
        FootstepEventRef = stepStartIdxArray(event_start);
        
        plot(data(5,:));hold on;
        eventTime = (stepStartIdxArray-FootstepEventRef)./Fs+label_start;
        eventMin = floor(eventTime./60);
        eventSec = round(eventTime - eventMin.*60);
        
        Floor{repID}.eventTime = eventTime;
        Floor{repID}.eventMin = eventMin;
        Floor{repID}.eventSec = eventSec;
        Floor{repID}.stepStartIdxArray = stepStartIdxArray;
        Floor{repID}.stepStopIdxArray = stepStopIdxArray;
        
        for i = 1:length(stepStartIdxArray)
            plot([stepStartIdxArray(i), stepStartIdxArray(i)],[0,5],'g');
            plot([stepStopIdxArray(i), stepStopIdxArray(i)],[0,5],'r');
        end
        hold off;
        
        subplot(3,1,1);
        plot([1:length(data(2,:))]./Fs, data(2,:));hold on;
        plot([1:length(data(3,:))]./Fs, data(3,:));
        [ stepEventsSig, stepEventsIdx, stepEventsVal, ...
            stepStartIdxArray, stepStopIdxArray, ... 
            windowEnergyArray, noiseMu, noiseSigma, noiseRange ]= SEDetection( data(3,:), data(3,noise_idx), 50, Fs);
        [ stepStartIdxArray, stepStopIdxArray ] = mergeOverlapEvents( stepStartIdxArray, stepStopIdxArray );
        eventTime = 0;
        eventMin = floor(eventTime./60);
        eventSec = round(eventTime - eventMin.*60);

        Currents{repID}.eventTime = eventTime;
        Currents{repID}.eventMin = eventMin;
        Currents{repID}.eventSec = eventSec;
        Currents{repID}.stepStartIdxArray = stepStartIdxArray;
        Currents{repID}.stepStopIdxArray = stepStopIdxArray;

        for i = 1:length(stepStartIdxArray)
            plot([stepStartIdxArray(i), stepStartIdxArray(i)]./Fs,[0,5],'g');
            plot([stepStopIdxArray(i), stepStopIdxArray(i)]./Fs,[0,5],'r');
        end
        hold off;

        subplot(3,1,2);
        plot(data(4,:));hold on;
        if personID == 1 && repID == 5
        [ stepEventsIdx, stepEventsVal, ...
                stepStartIdxArray, stepStopIdxArray, ... 
                windowEnergyArray, noiseMu, noiseSigma, noiseRange ] = SEDetectionFlex( data(4,:), data(4,noise_idx), Fs/4,  32);%32
        else
            [ stepEventsIdx, stepEventsVal, ...
                stepStartIdxArray, stepStopIdxArray, ... 
                windowEnergyArray, noiseMu, noiseSigma, noiseRange ] = SEDetectionFlex( data(4,:), data(4,noise_idx), Fs/4,  16);
        end
        [ stepStartIdxArray, stepStopIdxArray ] = mergeOverlapEvents( stepStartIdxArray, stepStopIdxArray );
        eventTime = (stepStartIdxArray-FootstepEventRef)./Fs+label_start;
        eventMin = floor(eventTime./60);
        eventSec = round(eventTime - eventMin.*60);

        Table{repID}.eventTime = eventTime;
        Table{repID}.eventMin = eventMin;
        Table{repID}.eventSec = eventSec;
        Table{repID}.stepStartIdxArray = stepStartIdxArray;
        Table{repID}.stepStopIdxArray = stepStopIdxArray;

        for i = 1:length(stepStartIdxArray)
            plot([stepStartIdxArray(i), stepStartIdxArray(i)],[0,5],'g');
            plot([stepStopIdxArray(i), stepStopIdxArray(i)],[0,5],'r');
        end
        hold off;
        
%         Raw_Data{repID} = data;

%         save('P1.mat','Currents','Table','Floor');
        save(['P' num2str(personID) '.mat'],'Currents','Table','Floor');
    end
end

% save('labeling_info.mat','label_start_set','noise_idx_set');