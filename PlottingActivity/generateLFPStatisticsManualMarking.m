function generateLFPStatisticsManualMarking

% This code collects all computed spectrograms across datasets and then
% creates a grand average of selective sites during Riv and during PA_FS
% for comparison

%% Enumerate the datasets

% traces_ according to Selectivity during Rivalry

datasetsLfpStats{1} = ['B:\H07\12-06-2016\PFC\Bfsgrad1\LFPSpectrograms\ManualPhysicalSwitches\manualPAEvents_0.5s_back_0.5s.mat'];
datasetsLfpStats{2} = ['B:\H07\13-07-2016\PFC\Bfsgrad1\LFPSpectrograms\ManualPhysicalSwitches\manualPAEvents_0.5s_back_0.5s.mat'];
datasetsLfpStats{3} = ['B:\H07\20161019\PFC\Bfsgrad1\LFPSpectrograms\ManualPhysicalSwitches\manualPAEvents_0.5s_back_0.5s.mat'];
datasetsLfpStats{4} = ['B:\H07\20161025\PFC\Bfsgrad1\LFPSpectrograms\ManualPhysicalSwitches\manualPAEvents_0.5s_back_0.5s.mat'];
datasetsLfpStats{5} = ['B:\A11\20170305\PFC\Bfsgrad1\LFPSpectrograms\ManualPhysicalSwitches\manualPAEvents_0.5s_back_0.5s.mat'];
datasetsLfpStats{6} = ['B:\A11\20170302\PFC\Bfsgrad1\LFPSpectrograms\ManualPhysicalSwitches\manualPAEvents_0.5s_back_0.5s.mat'];

%% Plot grand average for DomSels

% collect

for iSession = 1:length(datasetsLfpStats)
    
    if iSession == 1
        
        peaks_PA_90 = [];
        peaks_PA_270 = [];
        
        t = linspace(-0.5,0.5,501);
        
        
        load(datasetsLfpStats{iSession});
        folderName = ['B:\Results\LFP_Statistics\ManualMarking\std4\low\0.5s'];
        mkdir(folderName)
        cd(folderName)
        
        % Do for PA 90
        
        for iElec = 1:96
            
            peaks_PA_90 = [peaks_PA_90 (manualPAEvents(iElec).PA.dom90events)];
            peaks_PA_270 = [peaks_PA_270 (manualPAEvents(iElec).PA.dom270events)];
            
        end
        
        peaks_PA = [peaks_PA_90 peaks_PA_270];
        
    else
        
        load(datasetsLfpStats{iSession});
        folderName = ['B:\Results\LFP_Statistics\ManualMarking\std4\low\0.5s'];
        mkdir(folderName)
        cd(folderName)
        
        % Do for PA 90
        
        for iElec = 1:96
            
            peaks_PA = [peaks_PA (manualPAEvents(iElec).PA.domevents)];
            
        end
        
        
    end
    
end

save('paPeaks_Manual.mat','peaks_PA')

