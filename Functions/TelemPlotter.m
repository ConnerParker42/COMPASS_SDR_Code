function [] = TelemPlotter(parsedData, epoch)
% TelemPlotter: Plots the telemetry data from a CSAC
%   Inputs: parsedData = cell array with tables in each cell, table has
%       seconds and data
%       epoch = time of start of test
%   Outputs: N/A
%   Plots: Graph of telemetry data for each CSAC

    figure()
    hold on
    xlabel('Date and Time', FontSize=10, Interpreter='latex'); ylabel('Temperature [dC]', FontSize=10, Interpreter='latex'); grid on;
    ax = gca;
    ax.FontSize=10;
    title('CSAC Telemetry Data',FontSize=15)
    colors = distinguishable_colors(length(parsedData));
    for i = 1:length(parsedData)
        time = parsedData{i}.Seconds;
        time = epoch + seconds(time);
        telemData = parsedData{i}.Temp_dC_;
        plot(time,telemData, LineStyle="-", Color=colors(i,:), LineWidth=1.5)
    end
    legend(["Chip Telemetry", "Ralphie Telemetry"], Location="best", FontSize=7);

end

