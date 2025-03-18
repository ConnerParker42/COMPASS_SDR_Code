%% RINEX OBS 3.04 Parser Generic
% Updated: Justin Pedersen      - 03/01/2023
%==========================================================================
% Parses satellite count (all sats) from Rinex OBS 3.04 file. This function
% reads a RINEX file from a receiver and outputs satellite count and C/NO 
% values (L1&L2) for each satellite at each time stamp. This code should
% work for any RINEX 3.04 file.
%==========================================================================

function [output,time] = RINEXOBS304_generic(filename)

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
% pre-allocate PRN array
GPS = 0;
GLONSS = 0;
BNSS = 0;
GNSS = 0;
SBAS = 0;

% feof checks end of file
while true

    tline = fgetl(fileID);

    % check if end of file
    if tline == -1

        % save last satellite count
        GPS_satCount(i,1) = GPS;
        GLONSS_satCount(i,1) = GLONSS;
        GNSS_satCount(i,1) = GNSS;
        BNSS_satCount(i,1) = BNSS;
        SBAS_satCount(i,1) = SBAS;

        % break loop
        break

    end

    % check for block header
    if contains(tline,'>')

        % save time stamp
        year = str2double(tline(3:6));
        month = str2double(tline(8:9));
        day = str2double(tline(11:12));
        hour = str2double(tline(14:15));
        minute = str2double(tline(17:18));
        second = str2double(tline(20:29));
        time(i+1,:) = datetime(year,month,day,hour,minute,second);
        
        clc
        fprintf(tline)
        fprintf('\n')

        if i > 0

            % save satellite count
            GPS_satCount(i,1) = GPS;
            GLONSS_satCount(i,1) = GLONSS;
            GNSS_satCount(i,1) = GNSS;
            BNSS_satCount(i,1) = BNSS;
            SBAS_satCount(i,1) = SBAS;


            % clear count variables
            GPS = 0;
            GLONSS = 0;
            BNSS = 0;
            GNSS = 0;
            SBAS = 0;

        end
        
        % increment counter
        i = i + 1;

    else

        fprintf(tline)
        fprintf('\n')

        % satelite type
        sat = tline(1);
        % check PRN code
        PRN = str2double(tline(2:3));
        % check for L2 data
        L2_check = numel(tline);
            if L2_check > 70
                L2_check = isnan(str2double(tline(124:129)));
            else
                L2_check = 1;
            end
        % tally satellite type  
        if contains(sat,'G')
            GPS = GPS + 1;
            % L1 C/NO
            GPS_L1_CNO(i,PRN) = str2double(tline(60:65));
            % L2 C/NO
            if L2_check == 0
                GPS_L2_CNO(i,PRN) = str2double(tline(124:129));
            else
                GPS_L2_CNO(i,PRN) = 0;
            end

        elseif contains(sat,'R')
            GLONSS = GLONSS + 1;
            % L1 C/NO
            GLONSS_L1_CNO(i,PRN) = str2double(tline(60:65));
            % L2 C/NO
            if L2_check == 0
                GLONSS_L2_CNO(i,PRN) = str2double(tline(124:129));
            else
                GLONSS_L2_CNO(i,PRN) = 0;
            end

        elseif contains(sat,'E')
            GNSS = GNSS + 1;
            % L1 C/NO
            GNSS_L1_CNO(i,PRN) = str2double(tline(60:65));
            % L2 C/NO
            if L2_check == 0
                GNSS_L2_CNO(i,PRN) = str2double(tline(124:129));
            else
                GNSS_L2_CNO(i,PRN) = 0;
            end

        elseif contains(sat,'C')
            BNSS = BNSS + 1;
            % L1 C/NO
            BNSS_L1_CNO(i,PRN) = str2double(tline(60:65));
            % L2 C/NO
            if L2_check == 0
                BNSS_L2_CNO(i,PRN) = str2double(tline(124:129));
            else
                BNSS_L2_CNO(i,PRN) = 0;
            end

        elseif contains(sat,'S')
            SBAS = SBAS + 1;
            % L1 C/NO
            SBAS_L1_CNO(i,PRN) = str2double(tline(60:65));
            % L2 C/NO
            if L2_check == 0
                SBAS_L2_CNO(i,PRN) = str2double(tline(124:129));
            else
                SBAS_L2_CNO(i,PRN) = 0;
            end

        end

    end

end

% close
fclose(fileID);

%% Save Data Structs

% reset variable names
clear GPS GLONSS GNSS BNSS SBAS

% GPS
if exist('GPS_L1_CNO','var')
    output.GPS.SatCount = GPS_satCount;
    output.GPS.L1_CNO = GPS_L1_CNO;
    output.GPS.L2_CNO = GPS_L2_CNO;
end

% GNSS
if exist('GLONSS_L1_CNO','var')
    output.GLONSS.SatCount = GLONSS_satCount;
    output.GLONSS.L1_CNO = GLONSS_L1_CNO;
    output.GLONSS.L2_CNO = GLONSS_L2_CNO;
end

% GNSS
if exist('GNSS_L1_CNO','var')
    output.GNSS.SatCount = GNSS_satCount;
    output.GNSS.L1_CNO = GNSS_L1_CNO;
    output.GNSS.L2_CNO = GNSS_L2_CNO;
end

% BNSS
if exist('BNSS_L1_CNO','var')
    output.BNSS.SatCount = BNSS_satCount;
    output.BNSS.L1_CNO = BNSS_L1_CNO;
    output.BNSS.L2_CNO = BNSS_L2_CNO;
end

% SBAS
if exist('SBAS_L1_CNO','var')
    output.SBAS.SatCount = SBAS_satCount;
    output.SBAS.L1_CNO = SBAS_L1_CNO;
    output.SBAS.L2_CNO = SBAS_L2_CNO;
end

end