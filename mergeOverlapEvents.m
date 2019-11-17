function [ stepStartIdxArray, stepStopIdxArray ] = mergeOverlapEvents( stepStartIdxArray, stepStopIdxArray )
%MERGEOVERLAPEVENTS Summary of this function goes here
%   Detailed explanation goes here
    i = 2;
    while i <= length(stepStartIdxArray)
        % if 1st stepstop idx is > 2nd stepstart, they merge
        if stepStopIdxArray(i-1) > stepStartIdxArray(i)
            stepStopIdxArray(i-1) = [];
            stepStartIdxArray(i) = [];
        else
            i = i + 1;
        end
    end

end

