function generateLFPStatisticsRawSeparated(duration,filtType)

dbstop if error

% This code collects all computed spectrograms across datasets and then
% creates a grand average of selective sites during Riv and during PA_FS
% for comparison

%% Enumerate the datasets

% traces_ according to Selectivity during Rivalry

datasetsLfpStats{1} = ['B:\H07\12-06-2016\PFC\Bfsgrad1\LFPStatistics\MMstd4_blpCharacteristics_' num2str(duration) 'ms_Chebyshev1_' filtType '.mat'];
datasetsLfpStats{2} = ['B:\H07\13-07-2016\PFC\Bfsgrad1\LFPStatistics\MMstd4_blpCharacteristics_' num2str(duration) 'ms_Chebyshev1_' filtType '.mat'];
datasetsLfpStats{3} = ['B:\H07\20161019\PFC\Bfsgrad1\LFPStatistics\MMstd4_blpCharacteristics_' num2str(duration) 'ms_Chebyshev1_' filtType '.mat'];
datasetsLfpStats{4} = ['B:\H07\20161025\PFC\Bfsgrad1\LFPStatistics\MMstd4_blpCharacteristics_' num2str(duration) 'ms_Chebyshev1_' filtType '.mat'];
datasetsLfpStats{5} = ['B:\A11\20170305\PFC\Bfsgrad1\LFPStatistics\MMstd4_blpCharacteristics_' num2str(duration) 'ms_Chebyshev1_' filtType '.mat'];
datasetsLfpStats{6} = ['B:\A11\20170302\PFC\Bfsgrad1\LFPStatistics\MMstd4_blpCharacteristics_' num2str(duration) 'ms_Chebyshev1_' filtType '.mat'];

