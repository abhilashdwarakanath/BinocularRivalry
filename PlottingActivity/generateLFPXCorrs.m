function generateLFPXCorrs(duration)

% This code collects all computed spectrograms across datasets and then
% creates a grand average of selective sites during Riv and during PA_FS
% for comparison

%% Enumerate the datasets for PLV

% traces_ according to Selectivity during Rivalry

datasetsLfpStats{1} = ['B:\H07\12-06-2016\PFC\Bfsgrad1\LFPStatistics\EventXCorrs_' num2str(duration) 'ms_Chebyshev1_.mat'];
datasetsLfpStats{2} = ['B:\H07\13-07-2016\PFC\Bfsgrad1\LFPStatistics\EventXCorrs_' num2str(duration) 'ms_Chebyshev1_.mat'];
datasetsLfpStats{3} = ['B:\H07\20161019\PFC\Bfsgrad1\LFPStatistics\EventXCorrs_' num2str(duration) 'ms_Chebyshev1_.mat'];
datasetsLfpStats{4} = ['B:\H07\20161025\PFC\Bfsgrad1\LFPStatistics\EventXCorrs_' num2str(duration) 'ms_Chebyshev1_.mat'];
datasetsLfpStats{5} = ['B:\A11\20170305\PFC\Bfsgrad1\LFPStatistics\EventXCorrs_' num2str(duration) 'ms_Chebyshev1_.mat'];
datasetsLfpStats{6} = ['B:\A11\20170302\PFC\Bfsgrad1\LFPStatistics\EventXCorrs_' num2str(duration) 'ms_Chebyshev1_.mat'];

datasets_parentDir{1} = ['B:\H07\12-06-2016\PFC\Bfsgrad1\'];
datasets_parentDir{2} = ['B:\H07\13-07-2016\PFC\Bfsgrad1\'];
datasets_parentDir{3} = ['B:\H07\20161019\PFC\Bfsgrad1\'];
datasets_parentDir{4} = ['B:\H07\20161025\PFC\Bfsgrad1\'];
datasets_parentDir{5} = ['B:\A11\20170305\PFC\Bfsgrad1\'];
datasets_parentDir{6} = ['B:\A11\20170302\PFC\Bfsgrad1\'];

% collect

for iDataset = [1 2 3 4 5 6]
    
    load(datasetsLfpStats{iDataset});

    folderName = ['B:\Results\LFPStatistics\XCorrs\EventTriggered\' num2str(duration/1000) 's'];
    mkdir(folderName)
    cd(folderName)
    
    t = linspace((-duration)/1000,(duration)/1000,duration+1);
    cd(datasets_parentDir{iDataset})
    load('nTransitions_0.5s.mat')
    
    nTransitions.s270TO90_PA = nTransitions_PA_90;
    nTransitions.s90TO270_PA = nTransitions_PA_270;
    
    nTransitions.s270TO90_BR = nTransitions_BR_90;
    nTransitions.s90TO270_BR = nTransitions_BR_270;
    
    % Collect Datasets
    
    LFPPeakShifts(iDataset).betaLowLag = XCorrs;
    LFPPeakShifts(iDataset).nTransitions = nTransitions;
    
    
end

cd(folderName)

save('EventXCorrs_lowBeta_Lag.mat','LFPPeakShifts','-v7.3');