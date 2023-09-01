function generateEnsemblePSTHsPlotsLFPs

%% Enumerate datasets

datasets{1} = 'C:\Data\H07\12-06-2016\PFC\Bfsgrad1\EnsemblePSTHs\MM\MM_EnsemblePSTHs_MU_LFPTraces_1000ms_BSAS_BRPASel.mat';
recDate{1} = '12062016';
fileID{1} = '12-06-2016';
subjID{1} = 'Hayo';
datasets{2} = 'C:\Data\H07\13-07-2016\PFC\Bfsgrad1\EnsemblePSTHs\MM\MM_EnsemblePSTHs_MU_LFPTraces_1000ms_BSAS_BRPASel.mat';
recDate{2} = '13072016';
fileID{2} = '13-07-2016';
subjID{2} = 'Hayo';
datasets{3} = 'C:\Data\H07\20161019\PFC\Bfsgrad1\EnsemblePSTHs\MM\MM_EnsemblePSTHs_MU_LFPTraces_1000ms_BSAS_BRPASel.mat';
recDate{3} = '19102016';
fileID{3} = '20161019';
subjID{3} = 'Hayo';
datasets{4} = 'C:\Data\H07\20161025\PFC\Bfsgrad1\EnsemblePSTHs\MM\MM_EnsemblePSTHs_MU_LFPTraces_1000ms_BSAS_BRPASel.mat';
recDate{4} = '25102016';
fileID{4} = '20161025';
subjID{4} = 'Hayo';
datasets{5} = 'C:\Data\A11\20170305\PFC\Bfsgrad1\EnsemblePSTHs\MM\MM_EnsemblePSTHs_MU_LFPTraces_1000ms_BSAS_BRPASel.mat';
recDate{5} = '05032017';
fileID{5} = '20170305';
subjID{5} = 'Anton';
datasets{6} = 'C:\Data\A11\20170302\PFC\Bfsgrad1\EnsemblePSTHs\MM\MM_EnsemblePSTHs_MU_LFPTraces_1000ms_BSAS_BRPASel.mat';
recDate{6} = '02032017';
fileID{6} = '20170302';
subjID{6} = 'Anton';

%% Load and pool

sel90_BR_s270TO90 = [];
sel90_BR_s90TO270 = [];
sel270_BR_s270TO90 = [];
sel270_BR_s90TO270 = [];

sel90_PA_s270TO90 = [];
sel90_PA_s90TO270 = [];
sel270_PA_s270TO90 = [];
sel270_PA_s90TO270 = [];

for iDataset = 1:6
    
    load(datasets{iDataset})
    
    sel90_BR_s270TO90 = [sel90_BR_s270TO90;spikingActivityPerTransition.sel90.sdf.BR.s270TO90];
    sel90_BR_s90TO270 = [sel90_BR_s90TO270;spikingActivityPerTransition.sel90.sdf.BR.s90TO270];
    sel270_BR_s270TO90 = [sel270_BR_s270TO90;spikingActivityPerTransition.sel270.sdf.BR.s270TO90];
    sel270_BR_s90TO270 = [sel270_BR_s90TO270;spikingActivityPerTransition.sel270.sdf.BR.s90TO270];
    
    sel90_PA_s270TO90 = [sel90_PA_s270TO90;spikingActivityPerTransition.sel90.sdf.PA.s270TO90];
    sel90_PA_s90TO270 = [sel90_PA_s90TO270;spikingActivityPerTransition.sel90.sdf.PA.s90TO270];
    sel270_PA_s270TO90 = [sel270_PA_s270TO90;spikingActivityPerTransition.sel270.sdf.PA.s270TO90];
    sel270_PA_s90TO270 = [sel270_PA_s90TO270;spikingActivityPerTransition.sel270.sdf.PA.s90TO270];
    
end

% Normalise each before averaging and taking SEM

for iTr = 1:size(sel90_BR_s270TO90,1)
    
    sel90_BR_s270TO90(iTr,:) = (sel90_BR_s270TO90(iTr,:));
    
end

for iTr = 1:size(sel90_BR_s90TO270,1)
    
    sel90_BR_s90TO270(iTr,:) = (sel90_BR_s90TO270(iTr,:));
    
end

for iTr = 1:size(sel270_BR_s270TO90,1)
    
    sel270_BR_s270TO90(iTr,:) = (sel270_BR_s270TO90(iTr,:));
    
