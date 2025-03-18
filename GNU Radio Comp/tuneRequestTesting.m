clc; clear; close all;
format long;

%% Analog and Digital Mixing
masterClkRate = 100e6;
numBit = 32;
signalFreq = 10e6;
desireFreq = 73;
centerFreq = signalFreq - desireFreq;
lo_offset = 250e3;
amplitude = 10;

freqPrec = masterClkRate / (2^numBit);

IF = centerFreq + lo_offset;
mixFreq = abs([signalFreq + IF, signalFreq - IF]);

dspFreq_Ideal = IF - centerFreq;
bitNum = round(dspFreq_Ideal / freqPrec);
dspFreq_Real = freqPrec * bitNum;
finalFreq = abs([mixFreq(1) + dspFreq_Real, mixFreq(1) - dspFreq_Real, mixFreq(2) + dspFreq_Real, mixFreq(2) - dspFreq_Real]);
finalFreq(3);

freqOffset = min(finalFreq - desireFreq)

figure()
hold on
title("Analog and Digital Tune Request")
xlim([0, signalFreq+IF+dspFreq_Ideal+desireFreq])
line([signalFreq signalFreq], [0 amplitude], 'Color', 'blue', 'LineWidth', 2)

line([mixFreq(1) mixFreq(1)], [0 amplitude/2], 'Color', 'red', 'LineWidth', 2)
line([mixFreq(2) mixFreq(2)], [0 amplitude/2], 'Color', 'red', 'LineWidth', 2)

line([finalFreq(1) finalFreq(1)], [0 amplitude/4], 'Color', 'gree', 'LineWidth', 2)
line([finalFreq(2) finalFreq(2)], [0 amplitude/4], 'Color', 'gree', 'LineWidth', 2)
line([finalFreq(3) finalFreq(3)], [0 amplitude/4], 'Color', 'gree', 'LineWidth', 2)
line([finalFreq(4) finalFreq(4)], [0 amplitude/4], 'Color', 'gree', 'LineWidth', 2)
legend("Signal Frequency", "","IF Mixing", "DSP Mixing")

%% Digital Only Mixing
masterClkRate = 100e6;
numBit = 32;
signalFreq = 10e6;
desireFreq = 200;
centerFreq = abs(signalFreq - desireFreq);
amplitude = 10;

freqPrec = masterClkRate / (2^numBit);

dspFreq_Ideal = centerFreq;
bitNum = floor(dspFreq_Ideal / freqPrec);
dspFreq_Real = freqPrec * bitNum;
finalFreq = abs([signalFreq + dspFreq_Real, signalFreq - dspFreq_Real]);

freqOffset = min(finalFreq - desireFreq)

figure()
hold on
title("Mixing Stages")
xlim([0, signalFreq+dspFreq_Ideal])
line([signalFreq signalFreq], [0 amplitude], 'Color', 'blue', 'LineWidth', 2)

line([finalFreq(1) finalFreq(1)], [0 amplitude], 'Color', 'gree', 'LineWidth', 2)
line([finalFreq(2) finalFreq(2)], [0 amplitude], 'Color', 'gree', 'LineWidth', 2)
legend("Signal Frequency", "DSP Mixing")