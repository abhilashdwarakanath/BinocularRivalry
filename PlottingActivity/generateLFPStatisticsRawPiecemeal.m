function generateLFPStatisticsRawPiecemeal(duration,filtType)

% This code collects all computed spectrograms across datasets and then
% creates a grand average of selective sites during Riv and during PA_FS
% for comparison

%% Enumerate the datasets

% traces_ according to Selectivity during Rivalry

datasetsLfpStats{1} = ['B:\H07\12-06-2016\PFC\Bfsgrad1\LFPStatisticsPiecemeals\MMstd4_piecemeal_blpCharacteristics_' num2str(duration) 'ms_Chebyshev1_' filtType '.mat'];
datasetsLfpStats{2} = ['B:\H07\13-07-2016\PFC\Bfsgrad1\LFPStatisticsPiecemeals\MMstd4_piecemeal_blpCharacteristics_' num2str(duration) 'ms_Chebyshev1_' filtType '.mat'];
datasetsLfpStats{3} = ['B:\H07\20161019\PFC\Bfsgrad1\LFPStatisticsPiecemeals\MMstd4_piecemeal_blpCharacteristics_' num2str(duration) 'ms_Chebyshev1_' filtType '.mat'];
datasetsLfpStats{4} = ['B:\H07\20161025\PFC\Bfsgrad1\LFPStatisticsPiecemeals\MMstd4_piecemeal_blpCharacteristics_' num2str(duration) 'ms_Chebyshev1_' filtType '.mat'];
datasetsLfpStats{5} = ['B:\A11\20170305\PFC\Bfsgrad1\LFPStatisticsPiecemeals\MMstd4_piecemeal_blpCharacteristics_' num2str(duration) 'ms_Chebyshev1_' filtType '.mat'];
datasetsLfpStats{6} = ['B:\A11\20170302\PFC\Bfsgrad1\LFPStatisticsPiecemeals\MMstd4_piecemeal_blpCharacteristics_' num2str(duration) 'ms_Chebyshev1_' filtType '.mat'];

