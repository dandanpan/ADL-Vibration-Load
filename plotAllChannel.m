function [ output_args ] = plotAllChannel( signal )
%PLOTALLCHANNEL Summary of this function goes here
%   Detailed explanation goes here
    size1 = size(signal,1);
    size2 = size(signal,2);
    if size1>size2
        channelID = 2;
    else
        channelID = 1;
    end
    
    if channelID == 1
        figure;
        for cID = 1:size1
            plot(signal(cID,:));hold on;
        end
    else
        figure;
        for cID = 1:size2
            plot(signal(:,cID));hold on;
        end
    end
end

