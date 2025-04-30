%--------------------------------------------------------------------------
% File Name:        n310_ensemble_estimates
% Author:           Conner Parker
% Created:          2023-10-28
% Last Modified:    2025-04-30
%
% Description:
%   This script processes data from the N310 assuming the gnu script had
%   the embedded clock ensemble Kalman Filter.
%
% Notes:
%   Requires Signal Processing Toolbox.
%   Besure to change any variables such that the code finds the correct
%   file and uses the correct testing parameters, sample rates, carrier
%   freq etc.
%   CSAC telemetry data is also plotted if available, uncomment csac
%   plotting section to plot
%
% Dependencies:
%   - unwrappedPhaseParser.m
%   - phaseDifferencePlotter.m
%   - phaseEstPlotter.m
%   - freqEstParser.m
%   - TelemParser.m
%   - TelemPlotter.m
%
%--------------------------------------------------------------------------


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
