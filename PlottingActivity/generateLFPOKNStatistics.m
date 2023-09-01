
function generateLFPOKNStatistics(duration,filtType)

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

datasetsOknStats{1} = ['B:\H07\12-06-2016\PFC\Bfsgrad1\OKNStatistics\oknLags_' num2str(duration/1000) 's_back_' num2str(duration/1000) 's.mat'];
datasetsOknStats{2} = ['B:\H07\13-07-2016\PFC\Bfsgrad1\OKNStatistics\oknLags_' num2str(duration/1000) 's_back_' num2str(duration/1000) 's.mat'];
datasetsOknStats{3} = ['B:\H07\20161019\PFC\Bfsgrad1\OKNStatistics\oknLags_' num2str(duration/1000) 's_back_' num2str(duration/1000) 's.mat'];
datasetsOknStats{4} = ['B:\H07\20161025\PFC\Bfsgrad1\OKNStatistics\oknLags_' num2str(duration/1000) 's_back_' num2str(duration/1000) 's.mat'];
datasetsOknStats{5} = ['B:\A11\20170305\PFC\Bfsgrad1\OKNStatistics\oknLags_' num2str(duration/1000) 's_back_' num2str(duration/1000) 's.mat'];
datasetsOknStats{6} = ['B:\A11\20170302\PFC\Bfsgrad1\OKNStatistics\oknLags_' num2str(duration/1000) 's_back_' num2str(duration/1000) 's.mat'];

%% Plot grand average for DomSels

% collect

preSwitchPeaks_BR_90 = [];
preSwitchPeaks_BR_270 = [];
preSwitchPeaks_PA_90 = [];
preSwitchPeaks_PA_270 = [];

postSwitchPeaks_BR_90 = [];
postSwitchPeaks_BR_270 = [];
postSwitchPeaks_PA_90 = [];
postSwitchPeaks_PA_270 = [];

oknFPpeaks_BR_90 = [];
oknFPpeaks_BR_270 = [];
oknFPpeaks_PA_90 = [];
oknFPpeaks_PA_270 = [];

endDom_BR_90 = [];
endDom_BR_270 = [];


