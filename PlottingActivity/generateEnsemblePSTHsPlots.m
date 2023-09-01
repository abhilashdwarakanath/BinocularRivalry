function generateEnsemblePSTHsPlots

dbstop if error

%% Enumerate datasets

datasets{1} = 'B:\H07\12-06-2016\PFC\Bfsgrad1\EnsemblePSTHs\10ms_MM_EnsemblePSTHs_SUMU_1000ms_BRPASel_BSAS.mat';
recDate{1} = '12062016';
fileID{1} = '12-06-2016';
subjID{1} = 'Hayo';
datasets{2} = 'B:\H07\13-07-2016\PFC\Bfsgrad1\EnsemblePSTHs\10ms_MM_EnsemblePSTHs_SUMU_1000ms_BRPASel_BSAS.mat';
recDate{2} = '13072016';
fileID{2} = '13-07-2016';
subjID{2} = 'Hayo';
datasets{3} = 'B:\H07\20161019\PFC\Bfsgrad1\EnsemblePSTHs\10ms_MM_EnsemblePSTHs_SUMU_1000ms_BRPASel_BSAS.mat';
recDate{3} = '19102016';
fileID{3} = '20161019';
subjID{3} = 'Hayo';
datasets{4} = 'B:\H07\20161025\PFC\Bfsgrad1\EnsemblePSTHs\10ms_MM_EnsemblePSTHs_SUMU_1000ms_BRPASel_BSAS.mat';
recDate{4} = '25102016';
fileID{4} = '20161025';
subjID{4} = 'Hayo';
datasets{5} = 'B:\A11\20170305\PFC\Bfsgrad1\EnsemblePSTHs\10ms_MM_EnsemblePSTHs_SUMU_1000ms_BRPASel_BSAS.mat';
recDate{5} = '05032017';
fileID{5} = '20170305';
subjID{5} = 'Anton';
datasets{6} = 'B:\A11\20170302\PFC\Bfsgrad1\EnsemblePSTHs\10ms_MM_EnsemblePSTHs_SUMU_1000ms_BRPASel_BSAS.mat';
recDate{6} = '02032017';
fileID{6} = '20170302';
subjID{6} = 'Anton';

%% Load and pool

edges = -1:0.01:1;

sel90_BR_s270TO90 = [];
sel90_BR_s90TO270 = [];
sel270_BR_s270TO90 = [];
sel270_BR_s90TO270 = [];

sel90_PA_s270TO90 = [];
sel90_PA_s90TO270 = [];
sel270_PA_s270TO90 = [];
sel270_PA_s90TO270 = [];

%Prepare first for crossover structure

for iDataset = 1:6
    
    load(datasets{iDataset})
    
    ensemblePSTHs(iDataset).spikingActivity = spikingActivityPerTransition;
    ensemblePSTHs(iDataset).t = edges;
    
end

for iDataset = 1:6
    
    load(datasets{iDataset})
    
    sel90_BR_s270TO90 = [sel90_BR_s270TO90;spikingActivityPerTransition.sel90.BR.s270TO90];
    sel90_BR_s90TO270 = [sel90_BR_s90TO270;spikingActivityPerTransition.sel90.BR.s90TO270];
    sel270_BR_s270TO90 = [sel270_BR_s270TO90;spikingActivityPerTransition.sel270.BR.s270TO90];
    sel270_BR_s90TO270 = [sel270_BR_s90TO270;spikingActivityPerTransition.sel270.BR.s90TO270];
    
    sel90_PA_s270TO90 = [sel90_PA_s270TO90;spikingActivityPerTransition.sel90.PA.s270TO90];
    sel90_PA_s90TO270 = [sel90_PA_s90TO270;spikingActivityPerTransition.sel90.PA.s90TO270];
    sel270_PA_s270TO90 = [sel270_PA_s270TO90;spikingActivityPerTransition.sel270.PA.s270TO90];
    sel270_PA_s90TO270 = [sel270_PA_s90TO270;spikingActivityPerTransition.sel270.PA.s90TO270];
    
end

%% Normalise each before averaging and taking SEM

for iTr = 1:size(sel90_BR_s270TO90,1)
    
    sel90_BR_s270TO90(iTr,:) = normalise(sel90_BR_s270TO90(iTr,:));
    
end

for iTr = 1:size(sel90_BR_s90TO270,1)
    
    sel90_BR_s90TO270(iTr,:) = normalise(sel90_BR_s90TO270(iTr,:));
    
end

for iTr = 1:size(sel270_BR_s270TO90,1)
    
    sel270_BR_s270TO90(iTr,:) = normalise(sel270_BR_s270TO90(iTr,:));
    
