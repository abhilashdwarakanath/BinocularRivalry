function generateLFPtracesTbyT(duration)

% This code collects all computed spectrograms across datasets and then
% creates a grand average of selective sites during Riv and during PA_FS
% for comparison

%% Enumerate the datasets

% traces_ according to Selectivity during Rivalry

datasetsDS{1} = ['E:\Data\H07\12-06-2016\PFC\Bfsgrad1\LFPSpectrograms\traces_trialByTrial_' num2str(duration/1000) 's_back_' num2str(duration/1000) 's'  '.mat'];
datasetsDS{2} = ['E:\Data\H07\13-07-2016\PFC\Bfsgrad1\LFPSpectrograms\traces_trialByTrial_' num2str(duration/1000) 's_back_' num2str(duration/1000) 's'  '.mat'];
datasetsDS{3} = ['E:\Data\H07\20161019\PFC\Bfsgrad1\LFPSpectrograms\traces_trialByTrial_' num2str(duration/1000) 's_back_' num2str(duration/1000) 's'  '.mat'];
datasetsDS{4} = ['E:\Data\H07\20161025\PFC\Bfsgrad1\LFPSpectrograms\traces_trialByTrial_' num2str(duration/1000) 's_back_' num2str(duration/1000) 's'  '.mat'];
datasetsDS{5} = ['E:\Data\A11\20170305\PFC\Bfsgrad1\LFPSpectrograms\traces_trialByTrial_' num2str(duration/1000) 's_back_' num2str(duration/1000) 's'  '.mat'];
datasetsDS{6} = ['E:\Data\A11\20170302\PFC\Bfsgrad1\LFPSpectrograms\traces_trialByTrial_' num2str(duration/1000) 's_back_' num2str(duration/1000) 's'  '.mat'];

%% Plot grand average for DomSels

% collect

t = linspace(-duration/1000,duration/1000,duration+1);

for iDataset = [1 2 3 4 5 6]
    
    load(datasetsDS{iDataset});
    folderName = ['E:\Data\Results\TracesMeans\TrialByTrial\Low-Beta\Dataset' num2str(iDataset) '\'  num2str(duration/1000) 's'];
    mkdir(folderName)
    
    cd(folderName)
    mkdir('PA')
    cd PA

    for i = 1:size(traces.PA.low,1)
        figure(i)
        plot(t,traces.PA.low(i,:),'-r','LineWidth',2)
        hold on
        plot(t,traces.PA.beta(i,:),'-k','LineWidth',1.5)
        xlabel('time in s')
        ylabel('lfp amp')
        title(['PA Transition # : ' num2str(i)]);
        legend('Low (1-9 Hz)','Beta (20-40 Hz)')
        axis tight; grid on;
        vline(0,'--b')
        saveas(gcf,['PATransitions_' num2str(i)],'png')
        pause(1)
        close all
    end
    
    cd(folderName)
    mkdir('BR')
    cd BR

    for i = 1:size(traces.BR.low,1)
        figure(i)
        plot(t,traces.BR.low(i,:),'-r','LineWidth',2)
        hold on
        plot(t,traces.BR.beta(i,:),'-k','LineWidth',1.5)
        xlabel('time in s')
        ylabel('lfp amp')
        title(['BR Transition # : ' num2str(i)]);
        legend('Low (1-9 Hz)','Beta (20-40 Hz)')
        axis tight; grid on;
        vline(0,'--b')
        saveas(gcf,['BRTransitions_' num2str(i)],'png')
        pause(1)
        close all
    end
    
    
end

