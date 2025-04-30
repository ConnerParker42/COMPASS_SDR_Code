%--------------------------------------------------------------------------
% File Name:        nco_characterization
% Author:           Conner Parker
% Created:          2025-01
% Last Modified:    2025-04-30
%
% Description:
%   This script processes data from N310 or N210 for NCO characterization testing. 
%
% Notes:
%   Requires Signal Processing Toolbox.
%   Besure to change any variables such that the code finds the correct
%   file and uses the correct testing parameters, sample rates, carrier
%   freq etc.
%   The time interval must be chosen such that the data is when both the TX
%   and RX are working. Usually the RX has a few seconds of data at the
%   beginning where the TX is not on.
%   
%
% Dependencies:
%   - IQDataParser.m
%   - N310_Plotter.m
%   - N200_ClockPlotter.m
%   - N200_ClockPlotter_SingleInput.m
%   - PhaseNCO_N210_Plotter.m
%   - PhaseNCO_N310_Plotter.m
%   - OADParser_N200.m
%   - OADParser_singleInput.m
%   - OADPlotter.m
%
%--------------------------------------------------------------------------

% Housekeeping
clc; clear; close all;

% Change depending on test
sampleRateIQ = 120e3 / (30 * 10);
signalFreq = 10e6; % Hz
beatFreq = 73; % Hz
NCO_sampleRate = 200e3; % Hz

% Time interval where data is valid
timeInt = [1.44 300]; % sec

% Paths to read and write data
readPath = 'C:\Users\cpark\COMPASS Research\N210 NCO Characterization\N310_NCO_sawtooth_basic';
savePath = '../Figures';
funcPath = '../Functions';
cmdPhasePath = "C:\Users\cpark\COMPASS Research\N210 NCO Characterization\Phase Offsets\DopPhase_sawtooth.bin";
currDirec = pwd;
addpath(readPath,funcPath)

filesInRead = dir(readPath);
filesInRead = extractfield(filesInRead,"name");

%% Data Processing
tic

fprintf('Starting IQ Data Processing\n')
IQFiles = filesInRead(contains(filesInRead, "complex_data"));
parsedIQData = IQDataParser(IQFiles, readPath, sampleRateIQ, signalFreq, beatFreq);
N310_Plotter(parsedIQData, signalFreq)
% N200_ClockPlotter(parsedIQData, signalFreq)
% N200_ClockPlotter_SingleInput(parsedIQData, signalFreq)
% PhaseNCO_N210_Plotter(parsedIQData, cmdPhasePath, NCO_sampleRate, signalFreq, timeInt)
PhaseNCO_N310_Plotter(parsedIQData, cmdPhasePath, NCO_sampleRate, signalFreq, timeInt)

% fprintf('Starting ADEV Data Processing\n')
% OADData = OADParser_N200(parsedIQData, sampleRateIQ);
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