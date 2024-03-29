function [ stepEventsSig, stepEventsIdx, stepEventsVal, ...
            stepStartIdxArray, stepStopIdxArray, ... 
            windowEnergyArray, noiseMu, noiseSigma, noiseRange ] = SEDetection( signal, noiseSig, sigmaSize, Fs )

    % this function extract the footsteps from a signal segment
    
    windowSize = Fs/4;
    WIN1=Fs/4;
    WIN2=Fs/4;
%     WIN1=5000;
%     WIN2=5001;
    eventSize = WIN1+WIN2;
    signal = signal - mean(signal);
    noiseSig = noiseSig - mean(noiseSig);
    
    states = 0;% is noise
    windowEnergyArray = [];
    windowDataEnergyArray = [];
    stepEventsSig = [];
    stepEventsIdx = [];
    stepEventsVal = [];
    continueDetection = 0;
    noiseRange = [];
    stepStartIdx = 1;
    stepStopIdx = 1;
    stepPeak = 1;
    stepStartIdxArray = [];
    stepStopIdxArray = [];
    
    idx = 1;
    while idx < length(noiseSig) - max(windowSize, eventSize)
        windowData = noiseSig(idx:idx+windowSize-1);
        windowDataEnergy = sum(windowData.*windowData);
        windowDataEnergyArray = [windowDataEnergyArray windowDataEnergy];
        idx = idx + windowSize/2;
    end
    [noiseMu,noiseSigma] = normfit(windowDataEnergyArray);
    
    idx = 1;
    while idx < length(signal) - 2 * max(windowSize, eventSize)
        % if one sensor detected, we count all sensor detected it
        windowData = signal(idx:idx+windowSize-1);
        windowDataEnergy = sum(windowData.*windowData);
        windowEnergyArray = [windowEnergyArray; windowDataEnergy idx];
        
        % gaussian fit
        if windowDataEnergy  < noiseSigma * sigmaSize + noiseMu

            if states == 1 && idx < length(signal) - eventSize
                % find the event peak as well as the event
                stepEnd = idx;
                stepRange = signal(stepStart:stepEnd);
                [localPeakValue, localPeak] = max(abs(stepRange));
                stepPeak = stepStart + localPeak - 1;


                % extract clear signal
                stepStartIdx = stepStart %max(stepPeak - WIN1, stepStart);
                stepStopIdx = stepEnd-1 %stepStartIdx + eventSize - 1;
                stepSig = signal(stepStartIdx:stepStopIdx);
                stepStartIdxArray = [stepStartIdxArray, stepStartIdx]
                stepStopIdxArray = [stepStopIdxArray, stepStopIdx]

                % save the signal
%                 if size(stepSig,2) == 1
%                     stepEventsSig = [stepEventsSig; stepSig'];
%                 else
%                     stepEventsSig = [stepEventsSig; stepSig];
%                 end
                stepEventsIdx = [stepEventsIdx; stepPeak];
                stepEventsVal = [stepEventsVal; localPeakValue];

                % move the index to skip the event
                idx = stepStopIdx - windowSize/2;
            end
            states = 0;
            continueDetection = 0;
        else
            % mark step
            if states == 0 %&& idx - stepPeak > 350
                stepStart = idx; 
                states = 1;
            end
        end  
        
        idx = idx + windowSize/2;
    end
    
    if states == 1
        stepEnd = length(signal);
        % extract clear signal
        stepStartIdx = stepStart %max(stepPeak - WIN1, stepStart);
        stepStopIdx = stepEnd-1 %stepStartIdx + eventSize - 1;
        stepSig = signal(stepStartIdx:stepStopIdx);
        stepStartIdxArray = [stepStartIdxArray, stepStartIdx]
        stepStopIdxArray = [stepStopIdxArray, stepStopIdx]
    end
end

