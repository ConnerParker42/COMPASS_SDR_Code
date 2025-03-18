%% RINEX OBS 3.04 Parser NovAtel
% Updated: Justin Pedersen      - 02/27/2023
%==========================================================================
% Parses satellite count (all sats) from Rinex OBS 3.04 file. This function
% reads a RINEX file from a NovAtel receiver and outputs satellite count
% and C/NO values (L1&L2) for each satellite at each time stamp
%==========================================================================

function [satCount,L1_CNO,L2_CNO,time] = RINEXOBS304_NovAtel(filename)

fileID = fopen(filename);

% check for file
if fileID == -1

    fprintf('Error, file does not exist\n')
    return;

end

%% Skip Header

% flag header
flag = 0;

while flag == 0

    tline = fgetl(fileID);

    if contains(tline,'END OF HEADER')

        flag = 1;

    end

end

%% Read Blocks

% pre-allocate array count
i = 0;
% pre-allocate satellite count
n = 0;
% pre-allocate PRN array

% feof checks end of file
while true

    tline = fgetl(fileID);

    % check if end of file
    if tline == -1

        % save last satellite count
        satCount(i,1) = n;
        % break loop
        break

    end

    % check for block header
    if contains(tline,'>')
        
        clc
        fprintf(tline)
        fprintf('\n')

        if i > 0

            satCount(i,1) = n;
            n = 0;

        end
        
        % increment counter
        i = i + 1;

    else

        fprintf(tline)
        fprintf('\n')
        n = n + 1;
        % check PRN code
        PRN = str2double(tline(2:3));
        % check for L2 data
        L2_check = numel(tline);
        % save C/NO
        L1_CNO(i,PRN) = str2double(tline(60:65));

        if L2_check > 70

            L2_CNO(i,PRN) = str2double(tline(124:129));

        else

            L2_CNO(i,PRN) = 0;

        end

    end

end

% close
fclose(fileID);

% test duration
time = (1:numel(satCount))';

end