end

for iTr = 1:size(sel270_BR_s90TO270,1)
    
    sel270_BR_s90TO270(iTr,:) = normalise(sel270_BR_s90TO270(iTr,:));
    
end

for iTr = 1:size(sel90_PA_s270TO90,1)
    
    sel90_PA_s270TO90(iTr,:) = normalise(sel90_PA_s270TO90(iTr,:));
    
end

for iTr = 1:size(sel90_PA_s90TO270,1)
    
    sel90_PA_s90TO270(iTr,:) = normalise(sel90_PA_s90TO270(iTr,:));
    
end

for iTr = 1:size(sel270_PA_s270TO90,1)
    
    sel270_PA_s270TO90(iTr,:) = normalise(sel270_PA_s270TO90(iTr,:));
    
end

for iTr = 1:size(sel270_PA_s90TO270,1)
    
    sel270_PA_s90TO270(iTr,:) = normalise(sel270_PA_s90TO270(iTr,:));
    
end

%% Do a t-test for each bin for the two competing ensembles

[h, p_BR_s270TO90] = ttest2(sel90_BR_s270TO90, sel270_BR_s270TO90);
[h, p_BR_s90TO270] = ttest2(sel90_BR_s90TO270, sel270_BR_s90TO270);
[h, p_PA_s270TO90] = ttest2(sel90_PA_s270TO90, sel270_PA_s270TO90);
[h, p_PA_s90TO270] = ttest2(sel90_PA_s90TO270, sel270_PA_s90TO270);

% Plot the P-values

plot(edges(3:end-2),(p_BR_s270TO90(3:end-2)),'r','LineWidth',1)
hold on
plot(edges(3:end-2),(p_BR_s90TO270(3:end-2)),'--r','LineWidth',1)
plot(edges(3:end-2),(p_PA_s270TO90(3:end-2)),'k','LineWidth',1)
plot(edges(3:end-2),(p_PA_s90TO270(3:end-2)),'--k','LineWidth',1)
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

plot(edges(3:end-2),dp_mean_BR_s270TO90(3:end-2),'-r','LineWidth',1)
hold on
plot(edges(3:end-2),dp_mean_BR_s90TO270(3:end-2),'--r','LineWidth',1)
plot(edges(3:end-2),dp_mean_PA_s270TO90(3:end-2),'-k','LineWidth',1)
plot(edges(3:end-2),dp_mean_PA_s90TO270(3:end-2),'--k','LineWidth',1)
vline(0,'--b')
xlabel('bins')
ylabel('abs(d-prime)')
axis tight
box off
title('Binwise d-prime between competing ensembles')
legend('BR 270TO90', 'BR 90TO270','PA 270TO90','PA 90TO270')
%% Get the means and SEMs

mean_sel90_BR_s270TO90 = nanmean(sel90_BR_s270TO90,1);
sem_sel90_BR_s270TO90 = nanstd(sel90_BR_s270TO90,1)./sqrt(size(sel90_BR_s270TO90,1));
mean_sel90_BR_s90TO270 = nanmean(sel90_BR_s90TO270,1);
sem_sel90_BR_s90TO270 = nanstd(sel90_BR_s90TO270,1)./sqrt(size(sel90_BR_s90TO270,1));
mean_sel270_BR_s270TO90 = nanmean(sel270_BR_s270TO90,1);
sem_sel270_BR_s270TO90 = nanstd(sel270_BR_s270TO90,1)./sqrt(size(sel270_BR_s270TO90,1));
mean_sel270_BR_s90TO270 = nanmean(sel270_BR_s90TO270,1);
sem_sel270_BR_s90TO270 = nanstd(sel270_BR_s90TO270,1)./sqrt(size(sel270_BR_s90TO270,1));

mean_sel90_PA_s270TO90 = nanmean(sel90_PA_s270TO90,1);
sem_sel90_PA_s270TO90 = nanstd(sel90_PA_s270TO90,1)./sqrt(size(sel90_PA_s270TO90,1));
mean_sel90_PA_s90TO270 = nanmean(sel90_PA_s90TO270,1);
sem_sel90_PA_s90TO270 = nanstd(sel90_PA_s90TO270,1)./sqrt(size(sel90_PA_s90TO270,1));
mean_sel270_PA_s270TO90 = nanmean(sel270_PA_s270TO90,1);
sem_sel270_PA_s270TO90 = nanstd(sel270_PA_s270TO90,1)./sqrt(size(sel270_PA_s270TO90,1));
mean_sel270_PA_s90TO270 = nanmean(sel270_PA_s90TO270,1);
sem_sel270_PA_s90TO270 = nanstd(sel270_PA_s90TO270,1)./sqrt(size(sel270_PA_s90TO270,1));

