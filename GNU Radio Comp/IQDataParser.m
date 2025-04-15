function [parsedData] = IQDataParser(filesToRead, readPath, sampleRate, signalFreq, beatFreq)
% IQDataParser: Parses unwrapped phase data from GNU Radio Companion binary
% files
%   Inputs: filesToRead = array of files to parse data from
%       readPath = file path to folder with files to read
%       sampleRate = sample rate of samples in files
%       signalFreq = frequency of received signal
%       beatFreq = frequency of mixed down signal
%   Outputs: parsedData = cell array of tables with time and phase in
%       radians and seconds
%   Plots: N/A
  
    addpath(readPath)
    parsedData = cell(0);
    for i=(1:length(filesToRead))
        file0 = filesToRead{i};
    
        % First complex file from GNU 
        fileID = fopen(file0, 'rb');
        FreqFile = fread(fileID, 1e8, 'float');
        % Separate In-Phase and Quadrature components
        SignalInPhase = FreqFile(1:2:end); % real (cosine)
        SignalQuadrature = FreqFile(2:2:end); % complex (sine)
        
        t = (0:length(SignalInPhase)-1)'./sampleRate;
        
        % Remove beat frequency
        beatFreqCos = cos(2 * pi * beatFreq * t);
        beatFreqSin = sin(2 * pi * beatFreq * t);

        % Complex mixing
        FreqInPhasePrime = SignalInPhase .* beatFreqCos + SignalQuadrature .* beatFreqSin;
        FreqQuadraturePrime = SignalQuadrature .* beatFreqCos - SignalInPhase .* beatFreqSin;

        % Real mixing
        % FreqInPhasePrime = SignalInPhase .* beatFreqCos;
        % FreqQuadraturePrime = -SignalInPhase .* beatFreqSin;
        
        % Compute phase in radians from each file and difference
        wrapRad = atan2(FreqQuadraturePrime,FreqInPhasePrime);

        % Unwrap before converting to seconds
        phaseRad = unwrap(wrapRad);
        
        % Convert phase from radians to seconds
        phaseSec = phaseRad  ./ (2 * pi * signalFreq);

         % Build time vector based on sample size and sample rate
        dataTable = table(t, SignalInPhase, SignalQuadrature, phaseRad, phaseSec, 'VariableNames', ["Time", "In Phase [V]", "Quadrature [V]", "Phase [rad]", "Phase [s]"] );
        parsedData{end+1} = dataTable;
    end
end

