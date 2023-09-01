clear all
close all
clc

% This code collects all computed spectrograms across datasets and then
% creates a grand average of selective sites during Riv and during PA_FS
% for comparison

%% Enumerate the datasets

% Specgrams according to Selectivity during Rivalry

datasetsDS{1} = 'E:\Data\H07\12-06-2016\PFC\Bfsgrad1\cleanDomSpectrograms1s_back_3sDomSel.mat';
datasetsDS{2} = 'E:\Data\H07\13-07-2016\PFC\Bfsgrad1\cleanDomSpectrograms1s_back_3sDomSel.mat';
datasetsDS{3} = 'E:\Data\H07\20161019\PFC\Bfsgrad1\cleanDomSpectrograms1s_back_3sDomSel.mat';
datasetsDS{4} = 'E:\Data\H07\20161025\PFC\Bfsgrad1\cleanDomSpectrograms1s_back_3sDomSel.mat';
datasetsDS{5} = 'E:\Data\A11\20170305\PFC\Bfsgrad1\cleanDomSpectrograms1s_back_3sDomSel.mat';
datasetsDS{6} = 'E:\Data\A11\20170302\PFC\Bfsgrad1\cleanDomSpectrograms1s_back_3sDomSel.mat';


%% Plot grand average for DomSels

% collect

specgramsp2npBRDS = [];
specgramsp2npPADS = [];
specgramsnp2pBRDS = [];
specgramsnp2pPADS = [];

for iDataset = [1 2 3 4 6]
    
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

figure(4)
subplot(2,2,1)
imagesc(t,log2(f),(p2npAvgPA-mean(p2npAvgPA,2))./std(p2npAvgPA,[],2))
Yticks = 2.^(round(log2(min(f))):round(log2(max(f))));
xlabel('time in s');
ylabel('Hz')
vline(0,'--k')
AX = gca;
AX.YLim = log2([min(f), max(f)]);
AX.CLim = [0 3];
set(AX, 'YTick',log2(Yticks(:)), 'YTickLabel',num2str(sprintf('%g\n',Yticks)))
axis xy
vline(0,'--k')
colormap jet
title('P2NP PA - Pooled')
subplot(2,2,2)
imagesc(t,log2(f),(p2npAvgBR-mean(p2npAvgBR,2))./std(p2npAvgBR,[],2))
Yticks = 2.^(round(log2(min(f))):round(log2(max(f))));
xlabel('time in s');
ylabel('Hz')
vline(0,'--k')
AX = gca;
AX.YLim = log2([min(f), max(f)]);
AX.CLim = [0 3];
set(AX, 'YTick',log2(Yticks(:)), 'YTickLabel',num2str(sprintf('%g\n',Yticks)))
axis xy
vline(0,'--k')
colormap jet
title('P2NP BR - Pooled')

subplot(2,2,3)
imagesc(t,log2(f),(np2pAvgPA-mean(np2pAvgPA,2))./std(np2pAvgPA,[],2))
Yticks = 2.^(round(log2(min(f))):round(log2(max(f))));
xlabel('time in s');
ylabel('Hz')
vline(0,'--k')
AX = gca;
AX.YLim = log2([min(f), max(f)]);
AX.CLim = [0 3];
set(AX, 'YTick',log2(Yticks(:)), 'YTickLabel',num2str(sprintf('%g\n',Yticks)))
axis xy
vline(0,'--k')
colormap jet
title('NP2P PA - Pooled')
subplot(2,2,4)
imagesc(t,log2(f),(np2pAvgBR-mean(np2pAvgBR,2))./std(np2pAvgBR,[],2))
Yticks = 2.^(round(log2(min(f))):round(log2(max(f))));
xlabel('time in s');
ylabel('Hz')
vline(0,'--k')
AX = gca;
AX.YLim = log2([min(f), max(f)]);
AX.CLim = [0 3];
set(AX, 'YTick',log2(Yticks(:)), 'YTickLabel',num2str(sprintf('%g\n',Yticks)))
axis xy
vline(0,'--k')
colormap jet
title('NP2P BR - Pooled')
