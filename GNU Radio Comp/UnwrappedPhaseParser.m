function [parsedData] = UnwrappedPhaseParser(filesToRead, readPath, sampleRate, signalFreq)
% UnwrappedPhaseParser: Parses unwrapped phase data from GNU Radio Companion binary
% files
%   Inputs: filesToRead = array of files to parse data from
%       readPath = file path to folder with files to read
%       sampleRate = sample rate of samples in files
%       signalFreq = frequency of received signal
%   Outputs: parsedData = cell array of tables with time and phase in
%       radians and seconds
%   Plots: N/A

    addpath(readPath)
    parsedData = cell(0);
    for i=(1:2:length(filesToRead))    
        % First file (int or decimal)
        fileID = fopen(filesToRead{i}, 'rb');
        phaseRad0 = fread(fileID, Inf, 'float');
        
        % Second file (int or decimal)
        fileID = fopen(filesToRead{i+1}, 'rb');
        phaseRad1 = fread(fileID, Inf, 'float');
        
        % Get data of same size
        len = min(length(phaseRad0), length(phaseRad1));

        % Add together to get actual phase
        phase = phaseRad0(1:len) + phaseRad1(1:len);
        
        % Build time vector based on sample size and sample rate
        t = (0:length(phase)-1)' ./ sampleRate;
        
        % Convert phase from radians to seconds
        phaseSec = phase  ./ (2 * pi * signalFreq);
        
        % Build table and store it
        dataTable = table(t, phase, phaseSec, 'VariableNames', ["Time", "Phase [rad]", "Phase [s]"] );
        parsedData{end+1} = dataTable;
    end
end