end

for iTr = 1:size(sel270_BR_s90TO270,1)
    
    sel270_BR_s90TO270(iTr,:) = (sel270_BR_s90TO270(iTr,:));
    
end

for iTr = 1:size(sel90_PA_s270TO90,1)
    
    sel90_PA_s270TO90(iTr,:) = (sel90_PA_s270TO90(iTr,:));
    
end

for iTr = 1:size(sel90_PA_s90TO270,1)
    
    sel90_PA_s90TO270(iTr,:) = (sel90_PA_s90TO270(iTr,:));
    
end

for iTr = 1:size(sel270_PA_s270TO90,1)
    
    sel270_PA_s270TO90(iTr,:) = (sel270_PA_s270TO90(iTr,:));
    
end

for iTr = 1:size(sel270_PA_s90TO270,1)
    
    sel270_PA_s90TO270(iTr,:) = (sel270_PA_s90TO270(iTr,:));
    
end

%% For LF

low_sel90_BR_s270TO90 = [];
low_sel90_BR_s90TO270 = [];
low_sel270_BR_s270TO90 = [];
low_sel270_BR_s90TO270 = [];

low_sel90_PA_s270TO90 = [];
low_sel90_PA_s90TO270 = [];
low_sel270_PA_s270TO90 = [];
low_sel270_PA_s90TO270 = [];

for iDataset = 1:6
    
    load(datasets{iDataset})
    
    low_sel90_BR_s270TO90 = [low_sel90_BR_s270TO90;spikingActivityPerTransition.sel90.lowRate.BR.s270TO90];
    low_sel90_BR_s90TO270 = [low_sel90_BR_s90TO270;spikingActivityPerTransition.sel90.lowRate.BR.s90TO270];
    low_sel270_BR_s270TO90 = [low_sel270_BR_s270TO90;spikingActivityPerTransition.sel270.lowRate.BR.s270TO90];
    low_sel270_BR_s90TO270 = [low_sel270_BR_s90TO270;spikingActivityPerTransition.sel270.lowRate.BR.s90TO270];
    
    low_sel90_PA_s270TO90 = [low_sel90_PA_s270TO90;spikingActivityPerTransition.sel90.lowRate.PA.s270TO90];
    low_sel90_PA_s90TO270 = [low_sel90_PA_s90TO270;spikingActivityPerTransition.sel90.lowRate.PA.s90TO270];
    low_sel270_PA_s270TO90 = [low_sel270_PA_s270TO90;spikingActivityPerTransition.sel270.lowRate.PA.s270TO90];
    low_sel270_PA_s90TO270 = [low_sel270_PA_s90TO270;spikingActivityPerTransition.sel270.lowRate.PA.s90TO270];
    
end

% Normalise each before averaging and taking SEM

for iTr = 1:size(low_sel90_BR_s270TO90,1)
    
    low_sel90_BR_s270TO90(iTr,:) = (low_sel90_BR_s270TO90(iTr,:));
    
end

for iTr = 1:size(low_sel90_BR_s90TO270,1)
    
    low_sel90_BR_s90TO270(iTr,:) = (low_sel90_BR_s90TO270(iTr,:));
    
end

for iTr = 1:size(low_sel270_BR_s270TO90,1)
    
    low_sel270_BR_s270TO90(iTr,:) = (low_sel270_BR_s270TO90(iTr,:));
    
end

for iTr = 1:size(low_sel270_BR_s90TO270,1)
    
    low_sel270_BR_s90TO270(iTr,:) = (low_sel270_BR_s90TO270(iTr,:));
    
end

for iTr = 1:size(low_sel90_PA_s270TO90,1)
    
    low_sel90_PA_s270TO90(iTr,:) = (low_sel90_PA_s270TO90(iTr,:));
    
end

for iTr = 1:size(low_sel90_PA_s90TO270,1)
    
    low_sel90_PA_s90TO270(iTr,:) = (low_sel90_PA_s90TO270(iTr,:));
    
end

for iTr = 1:size(low_sel270_PA_s270TO90,1)
    
    low_sel270_PA_s270TO90(iTr,:) = (low_sel270_PA_s270TO90(iTr,:));
    
end

for iTr = 1:size(low_sel270_PA_s90TO270,1)
    
    low_sel270_PA_s90TO270(iTr,:) = (low_sel270_PA_s90TO270(iTr,:));
    
end

