%% NovAtel Test Data Start Date & Time
% Updated: Justin Pedersen      - 02/11/2023
%==========================================================================
% This function extracts the start date and time from a NovAtel ASC data
% file using the following naming convention for the file:
% BESTXYZ_DD-MM-YYYY_hr-min-sec.ASC
%==========================================================================

function [date,time] = NovAtel_StartDateTime(filename)

idx_trunc = strfind(filename,'BESTXYZ');
filename = filename(idx_trunc:end);

idx_f1 = strfind(filename,'_');
idx_f2 = strfind(filename,'-');

% date dd,mm,yyyy
day = str2double(filename(idx_f1(1)+1:idx_f2(1)-1));
month = str2double(filename(idx_f2(1)+1:idx_f2(2)-1));
year = str2double(filename(idx_f2(2)+1:idx_f1(2)-1));
date = [day,month,year];

% 24 hour time
hour = str2double(filename(idx_f1(2)+1:idx_f2(3)-1));
minute = str2double(filename(idx_f2(3)+1:idx_f2(4)-1));
second = str2double(filename(idx_f2(4)+1:idx_f2(4)+3));
time = [hour,minute,second];

end