function [] = OADPlotter(OADData)
% OADPlotter: Plot ADEV graphs
%   Inputs: OADData = cell array from OADParser function
%   Outputs: N/A
%   Plots: ADEV graphs

    % Rubidium FS725 Specs from data sheet
    Rb_ADEVSpecs = [1 2e-11; 10 1e-11; 100 2e-12];
    Rb_PhaseNoiseSpecs = [10 -130; 100 -140; 1000 -150; 10000 -155];
    
    % NEL NIST OCXO Specs from data sheet
    OCXO_ADEVSpecs = [0.1 5e-13; 1 2e-12; 10 5e-12];
    OCXO_PhaseNoiseSpecs = [1 -115; 10 -145; 100 -157; 1000 -162; 10000 -170; 100000 -172];
    
    % CSAC SA.45s Specs from data sheet
    CSAC_ADEVSpecs = [1 3e-10; 10 1e-10; 100 3e-11; 1000 1e-11];
    CSAC_PhaseNoiseSpecs = [1 -50; 10 -70; 100 -113; 1000 -128; 10000 -135; 100000 -140];
    
    % mRO-50 Specs from data sheet
    mRO_ADEVSpec = [1 1e-10; 10 3e-11; 100 1e-11];

    % TODO Add NEL OCSO Specs
    % OCXO_ADEVSpec = [.1 5e-13; 1 2e-12; 10 5e-12];
    OCXO_ADEVSpec = [1 2e-12; 10 5e-12];

    figure()
    hold on
    xlabel('$\tau$ [s]', FontSize=10, Interpreter='latex'); ylabel("Allan Deviation", FontSize=10); grid on;
    set(gca, 'XScale', 'log'); set(gca, 'YScale', 'log');
    title('Allan Deviation against Tau', FontSize=15)
    for i = 1:length(OADData)
        Tau = OADData{i}.Tau;
        OAD = OADData{i}.OAD;
        plot(Tau,OAD, LineWidth=1.5)
    end
    scatter(CSAC_ADEVSpecs(:,1), CSAC_ADEVSpecs(:,2), 'filled')
    scatter(Rb_ADEVSpecs(:,1), Rb_ADEVSpecs(:,2), 'filled')
    scatter(mRO_ADEVSpec(:,1), mRO_ADEVSpec(:,2), 'filled')
    scatter(OCXO_ADEVSpec(:,1), OCXO_ADEVSpec(:,2), 'filled')
    % ylim([10^-13, 10^-9])
    if(length(OADData) < 2)
        legend(["OAD RF1 - RF2", "CSAC Specs", "Rb Specs", "mRO Specs", "NEL OXCO Specs"])
    else
        legend(["OAD A0 - A1", "OAD B0 - B1", "CSAC Specs", "Rb Specs", "mRO Specs", "NEL OXCO Specs"])
    end
end

