function [ freq_features ] = frequencyFeature( signal, Fs, withTimestamp, binSize )
%FREQUENCYFEATURE Summary of this function goes here
%   Detailed explanation goes here
    
    if nargin < 4
        binSize = 1;
    elseif nargin < 3
        withTimestamp = 0;
        binSize = 1;
    end
    
    channel_num = size(signal,1);

    freq_features = [];
    
    if withTimestamp == 1
        channel_num = channel_num - 1;
        for cnum = 1:channel_num
            temp_sig = signal(cnum+1,:) - mean(signal(cnum+1,:));
            temp_sig = signalNormalization(temp_sig);
            [ Y, f ] = signalFreqencyExtract( temp_sig, Fs );
            [f, Y] = frequencyBin( f, Y, binSize );
            figure;plot(f,Y);
            freq_features = [freq_features; f', Y'];
        end
    else
        for cnum = 1:channel_num
            temp_sig = signal(cnum,:) - mean(signal(cnum,:));
%             temp_sig = signalNormalization(temp_sig);
%             [ temp_sig ] = signalFilter( temp_sig, Fs, 56, 62 );
%             [ temp_sig ] = signalFilter( temp_sig, Fs, 116, 122 );
%             [ temp_sig ] = signalFilter( temp_sig, Fs, 176, 182 );
%             [ temp_sig ] = signalFilter( temp_sig, Fs, 236, 242 );
            
            [ Y, f ] = signalFreqencyExtract( temp_sig, Fs );
            [f, Y] = frequencyBin( f, Y, binSize );
%             figure;plot(f,Y);
            freq_features = [freq_features; f', Y'];
        end
    end
end

