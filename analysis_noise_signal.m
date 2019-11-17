close all; clear all;
Fs = 25600;

load('/Users/shijiapan/Box Sync/Activity_Detection/0408/PortLab_20190408_Route_stove.mat');
plotAllChannel(data(2:5,:));
xlabel('Time (s)');
noise{1} = data(2:5,200000:300000);

load('/Users/shijiapan/Box Sync/Activity_Detection/0408/PortLab_20190408_Route_microwave.mat');
plotAllChannel(data(2:5,:));
xlabel('Time (s)');
noise{2} = data(2:5,600000:700000);

load('/Users/shijiapan/Box Sync/Activity_Detection/0407/PortLab_20190407_Route_vacuum_noise.mat');
plotAllChannel(data(2:5,:));
xlabel('Time (s)');
noise{3} = data(2:5,100000:200000);

load('/Users/shijiapan/Box Sync/Activity_Detection/0408/PortLab_20190408_Route_kettle.mat');
plotAllChannel(data(2:5,:));
xlabel('Time (s)');
noise{4} = data(2:5,400000:500000);
figure;
for i = 2:5
    plot([1:length(data(i,100000:end))]./Fs,data(i,100000:end));hold on;
end
hold off;
    
load('/Users/shijiapan/Box Sync/Activity_Detection/0408/PortLab_20190408_Route_fridge.mat');
plotAllChannel(data(2:5,:));
xlabel('Time (s)');
noise{5} = data(2:5,900000:1000000);
noise{6} = data(2:5,300000:400000);


save('noise.mat','noise');

%% freq PCA
% clear 
% close all
% clc
addpath('./stft/');
addpath('/Users/shijiapan/Documents/MATLAB/SASFunctions/');

load('noise.mat');
Fs = 25600;
binWidth = 1;
figure;
for i = 1:6
    [ noise_f{i,1} ] = frequencyFeature( noise{i}(3,:), Fs, 0 );
    [ noise_bin_f{i,1}, noise_bin_v{i,1} ] = frequencyBin( noise_f{i,1}(:,1),noise_f{i,1}(:,2), binWidth );
    plot(noise_bin_f{i,1},noise_bin_v{i,1});hold on;
end
hold off;
xlim([0,1000]);

figure;
for i = 1:6
    [ noise_f{i,2} ] = frequencyFeature( noise{i}(4,:), Fs, 0 );
    [ noise_bin_f{i,2}, noise_bin_v{i,2} ] = frequencyBin( noise_f{i,2}(:,1),noise_f{i,2}(:,2), binWidth );
    subplot(6,1,i);
    plot(noise_bin_f{i,1},noise_bin_v{i,1});hold on;
    plot(noise_bin_f{i,2},noise_bin_v{i,2});hold on;
    xlim([0,1000]);
end
hold off;
xlim([0,1000]);

% for i = 1:6
%     % define analysis parameters
%     wlen = 1024;                        % window length (recomended to be power of 2)
%     hop = wlen/4;                       % hop size (recomended to be power of 2)
%     nfft = 4096;                        % number of fft points (recomended to be power of 2)
%     fs = 25600;
%     % perform STFT
%     win = blackman(wlen, 'periodic');
%     [S, f, t] = stft(noise{i}(1,:), win, hop, nfft, fs);
% 
%     % calculate the coherent amplification of the window
%     C = sum(win)/wlen;
% 
%     % take the amplitude of fft(x) and scale it, so not to be a
%     % function of the length of the window and its coherent amplification
%     S = abs(S)/wlen/C;
% 
%     % correction of the DC & Nyquist component
%     if rem(nfft, 2)                     % odd nfft excludes Nyquist point
%         S(2:end, :) = S(2:end, :).*2;
%     else                                % even nfft includes Nyquist point
%         S(2:end-1, :) = S(2:end-1, :).*2;
%     end
% 
%     % convert amplitude spectrum to dB (min = -120 dB)
%     S = 20*log10(S + 1e-6);
% 
%     % plot the spectrogram
%     figure;
%     surf(t, f, S)
%     shading interp
%     axis tight
%     view(0, 90)
%     set(gca, 'FontName', 'Times New Roman', 'FontSize', 14)
%     xlabel('Time, s')
%     ylabel('Frequency, Hz')
%     ylim([0,500]);
%     title('Amplitude spectrogram of the signal')
% 
%     hcol = colorbar;
%     set(hcol, 'FontName', 'Times New Roman', 'FontSize', 14)
%     ylabel(hcol, 'Magnitude, dB')
% end
