clear all
close all
clc

% This code collects all computed spectrograms across datasets and then
% creates a grand average of selective sites during Riv and during PA_FS
% for comparison

%% Enumerate the datasets

% Specgrams according to Selectivity during Rivalry

datasetsDS{1} = 'E:\Data\H07\12-06-2016\PFC\Bfsgrad1\cleanDomSpectrograms0.5s_back_0.5sDomSel.mat';
datasetsDS{2} = 'E:\Data\H07\13-07-2016\PFC\Bfsgrad1\cleanDomSpectrograms0.5s_back_0.5sDomSel.mat';
datasetsDS{3} = 'E:\Data\H07\20161019\PFC\Bfsgrad1\cleanDomSpectrograms0.5s_back_0.5sDomSel.mat';
datasetsDS{4} = 'E:\Data\H07\20161025\PFC\Bfsgrad1\cleanDomSpectrograms0.5s_back_0.5sDomSel.mat';
datasetsDS{5} = 'E:\Data\A11\20170305\PFC\Bfsgrad1\cleanDomSpectrograms0.5s_back_0.5sDomSel.mat';
datasetsDS{6} = 'E:\Data\A11\20170302\PFC\Bfsgrad1\cleanDomSpectrograms0.5s_back_0.5sDomSel.mat';


%% Plot grand average for DomSels

% collect

specgramsp2npBRDS = [];
specgramsp2npPADS = [];
specgramsnp2pBRDS = [];
specgramsnp2pPADS = [];

for iDataset = [1 2 3 4 5 6]
    
    load(datasetsDS{iDataset});
    
    specgramsp2npBRDS = cat(3,specgramsp2npBRDS,cat(3,cleanDomSpectrograms.BR.p2np90,cleanDomSpectrograms.BR.p2np270));
    specgramsp2npPADS = cat(3,specgramsp2npPADS,cat(3,cleanDomSpectrograms.PA.p2np90,cleanDomSpectrograms.PA.p2np270));
    specgramsnp2pBRDS = cat(3,specgramsnp2pBRDS,cat(3,cleanDomSpectrograms.BR.np2p90,cleanDomSpectrograms.BR.np2p270));
    specgramsnp2pPADS = cat(3,specgramsnp2pPADS,cat(3,cleanDomSpectrograms.PA.np2p90,cleanDomSpectrograms.PA.np2p270));
    
end

p2npAvgBR = nanmean(specgramsp2npBRDS(:,251:end-250,:),3);
p2npAvgPA = nanmean(specgramsp2npPADS(:,251:end-250,:),3);
np2pAvgBR = nanmean(specgramsnp2pBRDS(:,251:end-250,:),3);
np2pAvgPA = nanmean(specgramsnp2pPADS(:,251:end-250,:),3);

t = cleanDomSpectrograms.t;
f = cleanDomSpectrograms.f;


% Plot


figure(5)
subplot(1,2,1)
pcolor(t,f(34:end),zscore(p2npAvgBR(34:end,:)-p2npAvgPA(34:end,:),[],2))
shading('interp')
xlabel('time in s');
ylabel('Hz')
AX = gca;
AX.CLim = [0 2.5];
axis xy
vline(0,'--w')
colormap jet
title('P2NP BR Baselined - Pooled')
subplot(1,2,2)
pcolor(t,f(34:end),zscore(np2pAvgBR(34:end,:)-np2pAvgPA(34:end,:),[],2))
shading('interp')
xlabel('time in s');
ylabel('Hz')
AX = gca;
AX.CLim = [0 2.5];
axis xy
vline(0,'--w')
colormap jet
title('NP2P BR Baselined - Pooled')
