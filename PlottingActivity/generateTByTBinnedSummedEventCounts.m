function generateTByTBinnedSummedEventCounts

datasets{1} = 'B:\H07\12-06-2016\PFC\Bfsgrad1';
recDate{1} = '12062016';
fileID{1} = '12-06-2016';
subjID{1} = 'Hayo';
datasets{2} = 'B:\H07\13-07-2016\PFC\Bfsgrad1';
recDate{2} = '13072016';
fileID{2} = '13-07-2016';
subjID{2} = 'Hayo';
datasets{3} = 'B:\H07\20161019\PFC\Bfsgrad1';
recDate{3} = '19102016';
fileID{3} = '20161019';
subjID{3} = 'Hayo';
datasets{4} = 'B:\H07\20161025\PFC\Bfsgrad1';
recDate{4} = '25102016';
fileID{4} = '20161025';
subjID{4} = 'Hayo';
datasets{5} = 'B:\A11\20170305\PFC\Bfsgrad1';
recDate{5} = '05032017';
fileID{5} = '20170305';
subjID{5} = 'Anton';
datasets{6} = 'B:\A11\20170302\PFC\Bfsgrad1';
recDate{6} = '02032017';
fileID{6} = '20170302';
subjID{6} = 'Anton';

%% Collect and sum

low_s270TO90_BR = [];
low_s90TO270_BR = [];
low_s270TO90_PA = [];
low_s90TO270_PA = [];


for iDataset = 1:length(datasets)
    
    cd(datasets{iDataset})
    load('TbyT_lowRate_1000ms.mat')
    
    low_s270TO90_BR = [low_s270TO90_BR; spikingActivityPerTransition.sel270.lowRate.BR.s270TO90];
    low_s90TO270_BR = [low_s90TO270_BR; spikingActivityPerTransition.sel270.lowRate.BR.s90TO270];
    low_s270TO90_PA = [low_s270TO90_PA; spikingActivityPerTransition.sel270.lowRate.PA.s270TO90];
    low_s90TO270_PA = [low_s90TO270_PA; spikingActivityPerTransition.sel270.lowRate.PA.s90TO270];
    
    
end

low_s270TO90_BR = nansum(low_s270TO90_BR,1);
low_s90TO270_BR = nansum(low_s90TO270_BR,1);
low_s270TO90_PA = nansum(low_s270TO90_PA,1);
low_s90TO270_PA = nansum(low_s90TO270_PA,1);


plot(edges(4:end-3)./1000,smooth(zscore(low_s270TO90_BR(4:end-3))),'-r')
hold on
plot(edges(4:end-3)./1000,smooth(zscore(low_s90TO270_BR(4:end-3))),'--r')
plot(edges(4:end-3)./1000,smooth(zscore(low_s270TO90_PA(4:end-3))),'-k')
plot(edges(4:end-3)./1000,smooth(zscore(low_s90TO270_PA(4:end-3))),'--k')
xlabel('duration [s]')
ylabel('zscored lfp event sum')
axis tight
box off
vline(0,'--b');