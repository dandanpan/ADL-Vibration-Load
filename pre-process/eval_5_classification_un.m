init;

for sensorID = 1:3
    if sensorID == 1 
       load('eval_current_un.mat');
    elseif sensorID == 2
        load('eval_table_un.mat');
    elseif sensorID == 3
        load('eval_floor_un.mat');
    end
      
    totalCM1 = Result.cMatrix;
    totalCM2 = Result.cMatrix2;
    for repID = 2:5
        totalCM1 = totalCM1 + Result.cMatrix;
        totalCM2 = totalCM2 + Result.cMatrix2;
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