%% Do a t-test for each bin for the two competing ensembles

[h, p_BR_s270TO90] = ttest2(sel90_BR_s270TO90, sel270_BR_s270TO90);
[h, p_BR_s90TO270] = ttest2(sel90_BR_s90TO270, sel270_BR_s90TO270);
[h, p_PA_s270TO90] = ttest2(sel90_PA_s270TO90, sel270_PA_s270TO90);
[h, p_PA_s90TO270] = ttest2(sel90_PA_s90TO270, sel270_PA_s90TO270);

% Plot the P-values

figure(100)
plot(edges(4:end-3)./1000,(p_BR_s270TO90(4:end-3)),'r','LineWidth',1)
hold on
plot(edges(4:end-3)./1000,(p_BR_s90TO270(4:end-3)),'--r','LineWidth',1)
plot(edges(4:end-3)./1000,(p_PA_s270TO90(4:end-3)),'k','LineWidth',1)
plot(edges(4:end-3)./1000,(p_PA_s90TO270(4:end-3)),'--k','LineWidth',1)
vline(0,'--b')
hline(0.05,'--b')
xlabel('bins')
ylabel('p-value')
axis tight
box off
title('Pairwise t-test between competing ensembles')
legend('BR 270TO90', 'BR 90TO270','PA 270TO90','PA 90TO270')

%% Plot d-prime for the competing ensembles

[dp_BR_s270TO90] = dprime_simple(sel90_BR_s270TO90, sel270_BR_s270TO90);
[dp_BR_s90TO270] = dprime_simple(sel90_BR_s90TO270, sel270_BR_s90TO270);
[dp_PA_s270TO90] = dprime_simple(sel90_PA_s270TO90, sel270_PA_s270TO90);
[dp_PA_s90TO270] = dprime_simple(sel90_PA_s90TO270, sel270_PA_s90TO270);

figure(200)
for i = 1:length(edges)
    clear temp
    temp = dp_BR_s270TO90(:,i);
    dp_mean_BR_s270TO90(i)=abs(nanmean(temp(isfinite(temp))));
    clear temp
    
    temp = dp_BR_s90TO270(:,i);
    dp_mean_BR_s90TO270(i)=abs(nanmean(temp(isfinite(temp))));
    clear temp
    
    temp = dp_PA_s270TO90(:,i);
    dp_mean_PA_s270TO90(i)=abs(nanmean(temp(isfinite(temp))));
    clear temp
    
    temp = dp_PA_s90TO270(:,i);
    dp_mean_PA_s90TO270(i)=abs(nanmean(temp(isfinite(temp))));
    clear temp
end

plot(edges(4:end-3)./1000,dp_mean_BR_s270TO90(4:end-3),'-r','LineWidth',1)
hold on
plot(edges(4:end-3)./1000,dp_mean_BR_s90TO270(4:end-3),'--r','LineWidth',1)
plot(edges(4:end-3)./1000,dp_mean_PA_s270TO90(4:end-3),'-k','LineWidth',1)
plot(edges(4:end-3)./1000,dp_mean_PA_s90TO270(4:end-3),'--k','LineWidth',1)
vline(0,'--b')
xlabel('bins')
ylabel('abs(d-prime)')
axis tight
box off
title('Binwise d-prime between competing ensembles')
legend('BR 270TO90', 'BR 90TO270','PA 270TO90','PA 90TO270')
%% Get the means and SEMs

mean_sel90_BR_s270TO90 = nanmean(sel90_BR_s270TO90,1);
sem_sel90_BR_s270TO90 = nanstd(sel90_BR_s270TO90,[],1)./sqrt(size(sel90_BR_s270TO90,1));
mean_sel90_BR_s90TO270 = nanmean(sel90_BR_s90TO270,1);
sem_sel90_BR_s90TO270 = nanstd(sel90_BR_s90TO270,[],1)./sqrt(size(sel90_BR_s90TO270,1));
mean_sel270_BR_s270TO90 = nanmean(sel270_BR_s270TO90,1);
sem_sel270_BR_s270TO90 = nanstd(sel270_BR_s270TO90,[],1)./sqrt(size(sel270_BR_s270TO90,1));
mean_sel270_BR_s90TO270 = nanmean(sel270_BR_s90TO270,1);
sem_sel270_BR_s90TO270 = nanstd(sel270_BR_s90TO270,[],1)./sqrt(size(sel270_BR_s90TO270,1));

