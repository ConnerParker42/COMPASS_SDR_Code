function [output] = USRPrx_phaseComp(filename1,filename2,param)
% Author: Justin Pedersen
% Date: 07/12/22
% Description: conducts a phase comparison of two input clocks

%% Main Function Process

% extract radio processing parameters
dec = param(1);
samp_rate = param(2);
f_beat = param(3);
f_clck = param(4);

% extract interleaved complex signal data
rawData_RF1 = readBinData(filename1);
rawData_RF2 = readBinData(filename2);

% equate arrays
[rawData_RF1,rawData_RF2] = equateArray2(rawData_RF1,rawData_RF2);

% convert interleaved to planar data [I,Q]
[complex_RF1(:,1),complex_RF1(:,2)] = ILtoPL(rawData_RF1);
[complex_RF2(:,1),complex_RF2(:,2)] = ILtoPL(rawData_RF2);

% compute phase argument (radians) and unwrap
phi_RF1_meas = unwrap(atan2(complex_RF1(:,2),complex_RF1(:,1)));
phi_RF2_meas = unwrap(atan2(complex_RF2(:,2),complex_RF2(:,1)));

% remove initial 10 data points (possibly errant)
phi_RF1_meas(1:100) = [];
phi_RF2_meas(1:100) = [];

% TEMP CODE
% remove last 10% of data
last10 = round(0.99*numel(phi_RF1_meas));
phi_RF1_meas(last10:end) = [];
phi_RF2_meas(last10:end) = [];

% compute time array
time = elapTime(samp_rate/dec,numel(phi_RF1_meas));

% remove 73 Hz from measured phase
phi_RF1 = phi_RF1_meas - (2*pi*f_beat.*time);
phi_RF2 = phi_RF2_meas - (2*pi*f_beat.*time);

% convert phase argument to units of time (seconds)
phiT_RF1 = phi_RF1./(2*pi*f_clck);
phiT_RF2 = phi_RF2./(2*pi*f_clck);

% compute delta of RF1 and RF2
delta = phiT_RF2 - phiT_RF1;

% detrend delta
delta_detrend = detrend(delta);

% ADEV (Allan Deviation)
decArray = round((1:samp_rate/dec:numel(delta))');
ADEV_time = (1:1:length(decArray))';
ADEV_points = 1000;
minTau = 1;
maxTau = numel(ADEV_time)/3;

% compute Allen Deviation
[OAD,tau] = OAD_maxminTau(delta(decArray),ADEV_points,minTau,maxTau);

% compile data into matrix for output
output(1).data = time;
output(2).data = phi_RF1_meas;
output(3).data = phi_RF2_meas;
output(4).data = phi_RF1;
output(5).data = phi_RF2;
output(6).data = phiT_RF1;
output(7).data = phiT_RF2;
output(8).data = delta;
output(9).data = delta_detrend;
output(10).data = OAD;
output(11).data = tau;

%% Functions

% READ BIN DATA FUNCTION
function rawData = readBinData(filename)

f = fopen(filename, 'rb');
rawData = fread(f, Inf, 'float32');

end

% INTERLEAVED TO PLANAR FUNCTION
function [A,B] = ILtoPL(input)

A = input(1:2:end);
B = input(2:2:end);

end

% ELAPSED TIME FUNCTION
function time = elapTime(freq,samples)

samp_array = (0:samples-1)';
time = samp_array*(1/freq);

end

end