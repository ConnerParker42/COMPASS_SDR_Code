function [] = PhaseNCO_N310_Plotter(parsedData, cmdPhase_filePath)
% PhaseNCO_Plotter: Plot graphs to characterize phase NCO
%   Inputs: parsedData = cell array from PhaseParser function
%       cmdPhase_filePath = file path to folder with files of commanded
%       phase
%   Outputs: N/A
%   Plots: Characterization plots of rx signal on N310

    set(groot,'defaultLineLineWidth',1.5)
    set(groot,'defaultAxesFontSize',10)

    measTime = parsedData{1}.Time;
    phase1 = parsedData{1}.("Phase [s]");
    phase2 = parsedData{2}.("Phase [s]");
    phase3 = parsedData{3}.("Phase [s]");
    phase4 = parsedData{4}.("Phase [s]");
    measPhaseDiff1 = phase2 - phase1;
    measPhaseDiff2 = phase4 - phase3;

    timeInt = [3.375 450];
    lowIndex = find(measTime==timeInt(1));
    highIndex = find(measTime==timeInt(2));

    figure()
    hold on
    plot(measTime, measPhaseDiff1)
    plot(measTime, measPhaseDiff2)
    xline(timeInt(1), Color=[1,0,0])
    xline(timeInt(2), Color=[1,0,0])
    xlabel('Time [s]', Interpreter='latex'); ylabel('Phase [s]', Interpreter='latex'); grid on;
    legend('Measured Phase A0 - A1', 'Measured Phase B0 - B1', 'Cutoff', Location='best')
    title('N200 Phase NCO')
    
    measTime = measTime(lowIndex:highIndex) -  measTime(lowIndex);
    measPhaseDiff1 = measPhaseDiff1(lowIndex:highIndex);
    measPhaseDiff2 = measPhaseDiff2(lowIndex:highIndex);

    n200_samp_rate = 200e3;
    fileID = fopen(cmdPhase_filePath);
    cmdPhase = fread(fileID,'double');
    cmdPhase = cmdPhase / (2 * pi * 10e6);
    n200_time = (0:1:length(cmdPhase)-1) .* (1/n200_samp_rate);

    downSamplePhase = interp1(n200_time,cmdPhase,measTime);
    phaseErr1 = downSamplePhase - measPhaseDiff1;
    phaseErr2 = downSamplePhase - measPhaseDiff2;

    figure()
    hold on
    plot(measTime, measPhaseDiff1)
    plot(measTime, measPhaseDiff2)
    plot(n200_time, cmdPhase)
    xlabel('Time [s]', Interpreter='latex'); ylabel('Phase [s]', Interpreter='latex'); grid on;
    legend('Measured Phase A0 - A1', 'Measured Phase B0 - B1', 'Commanded Phase', Location='best')
    title('N200 Phase NCO')
    hold off

    figure()
    hold on
    plot(measTime, phaseErr1)
    plot(measTime, phaseErr2)
    xlabel('Time [s]', Interpreter='latex'); ylabel('Phase [s]', Interpreter='latex'); grid on;
    legend('Phase Error A0 - A1', 'Phase Error B0 - B1', Location='best')
    title('Phase Error')
    hold off

    coef = polyfit(measTime,phaseErr1,1);
    freqOffsetA0A1 = coef(1) * 10e6
    coef = polyfit(measTime,phaseErr2,1);
    freqOffsetB0B1 = coef(1) * 10e6

    figure()
    hold on
    plot(measTime, detrend(phaseErr1))
    plot(measTime, detrend(phaseErr2))
    xlabel('Time [s]', Interpreter='latex'); ylabel('Phase [s]', Interpreter='latex'); grid on;
    legend('Phase Error A0 - A1', 'Phase Error B0 - B1', Location='best')
    title('Phase Error')
    hold off

    fclose(fileID);
end