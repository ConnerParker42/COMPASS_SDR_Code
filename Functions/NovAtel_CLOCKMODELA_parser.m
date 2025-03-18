%% NovAtel BESTXYZ Parser
% Updated: Justin Pedersen      - 02/11/2023
%==========================================================================
% Parses clock bias and clock bias rate from an ASC file from a NovAtel 
% receiver output.
%==========================================================================

function clock = NovAtel_CLOCKMODELA_parser(filename)

fileID = fopen(filename);

% check for file
if fileID == -1

    fprintf('Error, file does not exist\n')
    return;

end

% pre-allocate memory
data = importdata(filename);
n = numel(data);
clock = zeros(n,4);

% initiate counter
i = 1;
j = 1;

% feof checks end of file
while ~feof(fileID)

    % grab line from text file
    tline = fgetl(fileID);
    idx = strfind(tline,',');
    % bias & bias rate - index1: 13,index2: 14
    index1 = idx(13);
    index2 = idx(14);
    idx_end = idx(15);
    clock(i,1) = str2double(tline(index1+1:index2-1));
    clock(i,2) = str2double(tline(index2+1:idx_end-1));
    % instant bias & bias rate - index1: 26, index2: 27
    index1 = idx(25);
    index2 = idx(26);
    idx_end = idx(27);
    clock(i,3) = str2double(tline(index1+1:index2-1));
    clock(i,4) = str2double(tline(index2+1:idx_end-1));
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

end