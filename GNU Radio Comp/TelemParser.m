function [parsedData] = TelemParser(filesToRead, readPath)
% TelemParser: Parses telemetry data from files
%   Inputs: filesToRead = array of files to parse data from
%       readPath = file path to folder with files to read
%   Outputs: parsedData = cell array of tables with time and telemetry data
%   Plots: N/A

    addpath(readPath)
    parsedData = cell(1,length(filesToRead));
    for i=(1:length(filesToRead))    
        
        opts=detectImportOptions(filesToRead{i});
        opts.VariableNamesLine = 1;
        opts.Delimiter =',';
        dataTable = readtable(filesToRead{i},opts, 'ReadVariableNames', true);
        
        parsedData{i} = dataTable;
    end
end

