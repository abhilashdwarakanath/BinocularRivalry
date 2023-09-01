clear all
close all
clc

% This code collects all computed spectrograms across datasets and then
% creates a grand average of selective sites during Riv and during PA_FS
% for comparison

%% Enumerate the datasets

% Specgrams according to Selectivity during Rivalry

datasetsDS{1} = 'B:\H07\12-06-2016\PFC\Bfsgrad1\LFPPiecemeals\piecemealSpecgrams_0.5s_back_0.5s.mat';
datasetsDS{2} = 'B:\H07\13-07-2016\PFC\Bfsgrad1\LFPPiecemeals\piecemealSpecgrams_0.5s_back_0.5s.mat';
datasetsDS{3} = 'B:\H07\20161019\PFC\Bfsgrad1\LFPPiecemeals\piecemealSpecgrams_0.5s_back_0.5s.mat';
datasetsDS{4} = 'B:\H07\20161025\PFC\Bfsgrad1\LFPPiecemeals\piecemealSpecgrams_0.5s_back_0.5s.mat';
datasetsDS{5} = 'B:\A11\20170305\PFC\Bfsgrad1\LFPPiecemeals\piecemealSpecgrams_0.5s_back_0.5s.mat';
datasetsDS{6} = 'B:\A11\20170302\PFC\Bfsgrad1\LFPPiecemeals\piecemealSpecgrams_0.5s_back_0.5s.mat';


%% Plot grand average for DomSels

% collect

specgrams90BR = [];
specgrams270BR = [];

specgrams90BR_norm1 = [];
specgrams270BR_norm1 = [];


for iDataset = 1:length(datasetsDS)
    
    load(datasetsDS{iDataset});
    
    for iChan = 1:96

    specgrams90BR = cat(3,specgrams90BR,piecemealSpectrograms(iChan).BR.dom90);
    specgrams270BR = cat(3,specgrams270BR,piecemealSpectrograms(iChan).BR.dom270);
    
    specgrams90BR_norm1 = cat(3,specgrams90BR_norm1,piecemealSpectrograms(iChan).BR.dom90_norm1);
    specgrams270BR_norm1 = cat(3,specgrams270BR_norm1,piecemealSpectrograms(iChan).BR.dom270_norm1);
    
    end
    
end

gaPM = nanmean(cat(3,specgrams90BR,specgrams270BR),3);

gaPM_norm1 = nanmean(cat(3,specgrams90BR_norm1,specgrams270BR_norm1),3);

t = piecemealSpectrograms(1).t;
f = piecemealSpectrograms(1).f;


%% Plot log scales

cd B:\Results\Spectrograms\Piecemeals
mkdir('Pooled_Spectrograms')
cd Pooled_Spectrograms
mkdir('05s')
cd 05s

Yticks = 2.^(round(log2(min(f))):round(log2(max(f))));

% Normalised



imagesc(t,log2(f),gaBR_norm1); shading('interp')
xlabel('time in s');
ylabel('Hz')
vline(0,'--w'); AX = gca;
set(AX, 'YTick',log2(Yticks(:)), 'YTickLabel',num2str(sprintf('%g\n',Yticks)))
AX.YLim = log2([min(f), max(f)]);
axis xy
colormap jet
AX = gca;
AX.CLim = [0 0.7];
