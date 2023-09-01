function generateLFPtracesBaselined(duration,filtType)

% This code collects all computed spectrograms across datasets and then
% creates a grand average of selective sites during Riv and during PA_FS
% for comparison

%% Enumerate the datasets

% traces_ according to Selectivity during Rivalry

datasetsDS{1} = ['E:\Data\H07\12-06-2016\PFC\Bfsgrad1\LFPStatistics\blpCharacteristics_' num2str(duration) 'ms_' filtType '_DomSel.mat'];
datasetsDS{2} = ['E:\Data\H07\13-07-2016\PFC\Bfsgrad1\LFPStatistics\blpCharacteristics_' num2str(duration) 'ms_' filtType '_DomSel.mat'];
datasetsDS{3} = ['E:\Data\H07\20161019\PFC\Bfsgrad1\LFPStatistics\blpCharacteristics_' num2str(duration) 'ms_' filtType '_DomSel.mat'];
datasetsDS{4} = ['E:\Data\H07\20161025\PFC\Bfsgrad1\LFPStatistics\blpCharacteristics_' num2str(duration) 'ms_' filtType '_DomSel.mat'];
datasetsDS{5} = ['E:\Data\A11\20170305\PFC\Bfsgrad1\LFPStatistics\blpCharacteristics_' num2str(duration) 'ms_' filtType '_DomSel.mat'];
datasetsDS{6} = ['E:\Data\A11\20170302\PFC\Bfsgrad1\LFPStatistics\blpCharacteristics_' num2str(duration) 'ms_' filtType '_DomSel.mat'];

%% Plot grand average for DomSels

% collect

