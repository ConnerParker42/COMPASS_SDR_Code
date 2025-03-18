function Clock = clock_read(filename, dataLines)
    % input handling
    
    % if dataLines is not specified, define defaults
    if nargin < 2
        dataLines = [1, Inf];
    end
    
    % set up the import options and import the data
    opts = delimitedTextImportOptions("NumVariables", 28);
    
    % specify range and delimiter
    opts.DataLines = dataLines;
    opts.Delimiter = ",";
    
    % specify column names and types
    opts.VariableNames = ["Var1", "Var2", "Var3", "Var4", "Var5", "Var6", "Var7", "Var8", "Var9", "Var10", "VarName11", "VarName12", "VarName13", "e02", "e01", "Var16", "e1", "e03", "Var19", "Var20", "e3", "Var22", "Var23", "Var24", "Var25", "VarName26", "e4", "Var28"];
    opts.SelectedVariableNames = ["VarName11", "VarName12", "VarName13", "e02", "e01", "e1", "e03", "e3", "VarName26", "e4"];
    opts.VariableTypes = ["string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "double", "double", "double", "double", "double", "string", "double", "double", "string", "string", "double", "string", "string", "string", "string", "double", "double", "string"];
    
    % specify file level properties
    opts.ExtraColumnsRule = "ignore";
    opts.EmptyLineRule = "read";
    
    % specify variable properties
    opts = setvaropts(opts, ["Var1", "Var2", "Var3", "Var4", "Var5", "Var6", "Var7", "Var8", "Var9", "Var10", "Var16", "Var19", "Var20", "Var22", "Var23", "Var24", "Var25", "Var28"], "WhitespaceRule", "preserve");
    opts = setvaropts(opts, ["Var1", "Var2", "Var3", "Var4", "Var5", "Var6", "Var7", "Var8", "Var9", "Var10", "Var16", "Var19", "Var20", "Var22", "Var23", "Var24", "Var25", "Var28"], "EmptyFieldRule", "auto");
    
    % import the data
    Clock = readtable(filename, opts);
    
    Clock.Properties.VariableNames = {'reject_count' 'propagation_time' 'update_time' 'bias' 'bias_rate' 'bias_variance' 'bias_rate_covar' 'rate_variance' 'instant_bias' 'instant_bias_rate'};

end