mean_sel90_PA_s270TO90 = nanmean(sel90_PA_s270TO90,1);
sem_sel90_PA_s270TO90 = nanstd(sel90_PA_s270TO90,[],1)./sqrt(size(sel90_PA_s270TO90,1));
mean_sel90_PA_s90TO270 = nanmean(sel90_PA_s90TO270,1);
sem_sel90_PA_s90TO270 = nanstd(sel90_PA_s90TO270,[],1)./sqrt(size(sel90_PA_s90TO270,1));
mean_sel270_PA_s270TO90 = nanmean(sel270_PA_s270TO90,1);
sem_sel270_PA_s270TO90 = nanstd(sel270_PA_s270TO90,[],1)./sqrt(size(sel270_PA_s270TO90,1));
mean_sel270_PA_s90TO270 = nanmean(sel270_PA_s90TO270,1);
sem_sel270_PA_s90TO270 = nanstd(sel270_PA_s90TO270,[],1)./sqrt(size(sel270_PA_s90TO270,1));

%% Mean and SEMs for LF

mean_low_sel90_BR_s270TO90 = nanmean(low_sel90_BR_s270TO90,1);
sem_low_sel90_BR_s270TO90 = nanstd(low_sel90_BR_s270TO90,[],1)./sqrt(size(low_sel90_BR_s270TO90,1));
mean_low_sel90_BR_s90TO270 = nanmean(low_sel90_BR_s90TO270,1);
sem_low_sel90_BR_s90TO270 = nanstd(low_sel90_BR_s90TO270,[],1)./sqrt(size(low_sel90_BR_s90TO270,1));
mean_low_sel270_BR_s270TO90 = nanmean(low_sel270_BR_s270TO90,1);
sem_low_sel270_BR_s270TO90 = nanstd(low_sel270_BR_s270TO90,[],1)./sqrt(size(low_sel270_BR_s270TO90,1));
mean_low_sel270_BR_s90TO270 = nanmean(low_sel270_BR_s90TO270,1);
sem_low_sel270_BR_s90TO270 = nanstd(low_sel270_BR_s90TO270,[],1)./sqrt(size(low_sel270_BR_s90TO270,1));

mean_low_sel90_PA_s270TO90 = nanmean(low_sel90_PA_s270TO90,1);
sem_low_sel90_PA_s270TO90 = nanstd(low_sel90_PA_s270TO90,[],1)./sqrt(size(low_sel90_PA_s270TO90,1));
mean_low_sel90_PA_s90TO270 = nanmean(low_sel90_PA_s90TO270,1);
sem_low_sel90_PA_s90TO270 = nanstd(low_sel90_PA_s90TO270,[],1)./sqrt(size(low_sel90_PA_s90TO270,1));
mean_low_sel270_PA_s270TO90 = nanmean(low_sel270_PA_s270TO90,1);
sem_low_sel270_PA_s270TO90 = nanstd(low_sel270_PA_s270TO90,[],1)./sqrt(size(low_sel270_PA_s270TO90,1));
mean_low_sel270_PA_s90TO270 = nanmean(low_sel270_PA_s90TO270,1);
sem_low_sel270_PA_s90TO270 = nanstd(low_sel270_PA_s90TO270,[],1)./sqrt(size(low_sel270_PA_s90TO270,1));

%% Plot means

t = linspace(-1,1,1001);

figure(1)

subplot(2,2,1)
shadedErrorBar(edges(4:end-3)./1000, mean_sel90_BR_s270TO90(4:end-3),sem_sel90_BR_s270TO90(4:end-3))
hold on
P(1)=plot(edges(4:end-3)./1000, mean_sel90_BR_s270TO90(4:end-3),'LineWidth',1);
shadedErrorBar(edges(4:end-3)./1000, mean_sel270_BR_s270TO90(4:end-3),sem_sel270_BR_s270TO90(4:end-3))
P(3)=plot(edges(4:end-3)./1000, mean_sel270_BR_s270TO90(4:end-3),'LineWidth',1);
%shadedErrorBar(t(76:926), mean_low_sel90_BR_s270TO90(76:926),sem_low_sel90_BR_s270TO90(76:926))
%P(2)=plot(t(76:926), mean_low_sel90_BR_s270TO90(76:926),'LineWidth',1);
%shadedErrorBar(t(76:926), mean_low_sel270_BR_s270TO90(76:926),sem_low_sel270_BR_s270TO90(76:926))
%P(4)=plot(t(76:926), mean_low_sel270_BR_s270TO90(76:926),'LineWidth',1);
set(gca,'xtick',[])
axis tight
%ylim([0.2 0.8])
vline(0,'--k'); box off
title('BR - 270TO90')

