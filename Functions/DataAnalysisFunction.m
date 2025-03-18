function [OAD, tau] = DataAnalysisFunction(clock_table,titletext)
    % --ASC Data Analysis--
    % Author: Christopher Krebs - 06/03/2021
    % Updated: Justin Pedersen  - 09/07/2022
    % Updated: Conner Parker    - 06/08/2023
    %==========================================================================
    % Run ASC_parser_main to put data in workspace
    %
    % Run through data sets to generate plots of instantaneous solutions and
    % NovAtel filtered solutions to compare.
    
    % Note: Cumulative sum, derivatives, and other prior calculations have been
    % removed from original DataAnalysisFunction but kept within DataAnalysis
    % script
    %==========================================================================
    % last edit: 09/07/2022
    
    c = 299792458; % speed of light [m/s]
    
    % instantaneous Solutions
    instant_bias = table2array(clock_table(:,9)); % [m]
    instant_bias_rate = table2array(clock_table(:,10)); % [m/s]
    
    % Convert data to correct units
    instant_bias = instant_bias./c; % [s]
    instant_bias_rate = instant_bias_rate./c; % [s/s]
    sample_rate = 1/(clock_table{2,2} - clock_table{1,2});
    
    % redefine time units as desired
    % note: original data collected in seconds
    time = [1:numel(instant_bias)]./3600 ./ sample_rate; % [h]
    %time = [1:length(instant_bias)]./60; %[min]
    
    % detrend
    bias_detrend = detrend(instant_bias);
    
    % ADEV
    decArray = round((1:1:numel(instant_bias))');
    ADEV_time = (1:1:length(decArray))';
    ADEV_points = 1000;
    minTau = 1/sample_rate;
    maxTau = numel(ADEV_time)/3;
    [OAD,tau] = OAD_maxminTau(instant_bias(decArray),ADEV_points,minTau,maxTau);
    
    % CSAC ADEV values from Microsemi
    CSAC_Tau_1 =  3E-10;
    CSAC_Tau_10 = 1E-10;
    CSAC_Tau_100 = 3E-11;
    CSAC_Tau_1000 = 1E-11;
    % FS725 ADEV values from SR
    rb_Tau_1 = 2e-11;
    rb_Tau_10 = 5e-12; 
    rb_Tau_100 = 7e-13;
    
    % plot: time series of bias
    figure
    plot(time,instant_bias,'linewidth',1.5)
    grid on
    set(gca,'fontsize',15)
    title(titletext,'Bias','fontsize',20)
    xlabel('Elapsed Time [hr]','fontsize',15)
    ylabel('Bias [s]','fontsize',15)
    
    % plot: time series of bias drift
    figure
    scatter(time,instant_bias_rate,'filled')
    grid on
    set(gca,'fontsize',15)
    title(titletext,'Bias Drift','fontsize',20)
    xlabel('Elapsed Time [hr]','fontsize',15)
    ylabel('Bias Rate [s/s]','fontsize',15)
    
    % plot: detrended
    figure
    plot(time,bias_detrend,'linewidth',1.5)
    grid on
    set(gca,'fontsize',15)
    title(titletext,'Detrended','fontsize',20)
    xlabel('Elapsed Time [hr]','fontsize',15)
    ylabel('Detrended Bias [s]','fontsize',15)
    
    % plot (3x): bias + bias drift + detrended
    figure
    
    subplot(3,1,1)
    plot(time,instant_bias,'linewidth',1.5)
    grid on
    title(titletext)
    subtitle('Bias')
    ylabel('Bias [s]')
    
    subplot(3,1,2)
    scatter(time,instant_bias_rate,'filled')
    grid on
    subtitle('Bias Drift')
    ylabel('Bias Rate [s/s]')
    
    subplot(3,1,3)
    plot(time,bias_detrend,'linewidth',1.5)
    grid on
    subtitle('Detrended')
    xlabel('Elapsed Time [hr]')
    ylabel('Detrended Bias [s]')
    
    % plot: ADEV
    figure
    loglog(tau,OAD,'linewidth',1.5)
    grid on
    hold on
    loglog(1,CSAC_Tau_1,'or')
    loglog(10,CSAC_Tau_10,'or')
    loglog(100,CSAC_Tau_100,'or')
    loglog(1000,CSAC_Tau_1000,'or')
    loglog(1,rb_Tau_1,'k*','markersize',5,'linewidth',1.5)
    loglog(10,rb_Tau_10,'k*','markersize',5,'linewidth',1.5)
    loglog(100,rb_Tau_100,'k*','markersize',5,'linewidth',1.5)
    set(gca,'fontsize',15)
    title(titletext,'Frequency Stability','fontsize',20)
    xlabel('Averaging Time \tau [s]','fontsize',15)
    ylabel('Allan Deviation \sigma(\tau)','fontsize',15)
    legend('Test Result','CSAC Spec','','','','Rb Spec')
    
    % stop counting
    toc

end