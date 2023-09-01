function generateEventRateStatistics(duration,filtType)

%% Enumerate datapaths

dataPath{1} = ['B:\Results\LFP_Statistics\MM\std4\' filtType '\' num2str(duration/1000) 's\MMstd4_SeparatedLfpStatistics_' filtType '_' num2str(duration/1000) 's.mat'];
dataPath{2} = ['B:\Results\LFP_Statistics\Piecemeal\' filtType '\' num2str(duration/1000) 's\std4_LFPStatisticsPiecemeals_' filtType '_' num2str(duration/1000) 's.mat'];
dataPath{3} = ['B:\Results\LFP_Statistics\RandomTriggered\Resampled\' filtType '\' num2str(duration/1000) 's\diffParams_nIter_randomTriggered_' filtType '_' num2str(duration/1000) 's.mat'];

datasets_parentDir{1} = ['B:\H07\12-06-2016\PFC\Bfsgrad1\'];
datasets_parentDir{2} = ['B:\H07\13-07-2016\PFC\Bfsgrad1\'];
datasets_parentDir{3} = ['B:\H07\20161019\PFC\Bfsgrad1\'];
datasets_parentDir{4} = ['B:\H07\20161025\PFC\Bfsgrad1\'];
datasets_parentDir{5} = ['B:\A11\20170305\PFC\Bfsgrad1\'];
datasets_parentDir{6} = ['B:\A11\20170302\PFC\Bfsgrad1\'];

nDatasets = 6;
nChans = 96;
%% Global Event Rates - BR and PA

load (dataPath{1})

pre_BR_nEvents = 0;
post_BR_nEvents = 0;
pre_PA_nEvents = 0;
post_PA_nEvents = 0;
nTrans_BR = 0;
nTrans_PA = 0;

for iDataset = 1:nDatasets
    
    cd(datasets_parentDir{iDataset})
    
    load('nTransitions_0.5s.mat')
    
    nTrans_PA = nTrans_PA+nTransitions_PA_270+nTransitions_PA_90;
    nTrans_BR = nTrans_BR+nTransitions_BR_90+nTransitions_BR_270;
    
    for iChan = 1:nChans
        
        tempPreBR_s270TO90 = numel(lfpStatistics.eventTimes.BR.s270TO90.Pre{iDataset}{iChan});
        tempPreBR_s90TO270 = numel(lfpStatistics.eventTimes.BR.s90TO270.Pre{iDataset}{iChan});
        
        pre_BR_nEvents = pre_BR_nEvents+tempPreBR_s270TO90+tempPreBR_s90TO270;
        
        tempPostBR_s270TO90 = numel(lfpStatistics.eventTimes.BR.s270TO90.Post{iDataset}{iChan});
        tempPostBR_s90TO270 = numel(lfpStatistics.eventTimes.BR.s90TO270.Post{iDataset}{iChan});
        
        post_BR_nEvents = post_BR_nEvents+tempPostBR_s270TO90+tempPostBR_s90TO270;
        
        tempPrePA_s270TO90 = numel(lfpStatistics.eventTimes.PA.s270TO90.Pre{iDataset}{iChan});
        tempPrePA_s90TO270 = numel(lfpStatistics.eventTimes.PA.s90TO270.Pre{iDataset}{iChan});
        
        pre_PA_nEvents = pre_PA_nEvents+tempPrePA_s270TO90+tempPrePA_s90TO270;
        
        tempPostPA_s270TO90 = numel(lfpStatistics.eventTimes.PA.s270TO90.Post{iDataset}{iChan});
        tempPostPA_s90TO270 = numel(lfpStatistics.eventTimes.PA.s90TO270.Post{iDataset}{iChan});
        
        post_PA_nEvents = post_PA_nEvents+tempPostPA_s270TO90+tempPostPA_s90TO270;
        
    end
    
end

rates.pre_BR_globalRate = pre_BR_nEvents/(nTrans_BR*96);
rates.post_BR_globalRate = post_BR_nEvents/(nTrans_BR*96);

rates.pre_PA_globalRate = pre_PA_nEvents/(nTrans_PA*96);
rates.post_PA_globalRate = post_PA_nEvents/(nTrans_PA*96);

%% Per channel event rates - BR and PA

pre_BR_nEvents = zeros(nDatasets,nChans);
post_BR_nEvents = zeros(nDatasets,nChans);
pre_PA_nEvents = zeros(nDatasets,nChans);
post_PA_nEvents = zeros(nDatasets,nChans);

for iDataset = 1:nDatasets
    
    cd(datasets_parentDir{iDataset})
    
    load('nTransitions_0.5s.mat')
    
    nTrans_PA = nTransitions_PA_270+nTransitions_PA_90;
    nTrans_BR = nTransitions_BR_90+nTransitions_BR_270;
    
    for iChan = 1:nChans
        
        tempPreBR_s270TO90 = numel(lfpStatistics.eventTimes.BR.s270TO90.Pre{iDataset}{iChan});
        tempPreBR_s90TO270 = numel(lfpStatistics.eventTimes.BR.s90TO270.Pre{iDataset}{iChan});
        
        pre_BR_nEvents(iDataset,iChan) = (tempPreBR_s270TO90+tempPreBR_s90TO270)/(nTrans_BR);
        
        tempPostBR_s270TO90 = numel(lfpStatistics.eventTimes.BR.s270TO90.Post{iDataset}{iChan});
        tempPostBR_s90TO270 = numel(lfpStatistics.eventTimes.BR.s90TO270.Post{iDataset}{iChan});
        
        post_BR_nEvents(iDataset,iChan) = (tempPostBR_s270TO90+tempPostBR_s90TO270)/(nTrans_BR);
        
        tempPrePA_s270TO90 = numel(lfpStatistics.eventTimes.PA.s270TO90.Pre{iDataset}{iChan});
        tempPrePA_s90TO270 = numel(lfpStatistics.eventTimes.PA.s90TO270.Pre{iDataset}{iChan});
        
        pre_PA_nEvents(iDataset,iChan) = (tempPrePA_s270TO90+tempPrePA_s90TO270)/(nTrans_PA);
        
        tempPostPA_s270TO90 = numel(lfpStatistics.eventTimes.PA.s270TO90.Post{iDataset}{iChan});
        tempPostPA_s90TO270 = numel(lfpStatistics.eventTimes.PA.s90TO270.Post{iDataset}{iChan});
        
        post_PA_nEvents(iDataset,iChan) = (tempPostPA_s270TO90+tempPostPA_s90TO270)/(nTrans_PA);
        
    end
    
end

rates.pre_BR(1) = mean(pre_BR_nEvents(:));
rates.pre_BR(2) = std(pre_BR_nEvents(:))/sqrt(nDatasets*nChans);
rates.post_BR(1) = mean(post_BR_nEvents(:));
rates.post_BR(2) = std(post_BR_nEvents(:))/sqrt(nDatasets*nChans);

rates.pre_PA(1) = mean(pre_PA_nEvents(:));
rates.pre_PA(2) = std(pre_PA_nEvents(:))/sqrt(nDatasets*nChans);
rates.post_PA(1) = mean(post_PA_nEvents(:));
rates.post_PA(2) = std(post_PA_nEvents(:))/sqrt(nDatasets*nChans);

dataMatrix = [pre_BR_nEvents(:) pre_PA_nEvents(:) post_BR_nEvents(:) post_PA_nEvents(:)];
% boxplot(dataMatrix,'Notch','on','Symbol','o','OutlierSize',4)
% box off
% h = findobj(gca,'Tag','Box');
% colors = {'k','r','k','r'};
% alpha = [1 1 1 1];
% for j=1:length(h)
% patch(get(h(j),'XData'),get(h(j),'YData'),colors{j},'FaceAlpha',alpha(j));
% end
% figure(1)
% violin(dataMatrix,'xlabel',{'PreBR','PrePA','PostBR','PostPA'},'facecolor',[[1 0 0];[0 0 0];[1 0 0];[0 0 0]],'facealpha',1,'mc','','medc','w')
% box off

% Rework below this to take in an integer number as nSamples and repeat them for the other 3 conditions, you lazy idiot.

% [names{1:384}] = deal('PreBR'); % Pre-swith rivalry
% [names{385:385+384-1}] = deal('PrePA'); % Pre-switch physical alternation     
% [names{769:769+384-1}] = deal('PostBR'); % post of the above
% [names{1153:1153+384-1}] = deal('PostPA'); % post of the above
% 
% colors(1:384) = ones(1,384); 
% colors(385:385+384-1) = 3*ones(1,384);
% colors(769:769+384-1) = 1*ones(1,384);
% colors(1153:1153+384-1) = 3*ones(1,384);
% 
% 
% g = gramm('x',names,'y',dataMatrix(:),'color',colors);
% set_order_options(g,'x',0)
% g.stat_violin('normalization','area','dodge',1,'fill','edge');
% g.set_names('x','condition','y','bursts/transition/channel','size',24)
% g.stat_boxplot('width',0.25,'notch','true');
% g.set_title('Burst rate statistics - BR vs PA - PFC');
% g.update()

%% Piecemeal global rate

load(dataPath{2})

pre_PM_nEvents = 0;
post_PM_nEvents = 0;
nTrans = 0;

for iDataset = 1:nDatasets
    
    nTrans = nTrans+lfpStatistics.nTransitions.BR(iDataset);
    
    for iChan = 1:nChans
        
        pre_PM_nEvents = pre_PM_nEvents+numel(lfpStatistics.eventTimes.BR.Pre{iDataset}{iChan});
        post_PM_nEvents = post_PM_nEvents+numel(lfpStatistics.eventTimes.BR.Post{iDataset}{iChan});
        
    end
    
end

rates.pre_PM_globalRate = pre_PM_nEvents/(nTrans*nChans);
rates.post_PM_globalRate = post_PM_nEvents/(nTrans*nChans);

%% Piecemeal event rate per transition

pre_PM_nEvents = zeros(nDatasets,nChans);
post_PM_nEvents = zeros(nDatasets,nChans);

for iDataset = 1:nDatasets
    
    nTrans = lfpStatistics.nTransitions.BR(iDataset);
    
    for iChan = 1:nChans
        
        pre_PM_nEvents(iDataset,iChan) = numel(lfpStatistics.eventTimes.BR.Pre{iDataset}{iChan})/nTrans;
        post_PM_nEvents(iDataset,iChan) = numel(lfpStatistics.eventTimes.BR.Post{iDataset}{iChan})/nTrans;
        
    end
    
end

rates.pre_PM(1) = mean(pre_PM_nEvents(:));
rates.pre_PM(2) = std(pre_PM_nEvents(:))/sqrt(nDatasets*nChans);

rates.post_PM(1) = mean(post_PM_nEvents(:));
rates.post_PM(2) = std(post_PM_nEvents(:))/sqrt(nDatasets*nChans);

dataMatrixPM = [pre_BR_nEvents(:) pre_PM_nEvents(:)];

% figure(2)
% [namesPM{1:576}] = deal('PreBR');
% [namesPM{577:577+576-1}] = deal('PrePM');
% 
% colorsPM(1:576) = ones(1,576);
% colorsPM(577:577+576-1) = 3*ones(1,576);
% 
% 
% g = gramm('x',namesPM,'y',dataMatrixPM(:),'color',colorsPM);
% set_order_options(g,'x',0)
% g.stat_violin('normalization','area','dodge',1,'fill','edge');
% g.set_names('x','condition','y','bursts/transition/channel','size',24)
% g.stat_boxplot('width',0.25,'notch','true');
% g.set_title('Burst rate statistics - BR vs PM');
% g.update()

%% Random Triggered global event rate

nIter = 100;

load(dataPath{3})

nEvents_Pre_RT = 0;
nEvents_Post_RT = 0;
nTrans = 0;

for iDataset = 1:nDatasets
    
    nTrans = nTrans+lfpStatistics.nTransitions(iDataset);
    
    for iChan = 1:nChans
        
        for iIter = 1:nIter
            
            nEvents_Pre_RT = nEvents_Pre_RT+numel(lfpStatistics.eventTimes.Pre{iDataset}{iChan}{iIter});
            nEvents_Post_RT = nEvents_Post_RT+numel(lfpStatistics.eventTimes.Post{iDataset}{iChan}{iIter});
            
        end
        
    end
    
end

rates.pre_RT_globalRate = nEvents_Pre_RT/(nTrans*nChans*nIter);
rates.post_RT_globalRate = nEvents_Post_RT/(nTrans*nChans*nIter);

%% RT event rate per transition across iterations

nIter = 100;
nEvents_Pre_RT = zeros(nDatasets,nChans,nIter);
nEvents_Post_RT = zeros(nDatasets,nChans,nIter);

for iDataset = 1:nDatasets
    
    nTrans = lfpStatistics.nTransitions(iDataset);
    
    for iChan = 1:nChans
        
        for iIter = 1:nIter
            
            nEvents_Pre_RT(iDataset,iChan,iIter) = numel(lfpStatistics.eventTimes.Pre{iDataset}{iChan}{iIter})/nTrans;
            nEvents_Post_RT(iDataset,iChan,iIter) = numel(lfpStatistics.eventTimes.Post{iDataset}{iChan}{iIter})/nTrans;
            
        end
        
    end
    
end

nEvents_Pre_RT = nanmean(nEvents_Pre_RT,3);
nEvents_Post_RT = nanmean(nEvents_Post_RT,3);
nEvents_RT = [nEvents_Pre_RT(:);nEvents_Post_RT(:)];

rates.preRT_rate(1) = nanmean(nEvents_Pre_RT(:));
rates.preRT_rate(2) = nanstd(nEvents_Pre_RT(:))./sqrt(576);
rates.RT_rate(1) = mean(nEvents_RT);
rates.RT_rate(2) = std(nEvents_RT)/sqrt(length(nEvents_RT));

dataMatrixRT = [pre_BR_nEvents(:); nEvents_RT(:)];


% [namesRT{1:576}] = deal('PreBR');
% [namesRT{577:577+1152-1}] = deal('RT');
% 
% colorsRT(1:576) = ones(1,576);
% colorsRT(577:577+1152-1) = 3*ones(1,1152);
% 
% 
% g = gramm('x',namesRT,'y',dataMatrixRT(:),'color',colorsRT);
% set_order_options(g,'x',0)
% g.stat_violin('normalization','area','dodge',1,'fill','edge');
% g.set_names('x','condition','y','bursts/transition/channel','size',24)
% g.stat_boxplot('width',0.25,'notch','true');
% g.set_title('Burst rate statistics - BR vs RT');
% g.update()

%% Empty sites RT

cPreEmpty = 0;
cPostEmpty = 0;

for iDataset = 1:nDatasets
    
    for iChan = 1:nChans
        
        for iIter = 1:nIter
            
            if isempty(lfpStatistics.eventTimes.Pre{iDataset}{iChan}{iIter})
            
            cPreEmpty = cPreEmpty+1;
            
            end
            
            if isempty(lfpStatistics.eventTimes.Post{iDataset}{iChan}{iIter})
            
            cPostEmpty = cPostEmpty+1;
            
            end
            
        end
        
    end
    
end

cEmpty = cPreEmpty+cPostEmpty;
pEmpty = cEmpty/(6*96*100);
rates.RT_pEmpty = pEmpty/2;
%% Required p-values

% t-test

[h, p.ttest.prevspost_PA] = ttest(pre_PA_nEvents(:),post_PA_nEvents(:));
[h, p.ttest.prevspre_PA_BR] = ttest(pre_PA_nEvents(:),pre_BR_nEvents(:));
[h, p.ttest.prevspost_BR] = ttest(pre_BR_nEvents(:),post_BR_nEvents(:));
[h, p.ttest.prevspre_BR_PM] = ttest(pre_PM_nEvents(:),pre_BR_nEvents(:));
[h, p.ttest.prevspost_PM] = ttest(pre_PM_nEvents(:),post_PM_nEvents(:));

[p.ranksum.prevspost_PA, h] = ranksum(pre_PA_nEvents(:),post_PA_nEvents(:));
[p.ranksum.prevspre_PA_BR, h] = ranksum(pre_PA_nEvents(:),pre_BR_nEvents(:));
[p.ranksum.prevspost_BR, h] = ranksum(pre_BR_nEvents(:),post_BR_nEvents(:));
[p.ranksum.prevspre_BR_PM, h] = ranksum(pre_PM_nEvents(:),pre_BR_nEvents(:));
[p.ranksum.prevspost_PM, h] = ranksum(pre_PM_nEvents(:),post_PM_nEvents(:));

%% Save

cd B:\Results\LFP_Statistics
mkdir Rates
cd Rates
mkdir std4
cd std4
mkdir MM
cd MM
save(['MM_EventRates_' filtType '_' num2str(duration/1000) '_s.mat'],'rates','p','-v7.3')

