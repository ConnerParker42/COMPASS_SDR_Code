function [parsedDataOAD] = OADParser_N310(parsedDataPhase, sampleRate)
% OADParser_singleInput: Computes OAD from parsed data assuming internal
%   reference clock on the N310
%   Inputs: parsedDataPhase = cell array from PhaseParser function
%       sampleRate = sample rate of samples in files
%   Outputs: parsedDataOAD = cell array of ADEV values with Tau and OAD
%   Plots: N/A
    
    parsedDataOAD = cell(0);
    % for i = 1:2:length(parsedDataPhase)
        phase1 = parsedDataPhase{1}.("Phase [s]");
        phase2 = parsedDataPhase{2}.("Phase [s]");
        phase3 = parsedDataPhase{3}.("Phase [s]");
        phase4 = parsedDataPhase{4}.("Phase [s]");

        len = min([length(phase1), length(phase2), length(phase3), length(phase4)]);
        phase1 = phase1(1:len);
        phase2 = phase2(1:len);
        phase3 = phase3(1:len);
        phase4 = phase4(1:len);

        phaseDiff1 = phase1 - phase2;
        phaseDiff2 = phase3 - phase4;

        %% OAD Computing
        minTau = 1;
        maxTau = length(phaseDiff1)/sampleRate / 3;
        numberTaus = 1000;
        [OAD,Tau] = OAD_maxminTau(detrend(phaseDiff1),numberTaus, minTau,maxTau);
        dataTable = table(Tau, OAD, 'VariableNames', ["Tau", "OAD"] );
        parsedDataOAD{end+1} = dataTable;

        [OAD,Tau] = OAD_maxminTau(detrend(phaseDiff2),numberTaus, minTau,maxTau);
        dataTable = table(Tau, OAD, 'VariableNames', ["Tau", "OAD"] );
        parsedDataOAD{end+1} = dataTable;
    % end
    
end