datasets_parentDir{1} = ['B:\H07\12-06-2016\PFC\Bfsgrad1\'];
datasets_parentDir{2} = ['B:\H07\13-07-2016\PFC\Bfsgrad1\'];
datasets_parentDir{3} = ['B:\H07\20161019\PFC\Bfsgrad1\'];
datasets_parentDir{4} = ['B:\H07\20161025\PFC\Bfsgrad1\'];
datasets_parentDir{5} = ['B:\A11\20170305\PFC\Bfsgrad1\'];
datasets_parentDir{6} = ['B:\A11\20170302\PFC\Bfsgrad1\'];

%% Plot grand average for DomSels

% collect

for iDataset = 1:length(datasetsLfpStats)
    
    load(datasetsLfpStats{iDataset});

    folderName = ['B:\Results\LFP_Statistics\PFC\MM\std4\' filtType '\' num2str(duration/1000) 's'];
    mkdir(folderName)
    cd(folderName)
    
    t = linspace((-duration)/1000,(duration)/1000,duration+1);
    sigLength = length(t);
    midPoint = floor(sigLength/2);
    nSampsPerBin = 25; % 50ms
    nBins = floor(midPoint/nSampsPerBin);
    cd(datasets_parentDir{iDataset})
    load('nTransitions_0.5s.mat')
    
    nTransitions_PA_90TO270(iDataset) = nTransitions_PA_270;
    nTransitions_PA_270TO90(iDataset) = nTransitions_PA_90;
    nTransitions_BR_90TO270(iDataset) = nTransitions_BR_270;
    nTransitions_BR_270TO90(iDataset) = nTransitions_BR_90;
    
    % Do for BR90
    
%     for iElec = 1:96
%         
%         % Set a temporal criterion of dip+100ms, so 300ms - DON'T DO THIS!
%         % ARTIFICIAL REDUCTION OF POST EVENTS!!!
%         
%         preIdxs90 = blpCharacteristics(iElec).BR.dom90.preEvtTimes>=-0.5; postIdxs90 = blpCharacteristics(iElec).BR.dom90.postEvtTimes<=0.5;
%         preIdxs270 = blpCharacteristics(iElec).BR.dom270.preEvtTimes>=-0.5; postIdxs270 = blpCharacteristics(iElec).BR.dom270.postEvtTimes<=0.5;
%         
%         % Event times
%         evtTimes_pre_BR_90{iDataset}{iElec} = [blpCharacteristics(iElec).BR.dom90.preEvtTimes(preIdxs90)];
%         evtTimes_post_BR_90{iDataset}{iElec} = [blpCharacteristics(iElec).BR.dom90.postEvtTimes(postIdxs90)];
%         
%         evtTimes_pre_BR_270{iDataset}{iElec} = [blpCharacteristics(iElec).BR.dom270.preEvtTimes(preIdxs270)];
%         evtTimes_post_BR_270{iDataset}{iElec} = [blpCharacteristics(iElec).BR.dom270.postEvtTimes(postIdxs270)];
%         
%         % Event amplitudes
%         ampPreEvents_BR_90{iDataset}{iElec} = [blpCharacteristics(iElec).BR.dom90.preAmps(preIdxs90)];
%         ampPostEvents_BR_90{iDataset}{iElec} = [blpCharacteristics(iElec).BR.dom90.postAmps(postIdxs90)];
%         
%         ampPreEvents_BR_270{iDataset}{iElec} = [blpCharacteristics(iElec).BR.dom270.preAmps(preIdxs270)];
%         ampPostEvents_BR_270{iDataset}{iElec} = [blpCharacteristics(iElec).BR.dom270.postAmps(postIdxs270)];
%         
%         % Signal energy
%         for iTrace = 1:size(blpCharacteristics(iElec).BR.dom90.traces,1)
%             tempTrace = blpCharacteristics(iElec).BR.dom90.traces(iTrace,1:midPoint);
%             tempBins = reshape(tempTrace,[],nBins);
%             tempSigEnergy = (1/nSampsPerBin).*sum(tempBins.^2,1);
%             sigEnergy_pre_BR_90(iTrace,:) = tempSigEnergy;
%         end
%         for iTrace = 1:size(blpCharacteristics(iElec).BR.dom90.traces,1)
%             tempTrace = blpCharacteristics(iElec).BR.dom90.traces(iTrace,midPoint+2:end);
%             tempBins = reshape(tempTrace,[],nBins);
%             tempSigEnergy = (1/nSampsPerBin).*sum(tempBins.^2,1);
%             sigEnergy_post_BR_90(iTrace,:) = tempSigEnergy;
%         end
%         for iTrace = 1:size(blpCharacteristics(iElec).BR.dom270.traces,1)
%             tempTrace = blpCharacteristics(iElec).BR.dom270.traces(iTrace,1:midPoint);
%             tempBins = reshape(tempTrace,[],nBins);
%             tempSigEnergy = (1/nSampsPerBin).*sum(tempBins.^2,1);
%             sigEnergy_pre_BR_270(iTrace,:) = tempSigEnergy;
%         end
%         for iTrace = 1:size(blpCharacteristics(iElec).BR.dom270.traces,1)
%             tempTrace = blpCharacteristics(iElec).BR.dom270.traces(iTrace,midPoint+2:end);
%             tempBins = reshape(tempTrace,[],nBins);
%             tempSigEnergy = (1/nSampsPerBin).*sum(tempBins.^2,1);
%             sigEnergy_post_BR_270(iTrace,:) = tempSigEnergy;
%         end
%         sigEnergy_Pre_BR_270TO90{iDataset}(iElec,:,:) = sigEnergy_pre_BR_90;
%         sigEnergy_Post_BR_270TO90{iDataset}(iElec,:,:) = sigEnergy_post_BR_90;
%         sigEnergy_Pre_BR_90TO270{iDataset}(iElec,:,:) = sigEnergy_pre_BR_270;
%         sigEnergy_Post_BR_90TO270{iDataset}(iElec,:,:) = sigEnergy_post_BR_270;
%         clear sigEnergy_post_BR_270; clear sigEnergy_pre_BR_270; clear sigEnergy_post_BR_90; clear sigEnergy_pre_BR_90;
%         
%     end
%     
%     for iElec = 1:96
%         
%         preIdxs90 = blpCharacteristics(iElec).PA.dom90.preEvtTimes>=-0.5; postIdxs90 = blpCharacteristics(iElec).PA.dom90.postEvtTimes<=0.5;
%         preIdxs270 = blpCharacteristics(iElec).PA.dom270.preEvtTimes>=-0.5; postIdxs270 = blpCharacteristics(iElec).PA.dom270.postEvtTimes<=0.5;
%         
%         % Event times
%         evtTimes_pre_PA_90{iDataset}{iElec} = [blpCharacteristics(iElec).PA.dom90.preEvtTimes(preIdxs90)];
%         evtTimes_post_PA_90{iDataset}{iElec} = [blpCharacteristics(iElec).PA.dom90.postEvtTimes(postIdxs90)];
%         
%         evtTimes_pre_PA_270{iDataset}{iElec} = [blpCharacteristics(iElec).PA.dom270.preEvtTimes(preIdxs270)];
%         evtTimes_post_PA_270{iDataset}{iElec} = [blpCharacteristics(iElec).PA.dom270.postEvtTimes(postIdxs270)];
%         
%         % Event amplitudes
%         ampPreEvents_PA_90{iDataset}{iElec} = [blpCharacteristics(iElec).PA.dom90.preAmps(preIdxs90)];
%         ampPostEvents_PA_90{iDataset}{iElec} = [blpCharacteristics(iElec).PA.dom90.postAmps(postIdxs90)];
%         
%         ampPreEvents_PA_270{iDataset}{iElec} = [blpCharacteristics(iElec).PA.dom270.preAmps(preIdxs270)];
%         ampPostEvents_PA_270{iDataset}{iElec} = [blpCharacteristics(iElec).PA.dom270.postAmps(postIdxs270)];
%         
%         % Signal energy
%         for iTrace = 1:size(blpCharacteristics(iElec).PA.dom90.traces,1)
%             tempTrace = blpCharacteristics(iElec).PA.dom90.traces(iTrace,1:midPoint);
%             tempBins = reshape(tempTrace,[],nBins);
%             tempSigEnergy = (1/nSampsPerBin).*sum(tempBins.^2,1);
%             sigEnergy_pre_PA_90(iTrace,:) = tempSigEnergy;
%         end
%         for iTrace = 1:size(blpCharacteristics(iElec).PA.dom90.traces,1)
%             tempTrace = blpCharacteristics(iElec).PA.dom90.traces(iTrace,midPoint+2:end);
%             tempBins = reshape(tempTrace,[],nBins);
%             tempSigEnergy = (1/nSampsPerBin).*sum(tempBins.^2,1);
%             sigEnergy_post_PA_90(iTrace,:) = tempSigEnergy;
%         end
%         for iTrace = 1:size(blpCharacteristics(iElec).PA.dom270.traces,1)
%             tempTrace = blpCharacteristics(iElec).PA.dom270.traces(iTrace,1:midPoint);
%             tempBins = reshape(tempTrace,[],nBins);
%             tempSigEnergy = (1/nSampsPerBin).*sum(tempBins.^2,1);
%             sigEnergy_pre_PA_270(iTrace,:) = tempSigEnergy;
%         end
%         for iTrace = 1:size(blpCharacteristics(iElec).PA.dom270.traces,1)
%             tempTrace = blpCharacteristics(iElec).PA.dom270.traces(iTrace,midPoint+2:end);
%             tempBins = reshape(tempTrace,[],nBins);
%             tempSigEnergy = (1/nSampsPerBin).*sum(tempBins.^2,1);
%             sigEnergy_post_PA_270(iTrace,:) = tempSigEnergy;
%         end
%         sigEnergy_Pre_PA_270TO90{iDataset}(iElec,:,:) = sigEnergy_pre_PA_90;
%         sigEnergy_Post_PA_270TO90{iDataset}(iElec,:,:) = sigEnergy_post_PA_90;
%         sigEnergy_Pre_PA_90TO270{iDataset}(iElec,:,:) = sigEnergy_pre_PA_270;
%         sigEnergy_Post_PA_90TO270{iDataset}(iElec,:,:) = sigEnergy_post_PA_270;
%         clear sigEnergy_post_PA_270; clear sigEnergy_pre_PA_270; clear sigEnergy_post_PA_90; clear sigEnergy_pre_PA_90;
%     end
   
end

lfpStatistics.eventTimes.BR.s270TO90.Pre = evtTimes_pre_BR_90;
lfpStatistics.eventTimes.BR.s270TO90.Post = evtTimes_post_BR_90;

lfpStatistics.eventAmps.BR.s270TO90.Pre = ampPreEvents_BR_90;
lfpStatistics.eventAmps.BR.s270TO90.Post = ampPostEvents_BR_90;

lfpStatistics.signalEnergy.s270TO90.BR.Pre = sigEnergy_Pre_BR_270TO90;
lfpStatistics.signalEnergy.s270TO90.BR.Post = sigEnergy_Post_BR_270TO90;

lfpStatistics.eventTimes.PA.s270TO90.Pre = evtTimes_pre_PA_90;
lfpStatistics.eventTimes.PA.s270TO90.Post = evtTimes_post_PA_90;

lfpStatistics.eventAmps.PA.s270TO90.Pre = ampPreEvents_PA_90;
lfpStatistics.eventAmps.PA.s270TO90.Post = ampPostEvents_PA_90;

lfpStatistics.signalEnergy.s270TO90.PA.Pre = sigEnergy_Pre_PA_270TO90;
lfpStatistics.signalEnergy.s270TO90.PA.Post = sigEnergy_Post_PA_270TO90;

lfpStatistics.eventTimes.BR.s90TO270.Pre = evtTimes_pre_BR_270;
lfpStatistics.eventTimes.BR.s90TO270.Post = evtTimes_post_BR_270;

lfpStatistics.eventAmps.BR.s90TO270.Pre = ampPreEvents_BR_270;
lfpStatistics.eventAmps.BR.s90TO270.Post = ampPostEvents_BR_270;

lfpStatistics.signalEnergy.s90TO270.BR.Pre = sigEnergy_Pre_BR_90TO270;
lfpStatistics.signalEnergy.s90TO270.BR.Post = sigEnergy_Post_BR_90TO270;

lfpStatistics.eventTimes.PA.s90TO270.Pre = evtTimes_pre_PA_270;
lfpStatistics.eventTimes.PA.s90TO270.Post = evtTimes_post_PA_270;

lfpStatistics.eventAmps.PA.s90TO270.Pre = ampPreEvents_PA_270;
lfpStatistics.eventAmps.PA.s90TO270.Post = ampPostEvents_PA_270;

lfpStatistics.signalEnergy.s90TO270.PA.Pre = sigEnergy_Pre_PA_90TO270;
lfpStatistics.signalEnergy.s90TO270.PA.Post = sigEnergy_Post_PA_90TO270;

lfpStatistics.nTransitions.BR.s270TO90 = nTransitions_BR_90;
lfpStatistics.nTransitions.PA.s270TO90 = nTransitions_PA_90;
lfpStatistics.nTransitions.BR.s90TO270 = nTransitions_BR_270;
lfpStatistics.nTransitions.PA.s90TO270 = nTransitions_PA_270;
lfpStatistics.nChannels = 96;
lfpStatistics.binWidths.Pre = {'-0.5 to -0.4', '-0.4 to -0.3', '-0.3 to -0.2', '-0.2 to -0.1', '-0.1 to 0'};
lfpStatistics.binWidths.Post = {'0 to 0.1', '0.1 to 0.2', '0.2 to 0.3', '0.3 to 0.4', '0.4 to 0.5'};

cd(folderName)
filename = ['MMstd4_SeparatedLfpStatistics_' filtType '_' num2str(duration/1000) 's.mat'];
save(filename,'lfpStatistics','-v7.3');
