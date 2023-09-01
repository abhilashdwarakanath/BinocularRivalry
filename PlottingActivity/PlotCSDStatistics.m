clear all
close all
clc

%% Define paths

datasets{1} = 'B:\H07\12-06-2016\PFC\Bfsgrad1\CriticalSlowingDown\MMstd4_TbyT_CSDACR_1000ms.mat';
datasets{2} = 'B:\H07\13-07-2016\PFC\Bfsgrad1\CriticalSlowingDown\MMstd4_TbyT_CSDACR_1000ms.mat';
datasets{3} = 'B:\H07\20161019\PFC\Bfsgrad1\CriticalSlowingDown\MMstd4_TbyT_CSDACR_1000ms.mat';
datasets{4} = 'B:\H07\20161025\PFC\Bfsgrad1\CriticalSlowingDown\MMstd4_TbyT_CSDACR_1000ms.mat';
datasets{5} = 'B:\A11\20170305\PFC\Bfsgrad1\CriticalSlowingDown\MMstd4_TbyT_CSDACR_1000ms.mat';
datasets{6} = 'B:\A11\20170302\PFC\Bfsgrad1\CriticalSlowingDown\MMstd4_TbyT_CSDACR_1000ms.mat';

%% Load and collect across BR and PA

ar1BR = [];
ar1PA = [];
varBR = [];
varPA = [];

for iDataset = 1:length(datasets)
    
    load(datasets{iDataset})
    
    ar1BR = [ar1BR; preSwitch.BR90.fwhmac; preSwitch.BR270.fwhmac];
    ar1PA = [ar1PA; preSwitch.PA90.fwhmac; preSwitch.PA270.fwhmac];
    
    varBR = [varBR; preSwitch.BR90.variance; preSwitch.BR270.variance];
    varPA = [varPA; preSwitch.PA90.variance; preSwitch.PA270.variance];
    
end

%% Plot

subplot(2,1,1)
plot(tPre,normalise(nanmean(varBR,1)),'--r','LineWidth',1.5)
hold on
plot(tPre,normalise(nanmean(varPA,1)),'--k','LineWidth',1.5)
box off; grid on;
ylabel('normalised log10 variance')
xlabel('time approaching a switch [s]')
subplot(2,1,2)
plot(tPre,smooth(nanmean(ar1BR,1)),'-r','LineWidth',1.5)
hold on
plot(tPre,smooth(nanmean(ar1PA,1)),'-k','LineWidth',1.5)
box off; grid on;
ylabel('ACF at FWHM')
xlabel('time approaching a switch [s]')
legend('BR','PA')
    