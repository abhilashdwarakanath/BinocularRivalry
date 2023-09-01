clear all
close all
clc

% This code collects all computed spectrograms across datasets and then
% creates a grand average of selective sites during Riv and during PA_FS
% for comparison

%% Enumerate the datasets

datasetsDS{1} = 'B:\H07\12-06-2016\PFC\Bfsgrad1\LFPSpectrograms\RandomTriggered\randomTriggeredSpecgrams_0.5s_back_0.5s.mat';
datasetsDS{2} = 'B:\H07\13-07-2016\PFC\Bfsgrad1\LFPSpectrograms\RandomTriggered\randomTriggeredSpecgrams_0.5s_back_0.5s.mat';
datasetsDS{3} = 'B:\H07\20161019\PFC\Bfsgrad1\LFPSpectrograms\RandomTriggered\randomTriggeredSpecgrams_0.5s_back_0.5s.mat';
datasetsDS{4} = 'B:\H07\20161025\PFC\Bfsgrad1\LFPSpectrograms\RandomTriggered\randomTriggeredSpecgrams_0.5s_back_0.5s.mat';
datasetsDS{5} = 'B:\A11\20170305\PFC\Bfsgrad1\LFPSpectrograms\RandomTriggered\randomTriggeredSpecgrams_0.5s_back_0.5s.mat';
datasetsDS{6} = 'B:\A11\20170302\PFC\Bfsgrad1\LFPSpectrograms\RandomTriggered\randomTriggeredSpecgrams_0.5s_back_0.5s.mat';


%% Plot grand average

% collect

rt_Specgrams = [];

for iDataset = 2
    
    load(datasetsDS{iDataset});
    
    rt_Specgrams = cat(3,rt_Specgrams,randomTriggeredSpecgrams1);
    
end

gaRT = nanmean(rt_Specgrams,3);