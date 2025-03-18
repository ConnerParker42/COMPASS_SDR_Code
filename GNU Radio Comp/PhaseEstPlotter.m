function [] = PhaseEstPlotter(parsedData, epoch)
% PhaseEstPlotter: Plot graphs of estimated phase of each clock from clock
%   ensemble Kalman Filter
%   Inputs: parsedData = cell array from PhaseEstParser function
%       epoch = time of start of test
%   Outputs: N/A
%   Plots: Estimated Phase plots as given by clock ensemble

    figure()
    hold on
    xlabel('Elapsed Time [s]', FontSize=10, Interpreter='latex'); ylabel('Phase [s]', FontSize=10, Interpreter='latex'); grid on;
    ax = gca;
    ax.FontSize=10;
    title('Phase Estimates', FontSize=15)
    colors = distinguishable_colors(length(parsedData)/2);
    for i = 1:2:length(parsedData)
        time = parsedData{i}.Time;
%         time = epoch + seconds(time);
        phaseEst1 = parsedData{i}.("Phase [s]");
        phaseEst2 = parsedData{i+1}.("Phase [s]");
        plot(time,phaseEst1, LineStyle="--", Color=colors((i+1)/2,:), LineWidth=1.5)
        plot(time,phaseEst2, LineStyle="-", Color=colors((i+1)/2,:), LineWidth=1.5)
    end
    legend(["Chip Clean", "Chip Synth", "mRO Clean", "mRO Synth", "Ralphie Clean", "Ralphie Synth"], Location="best", FontSize=7);

end