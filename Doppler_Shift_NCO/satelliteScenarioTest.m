close all; clear; clc;

set(groot, ...
    'defaultAxesFontSize',10, ...
    'defaultTextFontSize',15, ...
    'defaultTextFontSizeMode','manual', ...
    'defaultLegendFontSize',32, ...
    'defaultLegendFontSizeMode','manual', ...
    'DefaultLineLineWidth',2 ...
    )

tic;

c = 299792458;
signalFreq = 10e6;

% url = 'https://celestrak.org/NORAD/elements/gp.php?GROUP=gps-ops&FORMAT=tle';
% data = webread(url);
% tleFile = 'gpsTLE_Test.tle';      
% fid = fopen(tleFile, 'w' );
% fprintf(fid, '%s', data );
% fclose(fid);

startTime = datetime(2022,12,31) + days(60);
stopTime = startTime + days(1);
sampleRate = 2;
dt = 1 / sampleRate; % sec per sample

disp("Starting Sat Scenario")
toc;

sc = satelliteScenario(startTime, stopTime, dt);

% data = rinexread('BRDC00IGS_R_20230600000_01D_MN.rnx');
% sats = satellite(sc,data);

semiMajorAxis = 6378e3 + 500e3; % meters
eccentricity = 0;
inclination = 60; % degrees
rightAscensionOfAscendingNode = 0; % degrees
argumentOfPeriapsis = 0; % degrees
trueAnomaly = 0; % degrees
sats = satellite(sc,semiMajorAxis,eccentricity, ...
       inclination,rightAscensionOfAscendingNode, ...
       argumentOfPeriapsis,trueAnomaly, ...
       "OrbitPropagator","two-body-keplerian", ...
       "Name","MAXWELL");


lat = 40.01030786663782;
lon = -105.24384398465565;
gsUS = groundStation(sc, lat, lon, MinElevationAngle=10, Name="AERO");
ecefGs = lla2ecef( [lat, lon, 0] );

accessUS = access(gsUS, sats);
intervalsUS = accessIntervals(accessUS);

disp("Start Path Search")
toc;

passNum = 3;
satID = intervalsUS(passNum,:).Target;

for sat = sats
    if(sat.Name == satID)
        break
    end
end

timeVec = intervalsUS(passNum,:).StartTime:seconds(dt):intervalsUS(passNum,:).EndTime;
velNorms = zeros(length(timeVec),1);
for i = 1:length(timeVec)
    simTime = timeVec(i);
    [pos, vel, time] = states(sat,simTime, "CoordinateFrame","ecef"); % [m] [m/s] [UTC]
    posDiff = ecefGs' - pos;
    velNorms(i) = dot(vel, posDiff / norm(posDiff));
end

% play(sc)

%%

disp("Start Doppler Shift Calcs");
toc;

n200_samp_rate = 200e3;
elapseTime = (seconds(timeVec - timeVec(1)))';
% n200_time = 0:1/n200_samp_rate:elapseTime(end);
n200_time = 0:1/n200_samp_rate:1800;
n = length(n200_time);

% dopShift = velNorms/c * signalFreq; % Hz
% dopShift = interp1(elapseTime,dopShift,n200_time);
% fileName = 'DopPhase_MAXWELL.bin';

% dopShift = (linspace(0, 0, n))'; % Hz
% fileName = 'DopPhase_Zero.bin';
dopShift = (ones(n,1))' * 1.3; % Hz
fileName = 'DopPhase_Const.bin';
% dopShift = (linspace(0, 100, n))'; % Hz
% fileName = 'DopPhase_PosLin.bin';
% dopShift = (linspace(0, -100, n))'; % Hz
% fileName = 'DopPhase_NegLin.bin';
% dopShift = (linspace(-200, 200, n))'; % Hz
% fileName = 'DopPhase_PosLinNegOffset.bin';
% dopShift = 50 * (sawtooth(2*pi*.01*n200_time + pi/2, .5))'; % Hz
% fileName = 'DopPhase_sawtooth.bin';

dopPhaseRads = cumtrapz(dopShift) * 2*pi/n200_samp_rate; % rads

% dopShiftRads = (linspace(1, 1, n))';
% fileName = 'DopPhase_ConstPhase.bin';

% figure()
% plot(n200_time, dopShift);
% grid on;
% title(["Doppler Shift of " , sat.Name])
% xlabel("Elapsed Time [s]")
% ylabel("Doppler Shift [Hz]")

% figure()
% plot(n200_time, dopPhaseRads)
% grid on;
% title(["Doppler Shift in Radians of " , sat.Name])
% xlabel("Elapsed Time [s]")
% ylabel("Doppler Shift [rad]")

% figure()
% plot(n200_time, detrend(dopPhaseRads))
% grid on;
% title(["Detrended Doppler Shift in Radians of " , sat.Name])
% xlabel("Elapsed Time [s]")
% ylabel("Doppler Shift [rad]")

% figure()
% histogram(abs(dopShift))
% grid on;
% title("Cardinality of Doppler Profile")
% xlabel("Frequency [Hz]")
% ylabel("Count")

folderPath = './';
fileID = fopen([folderPath fileName], 'wb');
fwrite(fileID,dopPhaseRads,'double');
fclose(fileID);