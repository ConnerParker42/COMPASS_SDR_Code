%NIST Handbook of Freq Stability Analysis, Riley (2008)
%5.2.4: Overlapping Allan Deviation (PG 16, EQ 11)
function [OAD, Tau] = OAD_maxminTau(signal,numPoints, minTau, maxTau)
    %N is the number of data points in the input clock signal, this should be more
    %than the maxTau (at least 4X) to prevent squirrely results at end of plot

    N = length(signal);
    %The averaging factor is multiplied by the minTau (from 1 to
    %MaxTau/MinTau), this is equivalent to making a Tau Vector from MinTau to
    %MaxTau spaced by MinTau
    % maxAvgFactor = maxTau/minTau;

    %Preallocate OAD and Tau Vectors
    Tau = (minTau:minTau:maxTau)';
    % Tau = minTau * [1e0 1e1 1e2 1e3 1e4 1e5 1e6]';
    Tau = Tau(round(logspace(log10(1),log10(length(Tau)),numPoints)));

    Tau = unique(Tau);

    numTaus = length(Tau);
    OAD = zeros(numTaus,1);

    %Run Loop through Averaging Factors from 1 to MaxAvgFactor
    for nT = 1:numTaus

        %Define Tau as AveragingFactor (af) x MinTau
        m = round(Tau(nT)/minTau);

        %Preallocate Summation Loop as Number of Data Points - 2*AvgFactor
        %(Ensures window does not run out of data)
        xn = zeros(N-2*m,1);
        for ii = 1:N-2*m
            xn(ii) = (signal(ii+2*m) - 2*signal(ii+m) + signal(ii))^2;
        end

        AD = sqrt((1/(2*(Tau(nT)^2)*(N-2*m)))*sum(xn,'omitnan'));
        
        OAD(nT) = AD;
    end

end

