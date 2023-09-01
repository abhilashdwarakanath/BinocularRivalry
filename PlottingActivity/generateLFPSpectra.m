function generateLFPSpectra(duration)

% This code collects all computed spectrograms across datasets and then
% creates a grand average of selective sites during Riv and during PA_FS
% for comparison

%% Enumerate the datasets

% traces_ according to Selectivity during Rivalry

datasetsDS{1} = ['B:\H07\12-06-2016\PFC\Bfsgrad1\LFPSpectrograms\cleanDomSpectra_' num2str(duration/1000) 's_back_' num2str(duration/1000) 's'  '.mat'];
datasetsDS{2} = ['B:\H07\13-07-2016\PFC\Bfsgrad1\LFPSpectrograms\cleanDomSpectra_' num2str(duration/1000) 's_back_' num2str(duration/1000) 's'  '.mat'];
datasetsDS{3} = ['B:\H07\20161019\PFC\Bfsgrad1\LFPSpectrograms\cleanDomSpectra_' num2str(duration/1000) 's_back_' num2str(duration/1000) 's'  '.mat'];
datasetsDS{4} = ['B:\H07\20161025\PFC\Bfsgrad1\LFPSpectrograms\cleanDomSpectra_' num2str(duration/1000) 's_back_' num2str(duration/1000) 's'  '.mat'];
datasetsDS{5} = ['B:\A11\20170305\PFC\Bfsgrad1\LFPSpectrograms\cleanDomSpectra_' num2str(duration/1000) 's_back_' num2str(duration/1000) 's'  '.mat'];
datasetsDS{6} = ['B:\A11\20170302\PFC\Bfsgrad1\LFPSpectrograms\cleanDomSpectra_' num2str(duration/1000) 's_back_' num2str(duration/1000) 's'  '.mat'];

%% Plot grand average for DomSels

% collect

spectraBR = [];
spectraPA = [];

for iDataset = [1 2 3 4 5 6]
    
    load(datasetsDS{iDataset});
    folderName = ['B:\Results\Spectra\' num2str(duration/1000) 's'];
    mkdir(folderName)

        for iChan = 1:96
            
            pa90 = spectra(iChan).PA.dom90;
            pa270 = spectra(iChan).PA.dom270;
            pa = [pa90 pa270];
            
            spectraPA = cat(2,spectraPA,pa);
            
        end

    for iChan = 1:96
            
            br90 = spectra(iChan).BR.dom90;
            br270 = spectra(iChan).BR.dom270;
            br = [br90 br270];
            
            spectraBR = cat(2,spectraBR,br);
            
    end
    
end

%% Plot and Save

semBR = std(spectraBR,[],2)./sqrt(257);
semPA = std(spectraPA,[],2)./sqrt(257);

cd(folderName)
figure(1)
H(1)=shadedErrorBar(f(2:104),(nanmean(spectraPA(2:104,:),2)),semPA(2:104));
hold on
P(1) = plot(f(2:104), nanmean(spectraPA(2:104,:),2), '-k', 'LineWidth',1);
H(2)=shadedErrorBar(f(2:104),(nanmean(spectraBR(2:104,:),2)),semBR(2:104));
P(2) = plot(f(2:104), nanmean(spectraBR(2:104,:),2), '-r', 'LineWidth',1);
P(3)=plot(f(2:104),15.*(1./f(2:104)),'--b');
xlabel('Frequency in Hz')
ylabel('dB/Hz')
legend([H(1).patch H(2).patch P(3)],'PA Spectrum','BR Spectrum','Scaled 1/f Spectrum','Location','NorthEast')
grid on;
title('MT Spectrum - PA vs BR - Pooled')
axis tight
set(gca,'XScale','log')
set(gcf, 'Position', get(0, 'Screensize'));
saveas(gcf,'PA_BR_Spectrum','png')
pause(2); close all