datasets_parentDir{1} = ['B:\H07\12-06-2016\PFC\Bfsgrad1\'];
datasets_parentDir{2} = ['B:\H07\13-07-2016\PFC\Bfsgrad1\'];
datasets_parentDir{3} = ['B:\H07\20161019\PFC\Bfsgrad1\'];
datasets_parentDir{4} = ['B:\H07\20161025\PFC\Bfsgrad1\'];
datasets_parentDir{5} = ['B:\A11\20170305\PFC\Bfsgrad1\'];
datasets_parentDir{6} = ['B:\A11\20170302\PFC\Bfsgrad1\'];

%% Plot grand average for DomSels

% collect

nTransitions_BR_all = 0;

for iDataset = [1 2 3 4 5 6]
    
    load(datasetsLfpStats{iDataset});

    folderName = ['B:\Results\LFP_Statistics\Piecemeal\MM\std4\' filtType '\' num2str(duration/1000) 's'];
    mkdir(folderName)
    cd(folderName)
    
    t = linspace((-duration)/1000,(duration)/1000,duration+1);
    sigLength = length(t);
    midPoint = floor(sigLength/2);
    nSampsPerBin = 25; % 100ms
    nBins = midPoint/nSampsPerBin;
    cd(datasets_parentDir{iDataset})
    load('nTransitionsPiecemeals_0.5s.mat')

    nTransitions_BR(iDataset) = nTransitions_BR_270+nTransitions_BR_90;
    
    % Do for BR90
    
     for iElec = 1:96
        
        % Set a temporal criterion of dip+100ms, so 300ms - DON'T DO THIS!
        % ARTIFICIAL REDUCTION OF POST EVENTS!!!
        
        preIdxs90 = blpCharacteristics(iElec).BR.dom90.preEvtTimes>=-0.5; postIdxs90 = blpCharacteristics(iElec).BR.dom90.postEvtTimes<=0.5;
        preIdxs270 = blpCharacteristics(iElec).BR.dom270.preEvtTimes>=-0.5; postIdxs270 = blpCharacteristics(iElec).BR.dom270.postEvtTimes<=0.5;
        
        % Event times
        evtTimes_pre_BR{iDataset}{iElec} = [blpCharacteristics(iElec).BR.dom90.preEvtTimes(preIdxs90) blpCharacteristics(iElec).BR.dom270.preEvtTimes(preIdxs270)];
        evtTimes_post_BR{iDataset}{iElec} = [blpCharacteristics(iElec).BR.dom90.postEvtTimes(postIdxs90) blpCharacteristics(iElec).BR.dom270.postEvtTimes(postIdxs270)];
        
        % Event amplitudes
        ampPreEvents_BR{iDataset}{iElec} = [blpCharacteristics(iElec).BR.dom90.preAmps(preIdxs90) blpCharacteristics(iElec).BR.dom270.preAmps(preIdxs270)];
        ampPostEvents_BR{iDataset}{iElec} = [blpCharacteristics(iElec).BR.dom90.postAmps(postIdxs90) blpCharacteristics(iElec).BR.dom270.postAmps(postIdxs270)];
        
        % Signal energy
        for iTrace = 1:size(blpCharacteristics(iElec).BR.dom90.traces,1)
            tempTrace = blpCharacteristics(iElec).BR.dom90.traces(iTrace,1:midPoint);
            tempBins = reshape(tempTrace,[],nBins);
            tempSigEnergy = (1/nSampsPerBin).*sum(tempBins.^2,1);
            sigEnergy_pre_BR_90(iTrace,:) = tempSigEnergy;
        end
        for iTrace = 1:size(blpCharacteristics(iElec).BR.dom90.traces,1)
            tempTrace = blpCharacteristics(iElec).BR.dom90.traces(iTrace,midPoint+2:end);
            tempBins = reshape(tempTrace,[],nBins);
            tempSigEnergy = (1/nSampsPerBin).*sum(tempBins.^2,1);
            sigEnergy_post_BR_90(iTrace,:) = tempSigEnergy;
        end
        for iTrace = 1:size(blpCharacteristics(iElec).BR.dom270.traces,1)
            tempTrace = blpCharacteristics(iElec).BR.dom270.traces(iTrace,1:midPoint);
            tempBins = reshape(tempTrace,[],nBins);
            tempSigEnergy = (1/nSampsPerBin).*sum(tempBins.^2,1);
            sigEnergy_pre_BR_270(iTrace,:) = tempSigEnergy;
        end
        for iTrace = 1:size(blpCharacteristics(iElec).BR.dom270.traces,1)
            tempTrace = blpCharacteristics(iElec).BR.dom270.traces(iTrace,midPoint+2:end);
            tempBins = reshape(tempTrace,[],nBins);
            tempSigEnergy = (1/nSampsPerBin).*sum(tempBins.^2,1);
            sigEnergy_post_BR_270(iTrace,:) = tempSigEnergy;
        end
        sigEnergy_pre_BR{iDataset}(iElec,:,:) = cat(1,sigEnergy_pre_BR_90,sigEnergy_pre_BR_270);
        sigEnergy_post_BR{iDataset}(iElec,:,:) = cat(1,sigEnergy_post_BR_90,sigEnergy_post_BR_270);
        clear sigEnergy_post_BR_270; clear sigEnergy_pre_BR_270; clear sigEnergy_post_BR_90; clear sigEnergy_pre_BR_90;
        
    end
   
end

lfpStatistics.eventTimes.BR.Pre = evtTimes_pre_BR;
lfpStatistics.eventTimes.BR.Post = evtTimes_post_BR;

lfpStatistics.eventAmps.BR.Pre = ampPreEvents_BR;
lfpStatistics.eventAmps.BR.Post = ampPostEvents_BR;

lfpStatistics.signalEnergy.BR.Pre = sigEnergy_pre_BR;
lfpStatistics.signalEnergy.BR.Post = sigEnergy_post_BR;

lfpStatistics.nTransitions.BR = nTransitions_BR;
lfpStatistics.nChannels = 96;
lfpStatistics.binWidths.Pre = {'-0.5 to -0.4', '-0.4 to -0.3', '-0.3 to -0.2', '-0.2 to -0.1', '-0.1 to 0'};
lfpStatistics.binWidths.Post = {'0 to 0.1', '0.1 to 0.2', '0.2 to 0.3', '0.3 to 0.4', '0.4 to 0.5'};

cd(folderName)
filename = ['MMstd4_LFPStatisticsPiecemeals_' filtType '_' num2str(duration/1000) 's.mat'];
save(filename,'lfpStatistics','-v7.3');
