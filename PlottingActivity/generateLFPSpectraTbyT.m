function generateLFPSpectraTbyT(duration)

% This code collects all computed spectrograms across datasets and then
% creates a grand average of selective sites during Riv and during PA_FS
% for comparison

%% Enumerate the datasets

% traces_ according to Selectivity during Rivalry

datasetsDS{1} = ['B:\H07\12-06-2016\PFC\Bfsgrad1\LFPSpectrograms\cleanDomSpectra_TbyT_' num2str(duration/1000) 's_back_' num2str(duration/1000) 's'  '.mat'];
datasetsDS{2} = ['B:\H07\13-07-2016\PFC\Bfsgrad1\LFPSpectrograms\cleanDomSpectra_TbyT_' num2str(duration/1000) 's_back_' num2str(duration/1000) 's'  '.mat'];
datasetsDS{3} = ['B:\H07\20161019\PFC\Bfsgrad1\LFPSpectrograms\cleanDomSpectra_TbyT_' num2str(duration/1000) 's_back_' num2str(duration/1000) 's'  '.mat'];
datasetsDS{4} = ['B:\H07\20161025\PFC\Bfsgrad1\LFPSpectrograms\cleanDomSpectra_TbyT_' num2str(duration/1000) 's_back_' num2str(duration/1000) 's'  '.mat'];
datasetsDS{5} = ['B:\A11\20170305\PFC\Bfsgrad1\LFPSpectrograms\cleanDomSpectra_TbyT_' num2str(duration/1000) 's_back_' num2str(duration/1000) 's'  '.mat'];
datasetsDS{6} = ['B:\A11\20170302\PFC\Bfsgrad1\LFPSpectrograms\cleanDomSpectra_TbyT_' num2str(duration/1000) 's_back_' num2str(duration/1000) 's'  '.mat'];

%% Plot grand average for DomSels

% collect

t = linspace(-duration/1000,duration/1000,duration+1);

%for iDataset = [1 2 3 4 5 6]

for iDataset = 2:6
    
    load(datasetsDS{iDataset});
    folderName = ['B:\Results\Spectra\TrialByTrial\Dataset' num2str(iDataset) '\'  num2str(duration/1000) 's'];
    mkdir(folderName)
    
    cd(folderName)
    mkdir('PA')
    cd PA

    for i = 1:size(spectra.PA,1)
        figure(i)
       semilogx(spectra.f(2:206),(spectra.PA(i,2:206)),'-k','LineWidth',2)
        hold on
       semilogx(spectra.f(2:206),(1./spectra.f(2:206)),'--b')
        legend('BR Spectra','1/f')
        xlabel('Frequency in Hz')
        ylabel('z-scored dB')
        title(['PA Transition # : ' num2str(i)]);
        axis tight; grid on;
        saveas(gcf,['PATransitions_' num2str(i)],'png')
        close all
    end
    
    cd(folderName)
    mkdir('BR')
    cd BR

    for i = 1:size(spectra.BR,1)
        figure(i)
       semilogx(spectra.f(2:206),(spectra.BR(i,2:206)),'-r','LineWidth',2)
        hold on
       semilogx(spectra.f(2:206),(1./spectra.f(2:206)),'--b')
        legend('BR Spectra','1/f')
        xlabel('Frequency in Hz')
        ylabel('z-scored dB')
        title(['BR Transition # : ' num2str(i)]);
        axis tight; grid on;
        saveas(gcf,['BRTransitions_' num2str(i)],'png')
        close all
    end
    
    
end

