function [] = N310_Plotter(parsedData, signalFreq)
% N310_Plotter: Plots the phase data from N310
%   Inputs: parsedData = cell array from PhaseParser function
%   Outputs: N/A
%   Plots: Graph of phase data

    set(groot,'defaultLineLineWidth',1.5)
    set(groot,'defaultAxesFontSize',10)

    time = parsedData{1}.Time;
    phase1 = parsedData{1}.("Phase [s]");
    phase2 = parsedData{2}.("Phase [s]");
    phase3 = parsedData{3}.("Phase [s]");
    phase4 = parsedData{4}.("Phase [s]");

    len = min([length(phase1), length(phase2), length(phase3), length(phase4)]);
    time = time(1:len);
    phase1 = phase1(1:len);
    phase2 = phase2(1:len);
    phase3 = phase3(1:len);
    phase4 = phase4(1:len);

    isTableCol = @(t, thisCol) ismember(thisCol, t.Properties.VariableNames);

    if (isTableCol(parsedData{1}, "In Phase [V]"))
        % In Phase
        signal1 = parsedData{1}.("In Phase [V]");
        signal2 = parsedData{2}.("In Phase [V]");
        signal3 = parsedData{3}.("In Phase [V]");
        signal4 = parsedData{4}.("In Phase [V]");

        fprintf('RMS of In Phase A0: %d V\n', rms(signal1,"all"))
        fprintf('RMS of In Phase A1: %d V\n', rms(signal2,"all"))
        fprintf('RMS of In Phase B0: %d V\n', rms(signal3,"all"))
        fprintf('RMS of In Phase B1: %d V\n\n', rms(signal4,"all"))

        fprintf('Standard Deviation of In Phase A0: %.1d V\n', std(signal1) )
        fprintf('Standard Deviation of In Phase A1: %.1d V\n', std(signal2) )
        fprintf('Standard Deviation of In Phase B0: %.1d V\n', std(signal3) )
        fprintf('Standard Deviation of In Phase B1: %.1d V\n\n',std(signal4) )

        se1 = std(signal1)/sqrt(len);
        se2 = std(signal2)/sqrt(len);
        se3 = std(signal3)/sqrt(len);
        se4 = std(signal4)/sqrt(len);

        fprintf('Mean of In Phase A0: %d V\n', round( mean(signal1), -floor(log10(se1)) ))
        fprintf('Mean of In Phase A1: %d V\n', round( mean(signal2), -floor(log10(se2)) ))
        fprintf('Mean of In Phase B0: %d V\n', round( mean(signal3), -floor(log10(se3)) ))
        fprintf('Mean of In Phase B1: %d V\n\n', round( mean(signal4), -floor(log10(se4)) ))

         % Quadrature
        signal1 = parsedData{1}.("Quadrature [V]");
        signal2 = parsedData{2}.("Quadrature [V]");
        signal3 = parsedData{3}.("Quadrature [V]");
        signal4 = parsedData{4}.("Quadrature [V]");

        fprintf('RMS of Quadrature A0: %d V\n', rms(signal1,"all"))
        fprintf('RMS of Quadrature A1: %d V\n', rms(signal2,"all"))
        fprintf('RMS of Quadrature B0: %d V\n', rms(signal3,"all"))
        fprintf('RMS of Quadrature B1: %d V\n\n', rms(signal4,"all"))

        fprintf('Standard Deviation of Quadrature A0: %.1d V\n', std(signal1) )
        fprintf('Standard Deviation of Quadrature A1: %.1d V\n', std(signal2) )
        fprintf('Standard Deviation of Quadrature B0: %.1d V\n', std(signal3) )
        fprintf('Standard Deviation of Quadrature B1: %.1d V\n\n',std(signal4) )

        se1 = std(signal1)/sqrt(len);
        se2 = std(signal2)/sqrt(len);
        se3 = std(signal3)/sqrt(len);
        se4 = std(signal4)/sqrt(len);

        fprintf('Mean of Quadrature A0: %d V\n', round( mean(signal1), -floor(log10(se1)) ))
        fprintf('Mean of Quadrature A1: %d V\n', round( mean(signal2), -floor(log10(se2)) ))
        fprintf('Mean of Quadrature B0: %d V\n', round( mean(signal3), -floor(log10(se3)) ))
        fprintf('Mean of Quadrature B1: %d V\n\n', round( mean(signal4), -floor(log10(se4)) ))
    
        figure()
        subplot(2,1,1)
        hold on
        plot(time,signal1(1:len))
        plot(time,signal2(1:len))
        plot(time,signal3(1:len))
        plot(time,signal4(1:len))
        xlabel('Time [s]', Interpreter='latex'); ylabel('Signal [V]', Interpreter='latex'); grid on;
        legend('Signal A0', 'Signal A1', 'Signal B0', 'Signal B1', Location='best')
        % xlim([0 .25])
        title('Raw Signal (In Phase)')
        subplot(2,1,2)
        hold on
        plot(time,signal1(1:len))
        plot(time,signal2(1:len))
        plot(time,signal3(1:len))
        plot(time,signal4(1:len))
        xlabel('Time [s]', Interpreter='latex'); ylabel('Signal [V]', Interpreter='latex'); grid on;
        legend('Signal A0', 'Signal A1', 'Signal B0', 'Signal B1', Location='best')
        % xlim([0 .25])
        title('Raw Signal (Quadrature)')

        figure()
        subplot(2,1,1)
        hold on
        histogram(signal1, NumBins=100)
        histogram(signal2, NumBins=100)
        histogram(signal3, NumBins=100)
        histogram(signal4, NumBins=100)
        xlabel('Voltage [V]', Interpreter='latex'); ylabel('Count', Interpreter='latex'); grid on;
        legend('Signal A0', 'Signal A1', 'Signal B0', 'Signal B1', Location='best')
        title('Raw Signal Cardinality (In Phase)')
        subplot(2,1,2)
        hold on
        histogram(signal1, NumBins=100)
        histogram(signal2, NumBins=100)
        histogram(signal3, NumBins=100)
        histogram(signal4, NumBins=100)
        xlabel('Voltage [V]', Interpreter='latex'); ylabel('Count', Interpreter='latex'); grid on;
        legend('Signal A0', 'Signal A1', 'Signal B0', 'Signal B1', Location='best')
        title('Raw Signal Cardinality (Quadrature)')

        % Phasor Graph
        figure()
        hold on
        plot(parsedData{1}.("In Phase [V]"), parsedData{1}.("Quadrature [V]"))
        plot(parsedData{2}.("In Phase [V]"), parsedData{2}.("Quadrature [V]"))
        plot(parsedData{3}.("In Phase [V]"), parsedData{3}.("Quadrature [V]"))
        plot(parsedData{4}.("In Phase [V]"), parsedData{4}.("Quadrature [V]"))
        xlabel('In Phase [V]', Interpreter='latex'); ylabel('Quadrature [V]', Interpreter='latex'); grid on;
        legend('A0','A1','B0','B1', Location='best')
        title('Phasor Graph')

        fprintf('Power of A0: %d dB\n', 20*log10(max(signal1)))
        fprintf('Power of A1: %d dB\n', 20*log10(max(signal2)))
        fprintf('Power of B0: %d dB\n', 20*log10(max(signal3)))
        fprintf('Power of B1: %d dB\n\n', 20*log10(max(signal4)))
    end

    figure()
    subplot(2,1,1)
    hold on
    plot(time,phase1)
    plot(time,phase2)
    plot(time,phase3)
    plot(time,phase4)
    xlabel('Time [s]', Interpreter='latex'); ylabel('Phase [s]', Interpreter='latex'); grid on;
    legend('Unwrapped Phase A0', 'Unwrapped Phase A1', 'Unwrapped Phase B0', 'Unwrapped Phase B1', Location='best')
    title('Unwrapped Phases')
    subplot(2,1,2)
    hold on
    plot(time,detrend(phase1))
    plot(time,detrend(phase2))
    plot(time,detrend(phase3))
    plot(time,detrend(phase4))
    xlabel('Time [s]', Interpreter='latex'); ylabel('Phase [s]', Interpreter='latex'); grid on;
    legend('Detrended Phase A0', 'Detrended Phase A1', 'Detrended Phase B0', 'Detrended Phase B1',Location='best')
    title('Detrended Phases')

    figure()
    subplot(2,1,1)
    hold on
    plot(time,phase1 - phase2)
    plot(time,phase3 - phase4)
    xlabel('Time [s]', Interpreter='latex'); ylabel('Phase [s]', Interpreter='latex'); grid on;
    legend('Unwrapped Phase A0 - A1', 'Unwrapped Phase B0 - B1', Location='best')
    title('Unwrapped Phases Differences')
    subplot(2,1,2)
    hold on
    plot(time,detrend(phase1 - phase2))
    plot(time,detrend(phase3 - phase4))
    xlabel('Time [s]', Interpreter='latex'); ylabel('Phase [s]', Interpreter='latex'); grid on;
    legend('Unwrapped Phase A0 - A1', 'Unwrapped Phase B0 - B1', Location='best')
    % legend('Detrended Phase B0 - B1', Location='best')
    title('Detrended Phases Differences')


    figure()
    hold on
    plot(time,detrend(phase1 - phase3))
    plot(time,detrend(phase2 - phase4))
    xlabel('Time [s]', Interpreter='latex'); ylabel('Phase [s]', Interpreter='latex'); grid on;
    legend('Unwrapped Phase A0 - B0', 'Unwrapped Phase A1 - B1', Location='best')
    % legend('Detrended Phase B0 - B1', Location='best')
    title('Detrended Phases Differences Cross Daughterboard')

    format long;
    coef = polyfit(time,phase1,1);
    fprintf('Frequency Offset between A0 and Reference Clock: %d Hz\n', coef(1)*signalFreq)
    coef = polyfit(time,phase2,1);
    fprintf('Frequency Offset between A1 and Reference Clock: %d Hz\n', coef(1)*signalFreq)
    coef = polyfit(time,phase3,1);
    fprintf('Frequency Offset between B0 and Reference Clock: %d Hz\n', coef(1)*signalFreq)
    coef = polyfit(time,phase4,1);
    fprintf('Frequency Offset between B1 and Reference Clock: %d Hz\n', coef(1)*signalFreq)

    coef = polyfit(time,phase1 - phase2,1);
    fprintf('Frequency Offset between A0 and A1: %d Hz\n', coef(1)*signalFreq)
    coef = polyfit(time,phase3 - phase4,1);
    fprintf('Frequency Offset between B0 and B1: %d Hz\n\n', coef(1)*signalFreq)

end