function ClockSteer = clocksteer_read(filename, dataLines)
    % input handling
    
    % if dataLines is not specified, define defaults
    if nargin < 2
        dataLines = [1, Inf];
    end
    
    % set up the import options and import the data
    opts = delimitedTextImportOptions("NumVariables", 17);
    
    % specify range and delimiter
    opts = delimitedTextImportOptions("NumVariables", 19);
    
    % specify range and delimiter
    opts.DataLines = dataLines;
    opts.Delimiter = ["*", ",", ";"];
    
    % specify column names and types
    opts.VariableNames = ["Var1", "Var2", "Var3", "Var4", "Var5", "Var6", "Var7", "Var8", "Var9", "Var10", "EXTERNAL", "SECOND_ORDER", "VarName13", "VarName14", "VarName15", "VarName16", "VarName17", "VarName18", "Var19"];
    opts.SelectedVariableNames = ["EXTERNAL", "SECOND_ORDER", "VarName13", "VarName14", "VarName15", "VarName16", "VarName17", "VarName18"];
    opts.VariableTypes = ["string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "categorical", "categorical", "double", "double", "double", "double", "double", "double", "string"];
    
    % specify file level properties
    opts.ExtraColumnsRule = "ignore";
    opts.EmptyLineRule = "read";
    
    % specify variable properties
    opts = setvaropts(opts, ["Var1", "Var2", "Var3", "Var4", "Var5", "Var6", "Var7", "Var8", "Var9", "Var10", "Var19"], "WhitespaceRule", "preserve");
    opts = setvaropts(opts, ["Var1", "Var2", "Var3", "Var4", "Var5", "Var6", "Var7", "Var8", "Var9", "Var10", "EXTERNAL", "SECOND_ORDER", "Var19"], "EmptyFieldRule", "auto");
    
    % import the data
    ClockSteer = readtable(filename, opts);
    ClockSteer.Properties.VariableNames = {'source' 'steering_state' 'period' 'pulse_width' 'bandwidth' 'slope' 'offset' 'drift_rate'};
end    