%% Plot means

subplot(2,2,1)
shadedErrorBar(edges(3:end-2), mean_sel90_BR_s270TO90(3:end-2),sem_sel90_BR_s270TO90(3:end-2))
hold on
P(1)=plot(edges(3:end-2), mean_sel90_BR_s270TO90(3:end-2),'LineWidth',1);
shadedErrorBar(edges(3:end-2), mean_sel270_BR_s270TO90(3:end-2),sem_sel270_BR_s270TO90(3:end-2))
P(1)=plot(edges(3:end-2), mean_sel270_BR_s270TO90(3:end-2),'LineWidth',1);
set(gca,'xtick',[])
ylim([0.25 0.65])
vline(0,'--k'); box off
title('BR - Down To Up')

subplot(2,2,2)
shadedErrorBar(edges(3:end-2), mean_sel90_BR_s90TO270(3:end-2),sem_sel90_BR_s90TO270(3:end-2))
hold on
P(2)=plot(edges(3:end-2), mean_sel90_BR_s90TO270(3:end-2),'LineWidth',1);
shadedErrorBar(edges(3:end-2), mean_sel270_BR_s90TO270(3:end-2),sem_sel270_BR_s90TO270(3:end-2))
P(2)=plot(edges(3:end-2), mean_sel270_BR_s90TO270(3:end-2),'LineWidth',1);
set(gca,'xtick',[])
set(gca,'ytick',[])
ylim([0.25 0.65])
vline(0,'--k'); box off
title('BR - Up To Down')

subplot(2,2,3)
shadedErrorBar(edges(3:end-2), mean_sel90_PA_s270TO90(3:end-2),sem_sel90_PA_s270TO90(3:end-2))
hold on
P(1)=plot(edges(3:end-2), mean_sel90_PA_s270TO90(3:end-2),'LineWidth',1);
shadedErrorBar(edges(3:end-2), mean_sel270_PA_s270TO90(3:end-2),sem_sel270_PA_s270TO90(3:end-2))
P(1)=plot(edges(3:end-2), mean_sel270_PA_s270TO90(3:end-2),'LineWidth',1);
ylim([0.25 0.65])
vline(0,'--k'); box off
title('PA - Down To Up')

subplot(2,2,4)
shadedErrorBar(edges(3:end-2), mean_sel90_PA_s90TO270(3:end-2),sem_sel90_PA_s90TO270(3:end-2))
hold on
P(2)=plot(edges(3:end-2), mean_sel90_PA_s90TO270(3:end-2),'LineWidth',1);
shadedErrorBar(edges(3:end-2), mean_sel270_PA_s90TO270(3:end-2),sem_sel270_PA_s90TO270(3:end-2))
P(2)=plot(edges(3:end-2), mean_sel270_PA_s90TO270(3:end-2),'LineWidth',1);
set(gca,'ytick',[])
ylim([0.25 0.65])
vline(0,'--k'); box off
title('PA - Up To Down')

subplot(2,2,3)
shadedErrorBar(edges(3:end-2), mean_sel90_PA_s270TO90(3:end-2),sem_sel90_PA_s270TO90(3:end-2))
hold on
P(1)=plot(edges(3:end-2), mean_sel90_PA_s270TO90(3:end-2),'--','LineWidth',1);
shadedErrorBar(edges(3:end-2), mean_sel270_PA_s270TO90(3:end-2),sem_sel270_PA_s270TO90(3:end-2))
P(1)=plot(edges(3:end-2), mean_sel270_PA_s270TO90(3:end-2),'--','LineWidth',1);
ylim([0.25 0.65])
vline(0,'--k'); box off
title('PA - Down To Up')

subplot(2,2,4)
shadedErrorBar(edges(3:end-2), mean_sel90_PA_s90TO270(3:end-2),sem_sel90_PA_s90TO270(3:end-2))
hold on
P(2)=plot(edges(3:end-2), mean_sel90_PA_s90TO270(3:end-2),'--','LineWidth',1);
shadedErrorBar(edges(3:end-2), mean_sel270_PA_s90TO270(3:end-2),sem_sel270_PA_s90TO270(3:end-2))
P(2)=plot(edges(3:end-2), mean_sel270_PA_s90TO270(3:end-2),'--','LineWidth',1);
set(gca,'ytick',[])
ylim([0.25 0.65])
vline(0,'--k'); box off
title('PA - Up To Down')
