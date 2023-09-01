function generateLFPSpectrogramsTbyT(duration)

% This code collects all computed spectrograms across datasets and then
% creates a grand average of selective sites during Riv and during PA_FS
% for comparison

%% Enumerate the datasets

% traces_ according to Selectivity during Rivalry

datasetsDS{1} = ['E:\Data\H07\12-06-2016\PFC\Bfsgrad1\LFPSpectrograms\cleanDomSpecgrams_trialByTrial_' num2str(duration/1000) 's_back_' num2str(duration/1000) 's'  '.mat'];
datasetsDS{2} = ['E:\Data\H07\13-07-2016\PFC\Bfsgrad1\LFPSpectrograms\cleanDomSpecgrams_trialByTrial_' num2str(duration/1000) 's_back_' num2str(duration/1000) 's'  '.mat'];
datasetsDS{3} = ['E:\Data\H07\20161019\PFC\Bfsgrad1\LFPSpectrograms\cleanDomSpecgrams_trialByTrial_' num2str(duration/1000) 's_back_' num2str(duration/1000) 's'  '.mat'];
datasetsDS{4} = ['E:\Data\H07\20161025\PFC\Bfsgrad1\LFPSpectrograms\cleanDomSpecgrams_trialByTrial_' num2str(duration/1000) 's_back_' num2str(duration/1000) 's'  '.mat'];
datasetsDS{5} = ['E:\Data\A11\20170305\PFC\Bfsgrad1\LFPSpectrograms\cleanDomSpecgrams_trialByTrial_' num2str(duration/1000) 's_back_' num2str(duration/1000) 's'  '.mat'];
datasetsDS{6} = ['E:\Data\A11\20170302\PFC\Bfsgrad1\LFPSpectrograms\cleanDomSpecgrams_trialByTrial_' num2str(duration/1000) 's_back_' num2str(duration/1000) 's'  '.mat'];

%% Plot grand average for DomSels

% collect

t = linspace(-duration/1000,duration/1000,duration+1);

for iDataset = [1 2 3 4 5 6]
    
    load(datasetsDS{iDataset});
    folderName = ['E:\Data\Results\Spectrograms\TrialByTrial\Dataset' num2str(iDataset) '\'  num2str(duration/1000) 's'];
    mkdir(folderName)
    
    cd(folderName)
    mkdir('PA')
    cd PA
    
    f = spectrograms.f;
    Yticks = 2.^(round(log2(min(f))):round(log2(max(f))));
    
    for i = 1:size(spectrograms.PA,1)
        
        figure(i)
        
        subplot(3,1,1)
        imagesc(t,log2(f),squeeze(spectrograms.PA(i,:,:)))
        xlabel('time in s')
        ylabel('Frequency in Hz')
        title(['Raw PA CWT - transition # : ' num2str(i)])
        AX = gca;
        AX.YLim = log2([min(f), max(f)]);
        set(AX, 'YTick',log2(Yticks(:)), 'YTickLabel',num2str(sprintf('%g\n',Yticks)))
        axis xy
        vline(0,'--w')
        colormap jet
        AX.CLim = [50 600];
        
        subplot(3,1,2)
        imagesc(t,log2(f),zscore(squeeze(spectrograms.PA(i,:,:)),[],2))
        xlabel('time in s')
        ylabel('Frequency in Hz')
        title(['Time z-scored PA CWT - transition # : ' num2str(i)])
        AX = gca;
        AX.YLim = log2([min(f), max(f)]);
        set(AX, 'YTick',log2(Yticks(:)), 'YTickLabel',num2str(sprintf('%g\n',Yticks)))
        axis xy
        vline(0,'--w')
        colormap jet
        AX.CLim = [0 3.5];
        
        subplot(3,1,3)
        imagesc(t,log2(f),zscore(squeeze(spectrograms.PA(i,:,:)),[],1))
        xlabel('time in s')
        ylabel('Frequency in Hz')
        title(['Freq z-scored PA CWT - transition # : ' num2str(i)])
        AX = gca;
        AX.YLim = log2([min(f), max(f)]);
        set(AX, 'YTick',log2(Yticks(:)), 'YTickLabel',num2str(sprintf('%g\n',Yticks)))
        axis xy
        vline(0,'--w')
        colormap jet
        AX.CLim = [0 3.5];
        
        set(gcf, 'Position', get(0, 'Screensize'));
        saveas(gcf,['Specgrams_PATransitions_' num2str(i)],'png')
        pause(2)
        close all
    end
    
    cd(folderName)
    mkdir('BR')
    cd BR
    
   for i = 1:size(spectrograms.BR,1)
        
        figure(i)
        
        subplot(3,1,1)
        imagesc(t,log2(f),squeeze(spectrograms.BR(i,:,:)))
        xlabel('time in s')
        ylabel('Frequency in Hz')
        title(['Raw BR CWT - transition # : ' num2str(i)])
        AX = gca;
        AX.YLim = log2([min(f), max(f)]);
        set(AX, 'YTick',log2(Yticks(:)), 'YTickLabel',num2str(sprintf('%g\n',Yticks)))
        axis xy
        vline(0,'--w')
        colormap jet
        AX.CLim = [50 600];
        
        subplot(3,1,2)
        imagesc(t,log2(f),zscore(squeeze(spectrograms.BR(i,:,:)),[],2))
        xlabel('time in s')
        ylabel('Frequency in Hz')
        title(['Time z-scored BR CWT - transition # : ' num2str(i)])
        AX = gca;
        AX.YLim = log2([min(f), max(f)]);
        set(AX, 'YTick',log2(Yticks(:)), 'YTickLabel',num2str(sprintf('%g\n',Yticks)))
        axis xy
        vline(0,'--w')
        colormap jet
        AX.CLim = [0 3.5];
        
        subplot(3,1,3)
        pcolor(t,log2(f),zscore(squeeze(spectrograms.BR(i,:,:)),[],1))
        xlabel('time in s')
        ylabel('Frequency in Hz')
        title(['Freq z-scored BR CWT - transition # : ' num2str(i)])
        AX = gca;
        AX.YLim = log2([min(f), max(f)]);
        set(AX, 'YTick',log2(Yticks(:)), 'YTickLabel',num2str(sprintf('%g\n',Yticks)))
        axis xy
        vline(0,'--w')
        colormap jet
        AX.CLim = [0 3.5];
        
        set(gcf, 'Position', get(0, 'Screensize'));
        saveas(gcf,['Specgrams_BRTransitions_' num2str(i)],'png')
        pause(2)
        close all
    end
    
end

