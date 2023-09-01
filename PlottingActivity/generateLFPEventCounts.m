function generateLFPEventCounts(duration,filtType)

% This code collects all computed spectrograms across datasets and then
% creates a grand average of selective sites during Riv and during PA_FS
% for comparison

%% Enumerate the datasets

% traces_ according to Selectivity during Rivalry

datasetsLfpStats{1} = ['B:\H07\12-06-2016\PFC\Bfsgrad1\LFPStatistics\TbyT_blpCharacteristics_' num2str(duration) 'ms_Chebyshev1_' filtType '.mat'];
datasetsLfpStats{2} = ['B:\H07\13-07-2016\PFC\Bfsgrad1\LFPStatistics\TbyT_blpCharacteristics_' num2str(duration) 'ms_Chebyshev1_' filtType '.mat'];
datasetsLfpStats{3} = ['B:\H07\20161019\PFC\Bfsgrad1\LFPStatistics\TbyT_blpCharacteristics_' num2str(duration) 'ms_Chebyshev1_' filtType '.mat'];
datasetsLfpStats{4} = ['B:\H07\20161025\PFC\Bfsgrad1\LFPStatistics\TbyT_blpCharacteristics_' num2str(duration) 'ms_Chebyshev1_' filtType '.mat'];
datasetsLfpStats{5} = ['B:\A11\20170305\PFC\Bfsgrad1\LFPStatistics\TbyT_blpCharacteristics_' num2str(duration) 'ms_Chebyshev1_' filtType '.mat'];
datasetsLfpStats{6} = ['B:\A11\20170302\PFC\Bfsgrad1\LFPStatistics\TbyT_blpCharacteristics_' num2str(duration) 'ms_Chebyshev1_' filtType '.mat'];

datasets_parentDir{1} = ['B:\H07\12-06-2016\PFC\Bfsgrad1\'];
datasets_parentDir{2} = ['B:\H07\13-07-2016\PFC\Bfsgrad1\'];
datasets_parentDir{3} = ['B:\H07\20161019\PFC\Bfsgrad1\'];
datasets_parentDir{4} = ['B:\H07\20161025\PFC\Bfsgrad1\'];
datasets_parentDir{5} = ['B:\A11\20170305\PFC\Bfsgrad1\'];
datasets_parentDir{6} = ['B:\A11\20170302\PFC\Bfsgrad1\'];

%% Plot grand average for DomSels

% collect

for iDataset = [1 2 3 4 5 6]
    
    load(datasetsLfpStats{iDataset});

    folderName = ['B:\Results\LFP_Statistics\TbyT\EventCounts\' filtType '\' num2str(duration/1000) 's'];
    mkdir(folderName)
    cd(folderName)
    
    t = linspace((-duration)/1000,(duration)/1000,duration+1);
    sigLength = length(t);
    midPoint = floor(sigLength/2);
    nSampsPerBin = 25; % 50ms
    nBins = floor(midPoint/nSampsPerBin);
    cd(datasets_parentDir{iDataset})
    load('nTransitions_0.5s.mat')
    
    lfpStatistics(iDataset).eventCounts = blpCharacteristics;
    lfpStatistics(iDataset).nTransitions_PA_90TO270 = nTransitions_PA_270;
    lfpStatistics(iDataset).nTransitions_PA_270TO90 = nTransitions_PA_90;
    lfpStatistics(iDataset).nTransitions_BR_90TO270 = nTransitions_BR_270;
    lfpStatistics(iDataset).nTransitions_BR_270TO90 = nTransitions_BR_90;
    
end

cd(folderName)
filename = ['eventCountsLfpStatistics_' filtType '_' num2str(duration/1000) 's.mat'];
save(filename,'lfpStatistics','-v7.3');
