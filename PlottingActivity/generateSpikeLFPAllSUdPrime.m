function generateSpikeLFPAllSUdPrime(duration)

%% Datasets and SU info

dates{1} = 'H07\12-06-2016';
dates{2} = 'H07\13-07-2016';
dates{3} = 'H07\20161019';
dates{4} = 'H07\20161025';
dates{5} = 'A11\20170305';
dates{6} = 'A11\20170302';

nDatasets = length(dates);

cd (['B:\Results\SpikeLFPCoupling\PhaseDistribution\' num2str(duration/1000) 's']);
load evtTriggered_Collapsed_lowerTolerance_SU_low.mat
%% 270TO90 modulated channels
   
pooled_M_Diff = [];
pooled_M_270TO90 = [];
pooled_M_90TO270 = [];
pooled_dPrimes = [];

for iDataset = 1:6
    clear M_diff; clear M_270TO90; clear M_90TO270;
    
    cd(['B:\Results\' dates{iDataset} '\Bfsgrad\PFC\SUA\Preference_Arrays\cSwitch'])
    load('1000_250_1000_DF_pref_array_switch.mat')
    cd(['B:\' dates{iDataset} '\PFC\Bfsgrad1'])
    load('Su_info.mat')
    dprimeInfo = pref_array_switch.bs_Riv_dprime';
    dprimeInfo = [dprimeInfo SU_info];
    
    [elec, su] = size(spikeLFPCoupling(iDataset).PhaseDistribution);
    
    for j = 1:su
        
        tempDist270TO90 = wrapTo2Pi(spikeLFPCoupling(iDataset).PhaseDistribution(j).BR.s270TO90.Pre.phaseDist);
        
        tempDist270TO90(isnan(tempDist270TO90)) = [];
        
        tempDist90TO270 = wrapTo2Pi(spikeLFPCoupling(iDataset).PhaseDistribution(j).BR.s90TO270.Pre.phaseDist);
        
        tempDist90TO270(isnan(tempDist90TO270)) = [];
        
        if ~isempty(tempDist270TO90) && ~isempty(tempDist90TO270)
            
            r_270TO90 = abs(mean(exp(1i*tempDist270TO90)));
            m_270TO90 = (angle(mean(exp(1i*tempDist270TO90))));
            
            r_90TO270 = abs(mean(exp(1i*tempDist90TO270))); % Get the resultant length
            m_90TO270 = (angle(mean(exp(1i*tempDist90TO270)))); % Get the mean angle
            
            M_270TO90(j) = wrapTo2Pi(m_270TO90);
            M_90TO270(j) = wrapTo2Pi(m_90TO270);
            
            M_diff(j) = abs(M_270TO90(j)-M_90TO270(j));
            
        else M_diff(j) = NaN;
            
            M_270TO90(j) = NaN;
            
            M_90TO270(j) = NaN;
            
        end
        
        
    end
    
    pooled_M_Diff = [pooled_M_Diff M_diff];
    pooled_dPrimes = [pooled_dPrimes;dprimeInfo(:,1)];
    pooled_M_270TO90 = [pooled_M_270TO90 M_270TO90];
    pooled_M_90TO270 = [pooled_M_90TO270 M_90TO270];
    
    
    
end

scatter(pooled_M_Diff,pooled_dPrimes,'o')
hold on
plot([0 2*pi], [0 2*pi] ,'k','LineWidth',1.5)
grid on
box off
axis tight
xlabel('Phase Difference [rad]')
ylabel('d-Prime')
title('Phase Difference - Pooled SU vs d-Prime')