clear all
close all
clc

% This script generates the Gamma distributions for both spontaneous
% rivalry and flash suppression

%% Datapaths

dataset{1} = 'B:\H07\12-06-2016\PFC\Bfsgrad1\';
dataset{2} = 'B:\H07\13-07-2016\PFC\Bfsgrad1\';
dataset{3} = 'B:\H07\20161019\PFC\Bfsgrad1\';
dataset{4} = 'B:\H07\20161025\PFC\Bfsgrad1\';
dataset{5} = 'B:\A11\20170305\PFC\Bfsgrad1\';
dataset{6} = 'B:\A11\20170302\PFC\Bfsgrad1\';

nDatasets = length(dataset);

%% Load jMUDominances and get the durations

sponDominances = [];
flashDominances = [];

for iDataset = 1:nDatasets
    
    cd(dataset{iDataset})
    
    load jMUDominancesByTime.mat
    
    domTemp = [];
    flashDomTemp = [];
    
    for iCond = 1:4
        
        temp90 = cell2mat(jMUDominances.data.domDur.dom90{iCond});
        temp270 = cell2mat(jMUDominances.data.domDur.dom270{iCond});
        tempFlash = cell2mat(jMUDominances.data.domDur.flashDomMOA{iCond});
        
        nanIdx = isnan(tempFlash);
        tempFlash(nanIdx==1) = [];
        
        nanIdx = isnan(temp90);
        temp90(nanIdx==1) = [];
        
        nanIdx = isnan(temp270);
        temp270(nanIdx==1) = [];
        
        domTemp = [domTemp temp90 temp270];
        flashDomTemp = [flashDomTemp tempFlash];
        
    end
    
    sponDominances = [sponDominances domTemp];
    flashDominances = [flashDominances flashDomTemp];
    
end

sponDominances = sponDominances./1e3;
flashDominances = flashDominances./1e3;

%% Plot

figure

subplot(1,2,1)
histfit(flashDominances,25,'gamma')
axis tight; box off;
vline(mean(flashDominances),'--g')

subplot(1,2,2)
histfit(sponDominances,25,'gamma')
axis tight; box off;
vline(mean(sponDominances),'--g')
