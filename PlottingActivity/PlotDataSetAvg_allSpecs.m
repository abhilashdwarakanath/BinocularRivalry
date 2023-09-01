clear all
close all
clc

% This code collects all computed spectrograms across datasets and then
% creates a grand average of selective sites during Riv and during PA_FS
% for comparison

%% Enumerate the datasets

% Specgrams according to Selectivity during Rivalry

datasetsDS{1} = 'B:\H07\12-06-2016\PPC\Bfsgrad1\LFPSpectrograms\MM_cleanDomSpecgrams_0.5s_back_0.5s.mat';
datasetsDS{2} = 'B:\H07\13-07-2016\PPC\Bfsgrad1\LFPSpectrograms\MM_cleanDomSpecgrams_0.5s_back_0.5s.mat';
datasetsDS{3} = 'B:\H07\20161019\PPC\Bfsgrad1\LFPSpectrograms\MM_cleanDomSpecgrams_0.5s_back_0.5s.mat';
datasetsDS{4} = 'B:\H07\20161025\PPC\Bfsgrad1\LFPSpectrograms\MM_cleanDomSpecgrams_0.5s_back_0.5s.mat';
datasetsDS{5} = 'B:\A11\20170305\PPC\Bfsgrad1\LFPSpectrograms\cleanDomSpecgrams_0.5s_back_0.5s.mat';
datasetsDS{6} = 'B:\A11\20170302\PPC\Bfsgrad1\LFPSpectrograms\cleanDomSpecgrams_0.5s_back_0.5s.mat';


%% Plot grand average for DomSels

% collect

specgrams90BR_norm1 = [];
specgrams270BR_norm1 = [];
specgrams90PA_norm1 = [];
specgrams270PA_norm1 = [];


for iDataset = 1:length(datasetsDS)
    
    tic;
    
    load(datasetsDS{iDataset});
    
    for iChan = 1:96
    
    specgrams90BR_norm1 = cat(3,specgrams90BR_norm1,cleanDomSpectrograms(iChan).BR.dom90_norm1);
    specgrams90PA_norm1 = cat(3,specgrams90PA_norm1,cleanDomSpectrograms(iChan).PA.dom90_norm1);
    specgrams270BR_norm1 = cat(3,specgrams270BR_norm1,cleanDomSpectrograms(iChan).BR.dom270_norm1);
    specgrams270PA_norm1 = cat(3,specgrams270PA_norm1,cleanDomSpectrograms(iChan).PA.dom270_norm1);
%     
    
    end
    toc
end

gaBR_norm1 = nanmean(cat(3,specgrams90BR_norm1,specgrams270BR_norm1),3);
gaPA_norm1 = nanmean(cat(3,specgrams90PA_norm1,specgrams270PA_norm1),3);


t = cleanDomSpectrograms(1).t;
f = cleanDomSpectrograms(1).f;


%% Plot log scales

cd B:\Results\Spectrograms
mkdir PPC
cd PPC
mkdir('Pooled_Spectrograms')
cd Pooled_Spectrograms
mkdir MM
cd MM
mkdir('05s')
cd 05s

Yticks = 2.^(round(log2(min(f))):round(log2(max(f))));



% Normalised

figure(6)
subplot(1,2,1)
imagesc(t,log2(f),gaPA_norm1); shading('interp')
xlabel('time in s');
ylabel('Hz')
vline(0,'--w'); AX = gca;
set(AX, 'YTick',log2(Yticks(:)), 'YTickLabel',num2str(sprintf('%g\n',Yticks)))
AX.YLim = log2([min(f), max(f)]);
axis xy
colormap jet
AX = gca;
AX.CLim = [0 0.7];
title('PA - Pooled')

subplot(1,2,2)
imagesc(t,log2(f),gaBR_norm1); shading('interp')
xlabel('time in s');
ylabel('Hz')
vline(0,'--w'); AX = gca;
set(AX, 'YTick',log2(Yticks(:)), 'YTickLabel',num2str(sprintf('%g\n',Yticks)))
AX.YLim = log2([min(f), max(f)]);
axis xy
colormap jet
AX = gca;
AX.CLim = [-0.1 0.5];
title('BR - Pooled')
set(gcf, 'Position', get(0, 'Screensize'));
saveas(gcf,'FreqZscored_LogScale_05s_UnBaselined_Specgrams','png')
saveas(gcf,'FreqZscored_LogScale_05s_UnBaselined_Specgrams','fig')


