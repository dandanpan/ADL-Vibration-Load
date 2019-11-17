clear all
close all
clc;

load('noise.mat');
Fs = 25600;

table = [];floor = [];table_label = [];floor_label = [];
for applianceID = 1:6
    for idx = 1:10000:90000
        table_noise = noise{applianceID}(3,idx:idx+999);
        floor_noise = noise{applianceID}(4,idx:idx+999);
        table_noise_freq = frequencyFeature( table_noise, Fs, 0 );
        [ table_noise_f, table_noise_v ] = frequencyBin( table_noise_freq(:,1),table_noise_freq(:,2), 50 );
        floor_noise_freq = frequencyFeature( floor_noise, Fs, 0 );
        [ floor_noise_f, floor_noise_v ] = frequencyBin( floor_noise_freq(:,1),floor_noise_freq(:,2), 50 );
        
        table = [table; table_noise_v];
        table_label = [table_label; applianceID];
        floor = [floor; floor_noise_v];
        floor_label = [floor_label; applianceID];
    end 
end

figure;
[coeff, score, latent] = pca(table);
for classID = 1:6
    scatter3(score(table_label == classID,1),score(table_label == classID,2),score(table_label == classID,3));hold on;
end
hold off;

figure;
[coeff, score, latent] = pca(floor);
for classID = 1:6
    scatter3(score(table_label == classID,1),score(table_label == classID,2),score(table_label == classID,3));hold on;
end
hold off;

figure;
[coeff, score, latent] = pca([floor,table]);
for classID = 1:6
    scatter3(score(table_label == classID,1),score(table_label == classID,2),score(table_label == classID,3));hold on;
end
hold off;


%% kmeans
idx_table = kmeans(table, 6);
idx_floor = kmeans(floor, 6);
idx_ft = kmeans([floor,table], 6);

[idx_table, table_label]
[idx_floor, table_label]
[idx_ft, table_label]

ri_1 = rand_index(idx_table, table_label)
ri_2 = rand_index(idx_floor, table_label)
ri_3 = rand_index(idx_ft, table_label)

%% SVM
addpath('./libsvm-master/matlab/');
table_acc = [];
for i = 1:9
    test_label = table_label([i:9:54]);
    test_data = table([i:9:54],:);
    train_idx = 1:54;
    train_idx([i:9:54]) = [];
    train_label = table_label(train_idx);
    train_data = table(train_idx,:);
    
    accBase = 0;
    gc = 0;
    for gi = [0.1,0.5,1,3,5,7,9]
        tempStruct = svmtrain(train_label, train_data, ['-s 0 -t 2 -b 1 -g ' num2str(gi) ' -c 100']);
        [predicted_label, accuracy, decision_values] = svmpredict(train_label, train_data, tempStruct,'-b 1');
        if accuracy(1) > accBase
            svmstruct = tempStruct;
            accBase = accuracy(1);
            gc = gi;
        end
    end
    [predicted_table{i}, accuracy_table{i}, decision_values] = svmpredict(test_label, test_data, svmstruct,'-b 1');
    table_acc = [table_acc, accuracy_table{i}(1)];
end
table_acc


floor_acc = [];
for i = 1:9
    test_label = floor_label([i:9:54]);
    test_data = floor([i:9:54],:);
    train_idx = 1:54;
    train_idx([i:9:54]) = [];
    train_label = floor_label(train_idx);
    train_data = floor(train_idx,:);
    
    accBase = 0;
    gc = 0;
    for gi = [0.1,0.5,1,3,5,7,9]
        tempStruct = svmtrain(train_label, train_data, ['-s 0 -t 2 -b 1 -g ' num2str(gi) ' -c 100']);
        [predicted_label, accuracy, decision_values] = svmpredict(train_label, train_data, tempStruct,'-b 1');
        if accuracy(1) > accBase
            svmstruct = tempStruct;
            accBase = accuracy(1);
            gc = gi;
        end
    end
    [predicted_floor{i}, accuracy_floor{i}, decision_values] = svmpredict(test_label, test_data, svmstruct,'-b 1');
    floor_acc = [floor_acc, accuracy_floor{i}(1)];
end
floor_acc

ft = [floor,table];
ft_acc = [];
for i = 1:9
    test_label = floor_label([i:9:54]);
    test_data = ft([i:9:54],:);
    train_idx = 1:54;
    train_idx([i:9:54]) = [];
    train_label = floor_label(train_idx);
    train_data = ft(train_idx,:);
    
    accBase = 0;
    gc = 0;
    for gi = [0.1,0.5,1,3,5,7,9]
        tempStruct = svmtrain(train_label, train_data, ['-s 0 -t 2 -b 1 -g ' num2str(gi) ' -c 100']);
        [predicted_label, accuracy, decision_values] = svmpredict(train_label, train_data, tempStruct,'-b 1');
        if accuracy(1) > accBase
            svmstruct = tempStruct;
            accBase = accuracy(1);
            gc = gi;
        end
    end
    [predicted_ft{i}, accuracy_ft{i}, decision_values] = svmpredict(test_label, test_data, svmstruct,'-b 1');
    ft_acc = [ft_acc, accuracy_ft{i}(1)];
end
ft_acc
