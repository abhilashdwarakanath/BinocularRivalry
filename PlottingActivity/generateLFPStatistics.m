function generateLFPStatistics(duration,filtType)

% This code collects all computed spectrograms across datasets and then
% creates a grand average of selective sites during Riv and during PA_FS
% for comparison

%% Enumerate the datasets

% traces_ according to Selectivity during Rivalry

datasetsLfpStats{1} = ['E:\Data\H07\12-06-2016\PFC\Bfsgrad1\LFPStatistics\std4_blpCharacteristics_' num2str(duration) 'ms_Chebyshev1_' filtType '.mat'];
datasetsLfpStats{2} = ['E:\Data\H07\13-07-2016\PFC\Bfsgrad1\LFPStatistics\std4_blpCharacteristics_' num2str(duration) 'ms_Chebyshev1_' filtType '.mat'];
datasetsLfpStats{3} = ['E:\Data\H07\20161019\PFC\Bfsgrad1\LFPStatistics\std4_blpCharacteristics_' num2str(duration) 'ms_Chebyshev1_' filtType '.mat'];
datasetsLfpStats{4} = ['E:\Data\H07\20161025\PFC\Bfsgrad1\LFPStatistics\std4_blpCharacteristics_' num2str(duration) 'ms_Chebyshev1_' filtType '.mat'];
datasetsLfpStats{5} = ['E:\Data\A11\20170305\PFC\Bfsgrad1\LFPStatistics\std4_blpCharacteristics_' num2str(duration) 'ms_Chebyshev1_' filtType '.mat'];
datasetsLfpStats{6} = ['E:\Data\A11\20170302\PFC\Bfsgrad1\LFPStatistics\std4_blpCharacteristics_' num2str(duration) 'ms_Chebyshev1_' filtType '.mat'];

%% Plot grand average for DomSels

% collect

ampPreEvents_BR = [];
ampPostEvents_BR = [];
evtTimes_pre_BR = [];
evtTimes_post_BR = [];

ampPreEvents_PA = [];
ampPostEvents_PA = [];
evtTimes_pre_PA = [];
evtTimes_post_PA = [];

