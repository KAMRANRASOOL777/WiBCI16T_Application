function quickViewExperimentAFile(filePath)

FS                      = 250;
firHBFil                = fir1(256, [2 26]./(FS/2));
firAlphaFil             = fir1(256, [8 12]./(FS/2));

[EEG, DataTable]          = loadExperimentAFile(filePath);

hbSignal                = filtfilt(firHBFil, 1, DataTable.Left_arm - DataTable.Right_arm);
alphaSignal             = filtfilt(firAlphaFil, 1, DataTable.Cz);
eventSignal             = DataTable.("Event A");
eventSignal(eventSignal < 100) = NaN;
eventSignal             = eventSignal./100 .* max(alphaSignal);

 hbSignalX              = xcorr(hbSignal, 1000);
[~, hbSignalPerd]       = findpeaks(hbSignalX(1001:end), 'NPeaks', 1, 'SortStr', 'descend');

subplot(2, 3, [1 2 3]); plot((1:length(alphaSignal))./FS, alphaSignal);
hold on;
stem((1:length(alphaSignal))./FS, eventSignal, 'kx')
xlabel('Time (s)');
ylabel('Amplitude (uV)');
subtitle('Alpha Band of Cz');
box off;
legend('Signal', 'Trigger', 'Box', 'Off');
hold off;

subplot(2,3,[4 5]); plot((1:length(hbSignal))./FS, hbSignal);
xlabel('Time (s)');
ylabel('Amplitude (uV)');
subtitle('Left_{arm} - Right_{arm}');
box off;

subplot(2,3,6);plot(hbSignal(100:100+2*hbSignalPerd))
xticks([]);
yticks([]);
xticklabels([]);
yticklabels([]);
subtitle('Left_{arm} - Right_{arm}');
box off;

EEGOUT = pop_eegfilt( EEG, 4, 40);
pop_eegplot(EEGOUT, 1, 0, 1);
end