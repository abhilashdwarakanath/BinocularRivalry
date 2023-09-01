function generateLowFrequencyActivityProfilesPA(duration)

dbstop if error

%% Enumerate the datasets

datasets{1} = ['B:\H07\12-06-2016\PFC\Bfsgrad1\LFPStatistics\EventTriggeredTraces\TbyT_PA_eventShapes_Times_low_' num2str(duration/1000) 's_back_' num2str(duration/1000) 's.mat'];
datasets{2} = ['B:\H07\13-07-2016\PFC\Bfsgrad1\LFPStatistics\EventTriggeredTraces\TbyT_PA_eventShapes_Times_low_' num2str(duration/1000) 's_back_' num2str(duration/1000) 's.mat'];
datasets{3} = ['B:\H07\20161019\PFC\Bfsgrad1\LFPStatistics\EventTriggeredTraces\TbyT_PA_eventShapes_Times_low_' num2str(duration/1000) 's_back_' num2str(duration/1000) 's.mat'];
datasets{4} = ['B:\H07\20161025\PFC\Bfsgrad1\LFPStatistics\EventTriggeredTraces\TbyT_PA_eventShapes_Times_low_' num2str(duration/1000) 's_back_' num2str(duration/1000) 's.mat'];
datasets{5} = ['B:\A11\20170305\PFC\Bfsgrad1\LFPStatistics\EventTriggeredTraces\TbyT_PA_eventShapes_Times_low_' num2str(duration/1000) 's_back_' num2str(duration/1000) 's.mat'];
datasets{6} = ['B:\A11\20170302\PFC\Bfsgrad1\LFPStatistics\EventTriggeredTraces\TbyT_PA_eventShapes_Times_low_' num2str(duration/1000) 's_back_' num2str(duration/1000) 's.mat'];

%% Compute activity profiles for each transition

t = linspace(-duration/1000,duration/1000,duration+1);
midPoint = find(t==0);
binSize = length(t)/3;
bins = (t(1):length(t)/3000:t(midPoint));
bins = [bins 0];

t_pre = linspace(-duration/1000,0,midPoint);

cmap1 = [255 230 13]./255;
cmap2 = [8 181 74]./255;
cmap3=[0 168 255]./255;