subplot(2,2,2)
shadedErrorBar(edges(4:end-3)./1000, mean_sel90_BR_s90TO270(4:end-3),sem_sel90_BR_s90TO270(4:end-3))
hold on
P(1)=plot(edges(4:end-3)./1000, mean_sel90_BR_s90TO270(4:end-3),'LineWidth',1);
shadedErrorBar(edges(4:end-3)./1000, mean_sel270_BR_s90TO270(4:end-3),sem_sel270_BR_s90TO270(4:end-3))
P(3)=plot(edges(4:end-3)./1000, mean_sel270_BR_s90TO270(4:end-3),'LineWidth',1);
%shadedErrorBar(t(76:926), mean_low_sel90_BR_s90TO270(76:926),sem_low_sel90_BR_s90TO270(76:926))
%P(2)=plot(t(76:926), mean_low_sel90_BR_s90TO270(76:926),'LineWidth',1);
%shadedErrorBar(t(76:926), mean_low_sel270_BR_s90TO270(76:926),sem_low_sel270_BR_s90TO270(76:926))
%P(4)=plot(t(76:926), mean_low_sel270_BR_s90TO270(76:926),'LineWidth',1);
set(gca,'xtick',[])
axis tight
%ylim([0.2 0.8])
vline(0,'--k'); box off
title('BR - 90 to 270')

subplot(2,2,3)
shadedErrorBar(edges(4:end-3)./1000, mean_sel90_PA_s270TO90(4:end-3),sem_sel90_PA_s270TO90(4:end-3))
hold on
P(1)=plot(edges(4:end-3)./1000, mean_sel90_PA_s270TO90(4:end-3),'LineWidth',1);
shadedErrorBar(edges(4:end-3)./1000, mean_sel270_PA_s270TO90(4:end-3),sem_sel270_PA_s270TO90(4:end-3))
P(3)=plot(edges(4:end-3)./1000, mean_sel270_PA_s270TO90(4:end-3),'LineWidth',1);
%shadedErrorBar(t(76:926), mean_low_sel90_PA_s270TO90(76:926),sem_low_sel90_PA_s270TO90(76:926))
%P(2)=plot(t(76:926), mean_low_sel90_PA_s270TO90(76:926),'LineWidth',1);
%shadedErrorBar(t(76:926), mean_low_sel270_PA_s270TO90(76:926),sem_low_sel270_PA_s270TO90(76:926))
%P(4)=plot(t(76:926), mean_low_sel270_PA_s270TO90(76:926),'LineWidth',1);
%ylim([0.2 0.8])
axis tight
vline(0,'--k'); box off
title('PA - 270 to 90')

subplot(2,2,4)
shadedErrorBar(edges(4:end-3)./1000, mean_sel90_PA_s90TO270(4:end-3),sem_sel90_PA_s90TO270(4:end-3))
hold on
P(1)=plot(edges(4:end-3)./1000, mean_sel90_PA_s90TO270(4:end-3),'LineWidth',1);
shadedErrorBar(edges(4:end-3)./1000, mean_sel270_PA_s90TO270(4:end-3),sem_sel270_PA_s90TO270(4:end-3))
P(3)=plot(edges(4:end-3)./1000, mean_sel270_PA_s90TO270(4:end-3),'LineWidth',1);
%shadedErrorBar(t(76:926), mean_low_sel90_PA_s90TO270(76:926),sem_low_sel90_PA_s90TO270(76:926))
%P(2)=plot(t(76:926), mean_low_sel90_PA_s90TO270(76:926),'LineWidth',1);
%shadedErrorBar(t(76:926), mean_low_sel270_PA_s90TO270(76:926),sem_low_sel270_PA_s90TO270(76:926))
%P(4)=plot(t(76:926), mean_low_sel270_PA_s90TO270(76:926),'LineWidth',1);
%ylim([0.2 0.8])
axis tight
vline(0,'--k'); box off
title('PA - 90 to 270')

%% Plot Sums

sum_sel90_BR_s270TO90 = nansum(sel90_BR_s270TO90,1);

