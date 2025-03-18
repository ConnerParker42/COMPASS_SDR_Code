%% RINEX OBS 3.04 Parser (v1)
% Updated: Justin Pedersen      - 02/23/2023
%==========================================================================
% Parses satellite count and C/NO (L1 and L2) from Rinex OBS 3.04 file
%==========================================================================

function [satCount,time] = RINEXOBS304_block_old(filename)

fileID = fopen(filename);

% check for file
if fileID == -1

    fprintf('Error, file does not exist\n')
    return;

end

% satellite count array iteration
i = 1;
tf = 0;

% feof checks end of file
while ~feof(fileID)

    % pre-allocate satellite count
    count = 0;

    if tf == 0
        % grab line from text file
        tline = fgetl(fileID);
    end

    % check for beginning of block (0 yes, 1 no)
    blockCheck = isempty(strfind(tline,'>'));

    % if yes save first line to check with next block
    if blockCheck == 0
        initline = tline;
        % print working line
        fprintf(tline)
        fprintf('\n')
    end

    while blockCheck == 0

        % start satellite count
        tline = fgetl(fileID);
        satCheck = isempty(strfind(tline,'G'));
        tf = strcmp(initline,tline);
        
        if satCheck == 0
            % print working line
            fprintf(tline)
            fprintf('\n')
        end

        if satCheck == 0

            count = count + 1;

        elseif satCheck ~= 0

            if tf == 0
                satCount(i,1) = count;
                i = i + 1;
            end

            blockCheck = 1;
            clc

        end

    end

end

% close
fclose(fileID);

% test duration
time = (1:numel(satCount))';

end