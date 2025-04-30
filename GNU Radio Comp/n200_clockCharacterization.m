%--------------------------------------------------------------------------
% File Name:        n200_clockCharacterization
% Author:           Conner Parker
% Created:          2024-11-28
% Last Modified:    2025-04-30
%
% Description:
%   This script processes a raw IQ signal from N200 with the optional code
%   to run unwrapped phase parsing
%
% Notes:
%   Requires Signal Processing Toolbox.
%   Besure to change any variables such that the code finds the correct
%   file and uses the correct testing parameters, sample rates, carrier
%   freq etc.
%   Logic to handle both single and dual input plotting. Uncomment the
%   plotter corresponding to the test setup
%
% Dependencies:
%   - IQDataParser.m
%   - N200_ClockPlotter.m
%   - N200_ClockPlotter_SingleInput.m
%   - UnwrappedPhaseParser.m
%   - OADParser_N200.m
%   - OADPlotter.m
%
%--------------------------------------------------------------------------

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
% Uncomment correct plotting
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