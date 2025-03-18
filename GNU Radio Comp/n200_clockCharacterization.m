% Housekeeping
clc; clear; close all;

% Change depending on test
sampleRateIQ = 500e3 / (50 * 10);
signalFreq = 100e6; % Hz
beatFreq = 73; % Hz

% Paths to read and write data
readPath = 'C:\Users\cpark\COMPASS Research\N210 NCO Characterization\N210_ChipMRO_Character';
savePath = '../Figures';
funcPath = '../Functions';
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

fprintf('Starting ADEV Data Processing\n')
% OADData = OADParser_N200(parsedIQData, sampleRateIQ);
OADData = OADParser_singleInput(parsedIQData, sampleRateIQ);
OADPlotter(OADData)

% fprintf('Starting Unwrapped Phase Data Processing\n')
% unwrapPhaseFiles = filesInRead(contains(filesInRead, "unwrapped_phase"));
% parsedDataPhase = UnwrappedPhaseParser(unwrapPhaseFiles,readPath,sampleRate,signalFreq);
% N200_ClockPlotter(parsedDataPhase, signalFreq)
% 
% fprintf('Starting ADEV Data Processing\n')
% OADData = OADParser_N200(parsedDataPhase, sampleRate);
% OADPlotter(OADData)

toc