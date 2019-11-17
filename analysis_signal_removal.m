close all; clear all;
Fs = 25600;

load('noise.mat');


load('/Users/shijiapan/Box Sync/Activity_Detection/0311/DATA/PorterLab_20190311_cup_kettle_rep0.mat');
data_kettle_cup = data(110000:end,:);
[ stepEventsSig, stepEventsIdx, stepEventsVal, ...
            stepStartIdxArray, stepStopIdxArray, ... 
            windowEnergyArray, noiseMu, noiseSigma, noiseRange ] = SEDetection( data_kettle_cup(:,3), data_kettle_cup(1:30000,3), 5, Fs ); 
plotAllChannel( data_kettle_cup );

scatter(stepStartIdxArray,data_kettle_cup(stepStartIdxArray,3),'rv');hold on;
scatter(stepStopIdxArray,data_kettle_cup(stepStopIdxArray,3),'gv');hold off;
selected_event_ID = [1,2,3,4,5,7,8,11];
for eventID = 1:length(selected_event_ID)
    event_kettle_cup{eventID} = data_kettle_cup(stepStartIdxArray(selected_event_ID(eventID)):stepStopIdxArray(selected_event_ID(eventID)),:);
%     plotAllChannel( event_kettle_cup{eventID} );
end
ylim([-5,5]);

load('/Users/shijiapan/Box Sync/Activity_Detection/0311/DATA/PorterLab_20190311_cup_rep0.mat');
data_cup = data(200000:end,:);
[ stepEventsSig, stepEventsIdx, stepEventsVal, ...
            stepStartIdxArray, stepStopIdxArray, ... 
            windowEnergyArray, noiseMu, noiseSigma, noiseRange ] = SEDetection( data_cup(:,3), data_cup(180000:210000,3), 10, Fs ); 
plotAllChannel( data_cup );
scatter(stepStartIdxArray,data_cup(stepStartIdxArray,3),'rv');hold on;
scatter(stepStopIdxArray,data_cup(stepStopIdxArray,3),'gv');hold off;
selected_event_ID = [1:8];
for eventID = 1:length(selected_event_ID)
    event_cup{eventID} = data_cup(stepStartIdxArray(selected_event_ID(eventID)):stepStopIdxArray(selected_event_ID(eventID)),:);
%     plotAllChannel( event_cup{eventID} );
end
ylim([-5,5]);


[ COEFS, maxScale, maxBandScale, bandEnergy1 ] = waveletAnalysis( signalNormalization(noise{6}(3,1:10001)), 1 );
[ COEFS, maxScale, maxBandScale, bandEnergy11 ] = waveletAnalysis( signalNormalization(event_kettle_cup{2}(:,3)), 1 );
[ COEFS, maxScale, maxBandScale, bandEnergy12 ] = waveletAnalysis( signalNormalization(event_cup{2}(:,3)), 1 );
[ COEFS, maxScale, maxBandScale, bandEnergy22 ] = waveletAnalysis( signalNormalization(event_cup{2}(:,4)), 1 );
[ COEFS, maxScale, maxBandScale, bandEnergy21 ] = waveletAnalysis( signalNormalization(event_kettle_cup{2}(:,4)), 1 );
[ COEFS, maxScale, maxBandScale, bandEnergy2 ] = waveletAnalysis( signalNormalization(noise{6}(4,:)), 1 );
figure;
plot(bandEnergy1);hold on;
plot(bandEnergy11);hold on;
plot(bandEnergy12);hold off;

figure;
plot(bandEnergy2); hold on;
plot(bandEnergy21); hold on;
plot(bandEnergy22);hold off;





return;

load('/Users/shijiapan/Box Sync/Activity_Detection/0311/DATA/PorterLab_20190311_kettle_pot_rep0.mat');
data_kettle_pot = data(100000:end,:);
[ stepEventsSig, stepEventsIdx, stepEventsVal, ...
            stepStartIdxArray, stepStopIdxArray, ... 
            windowEnergyArray, noiseMu, noiseSigma, noiseRange ] = SEDetection( data_kettle_pot(:,3), data_kettle_pot(1:20000,3), 6, Fs ); %(180000:210000,3)% (1000:21000,3)
plotAllChannel( data_kettle_pot );
scatter(stepStartIdxArray,data_kettle_pot(stepStartIdxArray,3),'rv');hold on;
scatter(stepStopIdxArray,data_kettle_pot(stepStopIdxArray,3),'gv');hold off;
selected_event_ID = [1,3,4,7,9,12,14,16];
for eventID = 1:length(selected_event_ID)
    event_kettle_pot{eventID} = data_kettle_pot(stepStartIdxArray(selected_event_ID(eventID)):stepStopIdxArray(selected_event_ID(eventID)),:);
%     plotAllChannel( event_cup{eventID} );
end
ylim([-5,5]);

%%
load('/Users/shijiapan/Box Sync/Activity_Detection/0311/DATA/PorterLab_20190311_pot_rep0.mat');
data_pot = data(120000:end, :);
[ stepEventsSig, stepEventsIdx, stepEventsVal, ...
            stepStartIdxArray, stepStopIdxArray, ... 
            windowEnergyArray, noiseMu, noiseSigma, noiseRange ] = SEDetection( data_pot(:,3), data_pot(1:20000,3), 100, Fs ); %(180000:210000,3)% (1000:21000,3)
plotAllChannel( data_pot );
scatter(stepStartIdxArray,data_pot(stepStartIdxArray,3),'rv');hold on;
scatter(stepStopIdxArray,data_pot(stepStopIdxArray,3),'gv');hold off;
selected_event_ID = [1,2,3,5,7,8,10,12];
for eventID = 1:length(selected_event_ID)
    event_pot{eventID} = data_pot(stepStartIdxArray(selected_event_ID(eventID)):stepStopIdxArray(selected_event_ID(eventID)),:);
%     plotAllChannel( event_cup{eventID} );
end
ylim([-5,5]);



