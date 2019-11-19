init;

noise_idx_set{1,1} = 1:60000;
noise_idx_set{1,2} = 1:50000;
noise_idx_set{1,3} = 1:60000;
noise_idx_set{1,4} = 1:60000;
noise_idx_set{1,5} = 1:50000;
noise_idx_set{1,6} = 1:50000;
noise_idx_set{1,7} = 1:60000;
noise_idx_set{1,8} = 1:50000;
noise_idx_set{1,9} = 1:60000;
noise_idx_set{1,10} = 10000:40000;

noise_idx_set{2,1} = 1:60000;
% noise_idx_set{2,2} = 1:55000;
% noise_idx_set{2,3} = 25000:65000;
% noise_idx_set{2,4} = 1:30000;
noise_idx_set{2,5} = 1:60000;
noise_idx_set{2,6} = 1:30000;
% noise_idx_set{2,7} = 1:30000;
noise_idx_set{2,8} = 1:60000;
noise_idx_set{2,9} = 1:70000;
% noise_idx_set{2,10} = 1:30000;

noise_idx_set{3,1} = 25000:42000;
noise_idx_set{3,2} = 1:40000;
noise_idx_set{3,3} = 1:40000;
noise_idx_set{3,4} = 1:60000;

noise_idx_set{4,2} = 35000:60000;
noise_idx_set{4,3} = 10000:60000;
noise_idx_set{4,4} = 25000:50000;
noise_idx_set{4,5} = 1:50000;
noise_idx_set{4,9} = 10000:55000;

noise_idx_set{5,3} = 160000:190000;
noise_idx_set{5,4} = 180000:240000;
noise_idx_set{5,5} = 1:40000;
noise_idx_set{5,9} = 1610000:1660000;
noise_idx_set{5,10} = 1:80000;

% repID{personID}
repIDSet{1} = [1:2,6:9];
repIDSet{2} = [1,5,6,8,9];
repIDSet{3} = [1:4];
repIDSet{4} = [2:5,9];
repIDSet{5} = [3:5,9:10];

for personID = 3% 5 %1:2
    for repID = repIDSet{personID}
    repID
        load(['/Users/shijiapan/Box Sync/Activity_Detection/0408/PortLab_20190408_Route_P' num2str(personID) '_Rep' num2str(repID) '.mat']);
%         load(['/Users/shijiapan/Box Sync/Activity_Detection/0429/PortLab_20190429_Route_P' num2str(personID) '_Rep' num2str(repID) '.mat']);
        % for manually label the noise duration
        figure;
        plot(data(3,:));hold on;
        plot(data(4,:));hold on;
        plot(data(5,:));hold off;
%         continue;

        noise_idx = noise_idx_set{personID, repID};

        figure;
        
        
        subplot(3,1,1);
        plot([1:length(data(2,:))]./Fs, data(2,:));hold on;
        plot([1:length(data(3,:))]./Fs, data(3,:));
        [ stepEventsSig, stepEventsIdx, stepEventsVal, ...
            stepStartIdxArray, stepStopIdxArray, ... 
            windowEnergyArray, noiseMu, noiseSigma, noiseRange ]= SEDetection( data(3,:), data(3,noise_idx), 50, Fs);
        [ stepStartIdxArray, stepStopIdxArray ] = mergeOverlapEvents( stepStartIdxArray, stepStopIdxArray );
        Currents{repID}.stepStartIdxArray = stepStartIdxArray;
        Currents{repID}.stepStopIdxArray = stepStopIdxArray;

        for i = 1:length(stepStartIdxArray)
            plot([stepStartIdxArray(i), stepStartIdxArray(i)]./Fs,[0,5],'g');
            plot([stepStopIdxArray(i), stepStopIdxArray(i)]./Fs,[0,5],'r');
        end
        hold off;

        subplot(3,1,2);
        plot(data(4,:));hold on;
        [ stepEventsIdx, stepEventsVal, ...
            stepStartIdxArray, stepStopIdxArray, ... 
            windowEnergyArray, noiseMu, noiseSigma, noiseRange ] = SEDetectionFlex( data(4,:), data(4,noise_idx), Fs/8,  24);
        [ stepStartIdxArray, stepStopIdxArray ] = mergeOverlapEvents( stepStartIdxArray, stepStopIdxArray );
        
        Table{repID}.stepStartIdxArray = stepStartIdxArray;
        Table{repID}.stepStopIdxArray = stepStopIdxArray;

        for i = 1:length(stepStartIdxArray)
            plot([stepStartIdxArray(i), stepStartIdxArray(i)],[0,5],'g');
            plot([stepStopIdxArray(i), stepStopIdxArray(i)],[0,5],'r');
        end
        hold off;
        
        subplot(3,1,3);
        [ stepEventsIdx, stepEventsVal, ...
                stepStartIdxArray, stepStopIdxArray, ... 
                windowEnergyArray, noiseMu, noiseSigma, noiseRange ] = SEDetectionFlex( data(5,:), data(5,noise_idx), Fs/8,  16);
        [ stepStartIdxArray, stepStopIdxArray ] = mergeOverlapEvents( stepStartIdxArray, stepStopIdxArray );
        
        plot(data(5,:));hold on;
        Floor{repID}.stepStartIdxArray = stepStartIdxArray;
        Floor{repID}.stepStopIdxArray = stepStopIdxArray;
        
        for i = 1:length(stepStartIdxArray)
            plot([stepStartIdxArray(i), stepStartIdxArray(i)],[0,5],'g');
            plot([stepStopIdxArray(i), stepStopIdxArray(i)],[0,5],'r');
        end
        hold off;

    end
    if personID >= 3
        save(['P' num2str(personID) '.mat'],'Currents','Table','Floor');
    else
        save(['P' num2str(personID) '_4act.mat'],'Currents','Table','Floor');
    end
end
