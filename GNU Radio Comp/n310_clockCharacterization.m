%--------------------------------------------------------------------------
% File Name:        n310_clockCharacterization
% Author:           Conner Parker
% Created:          2024-01-28
% Last Modified:    2025-04-30
%
% Description:
%   This script processes a raw IQ signal from N310 with the optional code
%   to run unwrapped phase parsing
%
% Notes:
%   Requires Signal Processing Toolbox.
%   Besure to change any variables such that the code finds the correct
%   file and uses the correct testing parameters, sample rates, carrier
%   freq etc.
%
% Dependencies:
%   - IQDataParser.m
%   - N310_Plotter.m
%   - UnwrappedPhaseParser.m
%   - OADParser_N310.m
%   - OADPlotter.m
%
%--------------------------------------------------------------------------


% Housekeeping
clc; clear; close all;

% Change depending on test
sampleRateIQ = 120000 / (30 * 10);
sampleRate = 120000 / (30 * 10 * 50);
signalFreq = 10e6;

% Paths to read and write data
readPath = 'C:\Users\cpark\COMPASS Research\N310 Noise Characterization\N310_Noise_mRO_TXRX_tune';
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