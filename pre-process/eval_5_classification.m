%% P1
init;

load('eval_current.mat');
Result_Current = Results(2:6);
load('eval_table.mat');
Result_Table = Results(2:6);
load('eval_floor.mat');
Result_Floor = Results(2:6);

load('eval_current_4act.mat');
Result_Current = [Result_Current, Results];
load('eval_table_4act.mat');
Result_Table = [Result_Table, Results];
load('eval_floor_4act.mat');
Result_Floor = [Result_Floor, Results];

clear Results;

totalCM1 = Result_Current{1}.cMatrix;
totalCM2 = Result_Current{1}.cMatrix2;
for repID = 2:10
    totalCM1 = totalCM1 + Result_Current{repID}.cMatrix;
    totalCM2 = totalCM2 + Result_Current{repID}.cMatrix2;
end

totalCM1(:,13) = [];
totalCM1(13,:) = [];
totalCM1(:,12) = [];
totalCM1(12,:) = [];
totalCM1(:,11) = [];
totalCM1(11,:) = [];
totalCM1(:,6) = [];
totalCM1(6,:) = [];

totalCM2(:,13) = [];
totalCM2(13,:) = [];
totalCM2(:,12) = [];
totalCM2(12,:) = [];
totalCM2(:,11) = [];
totalCM2(11,:) = [];
totalCM2(:,6) = [];
totalCM2(6,:) = [];


% figure;
% plotConfMat(totalCM1, {'OK', 'K', 'OM','M','PS','S','V','SF','Step','MD'});
figure;
% subplot(1,3,1);
plotConfMat(totalCM2', {'OK', 'K', 'OM','M','PS','S','V','SF','Step','MD'});

totalTM1 = Result_Table{1}.cMatrix;
totalTM2 = Result_Table{1}.cMatrix2;
for repID = 2:10
    totalTM1 = totalTM1 + Result_Table{repID}.cMatrix;
    totalTM2 = totalTM2 + Result_Table{repID}.cMatrix2;
end

totalTM1(:,13) = [];
totalTM1(13,:) = [];
totalTM1(:,12) = [];
totalTM1(12,:) = [];
totalTM1(:,11) = [];
totalTM1(11,:) = [];
totalTM1(:,6) = [];
totalTM1(6,:) = [];

totalTM2(:,13) = [];
totalTM2(13,:) = [];
totalTM2(:,12) = [];
totalTM2(12,:) = [];
totalTM2(:,11) = [];
totalTM2(11,:) = [];
totalTM2(:,6) = [];
totalTM2(6,:) = [];

% addpath('./plotConfMat/');
% figure;
% plotConfMat(totalTM1, {'OK', 'K', 'OM','M','PS','S','V','SF','Step','MD'});
% figure;

figure;
% subplot(1,3,2);
plotConfMat(totalTM2', {'OK', 'K', 'OM','M','PS','S','V','SF','Step','MD'});

totalFM1 = Result_Floor{1}.cMatrix;
totalFM2 = Result_Floor{1}.cMatrix2;
for repID = 2:10
    totalFM1 = totalFM1 + Result_Floor{repID}.cMatrix;
    totalFM2 = totalFM2 + Result_Floor{repID}.cMatrix2;
end

totalFM1(:,13) = [];
totalFM1(13,:) = [];
totalFM1(:,12) = [];
totalFM1(12,:) = [];
totalFM1(:,11) = [];
totalFM1(11,:) = [];
totalFM1(:,6) = [];
totalFM1(6,:) = [];

totalFM2(:,13) = [];
totalFM2(13,:) = [];
totalFM2(:,12) = [];
totalFM2(12,:) = [];
totalFM2(:,11) = [];
totalFM2(11,:) = [];
totalFM2(:,6) = [];
totalFM2(6,:) = [];

% addpath('./plotConfMat/');
% figure;
% plotConfMat(totalTM1, {'OK', 'K', 'OM','M','PS','S','V','SF','Step','MD'});
% figure;

% subplot(1,3,3);
figure;
plotConfMat(totalFM2', {'OK', 'K', 'OM','M','PS','S','V','SF','Step','MD'});

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


