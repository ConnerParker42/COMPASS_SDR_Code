function [] = FreqEstPlotter(parsedData, epoch)
% FreqEstPlotter: Plot graphs of estimated frequency of each clock from clock
%   ensemble Kalman Filter
%   Inputs: parsedData = cell array from FreqEstParser function
%       epoch = time of start of test
%   Outputs: N/A
%   Plots: Estimated Freq plots as given by clock ensemble

    figure()
    hold on
    xlabel('Elapsed Time [s]', FontSize=10, Interpreter='latex'); ylabel('Fractional Frequency', FontSize=10, Interpreter='latex'); grid on;
    ax = gca;
    ax.FontSize=10;
    title('Estimated Fractional Frequency', FontSize=15)
    colors = distinguishable_colors(length(parsedData)/2);
    for i = 1:2:length(parsedData)
        time = parsedData{i}.Time;
%         time = epoch + seconds(time);
        freqEst1 = parsedData{i}.Frequency;
        freqEst2 = parsedData{i+1}.Frequency;

        time = time(40:end);
        freqEst1 = freqEst1(40:end);
        freqEst2 = freqEst2(40:end);

        plot(time, freqEst1, LineStyle="--", Color=colors((i+1)/2,:), LineWidth=1.5)
        plot(time, freqEst2, LineStyle="-", Color=colors((i+1)/2,:), LineWidth=1.5)
    end
    legend(["Chip Clean", "Chip Synth", "mRO Clean", "mRO Synth", "Ralphie Clean", "Ralphie Synth"], Location="best", FontSize=7);
end

