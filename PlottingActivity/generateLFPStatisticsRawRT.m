function generateLFPStatisticsRawRT(duration,filtType)

% This code collects all computed spectrograms across datasets and then
% creates a grand average of selective sites during Riv and during PA_FS
% for comparison

%% Enumerate the datasets

% traces_ according to Selectivity during Rivalry

datasetsLfpStats{1} = ['B:\H07\12-06-2016\PFC\Bfsgrad1\LFPSpectrograms\RandomTriggered\diff_Params_randomTrigger_blpCharacteristics_' num2str(duration) 'ms_Chebyshev1_' filtType '.mat'];
% datasetsLfpStats{2} = ['B:\H07\13-07-2016\PFC\Bfsgrad1\LFPSpectrograms\RandomTriggered\randomTrigger_blpCharacteristics_' num2str(duration) 'ms_Chebyshev1_' filtType '.mat'];
% datasetsLfpStats{3} = ['B:\H07\20161019\PFC\Bfsgrad1\LFPSpectrograms\RandomTriggered\randomTrigger_blpCharacteristics_' num2str(duration) 'ms_Chebyshev1_' filtType '.mat'];
% datasetsLfpStats{4} = ['B:\H07\20161025\PFC\Bfsgrad1\LFPSpectrograms\RandomTriggered\randomTrigger_blpCharacteristics_' num2str(duration) 'ms_Chebyshev1_' filtType '.mat'];
% datasetsLfpStats{5} = ['B:\A11\20170305\PFC\Bfsgrad1\LFPSpectrograms\RandomTriggered\randomTrigger_blpCharacteristics_' num2str(duration) 'ms_Chebyshev1_' filtType '.mat'];
% datasetsLfpStats{6} = ['B:\A11\20170302\PFC\Bfsgrad1\LFPSpectrograms\RandomTriggered\randomTrigger_blpCharacteristics_' num2str(duration) 'ms_Chebyshev1_' filtType '.mat'];

%% Plot grand average for DomSels

% collect

