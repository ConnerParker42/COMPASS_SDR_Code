%% Spirent Simulator Antenna Pattern Generation Function
% Author: Justin Pedersen
% Date: 12/14/2022
% Description: Generates a attenuation matrix for an antenna radiation
% pattern given a CSV of elevetion versus gain. Output is a CSV and in 1
% degree increments. The resultant pattern will be symmetric across the Z-X
% plane.
% Requirements: Input file must be a CSV with first column being elevation
% data and second column being ATTENUATION values, NOT GAIN values.
% Elevation values must proceed from +90 to -90.
% plfag: input 1 for function to plot comparison of interpolation and
% original data.
% flag: input 1 to generate the CSV file.

function SS_antPatternGen_1d(filename,pflag,flag)

% establish 1 degree increment separation
elev_array = linspace(89.5,-89.5,180)';
azimuth_array = linspace(-179.5,179.5,360)';

% read CSV file
data = readmatrix(filename);

% plot
if pflag == 1

    figure(1)
    plot(data(:,1),data(:,2),'*')
    hold on

end

% separate elevation and attenuation values into arrays
elev = flip(unique(data(:,1)));      % elevation (degrees)
atten = unique(data(:,2));      % power (dB)

%elev = data(:,1);
%atten = data(:,2);

% interpolate
vq1 = interp1(elev,atten,elev_array,'linear');

% generate CSV
if flag == 1

    % create matrix
    mesh = repmat(vq1,1,360);

    % adjust export data to correct format
    export = cat(2,elev_array,mesh);
    temp = NaN;
    azimuth_array = cat(2,temp,azimuth_array');
    export = cat(1,azimuth_array,export);

    writematrix(export,'attenuation_pattern.csv')

end

% plot
if pflag == 1

    figure(1)
    plot(elev_array,vq1,'.')
    grid on
    xlabel('Elevation [degrees]')
    ylabel('Attenuation [dB]')
    title('Interpolation Plot')
    legend('Original','Interpolated')

end

end