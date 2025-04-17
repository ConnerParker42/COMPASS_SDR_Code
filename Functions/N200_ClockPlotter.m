function [] = N200_ClockPlotter(parsedData, signalFreq)
% N200_ClockPlotter: Plots the phase data from N200 assuming two
% measurements
%   Inputs: parsedData = cell array from PhaseParser function
%   Outputs: N/A
%   Plots: Graph of phase data

    time = parsedData{1}.Time;
    phase1 = parsedData{1}.("Phase [s]");
    phase2 = parsedData{2}.("Phase [s]");

    len = min([length(phase1), length(phase2)]);
    time = time(1:len);
    phase1 = phase1(1:len);
    phase2 = phase2(1:len);

    isTableCol = @(t, thisCol) ismember(thisCol, t.Properties.VariableNames);

    if (isTableCol(parsedData{1}, "In Phase [V]"))
        % In Phase
        signal1 = parsedData{1}.("In Phase [V]");
        signal2 = parsedData{2}.("In Phase [V]");
        fprintf('RMS of In Phase RF1: %d V\n', rms(signal1,"all"))
        fprintf('RMS of In Phase RF2: %d V\n', rms(signal2,"all"))
        fprintf('Standard Deviation of In Phase RF1: %.1d V\n', std(signal1) )
        fprintf('Standard Deviation of In Phase RF2: %.1d V\n', std(signal2) )
        se1 = std(signal1)/sqrt(len);
        se2 = std(signal2)/sqrt(len);
        fprintf('Mean of In Phase RF1: %d V\n', round( mean(signal1), -floor(log10(se1)) ))
        fprintf('Mean of In Phase RF2: %d V\n', round( mean(signal2), -floor(log10(se2)) ))

        figure()
        hold on
        plot(time,signal1)
        plot(time,signal2)
        xlabel('Time [s]', Interpreter='latex'); ylabel('Signal [V]', Interpreter='latex'); grid on;
        legend('Signal RF1', 'Signal RF2', Location='best')
        xlim([0 .25])
        title('Raw Signal (In Phase)')

        figure()
        hold on
        histogram(signal1, NumBins=100)
        histogram(signal2, NumBins=100)
        xlabel('Voltage [V]', Interpreter='latex'); ylabel('Count', Interpreter='latex'); grid on;
        legend('Signal RF1', 'Signal RF2', Location='best')
        title('Raw Signal Cardinality (In Phase)')


        % Quadrature 
        signal1 = parsedData{1}.("Quadrature [V]");
        signal2 = parsedData{2}.("Quadrature [V]");
        fprintf('RMS of Quadrature RF1: %d V\n', rms(signal1,"all"))
        fprintf('RMS of Quadrature RF2: %d V\n', rms(signal2,"all"))
        fprintf('Standard Deviation of Quadrature RF1: %.1d V\n', std(signal1) )
        fprintf('Standard Deviation of Quadrature RF2: %.1d V\n', std(signal2) )
        se1 = std(signal1)/sqrt(len);
        se2 = std(signal2)/sqrt(len);
        fprintf('Mean of Quadrature RF1: %d V\n', round( mean(signal1), -floor(log10(se1)) ))
        fprintf('Mean of Quadrature RF2: %d V\n', round( mean(signal2), -floor(log10(se2)) ))

        figure()
        hold on
        plot(time,signal1)
        plot(time,signal2)
        xlabel('Time [s]', Interpreter='latex'); ylabel('Signal [V]', Interpreter='latex'); grid on;
        legend('Signal RF1', 'Signal RF2', Location='best')
        xlim([0 .25])
        title('Raw Signal (Quadrature)')

        figure()
        hold on
        histogram(signal1, NumBins=100)
        histogram(signal2, NumBins=100)
        xlabel('Voltage [V]', Interpreter='latex'); ylabel('Count', Interpreter='latex'); grid on;
        legend('Signal RF1', 'Signal RF2', Location='best')
        title('Raw Signal Cardinality (Quadrature)')

        % Phasor Graph
        figure()
        hold on
        plot(parsedData{1}.("In Phase [V]"), parsedData{1}.("Quadrature [V]"))
        plot(parsedData{2}.("In Phase [V]"), parsedData{2}.("Quadrature [V]"))
        xlabel('In Phase [V]', Interpreter='latex'); ylabel('Quadrature [V]', Interpreter='latex'); grid on;
        legend('Signal RF1','Signal RF2', Location='best')
        title('Phasor Graph of RF1')
    end
    
    figure()
    hold on
    plot(time,phase1, LineWidth=1.5)
    plot(time,phase2, LineWidth=1.5)
    xlabel('Time [s]', FontSize=10, Interpreter='latex'); ylabel('Phase [s]', FontSize=10, Interpreter='latex'); grid on;
    legend('RF1', 'RF2', Location='best')
    title('Unwrapped Phases',FontSize=15)

    figure()
    hold on
    plot(time,detrend(phase1), LineWidth=1.5)
    plot(time,detrend(phase2), LineWidth=1.5)
    xlabel('Time [s]', FontSize=10, Interpreter='latex'); ylabel('Phase [s]', FontSize=10, Interpreter='latex'); grid on;
    legend('RF1', 'RF2', Location='best')
    title('Detrended Phases', FontSize=15)

    figure()
    hold on
    plot(time,detrend(phase1-phase2), LineWidth=1.5)
    xlabel('Time [s]', FontSize=10, Interpreter='latex'); ylabel('Phase [s]', FontSize=10, Interpreter='latex'); grid on;
    legend('RF1-RF2', Location='best')
    title('Detrended Phase Difference', FontSize=15)

    format long;
    coef = polyfit(time,phase1,1);
    fprintf('Frequency Offset between RF1 and Reference: %d Hz\n', coef(1)*signalFreq)
    coef = polyfit(time,phase2,1);
    fprintf('Frequency Offset between RF2 and Reference: %d Hz\n', coef(1)*signalFreq)
    coef = polyfit(time,phase1-phase2,1);
    fprintf('Frequency Offset between RF1 and RF2: %d Hz\n', coef(1)*signalFreq)
end

