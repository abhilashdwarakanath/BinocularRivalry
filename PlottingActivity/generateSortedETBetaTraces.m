function generateSortedETBetaTraces(duration)

%% Enumerate the datasets

% traces_ according to Selectivity during Rivalry

datasetsDS{1} = ['B:\H07\12-06-2016\PFC\Bfsgrad1\LFPStatistics\EventTriggeredTraces\evtTriggered_blpTraces_' num2str(duration) 'ms_Chebyshev1_'  '.mat'];
datasetsDS{2} = ['B:\H07\13-07-2016\PFC\Bfsgrad1\LFPStatistics\EventTriggeredTraces\evtTriggered_blpTraces_' num2str(duration) 'ms_Chebyshev1_'  '.mat'];
datasetsDS{3} = ['B:\H07\20161019\PFC\Bfsgrad1\LFPStatistics\EventTriggeredTraces\evtTriggered_blpTraces_' num2str(duration) 'ms_Chebyshev1_'  '.mat'];
datasetsDS{4} = ['B:\H07\20161025\PFC\Bfsgrad1\LFPStatistics\EventTriggeredTraces\evtTriggered_blpTraces_' num2str(duration) 'ms_Chebyshev1_'  '.mat'];
datasetsDS{5} = ['B:\A11\20170305\PFC\Bfsgrad1\LFPStatistics\EventTriggeredTraces\evtTriggered_blpTraces_' num2str(duration) 'ms_Chebyshev1_'  '.mat'];
datasetsDS{6} = ['B:\A11\20170302\PFC\Bfsgrad1\LFPStatistics\EventTriggeredTraces\evtTriggered_blpTraces_' num2str(duration) 'ms_Chebyshev1_'  '.mat'];

%% Plot grand average for DomSels

% collect

pre_BR_low = [];
pre_BR_beta = [];
post_PA_low = [];
post_PA_beta = [];

post_BR_low = [];
post_BR_beta = [];
pre_PA_low = [];
pre_PA_beta = [];

for iDataset = [1 2 3 4 5 6]
    
    load(datasetsDS{iDataset});
    folderName = ['B:\Results\TracesMeans\Pooled\EventTriggered\std4\' num2str(duration/1000) 's'];
    mkdir(folderName)
    cd(folderName)
    
    for i = 1:96
        pre_BR_low = [pre_BR_low eventTriggeredTraces(i).BR.dom90.Pre.low eventTriggeredTraces(i).BR.dom270.Pre.low];
        pre_BR_beta = [pre_BR_beta eventTriggeredTraces(i).BR.dom90.Pre.beta eventTriggeredTraces(i).BR.dom270.Pre.beta];
        post_PA_low = [post_PA_low eventTriggeredTraces(i).PA.dom90.Post.low eventTriggeredTraces(i).PA.dom270.Post.low];
        post_PA_beta = [post_PA_beta eventTriggeredTraces(i).PA.dom90.Post.beta eventTriggeredTraces(i).PA.dom270.Post.beta];
        
        post_BR_low = [post_BR_low eventTriggeredTraces(i).BR.dom90.Post.low eventTriggeredTraces(i).BR.dom270.Post.low];
        post_BR_beta = [post_BR_beta eventTriggeredTraces(i).BR.dom90.Post.beta eventTriggeredTraces(i).BR.dom270.Post.beta];
        pre_PA_low = [pre_PA_low eventTriggeredTraces(i).PA.dom90.Pre.low eventTriggeredTraces(i).PA.dom270.Pre.low];
        pre_PA_beta = [pre_PA_beta eventTriggeredTraces(i).PA.dom90.Pre.beta eventTriggeredTraces(i).PA.dom270.Pre.beta];
    end
    
end

%% Sort by amplitude

[val, idx] = max(pre_BR_low,[],1);
[sortedAmpsBR, idx] = sort(val);
sortedPreBRBeta = pre_BR_beta(:,idx);

[val, idx] = max(post_PA_low,[],1);
[sortedAmpsPA, idx] = sort(val);
sortedPostPABeta = post_PA_beta(:,idx);