sum_sel90_BR_s90TO270 = nansum(sel90_BR_s90TO270,1);

sum_sel270_BR_s270TO90 = nansum(sel270_BR_s270TO90,1);

sum_sel270_BR_s90TO270 = nansum(sel270_BR_s90TO270,1);


sum_sel90_PA_s270TO90 = nansum(sel90_PA_s270TO90,1);

sum_sel90_PA_s90TO270 = nansum(sel90_PA_s90TO270,1);

sum_sel270_PA_s270TO90 = nansum(sel270_PA_s270TO90,1);

sum_sel270_PA_s90TO270 = nansum(sel270_PA_s90TO270,1);


%% Mean and SEMs for LF

sum_low_sel90_BR_s270TO90 = nansum(low_sel90_BR_s270TO90,1);

sum_low_sel90_BR_s90TO270 = nansum(low_sel90_BR_s90TO270,1);

sum_low_sel270_BR_s270TO90 = nansum(low_sel270_BR_s270TO90,1);

sum_low_sel270_BR_s90TO270 = nansum(low_sel270_BR_s90TO270,1);


sum_low_sel90_PA_s270TO90 = nansum(low_sel90_PA_s270TO90,1);

sum_low_sel90_PA_s90TO270 = nansum(low_sel90_PA_s90TO270,1);

sum_low_sel270_PA_s270TO90 = nansum(low_sel270_PA_s270TO90,1);

sum_low_sel270_PA_s90TO270 = nansum(low_sel270_PA_s90TO270,1);

%% Plot Sums

figure(2)

subplot(2,2,1)

hold on
P(1)=plot(edges(4:end-3)./1000, smooth(zscore(sum_sel90_BR_s270TO90(4:end-3))),'LineWidth',1);

P(3)=plot(edges(4:end-3)./1000, smooth(zscore(sum_sel270_BR_s270TO90(4:end-3))),'LineWidth',1);

P(2)=plot(t(76:926), smooth(zscore(sum_low_sel90_BR_s270TO90(76:926))),'LineWidth',1);

P(4)=plot(t(76:926), smooth(zscore(sum_low_sel270_BR_s270TO90(76:926))),'LineWidth',1);
set(gca,'xtick',[])
vline(0,'--k'); box off
title('BR - 270 to 90')

subplot(2,2,2)

hold on
P(1)=plot(edges(4:end-3)./1000, smooth(zscore(sum_sel90_BR_s90TO270(4:end-3))),'LineWidth',1);

P(3)=plot(edges(4:end-3)./1000, smooth(zscore(sum_sel270_BR_s90TO270(4:end-3))),'LineWidth',1);

P(2)=plot(t(76:926), smooth(zscore(sum_low_sel90_BR_s90TO270(76:926))),'LineWidth',1);

P(4)=plot(t(76:926), smooth(zscore(sum_low_sel270_BR_s90TO270(76:926))),'LineWidth',1);
set(gca,'xtick',[])

vline(0,'--k'); box off
title('BR - 90 to 270')

subplot(2,2,3)

hold on
P(1)=plot(edges(4:end-3)./1000, smooth(zscore(sum_sel90_PA_s270TO90(4:end-3))),'LineWidth',1);

P(3)=plot(edges(4:end-3)./1000, smooth(zscore(sum_sel270_PA_s270TO90(4:end-3))),'LineWidth',1);

P(2)=plot(t(76:926), smooth(zscore(sum_low_sel90_PA_s270TO90(76:926))),'LineWidth',1);

P(4)=plot(t(76:926), smooth(zscore(sum_low_sel270_PA_s270TO90(76:926))),'LineWidth',1);

vline(0,'--k'); box off
title('PA - 270 to 90')

subplot(2,2,4)

hold on
P(1)=plot(edges(4:end-3)./1000, smooth(zscore(sum_sel90_PA_s90TO270(4:end-3))),'LineWidth',1);

P(3)=plot(edges(4:end-3)./1000, smooth(zscore(sum_sel270_PA_s90TO270(4:end-3))),'LineWidth',1);

P(2)=plot(t(76:926), smooth(zscore(sum_low_sel90_PA_s90TO270(76:926))),'LineWidth',1);

P(4)=plot(t(76:926), smooth(zscore(sum_low_sel270_PA_s90TO270(76:926))),'LineWidth',1);

vline(0,'--k'); box off
title('PA - 90 to 270')
