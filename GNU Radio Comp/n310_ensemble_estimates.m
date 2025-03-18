% Housekeeping
clc; clear; close all;

% Change depending on test
sampleRate = 120000 / (30 * 10 * 50);
signalFreq = 10e6;

% Paths to read and write data
readPath = 'C:\Users\cpark\COMPASS Research\EnsembleFreqJumpsData\EnsembleErrors\DoubleEnsembleFreqAdjustFreqJump';
funcPath = '..\Functions';
addpath(readPath)
addpath(funcPath)
epoch = datetime(2024,3,1,10,41,00,"TimeZone","America/Denver");

filesInRead = dir(readPath);
filesInRead = extractfield(filesInRead,"name");

%% Unwrapped Phases
filesToRead = filesInRead(contains(filesInRead, "unwrapped"));
parsedDataPhase = unwrappedPhaseParser(filesToRead,readPath,sampleRate,signalFreq);
phaseDifferencePlotter(parsedDataPhase, epoch)

%% Phase Estimates
filesToRead = filesInRead(contains(filesInRead, "bias"));
parsedDataEst = unwrappedPhaseParser(filesToRead,readPath,sampleRate,signalFreq);
phaseEstPlotter(parsedDataEst, epoch)

%% Frequency Estimates
filesToRead = filesInRead(contains(filesInRead, "freq"));
parsedDataFreq = freqEstParser(filesToRead, readPath, sampleRate);
freqEstPlotter(parsedDataFreq, epoch)

%% CSAC Telemetry
% filesToRead = filesInRead(contains(filesInRead, "csac") & contains(filesInRead, "csv"));
% parsedDataTelem = TelemParser(filesToRead, readPath);
% TelemPlotter(parsedDataTelem, epoch)
