init;

resultCount = 0;
load('./P1.mat');
for repID = 2:6
    resultCount = resultCount + 1;
    load(['/Users/shijiapan/Box Sync/Activity_Detection/0407/PortLab_20190407_Route_P2_Rep' num2str(repID) '.mat']);
    % current detection
    gt_length = length(data);
    gt = Label{repID}.label_array(1:min(gt_length, length(Label{repID}.label_array)));
    validIdx = find(gt~= 6 & gt~= 11 & gt~= 12 & gt~= 13);
    
    gt(gt > 0) = 1;
    current_detect = zeros(1,length(data));
    table_detect = zeros(1,length(data));
    floor_detect = zeros(1,length(data));
    
    for eventID = 1:length(Currents{repID}.stepStartIdxArray)
        tIdx = [Currents{repID}.stepStartIdxArray(eventID):Currents{repID}.stepStopIdxArray(eventID)];
        tIdx(tIdx > length(data)) = [];
        current_detect(tIdx) = 1;
    end
    for eventID = 1:length(Table{repID}.stepStartIdxArray)
        tIdx = [Table{repID}.stepStartIdxArray(eventID):Table{repID}.stepStopIdxArray(eventID)];
        tIdx(tIdx > length(data)) = [];
        table_detect(tIdx) = 1;
    end
    for eventID = 1:length(Floor{repID}.stepStartIdxArray)
        tIdx = [Floor{repID}.stepStartIdxArray(eventID):Floor{repID}.stepStopIdxArray(eventID)];
        tIdx(tIdx > length(data)) = [];
        floor_detect(tIdx) = 1;
    end

    total = current_detect + table_detect + floor_detect;
    total(total > 0) = 1;

    a = xor(gt(validIdx), current_detect(validIdx));
    tp = sum(current_detect(validIdx).*gt(validIdx));
    fp = sum(a.*current_detect(validIdx));
    fn = sum(a.*gt(validIdx));
    Detection_Result{resultCount}.current_precision = tp/(tp+fp)
    Detection_Result{resultCount}.current_recall = tp/(tp+fn)
    Detection_Result{resultCount}.current_f1 = 2*(Detection_Result{resultCount}.current_precision*Detection_Result{resultCount}.current_recall)/(Detection_Result{resultCount}.current_precision+Detection_Result{resultCount}.current_recall)
    
    a = xor(gt(validIdx), table_detect(validIdx));
    tp = sum(table_detect(validIdx).*gt(validIdx));
    fp = sum(a.*table_detect(validIdx));
    fn = sum(a.*gt(validIdx));
    Detection_Result{resultCount}.table_precision = tp/(tp+fp)
    Detection_Result{resultCount}.table_recall = tp/(tp+fn)
    Detection_Result{resultCount}.table_f1 = 2*(Detection_Result{resultCount}.table_precision*Detection_Result{resultCount}.table_recall)/(Detection_Result{resultCount}.table_precision+Detection_Result{resultCount}.table_recall)
    
    a = xor(gt(validIdx), floor_detect(validIdx));
    tp = sum(floor_detect(validIdx).*gt(validIdx));
    fp = sum(a.*floor_detect(validIdx));
    fn = sum(a.*gt(validIdx));
    Detection_Result{resultCount}.floor_precision = tp/(tp+fp)
    Detection_Result{resultCount}.floor_recall = tp/(tp+fn)
    Detection_Result{resultCount}.floor_f1 = 2*(Detection_Result{resultCount}.floor_precision*Detection_Result{resultCount}.floor_recall)/(Detection_Result{resultCount}.floor_precision+Detection_Result{resultCount}.floor_recall)
    
    a = xor(gt(validIdx), total(validIdx));
    tp = sum(total(validIdx).*gt(validIdx));
    fp = sum(a.*total(validIdx));
    fn = sum(a.*gt(validIdx));
    Detection_Result{resultCount}.fuse_precision = tp/(tp+fp)
    Detection_Result{resultCount}.fuse_recall = tp/(tp+fn)
    Detection_Result{resultCount}.fuse_f1 = 2*(Detection_Result{resultCount}.fuse_precision*Detection_Result{resultCount}.fuse_recall)/(Detection_Result{resultCount}.fuse_precision+Detection_Result{resultCount}.fuse_recall)
end

save('result_detect.mat','Detection_Result','resultCount');

init;
load('result_detect.mat');
load('P1_4act.mat');
for repID = [1,2,6,7,8]
    resultCount = resultCount + 1;
    load(['/Users/shijiapan/Box Sync/Activity_Detection/0407/PortLab_20190407_Route_P2_Rep' num2str(repID) '.mat']);
    % current detection
    gt_length = length(data);
    gt = Label{repID}.label_array(1:min(gt_length, length(Label{repID}.label_array)));
