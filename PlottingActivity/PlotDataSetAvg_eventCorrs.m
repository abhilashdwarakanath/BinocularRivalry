clear all
close all
clc

% This code collects all computed spectrograms across datasets and then
% creates a grand average of selective sites during Riv and during PA_FS
% for comparison

%% Enumerate the datasets

% eventCorrs_ according to Selectivity during Rivalry

datasetsDS{1} = 'E:\Data\H07\12-06-2016\PFC\Bfsgrad1\LFPStatistics\eventCorrs_500ms_beta_DomSel.mat';
datasetsDS{2} = 'E:\Data\H07\13-07-2016\PFC\Bfsgrad1\LFPStatistics\eventCorrs_500ms_beta_DomSel.mat';
datasetsDS{3} = 'E:\Data\H07\20161019\PFC\Bfsgrad1\LFPStatistics\eventCorrs_500ms_beta_DomSel.mat';
datasetsDS{4} = 'E:\Data\H07\20161025\PFC\Bfsgrad1\LFPStatistics\eventCorrs_500ms_beta_DomSel.mat';
datasetsDS{5} = 'E:\Data\A11\20170305\PFC\Bfsgrad1\LFPStatistics\eventCorrs_500ms_beta_DomSel.mat';
datasetsDS{6} = 'E:\Data\A11\20170302\PFC\Bfsgrad1\LFPStatistics\eventCorrs_500ms_beta_DomSel.mat';


%% Plot grand average for DomSels

% collect

eventCorrs_BR_p2np90DS = [];
eventCorrs_BR_p2np270DS = [];
eventCorrs_BR_np2p90DS = [];
eventCorrs_BR_np2p270DS = [];

for iDataset = [1 2 3 4 6]
    
    load(datasetsDS{iDataset});
    
    eventCorrs_BR_p2np90DS = [eventCorrs_BR_p2np90DS eventCorrs.BR.P2NP90'];
    eventCorrs_BR_p2np270DS = [eventCorrs_BR_p2np270DS eventCorrs.BR.P2NP270'];
    eventCorrs_BR_np2p90DS = [eventCorrs_BR_np2p90DS eventCorrs.BR.NP2P90'];
    eventCorrs_BR_np2p270DS = [eventCorrs_BR_np2p270DS eventCorrs.BR.NP2P270'];
    
end

eventCorrs_PA_p2np90DS = [];
eventCorrs_PA_p2np270DS = [];
eventCorrs_PA_np2p90DS = [];
eventCorrs_PA_np2p270DS = [];

for iDataset = 1:length(datasetsDS)
    
    load(datasetsDS{iDataset});
    
    eventCorrs_PA_p2np90DS = [eventCorrs_PA_p2np90DS eventCorrs.PA.P2NP90'];
    eventCorrs_PA_p2np270DS = [eventCorrs_PA_p2np270DS eventCorrs.PA.P2NP270'];
    eventCorrs_PA_np2p90DS = [eventCorrs_PA_np2p90DS eventCorrs.PA.NP2P90'];
    eventCorrs_PA_np2p270DS = [eventCorrs_PA_np2p270DS eventCorrs.PA.NP2P270'];
    
end

lags = eventCorrs.BR.lags;


% Plot

eventCorrs_BR_np2p = cat(2,eventCorrs_BR_np2p90DS,eventCorrs_BR_np2p270DS);
eventCorrs_BR_p2np = cat(2,eventCorrs_BR_p2np90DS,eventCorrs_BR_p2np270DS);

idxs = randi([1 size(eventCorrs_PA_np2p90DS,2)],1,size(eventCorrs_BR_np2p90DS,2));
eventCorrs_PA_np2p90DS = eventCorrs_PA_np2p90DS(:,idxs); 
idxs = randi([1 size(eventCorrs_PA_np2p270DS,2)],1,size(eventCorrs_BR_np2p270DS,2));
eventCorrs_PA_np2p270DS = eventCorrs_PA_np2p270DS(:,idxs);
idxs = randi([1 size(eventCorrs_PA_p2np90DS,2)],1,size(eventCorrs_BR_p2np90DS,2));
eventCorrs_PA_p2np90DS = eventCorrs_PA_p2np90DS(:,idxs); 
idxs = randi([1 size(eventCorrs_PA_p2np270DS,2)],1,size(eventCorrs_BR_p2np270DS,2));
eventCorrs_PA_p2np270DS = eventCorrs_PA_p2np270DS(:,idxs);

eventCorrs_PA_np2p = cat(2,eventCorrs_PA_np2p90DS,eventCorrs_PA_np2p270DS);
eventCorrs_PA_p2np = cat(2,eventCorrs_PA_p2np90DS,eventCorrs_PA_p2np270DS);

eventCorrs_BR_np2p = nanmean(eventCorrs_BR_np2p,2);
eventCorrs_BR_p2np = nanmean(eventCorrs_BR_p2np,2);

eventCorrs_PA_np2p = nanmean(eventCorrs_PA_np2p,2);
eventCorrs_PA_p2np = nanmean(eventCorrs_PA_p2np,2);

figure(1)

subplot(2,1,1)
plot(lags./1000,smooth(normalise(eventCorrs_BR_np2p)),'-r','LineWidth',1.5)
hold on
plot(lags./1000,smooth(normalise(eventCorrs_PA_np2p)),'-k','LineWidth',1.5)
grid on
axis tight
box off
legend('Spontaneous Switch NP to P','Physical Switch NP to P')
xlabel('lags in s')
ylabel('Normalised Xcorr Count')
title('Downward Preference- Low Freqs -Switch Corr')


subplot(2,1,2)
plot(lags./1000,smooth(normalise(eventCorrs_BR_p2np)),'-r','LineWidth',1.5)
hold on
plot(lags./1000,smooth(normalise(eventCorrs_PA_p2np)),'-k','LineWidth',1.5)
grid on
axis tight
box off
legend('Spontaneous Switch NP to P','Physical Switch NP to P')
xlabel('lags in s')
ylabel('Normalised Xcorr Count')
title('Upward Preference- Low Freqs -Switch Corr')


