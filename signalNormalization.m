function [ normalizedSig ] = signalNormalization( signal )
    normalizedSig = signal - mean(signal);
    signalEnergy= sqrt(sum(normalizedSig.*normalizedSig)); 
    normalizedSig = normalizedSig./signalEnergy;
end

