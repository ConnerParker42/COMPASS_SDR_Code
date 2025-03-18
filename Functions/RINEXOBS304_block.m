%% RINEX OBS 3.04 Parser (v2)
% Updated: Justin Pedersen      - 02/27/2023
%==========================================================================
% Parses satellite count (all sats) from Rinex OBS 3.04 file. This function
% can read RINEX files from any receiver.
%==========================================================================

function [satCount,time] = RINEXOBS304_block(filename)

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

%% Block Reader

% initiate save boolean
saveBool = 0;
% counter to save data in array
i = 1;
% pre-allocate satellite count
GPS = 0;
GLONSS = 0;
BNSS = 0;
GNSS = 0;
SBAS = 0;

while ~feof(fileID)

    tline = fgetl(fileID);

    % check for block header (yes 1, no 0)
    blockCheck = contains(tline,'>');

    if blockCheck == 1

        if saveBool == 1

            % save satellite count
            satCount(i,1) = GPS;
            satCount(i,2) = GLONSS;
            satCount(i,3) = GNSS;
            satCount(i,4) = BNSS;
            satCount(i,5) = SBAS;
            % increment save data in array counter
            i = i + 1;
            % reset satellite counter
            GPS = 0;
            GLONSS = 0;
            BNSS = 0;
            GNSS = 0;
            SBAS = 0;
            % clear console
            clc

        end

        % print header
        fprintf(tline)
        fprintf('\n')
        % initiate counter
        counter = 0;

    else

        % print line
        fprintf(tline)
        fprintf('\n')
        % save boolean
        saveBool = 1;
        % satelite type
        sat = tline(1);
        % tally satellite type
        if contains(sat,'G')
            GPS = GPS + 1;

        elseif contains(sat,'R')
            GLONSS = GLONSS + 1;

        elseif contains(sat,'E')
            GNSS = GNSS + 1;

        elseif contains(sat,'C')
            BNSS = BNSS + 1;

        elseif contains(sat,'S')
            SBAS = SBAS + 1;

        end

    end

end

% save final data count
satCount(i,1) = GPS;
satCount(i,2) = GLONSS;
satCount(i,3) = GNSS;
satCount(i,4) = BNSS;
satCount(i,5) = SBAS;

time = (1:numel(satCount(:,1)))';

end