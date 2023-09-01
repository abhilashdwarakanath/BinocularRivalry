function generateLowBetaAmpCorrelation(duration)

nDatasets = 6;
datasets{1} = ['B:\H07\12-06-2016\PFC\Bfsgrad1\LFPStatistics\std4_eventAmps_' num2str(duration) 'ms_Chebyshev1.mat'];
recDate{1} = '12062016';
fileID{1} = '12-06-2016';
subjID{1} = 'Hayo';
datasets{2} = ['B:\H07\13-07-2016\PFC\Bfsgrad1\LFPStatistics\std4_eventAmps_' num2str(duration) 'ms_Chebyshev1.mat'];
recDate{2} = '13072016';
fileID{2} = '13-07-2016';
subjID{2} = 'Hayo';
datasets{3} = ['B:\H07\20161019\PFC\Bfsgrad1\LFPStatistics\std4_eventAmps_' num2str(duration) 'ms_Chebyshev1.mat'];
recDate{3} = '19102016';
fileID{3} = '20161019';
subjID{3} = 'Hayo';
datasets{4} = ['B:\H07\20161025\PFC\Bfsgrad1\LFPStatistics\std4_eventAmps_' num2str(duration) 'ms_Chebyshev1.mat'];
recDate{4} = '25102016';
fileID{4} = '20161025';
subjID{4} = 'Hayo';
datasets{5} = ['B:\A11\20170305\PFC\Bfsgrad1\LFPStatistics\std4_eventAmps_' num2str(duration) 'ms_Chebyshev1.mat'];
recDate{5} = '05032017';
fileID{5} = '20170305';
subjID{5} = 'Anton';
datasets{6} = ['B:\A11\20170302\PFC\Bfsgrad1\LFPStatistics\std4_eventAmps_' num2str(duration) 'ms_Chebyshev1.mat'];
recDate{6} = '02032017';
fileID{6} = '20170302';
subjID{6} = 'Anton';

%% Load and collect

eventTimes_BR = [];
lowAmps_BR = [];
betaAmps_BR = [];

for iDataset = 1:nDatasets
    
    load(datasets{iDataset})
    
    eventTimes_BR = [];
    
end

