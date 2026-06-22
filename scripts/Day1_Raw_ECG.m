data = readtable('ecg100.csv');

ecg = data.ECG;

figure
plot(ecg)

title('Raw ECG Signal')
xlabel('Samples')
ylabel('Amplitude (mV)')
grid on

figure
plot(ecg(1:2000))
title('First 2000 Samples')
grid on
xlabel('Samples')
ylabel('Amplitude (mV)')