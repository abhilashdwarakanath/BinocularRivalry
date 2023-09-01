function generateGammaDistributions

% This code collects all computed spectrograms across datasets and then
% creates a grand average of selective sites during Riv and during PA_FS
% for comparison

%% Enumerate the datasets

% traces_ according to Selectivity during Rivalry

datasets{1} = ['B:\H07\12-06-2016\PFC\Bfsgrad1\jMUDominancesByTime.mat'];
datasets{2} = ['B:\H07\13-07-2016\PFC\Bfsgrad1\jMUDominancesByTime.mat'];
datasets{3} = ['B:\H07\20161019\PFC\Bfsgrad1\jMUDominancesByTime.mat'];
datasets{4} = ['B:\H07\20161025\PFC\Bfsgrad1\jMUDominancesByTime.mat'];
datasets{5} = ['B:\A11\20170305\PFC\Bfsgrad1\jMUDominancesByTime.mat'];
datasets{6} = ['B:\A11\20170302\PFC\Bfsgrad1\jMUDominancesByTime.mat'];

%% Collect all

% collect

dominanceDurations = [];

for iDataset = 1:length(datasets)
    
    load(datasets{iDataset})
    
    for iCond = 1:4
        
        domdurs = [cell2mat(jMUDominances.data.domDur.dom90{iCond}) cell2mat(jMUDominances.data.domDur.dom270{iCond})];
        dominanceDurations = [dominanceDurations domdurs];
        
        clear domdurs
        
    end
end

%% Collect 90 and 270 separately

dominanceDurations90 = [];
dominanceDurations270 = [];

for iDataset = 1:length(datasets)
    
    load(datasets{iDataset})
    
    for iCond = 1:4
        
        domdurs90 = cell2mat(jMUDominances.data.domDur.dom90{iCond});
        dominanceDurations90 = [dominanceDurations90 domdurs90];
        
        domdurs270 = cell2mat(jMUDominances.data.domDur.dom270{iCond});
        dominanceDurations270 = [dominanceDurations270 domdurs270];
        
        clear domdurs90; clear domdurs 270;
        
    end
end

%% Flash dominance

dominanceDurationsMOA = [];
dominanceDurationsPOA = [];

for iDataset = 1:length(datasets)
    
    load(datasets{iDataset})
    
    for iCond = 1:4
        
        domdurs = [cell2mat(jMUDominances.data.domDur.flashDomMOA{iCond})];
        domdurs2 = [cell2mat(jMUDominances.data.domDur.flashDomPOA{iCond})];
        dominanceDurationsMOA = [dominanceDurationsMOA domdurs];
        dominanceDurationsPOA = [dominanceDurationsPOA domdurs2];
        
        clear domdurs
        
    end
end

% FIt and plot

histfit(dominanceDurations,25,'gamma')
grid on
xlabel('FS Durations (ms)')
ylabel('Counts per bin')
title('Distributions of FS durations - pooled')
legend('data','fit')
vline(mean(dominanceDurations),'--g');