%     validIdx = [1:gt_length];%find(gt<11 | gt>13);
    validIdx = find(gt~= 6 & gt~= 11 & gt~= 12 & gt~= 13);
    
    gt(gt > 0) = 1;
    current_detect = zeros(1,length(data));
    table_detect = zeros(1,length(data));
    floor_detect = zeros(1,length(data));
    
    for eventID = 1:length(Currents{repID}.stepStartIdxArray)
        tIdx = [Currents{repID}.stepStartIdxArray(eventID):Currents{repID}.stepStopIdxArray(eventID)];
        tIdx(tIdx > length(data)) = [];
        current_detect(tIdx) = 1;
    end
    for eventID = 1:length(Table{repID}.stepStartIdxArray)
        tIdx = [Table{repID}.stepStartIdxArray(eventID):Table{repID}.stepStopIdxArray(eventID)];
        tIdx(tIdx > length(data)) = [];
        table_detect(tIdx) = 1;
    end
    for eventID = 1:length(Floor{repID}.stepStartIdxArray)
        tIdx = [Floor{repID}.stepStartIdxArray(eventID):Floor{repID}.stepStopIdxArray(eventID)];
        tIdx(tIdx > length(data)) = [];
        floor_detect(tIdx) = 1;
    end

    total = current_detect + table_detect + floor_detect;
    total(total > 0) = 1;

    a = xor(gt(validIdx), current_detect(validIdx));
    tp = sum(current_detect(validIdx).*gt(validIdx));
    fp = sum(a.*current_detect(validIdx));
    fn = sum(a.*gt(validIdx));
    Detection_Result{resultCount}.current_precision = tp/(tp+fp)
    Detection_Result{resultCount}.current_recall = tp/(tp+fn)
    Detection_Result{resultCount}.current_f1 = 2*(Detection_Result{resultCount}.current_precision*Detection_Result{resultCount}.current_recall)/(Detection_Result{resultCount}.current_precision+Detection_Result{resultCount}.current_recall)
    
    a = xor(gt(validIdx), table_detect(validIdx));
    tp = sum(table_detect(validIdx).*gt(validIdx));
    fp = sum(a.*table_detect(validIdx));
    fn = sum(a.*gt(validIdx));
    Detection_Result{resultCount}.table_precision = tp/(tp+fp)
    Detection_Result{resultCount}.table_recall = tp/(tp+fn)
    Detection_Result{resultCount}.table_f1 = 2*(Detection_Result{resultCount}.table_precision*Detection_Result{resultCount}.table_recall)/(Detection_Result{resultCount}.table_precision+Detection_Result{resultCount}.table_recall)
    
    a = xor(gt(validIdx), floor_detect(validIdx));
    tp = sum(floor_detect(validIdx).*gt(validIdx));
    fp = sum(a.*floor_detect(validIdx));
    fn = sum(a.*gt(validIdx));
    Detection_Result{resultCount}.floor_precision = tp/(tp+fp)
    Detection_Result{resultCount}.floor_recall = tp/(tp+fn)
    Detection_Result{resultCount}.floor_f1 = 2*(Detection_Result{resultCount}.floor_precision*Detection_Result{resultCount}.floor_recall)/(Detection_Result{resultCount}.floor_precision+Detection_Result{resultCount}.floor_recall)
    
    a = xor(gt(validIdx), total(validIdx));
    tp = sum(total(validIdx).*gt(validIdx));
    fp = sum(a.*total(validIdx));
    fn = sum(a.*gt(validIdx));
    Detection_Result{resultCount}.fuse_precision = tp/(tp+fp)
    Detection_Result{resultCount}.fuse_recall = tp/(tp+fn)
    Detection_Result{resultCount}.fuse_f1 = 2*(Detection_Result{resultCount}.fuse_precision*Detection_Result{resultCount}.fuse_recall)/(Detection_Result{resultCount}.fuse_precision+Detection_Result{resultCount}.fuse_recall)
end

save('result_detect.mat','Detection_Result','resultCount');

init;
load('result_detect.mat');

load('P2.mat');
for repID = [1:4,8]
    resultCount = resultCount + 1;
    load(['/Users/shijiapan/Box Sync/Activity_Detection/0407/PortLab_20190407_Route_P2_Rep' num2str(repID) '.mat']);
    % current detection
    gt_length = length(data);
    gt = Label{repID}.label_array(1:min(gt_length, length(Label{repID}.label_array)));
