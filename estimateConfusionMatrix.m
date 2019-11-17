function [ cMatrix ] = estimateConfusionMatrix( est, gt, numClass )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    
    cMatrix = zeros(numClass);
    for idx = 1:length(gt)
        cMatrix(gt(idx),est(idx)) = cMatrix(gt(idx),est(idx)) + 1;
    end
end

