%% P1
init;

for sensorID = 1:3
    if sensorID == 1 
       load('eval_current_p1.mat');
    elseif sensorID == 2
        load('eval_table_p1.mat');
    elseif sensorID == 3
        load('eval_floor_p1.mat');
    end
      
    totalCM1 = Results{1}.cMatrix;
    totalCM2 = Results{1}.cMatrix2;
    for repID = 2:5
        totalCM1 = totalCM1 + Results{repID}.cMatrix;
        totalCM2 = totalCM2 + Results{repID}.cMatrix2;
    end

    totalCM2(:,13) = [];
    totalCM2(13,:) = [];
    totalCM2(:,12) = [];
    totalCM2(12,:) = [];
    totalCM2(:,11) = [];
    totalCM2(11,:) = [];
    totalCM2(:,9) = [];
    totalCM2(9,:) = [];
    totalCM2(:,6) = [];
    totalCM2(6,:) = [];
    figure;
    plotConfMat(totalCM2', {'OK', 'K', 'OM','M','PS','S','V','Step','MD'});
end
return;

%% train P1 test P2
init;
load('result_table_train_p1_test_p2.mat');
totalM1 = Results{1}.cMatrix;
totalM2 = Results{1}.cMatrix2;
for repID = 2
    totalM1 = totalM1 + Results{repID}.cMatrix;
    totalM2 = totalM2 + Results{repID}.cMatrix2;
end

figure;
plotConfMat(totalM2', {'OK', 'K', 'OM','M','PS','OS','S','V','SF','Step','Mis','Sync','null','MD'});

load('result_floor_train_p1_test_p2.mat');
totalM1 = Results{1}.cMatrix;
totalM2 = Results{1}.cMatrix2;
for repID = 2
    totalM1 = totalM1 + Results{repID}.cMatrix;
    totalM2 = totalM2 + Results{repID}.cMatrix2;
end

figure;
plotConfMat(totalM2', {'OK', 'K', 'OM','M','PS','OS','S','V','SF','Step','Mis','Sync','null','MD'});

load('result_current_train_p1_test_p2.mat');
totalM1 = Results{1}.cMatrix;
totalM2 = Results{1}.cMatrix2;
for repID = 2
    totalM1 = totalM1 + Results{repID}.cMatrix;
    totalM2 = totalM2 + Results{repID}.cMatrix2;
end

figure;
plotConfMat(totalM2', {'OK', 'K', 'OM','M','PS','OS','S','V','SF','Step','Mis','Sync','null','MD'});