for iDataset = [1 2 3 4 5 6]
    
    load(datasetsDS{iDataset});
    folderName = ['E:\Data\Results\TracesMeans\BaselinedNormalised\' filtType '\Dataset' num2str(iDataset) '\' num2str(duration/1000) 's'];
    mkdir(folderName)
    cd(folderName)
    
    % Do for NP2P 90
    c=0;
    for iElec = 1:length(blpCharacteristicsNP2P_90)
        
        if ~isempty(blpCharacteristicsNP2P_90(iElec).BR)
            
            c = c+1;

        traces_BR_np2p90DS{c} = [blpCharacteristicsNP2P_90(iElec).BR.NP2P90.traces'];
        traces_PA_np2p90DS{c} = [blpCharacteristicsNP2P_90(iElec).PA.NP2P90.traces'];
        
        end
        
    end
    
    sigLength = size(traces_BR_np2p90DS{1},1);
    t = linspace((-sigLength+1)/1000,(sigLength-1)/1000,sigLength);
    numSubPlots = ceil(c/2);

    clear baseline

    for valChan = 1:c
        baseline(valChan,:) = nanmean(traces_PA_np2p90DS{valChan},2);
    end
    
    figure(1)
    suptitle(['Dataset # : ' num2str(iDataset)])
    c=0;
    for iElec = 1:length(blpCharacteristicsNP2P_90)
        
        if ~isempty(blpCharacteristicsNP2P_90(iElec).BR)
            c = c+1;
            subplot(2,numSubPlots,c)
            %plot(t,(traces_BR_np2p90DS{c})-baseline(c,:)','-r','LineWidth',0.75)
            %hold on
            plot(t,nanmean(traces_BR_np2p90DS{c},2)-baseline(c,:)','-r','LineWidth',2.5)
            vline(0,'--b')
            xlabel('time in s')
            ylabel('lfp amplitude')
            title(['Baselined BR NP2P Pref 90 ' filtType ' Ch : ' num2str(iElec)])
        end
    end
    set(gcf, 'Position', get(0, 'Screensize'));
    saveas(gcf,'np2p_Pref90_BR','png')
    close all
    
    
   c=0;
    for iElec = 1:length(blpCharacteristicsNP2P_270)
        
        if ~isempty(blpCharacteristicsNP2P_270(iElec).BR)
            
            c = c+1;

        traces_BR_np2p270DS{c} = [blpCharacteristicsNP2P_270(iElec).BR.NP2P270.traces'];
        traces_PA_np2p270DS{c} = [blpCharacteristicsNP2P_270(iElec).PA.NP2P270.traces'];
        
        end
        
    end
    
    sigLength = size(traces_BR_np2p270DS{1},1);
    t = linspace((-sigLength+1)/1000,(sigLength-1)/1000,sigLength);
    numSubPlots = ceil(c/2);
    clear baseline
    
    for valChan = 1:c
        baseline(valChan,:) = nanmean(traces_PA_np2p270DS{valChan},2);
    end
    
    figure(3)
    suptitle(['Dataset # : ' num2str(iDataset)])
    c=0;
    for iElec = 1:length(blpCharacteristicsNP2P_270)
        
        if ~isempty(blpCharacteristicsNP2P_270(iElec).BR)
            c = c+1;
            subplot(2,numSubPlots,c)
            %plot(t,(traces_BR_np2p270DS{c})-baseline(c,:)','-r','LineWidth',0.75)
            %hold on
            plot(t,nanmean(traces_BR_np2p270DS{c},2)-baseline(c,:)','-r','LineWidth',2.5)
            vline(0,'--b')
            xlabel('time in s')
            ylabel('lfp amplitude')
            title(['Baselined BR NP2P Pref 270 ' filtType ' Ch : ' num2str(iElec)])
        end
    end
    set(gcf, 'Position', get(0, 'Screensize'));
    saveas(gcf,'np2p_Pref270_BR','png')
    close all
    
    
            
    % Do P2NP
    
    c=0;
    for iElec = 1:length(blpCharacteristicsP2NP_90)
        
        if ~isempty(blpCharacteristicsP2NP_90(iElec).BR)
            
            c = c+1;

        traces_BR_p2np90DS{c} = [blpCharacteristicsP2NP_90(iElec).BR.P2NP270.traces'];
        traces_PA_p2np90DS{c} = [blpCharacteristicsP2NP_90(iElec).PA.P2NP270.traces'];
        
        end
        
    end
    
    sigLength = size(traces_BR_p2np90DS{1},1);
    t = linspace((-sigLength+1)/1000,(sigLength-1)/1000,sigLength);
    numSubPlots = ceil(c/2);
    clear baseline
    
    for valChan = 1:c
        baseline(valChan,:) = nanmean(traces_PA_p2np90DS{valChan},2);
    end
    
    figure(5)
    suptitle(['Dataset # : ' num2str(iDataset)])
    c=0;
    for iElec = 1:length(blpCharacteristicsP2NP_90)
        
        if ~isempty(blpCharacteristicsP2NP_90(iElec).BR)
            c = c+1;
            subplot(2,numSubPlots,c)
            %plot(t,(traces_BR_p2np90DS{c})-baseline(c,:)','-r','LineWidth',0.75)
            %hold on
            plot(t,nanmean(traces_BR_p2np90DS{c},2)-baseline(c,:)','-r','LineWidth',2.5)
            vline(0,'--b')
            xlabel('time in s')
            ylabel('lfp amplitude')
            title(['Baselined BR NP2P Pref 90 ' filtType ' Ch : ' num2str(iElec)])
        end
    end
    set(gcf, 'Position', get(0, 'Screensize'));
    saveas(gcf,'p2np_Pref90_BR','png')
    close all

    
    c=0;
    for iElec = 1:length(blpCharacteristicsP2NP_270)
        
        if ~isempty(blpCharacteristicsP2NP_270(iElec).BR)
            
            c = c+1;

        traces_BR_p2np270DS{c} = [blpCharacteristicsP2NP_270(iElec).BR.P2NP90.traces'];
        traces_PA_p2np270DS{c} = [blpCharacteristicsP2NP_270(iElec).PA.P2NP90.traces'];
        
        end
        
    end
    
    sigLength = size(traces_BR_p2np270DS{1},1);
    t = linspace((-sigLength+1)/1000,(sigLength-1)/1000,sigLength);
    numSubPlots = ceil(c/2);
    clear baseline
    
     for valChan = 1:c
        baseline(valChan,:) = nanmean(traces_PA_p2np270DS{valChan},2);
    end
    
    figure(7)
    suptitle(['Dataset # : ' num2str(iDataset)])
    c=0;
    for iElec = 1:length(blpCharacteristicsP2NP_270)
        
        if ~isempty(blpCharacteristicsP2NP_270(iElec).BR)
            c = c+1;
            subplot(2,numSubPlots,c)
             %plot(t,(traces_BR_p2np270DS{c})-baseline(c,:)','-r','LineWidth',0.75)
             %hold on
             plot(t,nanmean(traces_BR_p2np270DS{c},2)-baseline(c,:)','-r','LineWidth',2.5)
            vline(0,'--b')
            xlabel('time in s')
            ylabel('lfp amplitude')
            title(['Baselined BR NP2P Pref 270 ' filtType ' Ch : ' num2str(iElec)])
        end
    end
    set(gcf, 'Position', get(0, 'Screensize'));
    saveas(gcf,'p2np_Pref270_BR','png')
    close all

end

%% Plot the pooled traces

