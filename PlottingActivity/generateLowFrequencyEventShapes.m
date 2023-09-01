function generateLowFrequencyEventShapes(duration)

%% Enumerate the datasets

datasets{1} = ['B:\H07\12-06-2016\PFC\Bfsgrad1\LFPStatistics\EventTriggeredTraces\TbyT_eventShapes_Times_low_' num2str(duration/1000) 's_back_' num2str(duration/1000) 's.mat'];
datasets{2} = ['B:\H07\13-07-2016\PFC\Bfsgrad1\LFPStatistics\EventTriggeredTraces\TbyT_eventShapes_Times_low_' num2str(duration/1000) 's_back_' num2str(duration/1000) 's.mat'];
datasets{3} = ['B:\H07\20161019\PFC\Bfsgrad1\LFPStatistics\EventTriggeredTraces\TbyT_eventShapes_Times_low_' num2str(duration/1000) 's_back_' num2str(duration/1000) 's.mat'];
datasets{4} = ['B:\H07\20161025\PFC\Bfsgrad1\LFPStatistics\EventTriggeredTraces\TbyT_eventShapes_Times_low_' num2str(duration/1000) 's_back_' num2str(duration/1000) 's.mat'];
datasets{5} = ['B:\A11\20170305\PFC\Bfsgrad1\LFPStatistics\EventTriggeredTraces\TbyT_eventShapes_Times_low_' num2str(duration/1000) 's_back_' num2str(duration/1000) 's.mat'];
datasets{6} = ['B:\A11\20170302\PFC\Bfsgrad1\LFPStatistics\EventTriggeredTraces\TbyT_eventShapes_Times_low_' num2str(duration/1000) 's_back_' num2str(duration/1000) 's.mat'];

%% Load and collect

nDatasets = 6;

for iDataset = 1:nDatasets
    
    load(datasets{iDataset});
    
    shapesForClustering(iDataset).lowShapes = eventShapes;
    
end

%% Save

cd B:\Results\EventTriggeredStatistics\std4\0.5s

save('shapesForClustering.mat','shapesForClustering','-v7.3')