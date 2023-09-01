function generateLFPtraces(duration,filtType)

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

traces_BR_p2np90DS = [];
traces_BR_p2np270DS = [];
traces_BR_np2p90DS = [];
traces_BR_np2p270DS = [];

traces_PA_p2np90DS = [];
traces_PA_p2np270DS = [];
traces_PA_np2p90DS = [];
traces_PA_np2p270DS = [];

for iDataset = [1 2 3 4 5 6]
    
    load(datasetsDS{iDataset});
    folderName = ['E:\Data\Results\TracesMeans\MinMaxNormalised\' filtType '\Dataset' num2str(iDataset) '\' num2str(duration/1000) 's'];
    mkdir(folderName)
    cd(folderName)
    % Do for NP2P
    c=0;
    for iElec = 1:length(blpCharacteristicsNP2P_90)
        
        if ~isempty(blpCharacteristicsNP2P_90(iElec).BR)
            
            c = c+1;

        traces_BR_np2p90DS = [traces_BR_np2p90DS blpCharacteristicsNP2P_90(iElec).BR.NP2P90.traces'];
        traces_PA_np2p90DS = [traces_PA_np2p90DS blpCharacteristicsNP2P_90(iElec).PA.NP2P90.traces'];
        
        end
        
    end
    
    sigLength = size(traces_BR_np2p90DS,1);
    t = linspace((-sigLength+1)/1000,(sigLength-1)/1000,sigLength);
    numSubPlots = ceil(c/2);
    
    figure(1)
    suptitle(['Dataset # : ' num2str(iDataset)])
    c=0;
    for iElec = 1:length(blpCharacteristicsNP2P_90)
        
        if ~isempty(blpCharacteristicsNP2P_90(iElec).BR)
            c = c+1;
            
            subplot(2,numSubPlots,c)
            %if ~isempty(blpCharacteristicsNP2P_90(iElec).BR.NP2P90.traces')
            %plot(t,blpCharacteristicsNP2P_90(iElec).BR.NP2P90.traces','-r','LineWidth',0.15)
            %hold on
            plot(t,normalise(nanmean(blpCharacteristicsNP2P_90(iElec).BR.NP2P90.traces,1)),'-r','LineWidth',2.5)
            %end
            vline(0,'--b')
            xlabel('time in s')
            ylabel('lfp amplitude')
            title(['BR NP2P Pref 90 ' filtType ' Ch : ' num2str(iElec)])
        end
    end
    set(gcf, 'Position', get(0, 'Screensize'));
    saveas(gcf,'np2p_Pref90_BR','png')
    close all
    
    figure(2)
    suptitle(['Dataset # : ' num2str(iDataset)])
    c=0;
    for iElec = 1:length(blpCharacteristicsNP2P_90)
        
        if ~isempty(blpCharacteristicsNP2P_90(iElec).BR)
            c = c+1;
            
            subplot(2,numSubPlots,c)
            
            hold on
            %plot(t,blpCharacteristicsNP2P_90(iElec).PA.NP2P90.traces','-k','LineWidth',0.15)
            plot(t,normalise(nanmean(blpCharacteristicsNP2P_90(iElec).PA.NP2P90.traces,1)),'-k','LineWidth',2.5)
            vline(0,'--b')
            xlabel('time in s')
            ylabel('lfp amplitude')
            title(['PA NP2P Pref 90 ' filtType ' Ch : ' num2str(iElec)])
        end
    end
    set(gcf, 'Position', get(0, 'Screensize'));
    saveas(gcf,'np2p_Pref90_PA','png')
    close all
    
    c=0;
    for iElec = 1:length(blpCharacteristicsNP2P_270)
        
        if ~isempty(blpCharacteristicsNP2P_270(iElec).BR)
            
            c = c+1;

        traces_BR_np2p270DS = [traces_BR_np2p270DS blpCharacteristicsNP2P_270(iElec).BR.NP2P270.traces'];
        traces_PA_np2p270DS = [traces_PA_np2p270DS blpCharacteristicsNP2P_270(iElec).PA.NP2P270.traces'];
        
        end
        
    end
    
    sigLength = size(traces_BR_np2p270DS,1);
    t = linspace((-sigLength+1)/1000,(sigLength-1)/1000,sigLength);
    numSubPlots = ceil(c/2);
    
    figure(3)
    suptitle(['Dataset # : ' num2str(iDataset)])
    c=0;
    for iElec = 1:length(blpCharacteristicsNP2P_270)
        
        if ~isempty(blpCharacteristicsNP2P_270(iElec).BR)
            c = c+1;
            
            subplot(2,numSubPlots,c)
            %if ~isempty(blpCharacteristicsNP2P_270(iElec).BR.NP2P270.traces')
            %plot(t,blpCharacteristicsNP2P_270(iElec).BR.NP2P270.traces','-r','LineWidth',0.15)
            %hold on
            plot(t,normalise(nanmean(blpCharacteristicsNP2P_270(iElec).BR.NP2P270.traces,1)),'-r','LineWidth',2.5)
            %end
            vline(0,'--b')
            xlabel('time in s')
            ylabel('lfp amplitude')
            title(['BR NP2P Pref 270 ' filtType ' Ch : ' num2str(iElec)])
        end
    end
    set(gcf, 'Position', get(0, 'Screensize'));
    saveas(gcf,'np2p_Pref270_BR','png')
    close all
    
    figure(4)
    suptitle(['Dataset # : ' num2str(iDataset)])
    c=0;
    for iElec = 1:length(blpCharacteristicsNP2P_270)
        
        if ~isempty(blpCharacteristicsNP2P_270(iElec).BR)
            c = c+1;
            
            subplot(2,numSubPlots,c)
            
            %hold on
            %plot(t,blpCharacteristicsNP2P_270(iElec).PA.NP2P270.traces','-k','LineWidth',0.15)
            plot(t,normalise(nanmean(blpCharacteristicsNP2P_270(iElec).PA.NP2P270.traces,1)),'-k','LineWidth',2.5)
            vline(0,'--b')
            xlabel('time in s')
            ylabel('lfp amplitude')
            title(['PA NP2P Pref 270 ' filtType ' Ch : ' num2str(iElec)])
        end
    end
    set(gcf, 'Position', get(0, 'Screensize'));
    saveas(gcf,'np2p_Pref270_PA','png')
    close all
            
            
    % Do NP2P
    
    c=0;
    for iElec = 1:length(blpCharacteristicsP2NP_90)
        
        if ~isempty(blpCharacteristicsP2NP_90(iElec).BR)
            
            c = c+1;

        traces_BR_p2np270DS = [traces_BR_p2np270DS blpCharacteristicsP2NP_90(iElec).BR.P2NP270.traces'];
        traces_PA_p2np270DS = [traces_PA_p2np270DS blpCharacteristicsP2NP_90(iElec).PA.P2NP270.traces'];
        
        end
        
    end
    
    sigLength = size(traces_BR_p2np270DS,1);
    t = linspace((-sigLength+1)/1000,(sigLength-1)/1000,sigLength);
    numSubPlots = ceil(c/2);
    
    figure(5)
    suptitle(['Dataset # : ' num2str(iDataset)])
    c=0;
    for iElec = 1:length(blpCharacteristicsP2NP_90)
        
        if ~isempty(blpCharacteristicsP2NP_90(iElec).BR)
            c = c+1;
            
            subplot(2,numSubPlots,c)
            %if ~isempty(blpCharacteristicsP2NP_90(iElec).BR.P2NP270.traces')
            %plot(t,blpCharacteristicsP2NP_90(iElec).BR.P2NP270.traces','-r','LineWidth',0.15)
            %hold on
            plot(t,normalise(nanmean(blpCharacteristicsP2NP_90(iElec).BR.P2NP270.traces,1)),'-r','LineWidth',2.5)
            %end
            vline(0,'--b')
            xlabel('time in s')
            ylabel('lfp amplitude')
            title(['BR P2NP Pref 90 ' filtType ' Ch : ' num2str(iElec)])
        end
    end
    set(gcf, 'Position', get(0, 'Screensize'));
    saveas(gcf,'p2np_Pref90_BR','png')
    close all
    
    figure(6)
    suptitle(['Dataset # : ' num2str(iDataset)])
    c=0;
    for iElec = 1:length(blpCharacteristicsP2NP_90)
        
        if ~isempty(blpCharacteristicsP2NP_90(iElec).BR)
            c = c+1;
            
            subplot(2,numSubPlots,c)
            
            %hold on
            %plot(t,blpCharacteristicsP2NP_90(iElec).PA.P2NP270.traces','-k','LineWidth',0.15)
            plot(t,normalise(nanmean(blpCharacteristicsP2NP_90(iElec).PA.P2NP270.traces,1)),'-k','LineWidth',2.5)
            vline(0,'--b')
            xlabel('time in s')
            ylabel('lfp amplitude')
            title(['PA P2NP Pref 90 ' filtType ' Ch : ' num2str(iElec)])
        end
    end
    set(gcf, 'Position', get(0, 'Screensize'));
    saveas(gcf,'p2np_Pref90_PA','png')
    close all

    c=0;
    for iElec = 1:length(blpCharacteristicsP2NP_270)
        
        if ~isempty(blpCharacteristicsP2NP_270(iElec).BR)
            
            c = c+1;

        traces_BR_p2np90DS = [traces_BR_p2np90DS blpCharacteristicsP2NP_270(iElec).BR.P2NP90.traces'];
        traces_PA_p2np90DS = [traces_PA_p2np90DS blpCharacteristicsP2NP_270(iElec).PA.P2NP90.traces'];
        
        end
        
    end
    
    sigLength = size(traces_BR_p2np90DS,1);
    t = linspace((-sigLength+1)/1000,(sigLength-1)/1000,sigLength);
    numSubPlots = ceil(c/2);
    
    figure(7)
    suptitle(['Dataset # : ' num2str(iDataset)])
    c=0;
    for iElec = 1:length(blpCharacteristicsP2NP_270)
        
        if ~isempty(blpCharacteristicsP2NP_270(iElec).BR)
            c = c+1;
            
            subplot(2,numSubPlots,c)
            %if ~isempty(blpCharacteristicsP2NP_270(iElec).BR.P2NP90.traces')
            %plot(t,blpCharacteristicsP2NP_270(iElec).BR.P2NP90.traces','-r','LineWidth',0.15)
            %hold on
            plot(t,normalise(nanmean(blpCharacteristicsP2NP_270(iElec).BR.P2NP90.traces,1)),'-r','LineWidth',2.5)
            %end
            vline(0,'--b')
            xlabel('time in s')
            ylabel('lfp amplitude')
            title(['BR P2NP Pref 270 ' filtType ' Ch : ' num2str(iElec)])
        end
    end
    set(gcf, 'Position', get(0, 'Screensize'));
    saveas(gcf,'p2np_Pref270_BR','png')
    close all

    figure(8)
    suptitle(['Dataset # : ' num2str(iDataset)])
    c=0;
    for iElec = 1:length(blpCharacteristicsP2NP_270)
        
        if ~isempty(blpCharacteristicsP2NP_270(iElec).BR)
            c = c+1;
            
            subplot(2,numSubPlots,c)
            
            %hold on
            %plot(t,blpCharacteristicsP2NP_270(iElec).PA.P2NP90.traces','-k','LineWidth',0.15)
            plot(t,normalise(nanmean(blpCharacteristicsP2NP_270(iElec).PA.P2NP90.traces,1)),'-k','LineWidth',2.5)
            vline(0,'--b')
            xlabel('time in s')
            ylabel('lfp amplitude')
            title(['PA P2NP Pref 270 ' filtType ' Ch : ' num2str(iElec)])
        end
    end
    
    saveas(gcf,'p2np_Pref270_PA','png')
    close all
end

%% Plot the pooled traces

