function [ newf, newY ] = frequencyBin( f, Y, binWidth )
%FREQUENCYBIN Summary of this function goes here
%   Detailed explanation goes here
    binNum = max(f);
    newf = [1:binWidth:binNum];
    newY = zeros(1,length(newf));
    for freqID = 1:length(newf)
        newY(freqID) = sum(Y(f>=newf(freqID)-binWidth & f<newf(freqID)));
    end
end