for iDataset = 1:6
    
    % load maps
    
    if iDataset <= 4
        load('B:\H07\H07ElectrodeInfo.mat')
        chan2elec = H07.PFC.electrodeInfo;
        map=[NaN	88	78	68	58	48	38	28	18	NaN
            96	87	77	67	57	47	37	27	17	8
            95	86	76	66	56	46	36	26	16	7
            94	85	75	65	55	45	35	25	15	6
            93	84	74	64	54	44	34	24	14	5
            92	83	73	63	53	43	33	23	13	4
            91	82	72	62	52	42	32	22	12	3
            90	81	71	61	51	41	31	21	11	2
            89	80	70	60	50	40	30	20	10	1
            NaN	79	69	59	49	39	29	19	9	NaN];
    else
        load('B:\A11\A11ElectrodeInfo.mat')
        chan2elec = A11.PFC.electrodeInfo;
        map = [NaN    88    78    68    58    48    38    28    18   8
            96    87    77    67    57    47    37    27    17     7
            95    86    76    66    56    46    36    26    16     6
            94    85    75    65    55    45    35    25    15     5
            93    84    74    64    54    44    34    24    14     NaN
            92    83    73    63    53    43    33    23    13     4
            91    82    72    62    52    42    32    22    12     3
            90    81    71    61    51    41    31    21    11     2
            89    80    70    60    50    40    30    20    10     1
            NaN    79    69    59    49    39    29    19     9   NaN];
    end
    
    clear s270TO90_Traces; clear s90TO270_Traces;
    
    load(datasets{iDataset},'lowTraces')
    
    chanProfile(iDataset).s270TO90.nEarlyChans = zeros(size(lowTraces.s270TO90,1),96);
    chanProfile(iDataset).s270TO90.nMiddleChans = zeros(size(lowTraces.s270TO90,1),96);
    chanProfile(iDataset).s270TO90.nLateChans = zeros(size(lowTraces.s270TO90,1),96);
    chanProfile(iDataset).s270TO90.nEarlyLate = zeros(size(lowTraces.s270TO90,1),96);
    chanProfile(iDataset).s270TO90.nNoActivity = zeros(size(lowTraces.s270TO90,1),96);
    chanProfile(iDataset).s270TO90.nMultiProfile = zeros(size(lowTraces.s270TO90,1),96);
    
    chanProfile(iDataset).s270TO90.chanIdEarlyChans = zeros(size(lowTraces.s270TO90,1),96);
    chanProfile(iDataset).s270TO90.chanIdMiddleChans = zeros(size(lowTraces.s270TO90,1),96);
    chanProfile(iDataset).s270TO90.chanIdLateChans = zeros(size(lowTraces.s270TO90,1),96);
    chanProfile(iDataset).s270TO90.chanIdEarlyLate = zeros(size(lowTraces.s270TO90,1),96);
    chanProfile(iDataset).s270TO90.chanIdNoActivity = zeros(size(lowTraces.s270TO90,1),96);
    chanProfile(iDataset).s270TO90.chanIdMultiProfile = zeros(size(lowTraces.s270TO90,1),96);
    
    % s270TO90
    for iTrace = 1:size(lowTraces.s270TO90,1)
        
        for iChan = 1:96
            
            s270TO90_Traces(iTrace,iChan,:) = lowTraces.s270TO90(iTrace,iChan).PA.Pre';
            
        end
        
    end
    
    for iTrace = 1:size(s270TO90_Traces,1)
        
        testPop = squeeze(s270TO90_Traces(iTrace,:,:));
        
        for iChan = 1:96
            
            chanTrace = testPop(iChan,:);
            
            traceNoise = median(abs(chanTrace)/0.6745);
            
            tmp = findpeaks(chanTrace,traceNoise);
            peaks = tmp.loc;
            peaks = t_pre(peaks');
            
            peakProfile = histcounts(peaks,bins);
            
            zeroBins = sum(peakProfile==0);
            
            if zeroBins == 3
                
                chanProfile(iDataset).s270TO90.nNoActivity(iTrace,iChan) = chanProfile(iDataset).s270TO90.nNoActivity(iTrace,iChan)+1;
                chanProfile(iDataset).s270TO90.chanIdNoActivity(iTrace,iChan) = 1;
                
            end
            
            if zeroBins == 0
                
                chanProfile(iDataset).s270TO90.nMultiProfile(iTrace,iChan) = chanProfile(iDataset).s270TO90.nMultiProfile(iTrace,iChan)+1;
                chanProfile(iDataset).s270TO90.chanIdMultiProfile(iTrace,iChan) = 1;
            end
            
            if zeroBins == 1
                
                idxs = find(peakProfile~=0);
                
                if sum(idxs == [1 2]) == 2
                    
                    chanProfile(iDataset).s270TO90.nEarlyChans(iTrace,iChan) = chanProfile(iDataset).s270TO90.nEarlyChans(iTrace,iChan)+1;
                    chanProfile(iDataset).s270TO90.chanIdEarlyChans(iTrace,iChan) = 1;
                    
                elseif sum(idxs == [2 3]) == 2
                    
                    chanProfile(iDataset).s270TO90.nLateChans(iTrace,iChan) = chanProfile(iDataset).s270TO90.nLateChans(iTrace,iChan)+1;
                    chanProfile(iDataset).s270TO90.chanIdLateChans(iTrace,iChan) = 1;
                    
                elseif sum(idxs == [1 3]) == 2
                    
                    chanProfile(iDataset).s270TO90.nEarlyLate(iTrace,iChan) = chanProfile(iDataset).s270TO90.nEarlyLate(iTrace,iChan)+1;
                    chanProfile(iDataset).s270TO90.chanIdEarlyLate(iTrace,iChan) = 1;
                end
                
            end
            
            if zeroBins == 2
                
                idx = find(peakProfile~=0);
                
                if idx==1
                    
                    chanProfile(iDataset).s270TO90.nEarlyChans(iTrace,iChan) = chanProfile(iDataset).s270TO90.nEarlyChans(iTrace,iChan)+1;
                    chanProfile(iDataset).s270TO90.chanIdEarlyChans(iTrace,iChan) = 1;
                    
                elseif idx == 2
                    
                    chanProfile(iDataset).s270TO90.nMiddleChans(iTrace,iChan) = chanProfile(iDataset).s270TO90.nMiddleChans(iTrace,iChan)+1;
                    chanProfile(iDataset).s270TO90.chanIdMiddleChans(iTrace,iChan) = 1;
                    
                elseif idx == 3
                    
                    chanProfile(iDataset).s270TO90.nLateChans(iTrace,iChan) = chanProfile(iDataset).s270TO90.nLateChans(iTrace,iChan)+1;
                    chanProfile(iDataset).s270TO90.chanIdLateChans(iTrace,iChan) = 1;
                    
                end
                
            end
            
        end
        
        % Plot 3 matrices for each
        
        chanListEarly = find(chanProfile(iDataset).s270TO90.chanIdEarlyChans(iTrace,:)==1);
        chanListMiddle = find(chanProfile(iDataset).s270TO90.chanIdMiddleChans(iTrace,:)==1);
        chanListLate = find(chanProfile(iDataset).s270TO90.chanIdLateChans(iTrace,:)==1);
%         
        elecListEarly = chan2elec(chanListEarly,2);
        elecListMiddle = chan2elec(chanListMiddle,2);
        elecListLate = chan2elec(chanListLate,2);
        
        figure(1)
        chanColours = nan(96,1);
        chanColours(elecListEarly) = 1;
        image_mapArray(chanColours, map, 1);colormap(cmap1);
        mkdir B:\Results\ActivityProfiles
        cd B:\Results\ActivityProfiles
        mkdir([num2str(duration/1000) 's'])
        cd([num2str(duration/1000) 's'])
        mkdir(['Session' num2str(iDataset)])
        cd (['Session' num2str(iDataset)])
        fn = ['PA_Early_s270TO90_Trace_' num2str(iTrace) '_ActivityProfile'];
        saveas(gcf,fn,'fig')
        close all
        
        figure(2)
        chanColours = nan(96,1);
        chanColours(elecListMiddle) = 1;
        image_mapArray(chanColours, map, 1);colormap(cmap2);
        mkdir B:\Results\ActivityProfiles
        cd B:\Results\ActivityProfiles
        mkdir([num2str(duration/1000) 's'])
        cd([num2str(duration/1000) 's'])
        mkdir(['Session' num2str(iDataset)])
        cd (['Session' num2str(iDataset)])
        fn = ['PA_Middle_s270TO90_Trace_' num2str(iTrace) '_ActivityProfile'];
        saveas(gcf,fn,'fig')
        close all
        
        figure(3)
        chanColours = nan(96,1);
        chanColours(elecListLate) = 1;
        image_mapArray(chanColours, map, 1);colormap(cmap3);
        mkdir B:\Results\ActivityProfiles
        cd B:\Results\ActivityProfiles
        mkdir([num2str(duration/1000) 's'])
        cd([num2str(duration/1000) 's'])
        mkdir(['Session' num2str(iDataset)])
        cd (['Session' num2str(iDataset)])
        fn = ['PA_Late_s270TO90_Trace_' num2str(iTrace) '_ActivityProfile'];
        saveas(gcf,fn,'fig')
        close all
        
    end
    
    chanProfile(iDataset).s90TO270.nEarlyChans = zeros(size(lowTraces.s90TO270,1),96);
    chanProfile(iDataset).s90TO270.nMiddleChans = zeros(size(lowTraces.s90TO270,1),96);
    chanProfile(iDataset).s90TO270.nLateChans = zeros(size(lowTraces.s90TO270,1),96);
    chanProfile(iDataset).s90TO270.nEarlyLate = zeros(size(lowTraces.s90TO270,1),96);
    chanProfile(iDataset).s90TO270.nNoActivity = zeros(size(lowTraces.s90TO270,1),96);
    chanProfile(iDataset).s90TO270.nMultiProfile = zeros(size(lowTraces.s90TO270,1),96);
    
    chanProfile(iDataset).s90TO270.chanIdEarlyChans = zeros(size(lowTraces.s90TO270,1),96);
    chanProfile(iDataset).s90TO270.chanIdMiddleChans = zeros(size(lowTraces.s90TO270,1),96);
    chanProfile(iDataset).s90TO270.chanIdLateChans = zeros(size(lowTraces.s90TO270,1),96);
    chanProfile(iDataset).s90TO270.chanIdEarlyLate = zeros(size(lowTraces.s90TO270,1),96);
    chanProfile(iDataset).s90TO270.chanIdNoActivity = zeros(size(lowTraces.s90TO270,1),96);
    chanProfile(iDataset).s90TO270.chanIdMultiProfile = zeros(size(lowTraces.s90TO270,1),96);
    
    % s90TO270
    
    for iTrace = 1:size(lowTraces.s90TO270,1)
        
        for iChan = 1:96
            
            s90TO270_Traces(iTrace,iChan,:) = lowTraces.s90TO270(iTrace,iChan).PA.Pre';
            
        end
        
    end
    
    for iTrace = 1:size(s90TO270_Traces,1)
        
        testPop = squeeze(s90TO270_Traces(iTrace,:,:));
        
        for iChan = 1:96
            
            chanTrace = testPop(iChan,:);
            
            traceNoise = median(abs(chanTrace)/0.6745);
            
            tmp = findpeaks(chanTrace,traceNoise);
            peaks = tmp.loc;
            peaks = t_pre(peaks');
            
            peakProfile = histcounts(peaks,bins);
            
            zeroBins = sum(peakProfile==0);
            
            if zeroBins == 3
                
                chanProfile(iDataset).s90TO270.nNoActivity(iTrace,iChan) = chanProfile(iDataset).s90TO270.nNoActivity(iTrace,iChan)+1;
                chanProfile(iDataset).s90TO270.chanIdNoActivity(iTrace,iChan) = 1;
                
            end
            
            if zeroBins == 0
                
                chanProfile(iDataset).s90TO270.nMultiProfile(iTrace,iChan) = chanProfile(iDataset).s90TO270.nMultiProfile(iTrace,iChan)+1;
                chanProfile(iDataset).s90TO270.chanIdMultiProfile(iTrace,iChan) = 1;
            end
            
            if zeroBins == 1
                
                idxs = find(peakProfile~=0);
                
                if sum(idxs == [1 2]) == 2
                    
                    chanProfile(iDataset).s90TO270.nEarlyChans(iTrace,iChan) = chanProfile(iDataset).s90TO270.nEarlyChans(iTrace,iChan)+1;
                    chanProfile(iDataset).s90TO270.chanIdEarlyChans(iTrace,iChan) = 1;
                    
                elseif sum(idxs == [2 3]) == 2
                    
                    chanProfile(iDataset).s90TO270.nLateChans(iTrace,iChan) = chanProfile(iDataset).s90TO270.nLateChans(iTrace,iChan)+1;
                    chanProfile(iDataset).s90TO270.chanIdLateChans(iTrace,iChan) = 1;
                    
                elseif sum(idxs == [1 3]) == 2
                    
                    chanProfile(iDataset).s90TO270.nEarlyLate(iTrace,iChan) = chanProfile(iDataset).s90TO270.nEarlyLate(iTrace,iChan)+1;
                    chanProfile(iDataset).s90TO270.chanIdEarlyLate(iTrace,iChan) = 1;
                end
                
            end
            
            if zeroBins == 2
                
                idx = find(peakProfile~=0);
                
                if idx==1
                    
                    chanProfile(iDataset).s90TO270.nEarlyChans(iTrace,iChan) = chanProfile(iDataset).s90TO270.nEarlyChans(iTrace,iChan)+1;
                    chanProfile(iDataset).s90TO270.chanIdEarlyChans(iTrace,iChan) = 1;
                    
                elseif idx == 2
                    
                    chanProfile(iDataset).s90TO270.nMiddleChans(iTrace,iChan) = chanProfile(iDataset).s90TO270.nMiddleChans(iTrace,iChan)+1;
                    chanProfile(iDataset).s90TO270.chanIdMiddleChans(iTrace,iChan) = 1;
                    
                elseif idx == 3
                    
                    chanProfile(iDataset).s90TO270.nLateChans(iTrace,iChan) = chanProfile(iDataset).s90TO270.nLateChans(iTrace,iChan)+1;
                    chanProfile(iDataset).s90TO270.chanIdLateChans(iTrace,iChan) = 1;
                    
                end
                
            end
            
        end
        
        chanListEarly = find(chanProfile(iDataset).s90TO270.chanIdEarlyChans(iTrace,:)==1);
        chanListMiddle = find(chanProfile(iDataset).s90TO270.chanIdMiddleChans(iTrace,:)==1);
        chanListLate = find(chanProfile(iDataset).s90TO270.chanIdLateChans(iTrace,:)==1);
        
        elecListEarly = chan2elec(chanListEarly,2);
        elecListMiddle = chan2elec(chanListMiddle,2);
        elecListLate = chan2elec(chanListLate,2);
        
        figure(1)
        chanColours = nan(96,1);
        chanColours(elecListEarly) = 1;
        image_mapArray(chanColours, map, 1);colormap(cmap1);
        mkdir B:\Results\ActivityProfiles
        cd B:\Results\ActivityProfiles
        mkdir([num2str(duration/1000) 's'])
        cd([num2str(duration/1000) 's'])
        mkdir(['Session' num2str(iDataset)])
        cd (['Session' num2str(iDataset)])
        fn = ['PA_Early_s90TO270_Trace_' num2str(iTrace) '_ActivityProfile'];
        saveas(gcf,fn,'fig')
        close all
        
        figure(2)
        chanColours = nan(96,1);
        chanColours(elecListMiddle) = 2;
        image_mapArray(chanColours, map, 1);colormap(cmap2);
        mkdir B:\Results\ActivityProfiles
        cd B:\Results\ActivityProfiles
        mkdir([num2str(duration/1000) 's'])
        cd([num2str(duration/1000) 's'])
        mkdir(['Session' num2str(iDataset)])
        cd (['Session' num2str(iDataset)])
        fn = ['PA_Middle_s90TO270_Trace_' num2str(iTrace) '_ActivityProfile'];
        saveas(gcf,fn,'fig')
        close all
        
        figure(3)
        chanColours = nan(96,1);
        chanColours(elecListLate) = 3;
        image_mapArray(chanColours, map, 1);colormap(cmap3);
        mkdir B:\Results\ActivityProfiles
        cd B:\Results\ActivityProfiles
        mkdir([num2str(duration/1000) 's'])
        cd([num2str(duration/1000) 's'])
        mkdir(['Session' num2str(iDataset)])
        cd (['Session' num2str(iDataset)])
        fn = ['PA_Late_s90TO270_Trace_' num2str(iTrace) '_ActivityProfile'];
        saveas(gcf,fn,'fig')
        close all
        
    end
    
    chanSummary(iDataset).s270TO90.propEarlyChans = (sum(sum(chanProfile(iDataset).s270TO90.nEarlyChans,2)./96,1)./size(lowTraces.s270TO90,1))*100;
    chanSummary(iDataset).s270TO90.propMiddleChans = (sum(sum(chanProfile(iDataset).s270TO90.nMiddleChans,2)./96,1)./size(lowTraces.s270TO90,1))*100;
    chanSummary(iDataset).s270TO90.propLateChans = (sum(sum(chanProfile(iDataset).s270TO90.nLateChans,2)./96,1)./size(lowTraces.s270TO90,1))*100;
    chanSummary(iDataset).s270TO90.propEarlyLate = (sum(sum(chanProfile(iDataset).s270TO90.nEarlyLate,2)./96,1)./size(lowTraces.s270TO90,1))*100;
    chanSummary(iDataset).s270TO90.propMultiProfile = (sum(sum(chanProfile(iDataset).s270TO90.nMultiProfile,2)./96,1)./size(lowTraces.s270TO90,1))*100;
    chanSummary(iDataset).s270TO90.propNoActivity = (sum(sum(chanProfile(iDataset).s270TO90.nNoActivity,2)./96,1)./size(lowTraces.s270TO90,1))*100;
    
    chanSummary(iDataset).s90TO270.propEarlyChans = (sum(sum(chanProfile(iDataset).s90TO270.nEarlyChans,2)./96,1)./size(lowTraces.s90TO270,1))*100;
    chanSummary(iDataset).s90TO270.propMiddleChans = (sum(sum(chanProfile(iDataset).s90TO270.nMiddleChans,2)./96,1)./size(lowTraces.s90TO270,1))*100;
    chanSummary(iDataset).s90TO270.propLateChans = (sum(sum(chanProfile(iDataset).s90TO270.nLateChans,2)./96,1)./size(lowTraces.s90TO270,1))*100;
    chanSummary(iDataset).s90TO270.propEarlyLate = (sum(sum(chanProfile(iDataset).s90TO270.nEarlyLate,2)./96,1)./size(lowTraces.s90TO270,1))*100;
    chanSummary(iDataset).s90TO270.propMultiProfile = (sum(sum(chanProfile(iDataset).s90TO270.nMultiProfile,2)./96,1)./size(lowTraces.s90TO270,1))*100;
    chanSummary(iDataset).s90TO270.propNoActivity = (sum(sum(chanProfile(iDataset).s90TO270.nNoActivity,2)./96,1)./size(lowTraces.s90TO270,1))*100;
    
    clear s270TO90_Traces; clear s90TO270_Traces;
    
end

%% Take average across datasets and the two types of transitions

earlyChans = [];
middleChans = [];
lateChans = [];

for i = 1:6
earlyChans = [earlyChans;sum(chanProfile(i).s270TO90.nEarlyChans,2);sum(chanProfile(i).s90TO270.nEarlyChans,2)];
middleChans = [middleChans;sum(chanProfile(i).s270TO90.nMiddleChans,2);sum(chanProfile(i).s90TO270.nMiddleChans,2)];
lateChans = [lateChans;sum(chanProfile(i).s270TO90.nLateChans,2);sum(chanProfile(i).s90TO270.nLateChans,2)];
end

mEarly = median(earlyChans);
mMiddle = median(middleChans);
mLate = median(lateChans);

dataMatrix = [earlyChans;middleChans;lateChans];

[names{1:802}] = deal('Early Channels');
[names{803:803+802-1}] = deal('Middle Channels');
[names{1604:1604+802-1}] = deal('Late Channels');

colors(1:802) = ones(573,1);
colors(803:803+802-1) = 2.*ones(573,1);
colors(1604:1604+802-1) = 3.*ones(573,1);

g = gramm('x',names,'y',dataMatrix,'color',colors);
set_order_options(g,'x',0)
g.set_names('x','channel profile','y','number of active channels','size',24)
g.stat_boxplot('width',1.5,'notch','true');
g.update()