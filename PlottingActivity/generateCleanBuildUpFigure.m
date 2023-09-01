function generateCleanBuildUpFigure(duration,filtType)

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

% CHOOSE 100 TRANSITIONS FROM EACH AND THEN USE THE CLEAN TRANSITIONS
% SEPARATE THE 2 TYPES OF SWTICHES WHEN MAKING THIS FIGURE

allSwitches_BR = [];
allSwitches_PA = [];

for iDataset = [1 2 3 4 5 6]
    
    load(datasetsLfpStats{iDataset});

    folderName = ['B:\Results\LFP_Statistics\std4\Traces\' filtType '\' num2str(duration/1000) 's'];
    mkdir(folderName)
    cd(folderName)
    
    t = linspace((-duration)/1000,(duration)/1000,duration+1);
    
    selSwitches = randi([1, size(blpCharacteristics(1).BR.dom90.traces,1)], [1 100]);
    c = 0;
    for iSwitch = 1:length(selSwitches)
        c = c+1;
        for iChan = 1:96
        
        traces_BR_s270TO90(c,iChan,:) = zscore(blpCharacteristics(iChan).BR.dom90.traces(iSwitch(selSwitches,:)));
        
        end
        
    end
    
    traces_BR_s270TO90 = squeeze(nanmean(traces_BR_s270TO90,2));
    
     selSwitches = randi([1, size(blpCharacteristics(1).BR.dom270.traces,1)], 100);
    
    c = 0;
    for iSwitch = 1:length(selSwitches)
        c = c+1;
        for iChan = 1:96
        
      traces_BR_s270TO90(c,iChan,:) = zscore(blpCharacteristics(iChan).BR.dom270.traces(iSwitch(selSwitches,:)));
        
        end
        
    end
    
     selSwitches = randi([1, size(blpCharacteristics(1).PA.dom90.traces,1)], 100);
    
    c = 0;
    for iSwitch = 1:length(selSwitches)
        c = c+1;
        for iChan = 1:96
        
        traces_BR_s270TO90(c,iChan,:) = zscore(blpCharacteristics(iChan).PA.dom90.traces(iSwitch(selSwitches,:)));
        
        end
        
    end
    
    traces_PA_s270TO90 = squeeze(nanmean(traces_PA_s270TO90,2));
    
    selSwitches = randi([1, size(blpCharacteristics(1).PA.dom270.traces,1)], 100);
    
   c = 0;
    for iSwitch = 1:length(selSwitches)
        c = c+1;
        for iChan = 1:96
        
        traces_PA_s90TO270(c,iChan,:) = zscore(blpCharacteristics(iChan).PA.dom270.traces(iSwitch(selSwitches,:)));
        
        end
        
    end
    
    traces_PA_s90TO270 = squeeze(nanmean(traces_PA_s90TO270,2));
    
    allSwitches_BR = [allSwitches_BR;traces_BR_s270TO90;traces_BR_s90TO270];
    clear traces_BR_s270TO90; clear traces_BR_s90TO270;
    allSwitches_PA = [allSwitches_PA;traces_PA_s270TO90;traces_PA_s90TO270];
    clear traces_PA_s270TO90; clear traces_PA_s90TO270;
    
end

meanTracePA = nanmean(allSwitches_PA,1); % Get the mean
semTracePA = nanstd(allSwitches_PA,[],1)./sqrt(size(allSwitches_PA,1)); % Get the SEM

meanTraceBR = nanmean(allSwitches_BR,1); % Get the mean
semTraceBR = nanstd(allSwitches_BR,[],1)./sqrt(size(allSwitches_BR,1)); % Get the SEM

figure
subplot(1,2,1)
shadedErrorBar(t(26:476),meanTracePA(26:476),semTracePA(26:476))
hold on
plot(t(26:476),meanTracePA(26:476),'-k','LineWidth',1)
xlabel('time relative to switch [s]')
ylabel('instantaneous amplitude')
box off
xlim([-0.5 0.55])
vline(0,'--b')
title('PA Switches')
subplot(1,2,2)
shadedErrorBar(t(26:476),meanTraceBR(26:476),semTraceBR(26:476))
hold on
plot(t(26:476),meanTraceBR(26:476),'-r','LineWidth',1)
xlabel('time relative to switch [s]')
ylabel('instantaneous amplitude')
title('BR Switches')
box off
xlim([-0.5 0.55])
vline(0,'--b')

%% Plot imagesc

subplot(1,2,1)
imagesc(t,1:size(allSwitches_PA,1),allSwitches_PA-mean(mean(allSwitches_PA)))
colormap jet
xlabel('time relative to swtich [s]')
ylabel('switch number')
vline(0,'--w')
title('PA Switches')
subplot(1,2,2)
imagesc(t,1:size(allSwitches_BR,1),allSwitches_BR-mean(mean(allSwitches_BR)))
colormap jet
xlabel('time relative to swtich [s]')
vline(0,'--w')
title('PA Switches')


cd(folderName)
filename = ['std4_lfpStatistics_' filtType '_' num2str(duration/1000) 's.mat'];
save(filename,'lfpStatistics','-v7.3');
