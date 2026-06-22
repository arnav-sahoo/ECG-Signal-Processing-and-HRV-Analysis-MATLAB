clear
clc
close all

load('ProcessedSignals.mat')

ecg = ecg_Filtered;
Fs = 360;

figure
plot(ecg(1:2000))
title('Filtered ECG Signal - First 2000 Samples')
xlabel('Samples')
ylabel('Amplitude')
grid on

%The actual Advanced Analysis Part%
[pks,locs] = findpeaks(ecg,'MinPeakHeight',0.8,...
'MinPeakDistance',200);

figure
plot(ecg(1:2000))
hold on

idx=locs(locs<=2000);
pk_subset=pks(1:length(idx));

plot(idx,pk_subset,'rv')
title('Detected R Peaks')
xlabel('Samples')
ylabel('Amplitude')
grid on

peaktimes=locs/Fs;
RR=diff(peaktimes);
RR(1:10)

meanRR=mean(RR);
HR=60/meanRR;
fprintf('Average Heart Rate = %.2f BPM\n',HR)

SDNN=std(RR);
fprintf('SDNN is %.4f seconds\n',SDNN)

RMSSD=sqrt(mean(diff(RR).^2));
fprintf('RMSSD is %.4f seconds\n', RMSSD)

%Now the HRV Plot%
figure
plot(RR)

title('RR Interval Tachogram')
xlabel('Beat Number')
ylabel('RR Interval(secs)')
grid on

%Final Histogram Plot of RR%
figure
histogram(RR,20)

title('Distribution of RR Intervals')
xlabel('RR Interval(secs)')
ylabel('Frequency')
grid on