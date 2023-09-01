function generateSustainedBetavsSilent

%% Enumerate the datasets

datasets{1} = 'B:\H07\12-06-2016\PFC\Bfsgrad1\SFC\ContinuousBetavsSilent\ContinuousBetavsSilent_PA.mat';
recDate{1} = '12062016';
fileID{1} = '12-06-2016';
subjID{1} = 'Hayo';
datasets{2} = 'B:\H07\13-07-2016\PFC\Bfsgrad1\SFC\ContinuousBetavsSilent\ContinuousBetavsSilent_PA.mat';
recDate{2} = '13072016';
fileID{2} = '13-07-2016';
subjID{2} = 'Hayo';
datasets{3} = 'B:\H07\20161019\PFC\Bfsgrad1\SFC\ContinuousBetavsSilent\ContinuousBetavsSilent_PA.mat';
recDate{3} = '19102016';
fileID{3} = '20161019';
subjID{3} = 'Hayo';
datasets{4} = 'B:\H07\20161025\PFC\Bfsgrad1\SFC\ContinuousBetavsSilent\ContinuousBetavsSilent_PA.mat';
recDate{4} = '25102016';
fileID{4} = '20161025';
subjID{4} = 'Hayo';
datasets{5} = 'B:\A11\20170305\PFC\Bfsgrad1\SFC\ContinuousBetavsSilent\ContinuousBetavsSilent_PA.mat';
recDate{5} = '05032017';
fileID{5} = '20170305';
subjID{5} = 'Anton';
datasets{6} = 'B:\A11\20170302\PFC\Bfsgrad1\SFC\ContinuousBetavsSilent\ContinuousBetavsSilent_PA.mat';
recDate{6} = '02032017';
fileID{6} = '20170302';
subjID{6} = 'Anton';

%% Collect and plot boxplot and do statistics

sfc_PA_sfcSustained = [];
phi_PA_phiSustained = [];

sfc_PA_sfcSilence = [];
phi_PA_phiSilence = [];

for iDataset = 1:6
    
    load(datasets{iDataset})
    
    sfc_PA_sfcSustained = [sfc_PA_sfcSustained;SFC.pref90.sfcBetas;SFC.pref270.sfcBetas];
    phi_PA_phiSustained = [phi_PA_phiSustained;SFC.pref90.phiBetas;SFC.pref270.phiBetas];
    
    sfc_PA_sfcSilence = [sfc_PA_sfcSilence;SFC.pref90.sfcSilents;SFC.pref270.sfcSilents];
    phi_PA_phiSilence = [phi_PA_phiSilence;SFC.pref90.phiSilents;SFC.pref270.phiSilents];
    
end

%% Plot and get statistics

subplot(1,2,1)
dataMatrix = [sfc_PA_sfcSustained;sfc_PA_sfcSilence];
grouping = [ones(length(sfc_PA_sfcSustained),1); 2.*ones(length(sfc_PA_sfcSilence),1)];
boxplot(dataMatrix,grouping)

subplot(1,2,2)
dataMatrix = [phi_PA_phiSustained;phi_PA_phiSilence];
grouping = [ones(length(phi_PA_phiSustained),1); 2.*ones(length(phi_PA_phiSilence),1)];
boxplot(dataMatrix,grouping)

