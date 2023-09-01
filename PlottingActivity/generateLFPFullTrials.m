function generateLFPFullTrials

%% Enumerate datasets

nDatasets = 6;
directories.taskdirPFC{1} = 'B:\H07\12-06-2016\PFC\Bfsgrad1';
directories.taskdirPFC{2} = 'B:\H07\13-07-2016\PFC\Bfsgrad1';
directories.taskdirPFC{3} = 'B:\H07\20161019\PFC\Bfsgrad1';
directories.taskdirPFC{4} = 'B:\H07\20161025\PFC\Bfsgrad1';
directories.taskdirPFC{5} = 'B:\A11\20170305\PFC\Bfsgrad1';
directories.taskdirPFC{6} = 'B:\A11\20170302\PFC\Bfsgrad1';

%% Collect full trials

for iDataset = 1:nDatasets
    
    cd(directories.taskdirPFC{iDataset})
    load jMUSpikesByTime.mat
    cd LFPFullTrials
    
    load FullTrial_LFP_Hilberts_NormalisedRatios.mat
    
    normalisedAmplitudesRatios(iDataset).data = trialTraces;
    
    load FullTrial_LFP_Hilberts_Ratios.mat
    
   rawAmplitudesRatios(iDataset).data = trialTraces;

end

%% Save in results folder

cd B:\Results\
mkdir FullTrialTraces
cd FullTrialTraces

save('NormalisedFullTrialAmpsRatios.mat','normalisedAmplitudesRatios','-v7.3')
save('RawFullTrialAmpsRatios.mat','rawAmplitudesRatios','-v7.3')
