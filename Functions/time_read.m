function Time = time_read(filename, dataLines)

    % input handling
    
    % if dataLines is not specified, define defaults
    if nargin < 2
        dataLines = [1, Inf];
    end
    
    % set up the import options and import the data
    opts = delimitedTextImportOptions("NumVariables", 20);
    
    % specify range and delimiter
    opts.DataLines = dataLines;
    opts.Delimiter = ",";
    
    % specify column names and types
    opts.VariableNames = ["Var1", "Var2", "Var3", "Var4", "Var5", "Var6", "Var7", "Var8", "Var9", "Var10", "VarName11", "e09", "VarName13", "VarName14", "VarName15", "VarName16", "VarName17", "VarName18", "VarName19", "Var20"];
    opts.SelectedVariableNames = ["VarName11", "e09", "VarName13", "VarName14", "VarName15", "VarName16", "VarName17", "VarName18", "VarName19"];
    opts.VariableTypes = ["string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "double", "double", "double", "double", "double", "double", "double", "double", "double", "string"];
    
    % specify file level properties
    opts.ExtraColumnsRule = "ignore";
    opts.EmptyLineRule = "read";
    
    % specify variable properties
    opts = setvaropts(opts, ["Var1", "Var2", "Var3", "Var4", "Var5", "Var6", "Var7", "Var8", "Var9", "Var10", "Var20"], "WhitespaceRule", "preserve");
    opts = setvaropts(opts, ["Var1", "Var2", "Var3", "Var4", "Var5", "Var6", "Var7", "Var8", "Var9", "Var10", "Var20"], "EmptyFieldRule", "auto");
    
    % import the data
    Time = readtable(filename, opts);
    Time.Properties.VariableNames = {'offset' 'offset_std' 'utc_offset' 'utc_year' 'utc_month' 'utc_day' 'utc_hour' 'utc_min' 'utc_ms'};
end