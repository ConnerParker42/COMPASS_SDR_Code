function [] = FFT_Plotter(data, sampleRate)
% FFT_Plotter: Plot signal in frequency domain
%   Inputs: data = data vector
%       sampleRate = sample rate of data
%   Outputs: N/A
%   Plots: Signal in frequency domain

    data = detrend(data);
    
    Fs = sampleRate;
    L = length(data);
    Y = fft(data);
    
    P2 = abs(Y/L);
    P1 = P2(1:L/2+1);
    P1(2:end-1) = 2*P1(2:end-1);
    f = Fs/L*(0:(L/2));
    
    % figure(WindowState="maximized")
    figure()
    plot(f,P1,LineWidth=1.5) 
    title("Single-Sided Amplitude Spectrum of Phase Difference", FontSize=20)
    xlabel("f (Hz)", FontSize=15, Interpreter='latex'); ylabel("|P1(f)|", FontSize=15, Interpreter='latex')
    legend('Detrended Phase Difference PSD')
end

