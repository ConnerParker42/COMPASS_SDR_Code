function BestXYZ = bestxyz_read(filename, dataLines)
    % input handling
    
    % if dataLines is not specified, define defaults
    if nargin < 2
        dataLines = [1, Inf];
    end
    
    % set up the import options and import the data
    opts = delimitedTextImportOptions("NumVariables", 38);
    
    % specify range and delimiter
    opts.DataLines = dataLines;
    opts.Delimiter = [",", ";"];
    
    % specify column names and types
    opts.VariableNames = ["Var1", "Var2", "Var3", "Var4", "Var5", "Var6", "Var7", "Var8", "Var9", "Var10", "SOL_COMPUTED", "SINGLE", "VarName13", "VarName14", "VarName15", "VarName16", "VarName17", "VarName18", "SOL_COMPUTED1", "DOPPLER_VELOCITY", "VarName21", "VarName22", "VarName23", "VarName24", "VarName25", "VarName26", "Var27", "Var28", "Var29", "Var30", "Var31", "Var32", "Var33", "Var34", "Var35", "Var36", "Var37", "Var38"];
    opts.SelectedVariableNames = ["SOL_COMPUTED", "SINGLE", "VarName13", "VarName14", "VarName15", "VarName16", "VarName17", "VarName18", "SOL_COMPUTED1", "DOPPLER_VELOCITY", "VarName21", "VarName22", "VarName23", "VarName24", "VarName25", "VarName26"];
    opts.VariableTypes = ["string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "categorical", "categorical", "double", "double", "double", "double", "double", "double", "categorical", "categorical", "double", "double", "double", "double", "double", "double", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "string"];
    
    % specify file level properties
    opts.ExtraColumnsRule = "ignore";
    opts.EmptyLineRule = "read";
    
    % specify variable properties
    opts = setvaropts(opts, ["Var1", "Var2", "Var3", "Var4", "Var5", "Var6", "Var7", "Var8", "Var9", "Var10", "Var27", "Var28", "Var29", "Var30", "Var31", "Var32", "Var33", "Var34", "Var35", "Var36", "Var37", "Var38"], "WhitespaceRule", "preserve");
    opts = setvaropts(opts, ["Var1", "Var2", "Var3", "Var4", "Var5", "Var6", "Var7", "Var8", "Var9", "Var10", "SOL_COMPUTED", "SINGLE", "SOL_COMPUTED1", "DOPPLER_VELOCITY", "Var27", "Var28", "Var29", "Var30", "Var31", "Var32", "Var33", "Var34", "Var35", "Var36", "Var37", "Var38"], "EmptyFieldRule", "auto");
    
    % import the data
    BestXYZ = readtable(filename, opts);
    BestXYZ.Properties.VariableNames = {'P_sol_status' 'pos_type' 'p_x' 'p_y' 'p_z' 'p_x_std' 'p_y_std' 'p_z_std' 'v_sol_stat' 'vel_type' 'v_x' 'v_y' 'v_z' 'v_x_std' 'v_y_std' 'v_z_std'};
end