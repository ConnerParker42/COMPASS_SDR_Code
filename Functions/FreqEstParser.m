function [parsedData] = FreqEstParser(filesToRead, readPath, sampleRate)
% FreqEstParser: Parses estimated frequency data from GNU Radio Companion binary
%   files
%   Inputs: filesToRead = array of files to parse data from
%       readPath = file path to folder with files to read
%       sampleRate = sample rate of samples in files
%   Outputs: parsedData = cell array of tables with time and frequency
%   Plots: N/A

    addpath(readPath)
    parsedData = cell(0);
    for i=(1:length(filesToRead))    
        % First file from GNU (int or decimal)
        fileID = fopen(filesToRead{i}, 'rb');
        freq = fread(fileID, Inf, 'float');
        
        % Build time vector based on sample size and sample rate
        t = (0:length(freq)-1)' ./ sampleRate;
        
        % Build table and store it
        dataTable = table(t, freq, 'VariableNames', ["Time", "Frequency [Hz]"] );
        parsedData{end+1} = dataTable;
    end
end

