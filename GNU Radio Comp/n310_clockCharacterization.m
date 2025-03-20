% Housekeeping
clc; clear; close all;

% Change depending on test
sampleRateIQ = 120000 / (30 * 10);
sampleRate = 120000 / (30 * 10 * 50);
signalFreq = 10e6;

% Paths to read and write data
readPath = '/home/copa5633/COMPASS_Research/GNU_Data';
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
parsedIQData = IQDataParser(IQFiles, readPath, sampleRateIQ, signalFreq, 73);
N310_Plotter(parsedIQData, signalFreq)

fprintf('Starting ADEV Data Processing\n')
OADData = OADParser_N310(parsedIQData, sampleRateIQ);
OADPlotter(OADData)

% fprintf('Starting Unwrapped Phase Data Processing\n')
% unwrapPhaseFiles = filesInRead(contains(filesInRead, "unwrapped_phase"));
% parsedDataPhase = UnwrappedPhaseParser(unwrapPhaseFiles,readPath,sampleRate,signalFreq);
% N310_Plotter(parsedDataPhase, signalFreq)

% fprintf('Starting ADEV Data Processing\n')
% OADData = OADParser_N310(parsedDataPhase, sampleRate);
% OADPlotter(OADData)

toc