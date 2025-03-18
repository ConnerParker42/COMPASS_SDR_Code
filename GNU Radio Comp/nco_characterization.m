% Housekeeping
clc; clear; close all;

% Change depending on test
sampleRateIQ = 500e3 / (50 * 10);
signalFreq = 100e6; % Hz
beatFreq = 73; % Hz
NCO_sampleRate = 200e3; % Hz

% Time interval where data is valid
timeInt = [2.919 440]; % sec

% Paths to read and write data
readPath = 'C:\Users\cpark\COMPASS Research\N210 NCO Characterization\N210_NCO_Noise';
savePath = '../Figures';
funcPath = '../Functions';
cmdPhasePath = "C:\Users\cpark\COMPASS Research\COMPASSLabCode\Doppler_Shift_NCO\DopPhase_Zero.bin";
currDirec = pwd;
addpath(readPath,funcPath)

filesInRead = dir(readPath);
filesInRead = extractfield(filesInRead,"name");

%% Data Processing
tic

fprintf('Starting IQ Data Processing\n')
IQFiles = filesInRead(contains(filesInRead, "complex_data"));
parsedIQData = IQDataParser(IQFiles, readPath, sampleRateIQ, signalFreq, beatFreq);
% N200_ClockPlotter(parsedIQData, signalFreq)
N200_ClockPlotter_SingleInput(parsedIQData, signalFreq)
PhaseNCO_N210_Plotter(parsedIQData, cmdPhasePath, NCO_sampleRate, signalFreq, timeInt)

% fprintf('Starting ADEV Data Processing\n')
% % OADData = OADParser_N200(parsedIQData, sampleRateIQ);
% OADData = OADParser_singleInput(parsedIQData, sampleRateIQ);
% OADPlotter(OADData)

% fprintf('Starting Unwrapped Phase Data Processing\n')
% unwrapPhaseFiles = filesInRead(contains(filesInRead, "unwrapped_phase"));
% parsedDataPhase = UnwrappedPhaseParser(unwrapPhaseFiles,readPath,sampleRate,signalFreq);
% N200_ClockPlotter(parsedDataPhase, signalFreq)
% 
% fprintf('Starting ADEV Data Processing\n')
% OADData = OADParser_N200(parsedDataPhase, sampleRate);
% OADPlotter(OADData)

toc