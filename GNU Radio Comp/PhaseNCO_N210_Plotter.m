function [] = PhaseNCO_N210_Plotter(parsedData, cmdPhase_filePath, cmdPhaseRate, signalFreq,timeInt)
% PhaseNCO_Plotter: Plot graphs to characterize phase NCO on N210 assuming
% external reference was used
%   Inputs: parsedData = cell array from PhaseParser function
%       cmdPhase_filePath = file path to folder with files of commanded
%       phase
%   Outputs: N/A
%   Plots: Characterization plots of rx signal on N210

    % set(groot,'defaultLineLineWidth',1.5)
    % set(groot,'defaultAxesFontSize',1)

    measTime = parsedData{1}.Time;
    measPhaseDiff1 = parsedData{1}.("Phase [rad]");

    [~, lowIndex] = min(abs(measTime-timeInt(1)));
    [~, highIndex] = min(abs(measTime-timeInt(2)));

    % Commanded phase parsing
    fileID = fopen(cmdPhase_filePath);
    cmdPhase = fread(fileID,'double');
    cmdPhase = cmdPhase / (2 * pi * signalFreq);
    n200_time = (0:1:length(cmdPhase)-1) .* (1/cmdPhaseRate);

    figure()
    hold on
    plot(measTime, measPhaseDiff1)
    xline(timeInt(1), Color=[1,0,0])
    xline(timeInt(2), Color=[1,0,0])
    xlabel('Time [s]', Interpreter='latex'); ylabel('Phase [s]', Interpreter='latex'); grid on;
    legend('Measured Phase RF1 - EXT REF', 'Cutoff', Location='best')
    title('Measured Phase from NCO')
    
    measTime = measTime(lowIndex:highIndex) -  measTime(lowIndex);
    measPhaseDiff1 = measPhaseDiff1(lowIndex:highIndex);

    % Sample command phase at times which measurements were made
    downSamplePhase = interp1(n200_time,cmdPhase,measTime);
    phaseErr1 = measPhaseDiff1 - downSamplePhase;

    figure()
    hold on
    plot(measTime, measPhaseDiff1)
    plot(n200_time, cmdPhase)
    xlabel('Time [s]', Interpreter='latex'); ylabel('Phase [s]', Interpreter='latex'); grid on;
    legend('Measured Phase RF1 - EXT REF', 'Commanded Phase', Location='best')
    title('Measured Phase vs Commanded Phase')
    hold off

    figure()
    subplot(2,1,1)
    hold on
    plot(measTime, phaseErr1)
    xlabel('Time [s]', Interpreter='latex'); ylabel('Phase [s]', Interpreter='latex'); grid on;
    legend('Phase Error RF1 - EXT REF', Location='best')
    title('Phase Error')
    hold off

    subplot(2,1,2)
    hold on
    plot(measTime, detrend(phaseErr1))
    xlabel('Time [s]', Interpreter='latex'); ylabel('Phase [s]', Interpreter='latex'); grid on;
    legend('Phase Error RF1 - EXT REF', Location='best')
    title('Detrended Phase Error')
    hold off


    format long;
    coef = polyfit(measTime,phaseErr1,1);
    fprintf('Frequency Offset of Phase Error: %d Hz\n', coef(1)*signalFreq)

    FFT_Plotter(detrend(phaseErr1), 1/(measTime(2)-measTime(1)))

    fclose(fileID);
end