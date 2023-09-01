function generateSpikeLFPCouplingSU(duration)

% This code collects all computed spectrograms across datasets and then
% creates a grand average of selective sites during Riv and during PA_FS
% for comparison

%% Enumerate the datasets for PLV

% traces_ according to Selectivity during Rivalry

% datasetsLfpStats{1} = ['B:\H07\12-06-2016\PFC\Bfsgrad1\SpikeLFPCoupling\allSpikes_SUPLV_' num2str(duration) 'ms_Chebyshev1_thea.mat'];
% datasetsLfpStats{2} = ['B:\H07\13-07-2016\PFC\Bfsgrad1\SpikeLFPCoupling\allSpikes_SUPLV_' num2str(duration) 'ms_Chebyshev1_thea.mat'];
% datasetsLfpStats{3} = ['B:\H07\20161019\PFC\Bfsgrad1\SpikeLFPCoupling\allSpikes_SUPLV_' num2str(duration) 'ms_Chebyshev1_thea.mat'];
% datasetsLfpStats{4} = ['B:\H07\20161025\PFC\Bfsgrad1\SpikeLFPCoupling\allSpikes_SUPLV_' num2str(duration) 'ms_Chebyshev1_thea.mat'];
% datasetsLfpStats{5} = ['B:\A11\20170305\PFC\Bfsgrad1\SpikeLFPCoupling\allSpikes_SUPLV_' num2str(duration) 'ms_Chebyshev1_thea.mat'];
% datasetsLfpStats{6} = ['B:\A11\20170302\PFC\Bfsgrad1\SpikeLFPCoupling\allSpikes_SUPLV_' num2str(duration) 'ms_Chebyshev1_thea.mat'];
% 
% datasets_parentDir{1} = ['B:\H07\12-06-2016\PFC\Bfsgrad1\'];
% datasets_parentDir{2} = ['B:\H07\13-07-2016\PFC\Bfsgrad1\'];
% datasets_parentDir{3} = ['B:\H07\20161019\PFC\Bfsgrad1\'];
% datasets_parentDir{4} = ['B:\H07\20161025\PFC\Bfsgrad1\'];
% datasets_parentDir{5} = ['B:\A11\20170305\PFC\Bfsgrad1\'];
% datasets_parentDir{6} = ['B:\A11\20170302\PFC\Bfsgrad1\'];
% 
% % collect
% 
% for iDataset = [1 2 3 4 5 6]
%     
%     load(datasetsLfpStats{iDataset});
% 
%     folderName = ['B:\Results\SpikeLFPCoupling\PLV\Binned\' num2str(duration/1000) 's'];
%     mkdir(folderName)
%     cd(folderName)
%     
%     t = linspace((-duration)/1000,(duration)/1000,duration+1);
%     cd(datasets_parentDir{iDataset})
%     load('nTransitions_0.5s.mat')
%     
%     nTransitions.s270TO90_PA = nTransitions_PA_90;
%     nTransitions.s90TO270_PA = nTransitions_PA_270;
%     
%     nTransitions.s270TO90_BR = nTransitions_BR_90;
%     nTransitions.s90TO270_BR = nTransitions_BR_270;
%     
%     % Collect Datasets
%     
%     spikeLFPCoupling(iDataset).PLVBins = spikeLFPCouplingBins;
%     spikeLFPCoupling(iDataset).nTransitions = nTransitions;
%     
%     
% end

%% Collect Phase Distributions

% traces_ according to Selectivity during Rivalry

datasetsLfpStats{1} = ['B:\H07\12-06-2016\PFC\Bfsgrad1\SpikeLFPCoupling\looserTolerance_SUCollapsed_evtTriggered_SUPhaseValues_' num2str(duration) 'ms_Chebyshev1_low.mat'];
datasetsLfpStats{2} = ['B:\H07\13-07-2016\PFC\Bfsgrad1\SpikeLFPCoupling\looserTolerance_SUCollapsed_evtTriggered_SUPhaseValues_' num2str(duration) 'ms_Chebyshev1_low.mat'];
datasetsLfpStats{3} = ['B:\H07\20161019\PFC\Bfsgrad1\SpikeLFPCoupling\looserTolerance_SUCollapsed_evtTriggered_SUPhaseValues_' num2str(duration) 'ms_Chebyshev1_low.mat'];
datasetsLfpStats{4} = ['B:\H07\20161025\PFC\Bfsgrad1\SpikeLFPCoupling\looserTolerance_SUCollapsed_evtTriggered_SUPhaseValues_' num2str(duration) 'ms_Chebyshev1_low.mat'];
datasetsLfpStats{5} = ['B:\A11\20170305\PFC\Bfsgrad1\SpikeLFPCoupling\looserTolerance_SUCollapsed_evtTriggered_SUPhaseValues_' num2str(duration) 'ms_Chebyshev1_low.mat'];
datasetsLfpStats{6} = ['B:\A11\20170302\PFC\Bfsgrad1\SpikeLFPCoupling\looserTolerance_SUCollapsed_evtTriggered_SUPhaseValues_' num2str(duration) 'ms_Chebyshev1_low.mat'];

for iDataset = [1 2 3 4 5 6]
%for iDataset = 1;
    
    load(datasetsLfpStats{iDataset});

    folderName = ['B:\Results\SpikeLFPCoupling\PhaseDistribution\' num2str(duration/1000) 's'];
    mkdir(folderName)
    cd(folderName)
    
    % Collect Datasets
    
     spikeLFPCoupling(iDataset).PhaseDistribution = eventTriggeredTraces;
    
end
    cd(folderName)
save('evtTriggered_Collapsed_lowerTolerance_SU_low.mat','spikeLFPCoupling','-v7.3')

