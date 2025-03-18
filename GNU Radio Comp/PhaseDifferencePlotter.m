function [] = PhaseDifferencePlotter(parsedData, epoch)
% PhaseDifferencePlotter: Plot graphs of phase difference used for error
%   detection algorithm
%   Inputs: parsedData = cell array from PhaseParser function
%       epoch = time of start of test
%   Outputs: N/A
%   Plots: Phase difference plots between inputs on N310

    phaseData1 = parsedData{1}.("Phase [rad]");
    phaseData2 = parsedData{2}.("Phase [rad]");
    phaseData3 = parsedData{3}.("Phase [rad]");
    phaseData4 = parsedData{4}.("Phase [rad]");
    time = parsedData{1}.Time;
    
%     time = epoch + seconds(time);

    phaseDiff1 = phaseData1-phaseData3;
    phaseDiff2 = phaseData2-phaseData3;
    phaseDiff4 = phaseData4-phaseData3;

    format long
    
    n = 5000;
    alpha=1;
    x1 = diff(phaseDiff1);
    x2 = diff(phaseDiff2);
    x4 = diff(phaseDiff4);

    % len = size(x1, 1);
    % m  = len - mod(len, n);
    % y = reshape(x1(1:m), n, []);
    % blockAvg1 = transpose(sum(y, 1) / n);


    len = length(phaseData1);
    slidingAvg1 = zeros(len - n,1);
    slidingAvg2 = zeros(len - n,1);
    slidingAvg4 = zeros(len - n,1);
    for i = 1:(len - n)
        slidingAvg1(i) = mean( x1(i:(i+n-1)) );
        slidingAvg2(i) = mean( x2(i:(i+n-1)) );
        slidingAvg4(i) = mean( x4(i:(i+n-1)) );
    end
    
    predError1 = zeros(len - n,1);
    predError2 = zeros(len - n,1);
    predError4 = zeros(len - n,1);
    fitX = (0:(n*alpha)-1)';
    predX = (n*alpha:n-1)';
    for i = 1:(len - n)
        fitArrIds = (i:i+(n*alpha)-1)';
        predArrIds = (i+(n*alpha): i+n-1)';

        fitArr = x1(fitArrIds);
        predArr = x1(predArrIds);
        coef = polyfit(fitX, fitArr, 1);
        predVal = polyval(coef, predX);
        % predError1(i) = mean(predVal - predArr);
        predError1(i) = coef(1);

        fitArr = x2(fitArrIds);
        predArr = x2(predArrIds);
        coef = polyfit(fitX, fitArr, 1);
        predVal = polyval(coef, predX);
        % predError2(i) = mean(predVal - predArr);
        predError2(i) = coef(1);

        fitArr = x4(fitArrIds);
        predArr = x4(predArrIds);
        coef = polyfit(fitX, fitArr, 1);
        predVal = polyval(coef, predX);
        % predError4(i) = mean(predVal - predArr);
        predError4(i) = coef(1);
    end

    colors = distinguishable_colors(length(parsedData));
    figure()
    hold on;
    xlabel('Elapsed Time [s]', FontSize=10, Interpreter='latex'); ylabel('Phase [rad]', FontSize=10, Interpreter='latex'); grid on;
    ax = gca;
    ax.FontSize=10;
    % title("Detrended Phases",FontSize=15)
    % plot(time,detrend(phaseData1-phaseData2), Marker=".", Color=colors(1,:))
    % plot(time,detrend(phaseData3-phaseData4), Marker=".", Color=colors(3,:))
    % legend(["A0-A1","B0-B1"], Location="best", FontSize=10)
    
    % title('Phase Difference from Chip',FontSize=15)
    % plot(time,phaseDiff1, Marker=".", Color=colors(1,:))
    % plot(time,phaseDiff2, Marker=".", Color=colors(2,:))
    % plot(time,phaseDiff4, Marker=".", Color=colors(3,:))
    % legend(["mRO - Chip", "NCO - Chip", "Ralphie - Chip"], Location="best", FontSize=10)
    % axes('Position',[.20 .25 .25 .25]);
    % box on;
    % temp = phaseData2-phaseData3;
    % plot(time(45000:65000), temp(45000:65000), Color=colors(2,:), LineWidth=2)

    % title('Sequential Element Difference',FontSize=15)
    % plot(time(1:end-1),x1, Marker=".", Color=colors(1,:))
    % plot(time(1:end-1),x2, Marker=".", Color=colors(2,:))
    % plot(time(1:end-1),x4, Marker=".", Color=colors(3,:))
    % legend(["mRO - Chip", "NCO - Chip", "Ralphie - Chip"], Location="best", FontSize=10)

%     title('Block Average',FontSize=15)
%     plot(blockAvg1, Marker=".", Color=colors(1,:))
%     plot(blockAvg4, Marker=".", Color=colors(3,:))
%     plot(blockAvg3, Marker=".", Color=colors(2,:))
%     legend(["mRO - Chip", "Ralphie - Chip", "NCO - Chip"], Location="best", FontSize=10)
%     xlabel('Block Number', FontSize=10, Interpreter='latex');

    % title('Sliding Average',FontSize=15)
    % plot(slidingAvg1 - slidingAvg1(1), Marker=".", Color=colors(1,:))
    % plot(slidingAvg2 - slidingAvg2(1), Marker=".", Color=colors(2,:))
    % plot(slidingAvg4 - slidingAvg4(1), Marker=".", Color=colors(3,:))
    % legend(["mRO - Chip", "NCO - Chip", "Ralphie - Chip"], Location="best", FontSize=7)
    % xlabel('Starting Index', FontSize=10, Interpreter='latex');
    % slideAvg1Mean = mean(slidingAvg1 - slidingAvg1(1))
    % slideAvg1Std = std(slidingAvg1 - slidingAvg1(1))
    % slideAvg2Mean = mean(slidingAvg2 - slidingAvg2(1))
    % slideAvg2Std = std(slidingAvg2 - slidingAvg2(1))
    % slideAvg4Mean = mean(slidingAvg4 - slidingAvg4(1))
    % slideAvg4Std = std(slidingAvg4 - slidingAvg4(1))
    % yline([slideAvg1Mean, slideAvg1Mean+3*slideAvg1Std, slideAvg1Mean-3*slideAvg1Std], Color=colors(1,:), LineWidth=5)
    % yline([slideAvg2Mean, slideAvg2Mean+3*slideAvg2Std, slideAvg2Mean-3*slideAvg2Std], Color=colors(2,:), LineWidth=5)
    % yline([slideAvg4Mean, slideAvg4Mean+3*slideAvg4Std, slideAvg4Mean-3*slideAvg4Std], Color=colors(3,:), LineWidth=5)

    title("Least Square Slope", FontSize=15)
    plot(predError1, Marker=".", Color=colors(1,:))
    plot(predError2, Marker=".", Color=colors(2,:))
    plot(predError4, Marker=".", Color=colors(3,:))
    legend(["mRO - Chip", "NCO - Chip", "Ralphie - Chip"], Location="best", FontSize=7)
    xlabel('Starting Index', FontSize=10, Interpreter='latex');
    ylabel('Slope')
end