for iDataset = [1 2 3 4 5 6]
    
    load(datasetsLfpStats{iDataset});

    folderName = ['B:\Results\LFP_Statistics\RandomTriggered\' filtType '\' num2str(duration/1000) 's'];
    mkdir(folderName)
    cd(folderName)

    sigLength = length(t);
    midPoint = floor(sigLength/2);
    nSampsPerBin = 25; % 100ms
    nBins = midPoint/nSampsPerBin;

    nTransitionsSamp1(iDataset) = size(blpCharacteristicsRT(1).randomTrigger.sample1.traces,1);
    nTransitionsSamp2(iDataset) = size(blpCharacteristicsRT(1).randomTrigger.sample2.traces,1);
    nTransitions(iDataset) = nTransitionsSamp1(iDataset)+nTransitionsSamp1(iDataset);
    
    % Do for sample1
    
     for iElec = 1:96
        
        preIdxsSample1 = blpCharacteristicsRT(iElec).randomTrigger.sample1.preEvtTimes>=-0.5; postIdxsSample1 = blpCharacteristicsRT(iElec).randomTrigger.sample1.postEvtTimes<=0.5;
        preIdxsSample2 = blpCharacteristicsRT(iElec).randomTrigger.sample2.preEvtTimes>=-0.5; postIdxsSample2 = blpCharacteristicsRT(iElec).randomTrigger.sample2.postEvtTimes<=0.5;
        
        % Event times
        evtTimes_pre{iDataset}{iElec} = [blpCharacteristicsRT(iElec).randomTrigger.sample1.preEvtTimes(preIdxsSample1) blpCharacteristicsRT(iElec).randomTrigger.sample2.preEvtTimes(preIdxsSample2)];
        evtTimes_post{iDataset}{iElec} = [blpCharacteristicsRT(iElec).randomTrigger.sample1.postEvtTimes(postIdxsSample1) blpCharacteristicsRT(iElec).randomTrigger.sample2.postEvtTimes(postIdxsSample2)];
        
        % Event amplitudes
        ampPreEvents{iDataset}{iElec} = [blpCharacteristicsRT(iElec).randomTrigger.sample1.preAmps(preIdxsSample1) blpCharacteristicsRT(iElec).randomTrigger.sample2.preAmps(preIdxsSample2)];
        ampPostEvents{iDataset}{iElec} = [blpCharacteristicsRT(iElec).randomTrigger.sample1.postAmps(postIdxsSample1) blpCharacteristicsRT(iElec).randomTrigger.sample2.postAmps(postIdxsSample2)];
        
        % Signal energy
        for iTrace = 1:size(blpCharacteristicsRT(iElec).randomTrigger.sample1.traces,1)
            tempTrace = blpCharacteristicsRT(iElec).randomTrigger.sample1.traces(iTrace,1:midPoint);
            tempBins = reshape(tempTrace,[],nBins);
            tempSigEnergy = (1/nSampsPerBin).*sum(tempBins.^2,1);
            sigEnergy_pre_sample1{iTrace} = tempSigEnergy;
        end
        for iTrace = 1:size(blpCharacteristicsRT(iElec).randomTrigger.sample1.traces,1)
            tempTrace = blpCharacteristicsRT(iElec).randomTrigger.sample1.traces(iTrace,midPoint+2:end);
            tempBins = reshape(tempTrace,[],nBins);
            tempSigEnergy = (1/nSampsPerBin).*sum(tempBins.^2,1);
            sigEnergy_post_sample1{iTrace} = tempSigEnergy;
        end
        for iTrace = 1:size(blpCharacteristicsRT(iElec).randomTrigger.sample2.traces,1)
            tempTrace = blpCharacteristicsRT(iElec).randomTrigger.sample2.traces(iTrace,1:midPoint);
            tempBins = reshape(tempTrace,[],nBins);
            tempSigEnergy = (1/nSampsPerBin).*sum(tempBins.^2,1);
            sigEnergy_pre_sample2{iTrace} = tempSigEnergy;
        end
        for iTrace = 1:size(blpCharacteristicsRT(iElec).randomTrigger.sample2.traces,1)
            tempTrace = blpCharacteristicsRT(iElec).randomTrigger.sample2.traces(iTrace,midPoint+2:end);
            tempBins = reshape(tempTrace,[],nBins);
            tempSigEnergy = (1/nSampsPerBin).*sum(tempBins.^2,1);
            sigEnergy_post_sample2{iTrace} = tempSigEnergy;
        end
        sigEnergy_pre{iDataset}{iElec} = cat(2,sigEnergy_pre_sample1,sigEnergy_pre_sample2);
        sigEnergy_post{iDataset}{iElec} = cat(2,sigEnergy_post_sample1,sigEnergy_post_sample2);
        clear sigEnergy_post_sample2; clear sigEnergy_pre_sample2; clear sigEnergy_post_sample1; clear sigEnergy_pre_sample1;
        
    end
   
end

lfpStatistics.eventTimes.Pre = evtTimes_pre;
lfpStatistics.eventTimes.Post = evtTimes_post;

lfpStatistics.eventAmps.Pre = ampPreEvents;
lfpStatistics.eventAmps.Post = ampPostEvents;

lfpStatistics.signalEnergy.Pre = sigEnergy_pre;
lfpStatistics.signalEnergy.Post = sigEnergy_post;

lfpStatistics.nTransitions = nTransitions;
lfpStatistics.nChannels = 96;
lfpStatistics.binWidths.Pre = {'-0.5 to -0.4', '-0.4 to -0.3', '-0.3 to -0.2', '-0.2 to -0.1', '-0.1 to 0'};
lfpStatistics.binWidths.Post = {'0 to 0.1', '0.1 to 0.2', '0.2 to 0.3', '0.3 to 0.4', '0.4 to 0.5'};

cd(folderName)
filename = ['randomTriggered_' filtType '_' num2str(duration/1000) 's.mat'];
save(filename,'lfpStatistics','-v7.3');