for iDataset = [1 2 3 4 5 6]
    
    load(datasetsLfpStats{iDataset});
    load(datasetsOknStats{iDataset});
    folderName = ['B:\Results\LFP_OKN_Statistics\std4\' filtType '\' num2str(duration/1000) 's'];
    mkdir(folderName)
    cd(folderName)
    
    % Do for BR90

    for iElec = 1:96

       preSwitchPeaks_BR_90 = [preSwitchPeaks_BR_90 blpCharacteristics(iElec).BR.dom90.preEvtTimes];
        postSwitchPeaks_BR_90 = [postSwitchPeaks_BR_90 blpCharacteristics(iElec).BR.dom90.postEvtTimes];
        
    end
    
    % Do for PA 90
    
    for iElec = 1:96

       preSwitchPeaks_PA_90 = [preSwitchPeaks_PA_90 blpCharacteristics(iElec).PA.dom90.preEvtTimes];
        postSwitchPeaks_PA_90 = [postSwitchPeaks_PA_90 blpCharacteristics(iElec).PA.dom90.postEvtTimes];
        
    end
%     
    % Do for BR 270
    
    for iElec = 1:96

       preSwitchPeaks_BR_270 = [preSwitchPeaks_BR_270 blpCharacteristics(iElec).BR.dom270.preEvtTimes];
        postSwitchPeaks_BR_270 = [postSwitchPeaks_BR_270 blpCharacteristics(iElec).BR.dom270.postEvtTimes];
        
    end
    
    % Do for PA 270
    
    for iElec = 1:96

       preSwitchPeaks_PA_270 = [preSwitchPeaks_PA_270 blpCharacteristics(iElec).PA.dom270.preEvtTimes];
        postSwitchPeaks_PA_270 = [postSwitchPeaks_PA_270 blpCharacteristics(iElec).PA.dom270.postEvtTimes];
        
    end
    
    % Collect OKN lags
    
    oknFPpeaks_BR_90 = [oknFPpeaks_BR_90 oknLags.BR.dom90];
    oknFPpeaks_BR_270 = [oknFPpeaks_BR_270 oknLags.BR.dom270];
    
%     oknFPpeaks_PA_90 = [oknFPpeaks_PA_90 oknLags.PA.dom90];
%     oknFPpeaks_PA_270 = [oknFPpeaks_PA_270 oknLags.PA.dom270];
    
    ed90 = [];
    ed270 = [];
    
    for iCond = 1:size(endDomTimes.BR.data.endPrevDom.dom90,2)
        for nDom = 1:size(endDomTimes.BR.data.endPrevDom.dom90{iCond},2)
            piece = (endDomTimes.BR.data.endPrevDom.dom90{1, iCond}{nDom});
            if ~isnan(piece)
                ed90 = [ed90 piece];
            end
        end
    end
    
    for iCond = 1:size(endDomTimes.BR.data.endPrevDom.dom270,2)
        for nDom = 1:size(endDomTimes.BR.data.endPrevDom.dom270{iCond},2)
            piece = (endDomTimes.BR.data.endPrevDom.dom270{1, iCond}{nDom});
            if ~isnan(piece)
                ed270 = [ed270 piece];
            end
        end
    end
    
    endDom_BR_90 = [endDom_BR_90 ed90];
    endDom_BR_270 = [endDom_BR_270 ed270];
            
end

% Collapse stats across directions

preSwitchPeaks_BR = [preSwitchPeaks_BR_90 preSwitchPeaks_BR_270];
preSwitchPeaks_PA = [preSwitchPeaks_PA_90 preSwitchPeaks_PA_270];

postSwitchPeaks_BR = [postSwitchPeaks_BR_90 postSwitchPeaks_BR_270];
postSwitchPeaks_PA = [postSwitchPeaks_PA_90 postSwitchPeaks_PA_270];

% Collapse OKN across directions

oknFPpeaks_BR = [oknFPpeaks_BR_90 oknFPpeaks_BR_270]./1000;
%oknFPpeaks_PA = [oknFPpeaks_PA_90 oknFPpeaks_PA_270]./1000;

% Collapse across directions for end dom

endDom_BR = [endDom_BR_90 endDom_BR_270]./1000;

%% Plot the statistics

t = linspace(-duration/1000,duration/1000,(duration)+1);

% Do the statistics for pre OKN and BR

[p_okn h_okn] = ranksum(preSwitchPeaks_BR,oknFPpeaks_BR);

[p_switch h_switch] = ranksum(preSwitchPeaks_BR,endDom_BR);

% Do the kernel density estimation

pd_br_okn = fitdist(oknFPpeaks_BR','kernel');

pd_br_switch = fitdist(endDom_BR','kernel');

pd_br_pre = fitdist(preSwitchPeaks_BR','kernel');

taxis = t(1:301); % Fix this hardcoding!!!!


figure(1)
area(taxis,normalise(pdf(pd_br_pre,taxis)),'FaceColor',[0.7 0 0],'EdgeColor','k')
hold on
area(taxis,normalise(pdf(pd_br_switch,taxis)),'FaceColor',[0 0 0.7],'EdgeColor','k')
xlabel('duration [s]')
ylabel('normalised probability density')
vline(median(endDom_BR),'--w')
vline(median(preSwitchPeaks_BR),'--r')
grid off; box off;axis tight;

area(t,normalise(pdf(pd_br,t)),'FaceColor',[0.7 0 0],'EdgeColor','k')
hold on
vline(median(brPeaks),'--r')
area(t,normalise(pdf(pd_pa,t)),'FaceColor',[0.2 0.2 0.2],'EdgeColor','k')
vline(median(paPeaks),'--k')
xlabel('duration [s]')
ylabel('normalised probability density')
grid off; box off;axis tight;

