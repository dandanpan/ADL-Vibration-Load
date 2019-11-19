init;
eventIDMatch = [2,3,4,14,5,7,8,10];
eventIDMatch2 = [2,4,14,7,8];

% Events
% 2. kettle 
% 3. operating with microwave
% 4. microwave
% 5. put things on stove
% 6. operating with stove
% 7. use stove
% 8. operating vacuum
% 9. sweep floor
% 10. walking/step
% 11. miscellaneous
% 14. microwave door 

for sensorID = [1,3]
    if sensorID == 1
        load('feature_table_p1.mat');
        PFeature = FeatureSet(2:6);
        load('feature_table_p1_4act.mat');
        PFeature = [PFeature, FeatureSet([1,2,6,7,8])];
        load('feature_table_p2.mat');
        PFeature = [PFeature, FeatureSet([1:4,8])];
        load('feature_table_p2_4act.mat');
        PFeature = [PFeature, FeatureSet([1,5,6,8,9])];
    elseif sensorID == 2
        load('feature_floor_p1.mat');
        PFeature = FeatureSet(2:6);
        load('feature_floor_p1_4act.mat');
        PFeature = [PFeature, FeatureSet([1,2,6,7,8])];
        load('feature_floor_p2.mat');
        PFeature = [PFeature, FeatureSet([1:4,8])];
        load('feature_floor_p2_4act.mat');
        PFeature = [PFeature, FeatureSet([1,5,6,8,9])];
    elseif sensorID == 3
        load('feature_current_p1.mat');
        PFeature = FeatureSet(2:6);
        load('feature_current_p1_4act.mat');
        PFeature = [PFeature, FeatureSet([1,2,6,7,8])];
        load('feature_current_p2.mat');
        PFeature = [PFeature, FeatureSet([1:4,8])];
        load('feature_current_p2_4act.mat');
        PFeature = [PFeature, FeatureSet([1,5,6,8,9])];
    end
    
    totalFeature = [];
    totalLabel = [];
    for trialNum = 1:10
        totalFeature = [totalFeature; PFeature{trialNum}.Feature2];
        totalLabel = [totalLabel; PFeature{trialNum}.Label];
    end
    totalLabel(totalLabel == 1) = 2;
%     [coeff, score, latent] = pca(totalFeature,'Algorithm','eig');
%     [coeff, score, latent] = pca(totalFeature,'Algorithm','svd');
    [coeff, score, latent] = pca(totalFeature,'Algorithm','als');
    
%     if sensorID == 1
%         figure;
%         for classID = eventIDMatch
%             scatter(score(totalLabel == classID,1),score(totalLabel == classID,2));hold on;
%         end
%         hold off;
%     elseif sensorID == 3 
%         figure;
%         for classID = eventIDMatch2
%             scatter(score(totalLabel == classID,1),score(totalLabel == classID,2));hold on;
%         end
%         hold off;
%     end
    
    if sensorID == 1
        figure;
        for classID = eventIDMatch
            scatter3(score(totalLabel == classID,1),score(totalLabel == classID,2),score(totalLabel == classID,3),100);hold on;
        end
        hold off;
    elseif sensorID == 3 
        figure;
        for classID = eventIDMatch2
            scatter3(score(totalLabel == classID,1),score(totalLabel == classID,2),score(totalLabel == classID,3),100);hold on;
        end
        hold off;
    end
end

