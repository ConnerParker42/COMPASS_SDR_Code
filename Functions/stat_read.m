function RXStat = stat_read(filename, dataLines)
    % input handling
    
    % if dataLines is not specified, define defaults
    if nargin < 2
        dataLines = [1, Inf];
    end
    
    % set up the import options and import the data
    opts = delimitedTextImportOptions("NumVariables", 31);
    
    % specify range and delimiter
    opts.DataLines = dataLines;
    opts.Delimiter = ",";
    
    % specify column names and types
    opts.VariableNames = ["Var1", "Var2", "Var3", "Var4", "Var5", "Var6", "Var7", "Var8", "Var9", "VarName10", "Var11", "Var12", "Var13", "Var14", "Var15", "Var16", "Var17", "Var18", "Var19", "Var20", "Var21", "Var22", "Var23", "Var24", "Var25", "Var26", "Var27", "Var28", "Var29", "Var30", "Var31"];
    opts.SelectedVariableNames = "VarName10";
    opts.VariableTypes = ["string", "string", "string", "string", "string", "string", "string", "string", "string", "categorical", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string"];
    
    % specify file level properties
    opts.ExtraColumnsRule = "ignore";
    opts.EmptyLineRule = "read";
    
    % specify variable properties
    opts = setvaropts(opts, ["Var1", "Var2", "Var3", "Var4", "Var5", "Var6", "Var7", "Var8", "Var9", "Var11", "Var12", "Var13", "Var14", "Var15", "Var16", "Var17", "Var18", "Var19", "Var20", "Var21", "Var22", "Var23", "Var24", "Var25", "Var26", "Var27", "Var28", "Var29", "Var30", "Var31"], "WhitespaceRule", "preserve");
    opts = setvaropts(opts, ["Var1", "Var2", "Var3", "Var4", "Var5", "Var6", "Var7", "Var8", "Var9", "VarName10", "Var11", "Var12", "Var13", "Var14", "Var15", "Var16", "Var17", "Var18", "Var19", "Var20", "Var21", "Var22", "Var23", "Var24", "Var25", "Var26", "Var27", "Var28", "Var29", "Var30", "Var31"], "EmptyFieldRule", "auto");
    
    % import the data
    RXStat = readtable(filename, opts);
    RXStat.Properties.VariableNames = {'error'};
end