%     validIdx = [1:gt_length];%find(gt<11 | gt>13);
    validIdx = find(gt~= 6 & gt~= 11 & gt~= 12 & gt~= 13);
    
    gt(gt > 0) = 1;
    current_detect = zeros(1,length(data));
    table_detect = zeros(1,length(data));
    floor_detect = zeros(1,length(data));
    
    for eventID = 1:length(Currents{repID}.stepStartIdxArray)
        tIdx = [Currents{repID}.stepStartIdxArray(eventID):Currents{repID}.stepStopIdxArray(eventID)];
        tIdx(tIdx > length(data)) = [];
        current_detect(tIdx) = 1;
    end
    for eventID = 1:length(Table{repID}.stepStartIdxArray)
        tIdx = [Table{repID}.stepStartIdxArray(eventID):Table{repID}.stepStopIdxArray(eventID)];
        tIdx(tIdx > length(data)) = [];
        table_detect(tIdx) = 1;
    end
    for eventID = 1:length(Floor{repID}.stepStartIdxArray)
        tIdx = [Floor{repID}.stepStartIdxArray(eventID):Floor{repID}.stepStopIdxArray(eventID)];
        tIdx(tIdx > length(data)) = [];
        floor_detect(tIdx) = 1;
    end

    total = current_detect + table_detect + floor_detect;
    total(total > 0) = 1;

    a = xor(gt(validIdx), current_detect(validIdx));
    tp = sum(current_detect(validIdx).*gt(validIdx));
    fp = sum(a.*current_detect(validIdx));
    fn = sum(a.*gt(validIdx));
    Detection_Result{resultCount}.current_precision = tp/(tp+fp)
    Detection_Result{resultCount}.current_recall = tp/(tp+fn)
    Detection_Result{resultCount}.current_f1 = 2*(Detection_Result{resultCount}.current_precision*Detection_Result{resultCount}.current_recall)/(Detection_Result{resultCount}.current_precision+Detection_Result{resultCount}.current_recall)
    
    a = xor(gt(validIdx), table_detect(validIdx));
    tp = sum(table_detect(validIdx).*gt(validIdx));
    fp = sum(a.*table_detect(validIdx));
    fn = sum(a.*gt(validIdx));
    Detection_Result{resultCount}.table_precision = tp/(tp+fp)
    Detection_Result{resultCount}.table_recall = tp/(tp+fn)
    Detection_Result{resultCount}.table_f1 = 2*(Detection_Result{resultCount}.table_precision*Detection_Result{resultCount}.table_recall)/(Detection_Result{resultCount}.table_precision+Detection_Result{resultCount}.table_recall)
    
    a = xor(gt(validIdx), floor_detect(validIdx));
    tp = sum(floor_detect(validIdx).*gt(validIdx));
    fp = sum(a.*floor_detect(validIdx));
    fn = sum(a.*gt(validIdx));
    Detection_Result{resultCount}.floor_precision = tp/(tp+fp)
    Detection_Result{resultCount}.floor_recall = tp/(tp+fn)
    Detection_Result{resultCount}.floor_f1 = 2*(Detection_Result{resultCount}.floor_precision*Detection_Result{resultCount}.floor_recall)/(Detection_Result{resultCount}.floor_precision+Detection_Result{resultCount}.floor_recall)
    
    a = xor(gt(validIdx), total(validIdx));
    tp = sum(total(validIdx).*gt(validIdx));
    fp = sum(a.*total(validIdx));
    fn = sum(a.*gt(validIdx));
    Detection_Result{resultCount}.fuse_precision = tp/(tp+fp)
    Detection_Result{resultCount}.fuse_recall = tp/(tp+fn)
    Detection_Result{resultCount}.fuse_f1 = 2*(Detection_Result{resultCount}.fuse_precision*Detection_Result{resultCount}.fuse_recall)/(Detection_Result{resultCount}.fuse_precision+Detection_Result{resultCount}.fuse_recall)
end

save('result_detect.mat','Detection_Result','resultCount');

