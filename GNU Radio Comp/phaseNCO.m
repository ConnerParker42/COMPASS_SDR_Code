%--------------------------------------------------------------------------
% File Name:        nco_characterization
% Author:           Conner Parker
% Created:          2025-01
% Last Modified:    2025-04-30
%
% Description:
%   This script is very old, it is not useful but will remain in case it it
%   required.
%   Does the same thing as nco_characterization but the function calls may
%   not have correct parameters
%
%--------------------------------------------------------------------------

% Housekeeping
clc; clear; close all;

% Change depending on test
sampleRate = 120000 / (30 * 10 * 50);
signalFreq = 10e6;

% Paths to read and write data
readPath = 'C:\Users\cpark\COMPASS Research\N210 NCO Characterization\N210_NCO_Const';
funcPath = '..\Functions';
addpath(readPath)
addpath(funcPath)
epoch = datetime(2024,3,1,10,41,00,"TimeZone","America/Denver");

filesInRead = dir(readPath);
filesInRead = extractfield(filesInRead,"name");

%% Unwrapped Phases
filesToRead = filesInRead(contains(filesInRead, "unwrapped"));
parsedDataPhase = unwrappedPhaseParser(filesToRead,readPath,sampleRate,signalFreq);
phaseNCO_Plotter(parsedDataPhase, "C:\Users\cpark\COMPASS Research\COMPASSLabCode\Doppler_Shift_NCO\DopPhase_Const.bin")