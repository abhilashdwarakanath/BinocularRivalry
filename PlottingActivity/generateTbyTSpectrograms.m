function generateTbyTSpectrograms
% This code collects all computed spectrograms across datasets and then
% creates a grand average of selective sites during Riv and during PA_FS
% for comparison

%% Enumerate the datasets

% Specgrams according to Selectivity during Rivalry

datasetsDS{1} = 'B:\H07\12-06-2016\PFC\Bfsgrad1\LFPSpectrograms\cleanDomSpecgrams_trialByTrial_0.5s_back_0.5s.mat';
datasetsDS{2} = 'B:\H07\13-07-2016\PFC\Bfsgrad1\LFPSpectrograms\cleanDomSpecgrams_trialByTrial_0.5s_back_0.5s.mat';
datasetsDS{3} = 'B:\H07\20161019\PFC\Bfsgrad1\LFPSpectrograms\cleanDomSpecgrams_trialByTrial_0.5s_back_0.5s.mat';
datasetsDS{4} = 'B:\H07\20161025\PFC\Bfsgrad1\LFPSpectrograms\cleanDomSpecgrams_trialByTrial_0.5s_back_0.5s.mat';
datasetsDS{5} = 'B:\A11\20170305\PFC\Bfsgrad1\LFPSpectrograms\cleanDomSpecgrams_trialByTrial_0.5s_back_0.5s.mat';
datasetsDS{6} = 'B:\A11\20170302\PFC\Bfsgrad1\LFPSpectrograms\cleanDomSpecgrams_trialByTrial_0.5s_back_0.5s.mat';


%% Plot grand average for DomSels

% collect

specgramsBR = [];
specgramsPA = [];

for iDataset = 1:length(datasetsDS)
    
    load(datasetsDS{iDataset});
    
    specgramsBR = cat(1,specgramsBR,spectrograms.BR);
    specgramsPA = cat(1,specgramsPA,spectrograms.PA);

    
end

gaBR = squeeze(nanmean(specgramsBR,1));
gaPA = squeeze(nanmean(specgramsPA,1));

t = linspace(-0.5,0.5,501);
f = spectrograms.f;


%% Plot log scales

cd B:\Results\Spectrograms
mkdir('Pooled_Spectrograms_TbyT')
cd Pooled_Spectrograms_TbyT
mkdir('05s')
cd 05s

Yticks = 2.^(round(log2(min(f))):round(log2(max(f))));

% Raw

figure(5)
subplot(1,2,1)
imagesc(t,log2(f),gaPA); shading('interp')
xlabel('time in s');
ylabel('Hz')
vline(0,'--w'); AX = gca;
set(AX, 'YTick',log2(Yticks(:)), 'YTickLabel',num2str(sprintf('%g\n',Yticks)))
AX.YLim = log2([min(f), max(f)]);
axis xy
colormap jet
AX = gca;
%AX.CLim = [50 175];
title('PA - Pooled')

subplot(1,2,2)
imagesc(t,log2(f),gaBR); shading('interp')
xlabel('time in s');
ylabel('Hz')
vline(0,'--w'); AX = gca;
set(AX, 'YTick',log2(Yticks(:)), 'YTickLabel',num2str(sprintf('%g\n',Yticks)))
AX.YLim = log2([min(f), max(f)]);
axis xy
colormap jet
AX = gca;
%AX.CLim = [50 175];
title('BR - Pooled')
set(gcf, 'Position', get(0, 'Screensize'));
saveas(gcf,'LogScale_05s_UnBaselined_Specgrams','png')

figure(6)
imagesc(t,log2(f),gaBR-gaPA); shading('interp')
xlabel('time in s');
ylabel('Hz')
vline(0,'--w'); AX = gca;
set(AX, 'YTick',log2(Yticks(:)), 'YTickLabel',num2str(sprintf('%g\n',Yticks)))
AX.YLim = log2([min(f), max(f)]);
axis xy
colormap jet
AX = gca;