%%
init;
load('result_detect.mat');
load('P2_4act.mat');
for repID = [1,5,6,8,9]
    resultCount = resultCount + 1;
    load(['/Users/shijiapan/Box Sync/Activity_Detection/0429/PortLab_20190429_Route_P2_Rep' num2str(repID) '.mat']);
    % current detection
    gt_length = length(data);
    gt = Label{repID}.label_array(1:min(gt_length, length(Label{repID}.label_array)));
    validIdx = find(gt~= 6 & gt~= 11 & gt~= 12 & gt~= 13);
    
    gt(gt > 0) = 1;
    current_detect = zeros(1,length(data));
    table_detect = zeros(1,length(data));
    floor_detect = zeros(1,length(data));
    
    for eventID = 1:length(Currents{repID}.stepStartIdxArray)
        tIdx = [Currents{repID}.stepStartIdxArray(eventID):Currents{repID}.stepStopIdxArray(eventID)];
        tIdx(tIdx > length(data)) = [];
        current_detect(tIdx) = 1;
    end
    for eventID = 1:length(Table{repID}.stepStartIdxArray)
        tIdx = [Table{repID}.stepStartIdxArray(eventID):Table{repID}.stepStopIdxArray(eventID)];
        tIdx(tIdx > length(data)) = [];
        table_detect(tIdx) = 1;
    end
    for eventID = 1:length(Floor{repID}.stepStartIdxArray)
        tIdx = [Floor{repID}.stepStartIdxArray(eventID):Floor{repID}.stepStopIdxArray(eventID)];
        tIdx(tIdx > length(data)) = [];
        floor_detect(tIdx) = 1;
    end

    total = current_detect + table_detect + floor_detect;
    total(total > 0) = 1;

    a = xor(gt(validIdx), current_detect(validIdx));
    tp = sum(current_detect(validIdx).*gt(validIdx));
    fp = sum(a.*current_detect(validIdx));
    fn = sum(a.*gt(validIdx));
    Detection_Result{resultCount}.current_precision = tp/(tp+fp)
    Detection_Result{resultCount}.current_recall = tp/(tp+fn)
    Detection_Result{resultCount}.current_f1 = 2*(Detection_Result{resultCount}.current_precision*Detection_Result{resultCount}.current_recall)/(Detection_Result{resultCount}.current_precision+Detection_Result{resultCount}.current_recall)
    
    a = xor(gt(validIdx), table_detect(validIdx));
    tp = sum(table_detect(validIdx).*gt(validIdx));
    fp = sum(a.*table_detect(validIdx));
    fn = sum(a.*gt(validIdx));
    Detection_Result{resultCount}.table_precision = tp/(tp+fp)
    Detection_Result{resultCount}.table_recall = tp/(tp+fn)
    Detection_Result{resultCount}.table_f1 = 2*(Detection_Result{resultCount}.table_precision*Detection_Result{resultCount}.table_recall)/(Detection_Result{resultCount}.table_precision+Detection_Result{resultCount}.table_recall)
    
    a = xor(gt(validIdx), floor_detect(validIdx));
    tp = sum(floor_detect(validIdx).*gt(validIdx));
    fp = sum(a.*floor_detect(validIdx));
    fn = sum(a.*gt(validIdx));
    Detection_Result{resultCount}.floor_precision = tp/(tp+fp)
    Detection_Result{resultCount}.floor_recall = tp/(tp+fn)
    Detection_Result{resultCount}.floor_f1 = 2*(Detection_Result{resultCount}.floor_precision*Detection_Result{resultCount}.floor_recall)/(Detection_Result{resultCount}.floor_precision+Detection_Result{resultCount}.floor_recall)
    
    a = xor(gt(validIdx), total(validIdx));
    tp = sum(total(validIdx).*gt(validIdx));
    fp = sum(a.*total(validIdx));
    fn = sum(a.*gt(validIdx));
    Detection_Result{resultCount}.fuse_precision = tp/(tp+fp)
    Detection_Result{resultCount}.fuse_recall = tp/(tp+fn)
    Detection_Result{resultCount}.fuse_f1 = 2*(Detection_Result{resultCount}.fuse_precision*Detection_Result{resultCount}.fuse_recall)/(Detection_Result{resultCount}.fuse_precision+Detection_Result{resultCount}.fuse_recall)
end

cp = [];
cr = [];
cf1 = [];

tap = [];
tar = [];
taf1 = [];

flp = [];
flr = [];
flf1 = [];

fup = [];
fur = [];
fuf1 = [];


for resultCount = 1:4
    cp = [cp, Detection_Result{resultCount}.current_precision];
    cr = [cr, Detection_Result{resultCount}.current_recall];
    cf1 = [cf1, Detection_Result{resultCount}.current_f1];
    
    tap = [tap, Detection_Result{resultCount}.table_precision];
    tar = [tar, Detection_Result{resultCount}.table_recall];
    taf1 = [taf1, Detection_Result{resultCount}.table_f1];
    
    flp = [flp, Detection_Result{resultCount}.floor_precision];
    flr = [flr, Detection_Result{resultCount}.floor_recall];
    flf1 = [flf1, Detection_Result{resultCount}.floor_f1];
    
    fup = [fup, Detection_Result{resultCount}.fuse_precision];
    fur = [fur, Detection_Result{resultCount}.fuse_recall];
    fuf1 = [fuf1, Detection_Result{resultCount}.fuse_f1];
    
end

result{1} = [tap; tar; taf1]';
result{2} = [flp; flr; flf1]';
result{3} = [cp; cr; cf1]';
result{4} = [fup; fur; fuf1]';


addpath('./aboxplot/');
figure;
aboxplot(result);
ylim([0,1]);







