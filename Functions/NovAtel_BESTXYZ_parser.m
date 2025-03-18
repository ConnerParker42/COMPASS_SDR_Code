%% NovAtel BESTXYZ Parser
% Updated: Justin Pedersen      - 03/07/2023
%==========================================================================
% Parses XYZ from an ASC file from a NovAtel receiver output.
%==========================================================================

function xyz = NovAtel_BESTXYZ_parser(filename)

fileID = fopen(filename);

% check for file
if fileID == -1

    fprintf('Error, file does not exist\n')
    return;

end

% pre-allocate memory
data = importdata(filename);
n = numel(data);
xyz = zeros(n,3);

% initiate counter
i = 1;
j = 1;

% feof checks end of file
while ~feof(fileID)

    % grab line from text file
    tline = fgetl(fileID);
    idx = strfind(tline,',');
    % x+ 11, y+ 12, z+ 13
    xstart = idx(11);
    ystart = idx(12);
    zstart = idx(13);
    idx_end = idx(14);
    xyz(i,1) = str2double(tline(xstart+1:ystart-1));
    xyz(i,2) = str2double(tline(ystart+1:zstart-1));
    xyz(i,3) = str2double(tline(zstart+1:idx_end-1));
    % increment
    i = i + 1;

    % loading indicator
    load_criteria = rem(i,1000);
    if load_criteria == 0
        load_criteria2 = rem(j,50);
        if load_criteria2 == 0
            fprintf('\n.')
        else
            fprintf('.')
        end
        j = j + 1;
    end

end

% close
fclose(fileID);

end