function[EB_Lower, EB_Upper] = ADEV_ErrorBars(Tau, OAD, N)
% ADEV_ErrorBars: Calculates the upper and low bound error of ADEV
%   Inputs: Tau = vector of tau values
%       OAD = Overlapping Allan Deviation values
%       N = number of tua values
%   Outputs: EB_Lower = vector of lower bound ADEV errors
%       EB_Upper = vector of upper bound ADEV errors
%   Plots: N/A

% Note from Conner 
% I was never able to verify this code's validity, use with cause until
% thoroughly tested and validated against Stable32


inflection = find(OAD == min(OAD));
% y2 = find(abs(Tau - 10^floor(log10(Tau(inflection))))== min(abs(Tau - 10^floor(log10(Tau(inflection))))));
% slopes = (log10(OAD(y2)) - log10(OAD(1)))/(log10(Tau(y2)) - log10(Tau(1)));
% 
% if inflection ~= min(OAD);
%     y3 = find(abs(Tau - 10^ceil(log10(Tau(inflection))))== min(abs(Tau - 10^ceil(log10(Tau(inflection))))));
%     endEffects = find(OAD == max(OAD(y3:end)));
%     if endEffects ~= OAD(end);
%         y4 = y3 + find(gradient(log10(Tau(y3:end)), log10(OAD(y3:end)))>5,1);%find(abs(Tau - 3*10^floor(log10(Tau(endEffects))))== min(abs(Tau - 3*10^floor(log10(Tau(endEffects))))));
%         slopes = [slopes; (log10(OAD(y4)) - log10(OAD(y3)))/(log10(Tau(y4)) - log10(Tau(y3)))];
%     end
% end


edf = NaN(length(Tau), 1);
EB_Upper = NaN(length(Tau), 1);
EB_Lower = NaN(length(Tau), 1);
for tt = 1:length(Tau)
    m = Tau(tt)/Tau(1);
    if tt < inflection
        edf(tt) = (N+1)*(N-2*m)/(2*(N-m));
        
    else
        edf(tt) = ((3*(N-1)/2*m) - (2*(N-2)/N))*(4*(m^2)/(4*(m^2) +5));
    end
    EB_Upper(tt) = (OAD(tt)^2)*edf(tt)/chi2inv(.05, edf(tt));
    EB_Lower(tt) = (OAD(tt)^2)*edf(tt)/chi2inv(.95, edf(tt));
end

EB_Lower = OAD - sqrt(EB_Lower);
EB_Upper = OAD - sqrt(EB_Upper);
end