for iDataset = [1 2 3 4 5 6]
    
    load(datasetsLfpStats{iDataset});

    folderName = ['E:\Data\Results\LFP_Statistics\std4\' filtType '\' num2str(duration/1000) 's'];
    mkdir(folderName)
    cd(folderName)
    
    t = linspace((-duration)/1000,(duration)/1000,duration+1);
    sigLength = length(t);
    
    % Do for BR90
    
    for iElec = 1:96
        
        % Set a temporal criterion of dip+100ms, so 300ms
        
        preIdxs90 = blpCharacteristics(iElec).BR.dom90.preEvtTimes>=-0.5; postIdxs90 = blpCharacteristics(iElec).BR.dom90.postEvtTimes<=0.3;
        preIdxs270 = blpCharacteristics(iElec).BR.dom270.preEvtTimes>=-0.5; postIdxs270 = blpCharacteristics(iElec).BR.dom270.postEvtTimes<=0.3;
        
        evtTimes_pre_BR = [evtTimes_pre_BR blpCharacteristics(iElec).BR.dom90.preEvtTimes(preIdxs90) blpCharacteristics(iElec).BR.dom270.preEvtTimes(preIdxs270)];
        evtTimes_post_BR = [evtTimes_post_BR blpCharacteristics(iElec).BR.dom90.postEvtTimes(postIdxs90) blpCharacteristics(iElec).BR.dom270.postEvtTimes(postIdxs270)];
        
        ampPreEvents_BR = [ampPreEvents_BR blpCharacteristics(iElec).BR.dom90.preAmps(preIdxs90) blpCharacteristics(iElec).BR.dom270.preAmps(preIdxs270)];
        ampPostEvents_BR = [ampPostEvents_BR blpCharacteristics(iElec).BR.dom90.postAmps(postIdxs90) blpCharacteristics(iElec).BR.dom270.postAmps(postIdxs270)];
        
        sigEnergy_pre_BR(iDataset,iElec) = ((nanmean((1/floor(sigLength/2)).*sum(blpCharacteristics(iElec).BR.dom90.traces(:,1:floor(sigLength/2)).^2,1)))+(nanmean((1/floor(sigLength/2)).*sum(blpCharacteristics(iElec).BR.dom270.traces(:,1:floor(sigLength/2)).^2,1))))/2;
        sigEnergy_post_BR(iDataset,iElec) = ((nanmean((1/floor(sigLength/2)).*sum(blpCharacteristics(iElec).BR.dom90.traces(:,floor(sigLength/2)+1:end).^2,1)))+(nanmean((1/floor(sigLength/2)).*sum(blpCharacteristics(iElec).BR.dom270.traces(:,floor(sigLength/2)+1:end).^2,1))))/2;
    
    end
    
    for iElec = 1:96
        
        % Set a temporal criterion of dip+100ms, so 350ms
        
        preIdxs90 = blpCharacteristics(iElec).PA.dom90.preEvtTimes>=-0.5; postIdxs90 = blpCharacteristics(iElec).PA.dom90.postEvtTimes<=0.3;
        preIdxs270 = blpCharacteristics(iElec).PA.dom270.preEvtTimes>=-0.5; postIdxs270 = blpCharacteristics(iElec).PA.dom270.postEvtTimes<=0.3;
        
        evtTimes_pre_PA = [evtTimes_pre_PA blpCharacteristics(iElec).PA.dom90.preEvtTimes(preIdxs90) blpCharacteristics(iElec).PA.dom270.preEvtTimes(preIdxs270)];
        evtTimes_post_PA = [evtTimes_post_PA blpCharacteristics(iElec).PA.dom90.postEvtTimes(postIdxs90) blpCharacteristics(iElec).PA.dom270.postEvtTimes(postIdxs270)];
        
        ampPreEvents_PA = [ampPreEvents_PA blpCharacteristics(iElec).PA.dom90.preAmps(preIdxs90) blpCharacteristics(iElec).PA.dom270.preAmps(preIdxs270)];
        ampPostEvents_PA = [ampPostEvents_PA blpCharacteristics(iElec).PA.dom90.postAmps(postIdxs90) blpCharacteristics(iElec).PA.dom270.postAmps(postIdxs270)];
        
        sigEnergy_pre_PA(iDataset,iElec) = ((nanmean((1/floor(sigLength/2)).*sum(blpCharacteristics(iElec).PA.dom90.traces(:,1:floor(sigLength/2)).^2,1)))+(nanmean((1/floor(sigLength/2)).*sum(blpCharacteristics(iElec).PA.dom270.traces(:,1:floor(sigLength/2)).^2,1))))/2;
        sigEnergy_post_PA(iDataset,iElec) = ((nanmean((1/floor(sigLength/2)).*sum(blpCharacteristics(iElec).PA.dom90.traces(:,floor(sigLength/2)+1:end).^2,1)))+(nanmean((1/floor(sigLength/2)).*sum(blpCharacteristics(iElec).PA.dom270.traces(:,floor(sigLength/2)+1:end).^2,1))))/2;
    
    end
   
end

%% Plot for Event times

% Do the statistics for Event times pre and post

% Across PA and BR

[p_pre,~] = ranksum(evtTimes_pre_BR(:),evtTimes_pre_PA(:));

[p_post,~] = ranksum(evtTimes_post_BR(:),evtTimes_post_PA(:));

pd_br_pre = fitdist(evtTimes_pre_BR(:),'kernel');
pd_br_post = fitdist(evtTimes_post_BR(:),'kernel');

pd_pa_pre = fitdist(evtTimes_pre_PA(:),'kernel');
pd_pa_post = fitdist(evtTimes_post_PA(:),'kernel');

xmin = min([evtTimes_pre_BR(:); evtTimes_post_BR(:); evtTimes_pre_PA(:); evtTimes_post_PA(:)]);
xmax = max([evtTimes_pre_BR(:); evtTimes_post_BR(:); evtTimes_pre_PA(:); evtTimes_post_PA(:)]);

xaxis = linspace(xmin,xmax,50);

figure(2)
set(gcf, 'Position', get(0, 'Screensize'));
subplot(1,2,1)
plot(xaxis,(pdf(pd_br_pre,xaxis)),'-r','LineWidth',3)
hold on
vline(median(evtTimes_pre_BR(:)),'--r')
plot(xaxis,(pdf(pd_pa_pre,xaxis)),'-k','LineWidth',3)
vline(median(evtTimes_pre_PA(:)),'--k')
plot(0,0,'.w')
legend('preEvents BR','postEvents PA',['p = ' num2str(p_pre)])
grid on; box off; axis tight;
xlabel('event times')
ylabel('d count per bin')
title('event times Pre Switch BR and PA')

subplot(1,2,2)
plot(xaxis,(pdf(pd_br_post,xaxis)),'-r','LineWidth',3)
hold on
vline(median(evtTimes_post_BR(:)),'--r')
plot(xaxis,(pdf(pd_pa_post,xaxis)),'-k','LineWidth',3)
vline(median(evtTimes_post_PA(:)),'--k')
plot(0,0,'.w')
legend('postEvents BR','postEvents PA',['p = ' num2str(p_post)])
grid on; box off; axis tight;
xlabel('event times')
ylabel('count per bin')
title('event times post Switch BR and PA')
suptitle(['Pre and Post Events across Condition Comparison : ' filtType ' ' num2str(duration) 'ms'])
saveas(gcf,['PrePost_eventTimes_acrossCondition_' filtType '_' num2str(duration) 'ms'],'png')
pause(1); close all;
