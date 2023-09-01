function generateLFPtracesEvtTriggeredPLV(duration)

% This code collects all computed spectrograms across datasets and then
% creates a grand average of selective sites during Riv and during PA_FS
% for comparison

%% Enumerate the datasets

% traces_ according to Selectivity during Rivalry

datasetsDS{1} = ['B:\H07\12-06-2016\PFC\Bfsgrad1\LFPStatistics\std4_evtTriggered_jMUPLV_' num2str(duration) 'ms_Chebyshev1_'  '.mat'];
datasetsDS{2} = ['B:\H07\13-07-2016\PFC\Bfsgrad1\LFPStatistics\std4_evtTriggered_jMUPLV_' num2str(duration) 'ms_Chebyshev1_'  '.mat'];
datasetsDS{3} = ['B:\H07\20161019\PFC\Bfsgrad1\LFPStatistics\std4_evtTriggered_jMUPLV_' num2str(duration) 'ms_Chebyshev1_'  '.mat'];
datasetsDS{4} = ['B:\H07\20161025\PFC\Bfsgrad1\LFPStatistics\std4_evtTriggered_jMUPLV_' num2str(duration) 'ms_Chebyshev1_'  '.mat'];
datasetsDS{5} = ['B:\A11\20170305\PFC\Bfsgrad1\LFPStatistics\std4_evtTriggered_jMUPLV_' num2str(duration) 'ms_Chebyshev1_'  '.mat'];
datasetsDS{6} = ['B:\A11\20170302\PFC\Bfsgrad1\LFPStatistics\std4_evtTriggered_jMUPLV_' num2str(duration) 'ms_Chebyshev1_'  '.mat'];

%% Plot grand average for DomSels

% collect

for iDataset = [1 2 3 4 5 6]
    
    load(datasetsDS{iDataset});
    folderName = ['B:\Results\EventTriggeredStatistics\spikeLFP\jMU\std4\' num2str(duration/1000) 's'];
    mkdir(folderName)
    cd(folderName)
    
    for iChan = 1:96
        
        % PLV
        
        couplingMeasure.PLV.BR_Pre_270TO90{iDataset,iChan} = eventTriggeredTraces(iChan).BR.s270TO90.Pre.PLV;
        couplingMeasure.PLV.BR_Post_270TO90{iDataset,iChan} = eventTriggeredTraces(iChan).BR.s270TO90.Post.PLV;
        couplingMeasure.PLV.BR_Pre_90TO270{iDataset,iChan} = eventTriggeredTraces(iChan).BR.s90TO270.Pre.PLV;
        couplingMeasure.PLV.BR_Post_90TO270{iDataset,iChan} = eventTriggeredTraces(iChan).BR.s90TO270.Post.PLV;
        
        couplingMeasure.PLV.PA_Pre_270TO90{iDataset,iChan} = eventTriggeredTraces(iChan).PA.s270TO90.Pre.PLV;
        couplingMeasure.PLV.PA_Post_270TO90{iDataset,iChan} = eventTriggeredTraces(iChan).PA.s270TO90.Post.PLV;
        couplingMeasure.PLV.PA_Pre_90TO270{iDataset,iChan} = eventTriggeredTraces(iChan).PA.s90TO270.Pre.PLV;
        couplingMeasure.PLV.PA_Post_90TO270{iDataset,iChan} = eventTriggeredTraces(iChan).PA.s90TO270.Post.PLV;
        
        % Circular Correlation
        
        couplingMeasure.CIRC_R.BR_Pre_270TO90{iDataset,iChan} = eventTriggeredTraces(iChan).BR.s270TO90.Pre.circcc;
        couplingMeasure.CIRC_R.BR_Post_270TO90{iDataset,iChan} = eventTriggeredTraces(iChan).BR.s270TO90.Post.circcc;
        couplingMeasure.CIRC_R.BR_Pre_90TO270{iDataset,iChan} = eventTriggeredTraces(iChan).BR.s90TO270.Pre.circcc;
        couplingMeasure.CIRC_R.BR_Post_90TO270{iDataset,iChan} = eventTriggeredTraces(iChan).BR.s90TO270.Post.circcc;
        
        couplingMeasure.CIRC_R.PA_Pre_270TO90{iDataset,iChan} = eventTriggeredTraces(iChan).PA.s270TO90.Pre.circcc;
        couplingMeasure.CIRC_R.PA_Post_270TO90{iDataset,iChan} = eventTriggeredTraces(iChan).PA.s270TO90.Post.circcc;
        couplingMeasure.CIRC_R.PA_Pre_90TO270{iDataset,iChan} = eventTriggeredTraces(iChan).PA.s90TO270.Pre.circcc;
        couplingMeasure.CIRC_R.PA_Post_90TO270{iDataset,iChan} = eventTriggeredTraces(iChan).PA.s90TO270.Post.circcc;
        
    end
    
end

cd(folderName)
filename = ['PLV_CIRC_R_std4_Low_eventTriggered_Spikes_' num2str(duration/1000) 's.mat'];
save(filename,'couplingMeasure','-v7.3');
