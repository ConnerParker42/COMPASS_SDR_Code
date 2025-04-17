function [parsedDataOAD] = OADParser_singleInput(parsedDataPhase, sampleRate)
% OADParser_singleInput: Computes OAD from parsed data assuming an external
%   reference clock
%   Inputs: parsedDataPhase = cell array from PhaseParser function
%       sampleRate = sample rate of samples in files
%   Outputs: parsedDataOAD = cell array of ADEV values with Tau and OAD
%   Plots: N/A

    parsedDataOAD = cell(0);
    phase = parsedDataPhase{1}.("Phase [s]");

    %% OAD Computing
    minTau = 1;
    maxTau = length(phase)/sampleRate / 3;
    numberTaus = 1000;
    [OAD,Tau] = OAD_maxminTau(detrend(phase(1:sampleRate:end)),numberTaus, minTau,maxTau);
    dataTable = table(Tau, OAD, 'VariableNames', ["Tau", "OAD"] );
    parsedDataOAD{end+1} = dataTable;    
end

