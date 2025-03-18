function BestPos = bestpos_read(filename, dataLines)
    % set up the import options and import the data
    opts = delimitedTextImportOptions("NumVariables", 31);
    
    % specify range and delimiter
    opts.DataLines = dataLines;
    opts.Delimiter = [",", ";"];
    
    % specify column names and types
    opts.VariableNames = ["Var1", "Var2", "Var3", "Var4", "Var5", "Var6", "Var7", "Var8", "Var9", "Var10", "SOL_COMPUTED", "SINGLE", "VarName13", "VarName14", "VarName15", "VarName16", "WGS84", "VarName18", "VarName19", "VarName20", "Var21", "VarName22", "VarName23", "VarName24", "VarName25", "VarName26", "VarName27", "Var28", "Var29", "Var30", "Var31"];
    opts.SelectedVariableNames = ["SOL_COMPUTED", "SINGLE", "VarName13", "VarName14", "VarName15", "VarName16", "WGS84", "VarName18", "VarName19", "VarName20", "VarName22", "VarName23", "VarName24", "VarName25", "VarName26", "VarName27"];
    opts.VariableTypes = ["string", "string", "string", "string", "string", "string", "string", "string", "string", "string", "categorical", "categorical", "double", "double", "double", "double", "double", "double", "double", "double", "string", "double", "double", "double", "double", "double", "double", "string", "string", "string", "string"];
    
    % specify file level properties
    opts.ExtraColumnsRule = "ignore";
    opts.EmptyLineRule = "read";
    
    % specify variable properties
    opts = setvaropts(opts, ["Var1", "Var2", "Var3", "Var4", "Var5", "Var6", "Var7", "Var8", "Var9", "Var10", "Var21", "Var28", "Var29", "Var30", "Var31"], "WhitespaceRule", "preserve");
    opts = setvaropts(opts, ["Var1", "Var2", "Var3", "Var4", "Var5", "Var6", "Var7", "Var8", "Var9", "Var10", "SOL_COMPUTED", "SINGLE", "Var21", "Var28", "Var29", "Var30", "Var31"], "EmptyFieldRule", "auto");
    opts = setvaropts(opts, "WGS84", "TrimNonNumeric", true);
    opts = setvaropts(opts, "WGS84", "ThousandsSeparator", ",");
    
    % import the data
    BestPos = readtable(filename, opts);
    BestPos.Properties.VariableNames = {'sol_stat','pos_type','lat_deg','lon_deg','hgt_m','undulation','datum_id','std_lat_m','std_lon_m','std_h_m','diff_age','sol_age','SVs_visible','SVs_Soln','SVs_L1','SVs_Multi_Soln'};

end