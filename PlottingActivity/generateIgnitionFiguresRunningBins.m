function generateIgnitionFiguresRunningBins(dataPath,binWidth)

% This function generates the ingition plot and the ignited hotspots for a
% given dataset. Just pass in the dataPath. the variable that will be
% loaded will be called lfpStatistics and it has a...complicated structure.
% Ask me.

%% Load the dataset

% Load rivalry
load(dataPath{1});

%% Define the usual crap

bins = -500:binWidth:0; % These are the bins in ms. We leave out 400 to 500 because of the filtering.
t = linspace(-500,0,250);
nBins = length(bins);
nSessions = length(lfpStatistics.eventTimes.BR.s270TO90.Pre); % Number of sessions
nChans = length(lfpStatistics.eventTimes.BR.s270TO90.Pre{1}); % Number of channels

%% Collect for PreBR and PrePA

% Compute for Pre-BR 270TO90

meanAmplitudePreBR_270TO90 = zeros(nSessions,250-binWidth,nChans);

for iSession = 1:nSessions
    
    for iChan = 1:nChans
        
        for iBin = 1:250-binWidth
            
            tempTimes = (lfpStatistics.eventTimes.BR.s270TO90.Pre{iSession}{iChan})*1000; % Doesn't taking the absolute reverse the time-points?? Is this why we are seeing this ignition??
            tempAmps = lfpStatistics.eventAmps.BR.s270TO90.Pre{iSession}{iChan};
            idx = tempTimes>=t(iBin) & tempTimes<=t(iBin+binWidth);
            meanAmplitudePreBR_270TO90(iSession,iBin,iChan) = nanmean(tempAmps(idx));
            clear tempAmps; clear tempTimes; clear idx;
            
        end
        
    end
    
end

% Compute for Pre-BR 270TO90

meanAmplitudePreBR_90TO270 = zeros(nSessions,250-binWidth,nChans);

for iSession = 1:nSessions
    
    for iChan = 1:nChans
        
        for iBin = 1:250-binWidth
            
            tempTimes = (lfpStatistics.eventTimes.BR.s90TO270.Pre{iSession}{iChan})*1000; % Doesn't taking the absolute reverse the time-points?? Is this why we are seeing this ignition??
            tempAmps = lfpStatistics.eventAmps.BR.s90TO270.Pre{iSession}{iChan};
            idx = tempTimes>=t(iBin) & tempTimes<=t(iBin+binWidth);
            meanAmplitudePreBR_90TO270(iSession,iBin,iChan) = nanmean(tempAmps(idx));
            clear tempAmps; clear tempTimes; clear idx;
            
        end
        
    end
    
end

% Do PrePA

meanAmplitudePrePA_270TO90 = zeros(nSessions,250-binWidth,nChans);

for iSession = 1:nSessions
    
    for iChan = 1:nChans
        
        for iBin = 1:250-binWidth
            
            tempTimes = (lfpStatistics.eventTimes.PA.s270TO90.Pre{iSession}{iChan})*1000; % Doesn't taking the absolute reverse the time-points?? Is this why we are seeing this ignition??
            tempAmps = lfpStatistics.eventAmps.PA.s270TO90.Pre{iSession}{iChan};
            idx = tempTimes>=t(iBin) & tempTimes<=t(iBin+binWidth);
            meanAmplitudePrePA_270TO90(iSession,iBin,iChan) = nanmean(tempAmps(idx));
            clear tempAmps; clear tempTimes; clear idx;
            
        end
        
    end
    
end

% Compute for Pre-PA 270TO90

meanAmplitudePrePA_90TO270 = zeros(nSessions,250-binWidth,nChans);

for iSession = 1:nSessions
    
    for iChan = 1:nChans
        
        for iBin = 1:250-binWidth
            
            tempTimes = (lfpStatistics.eventTimes.PA.s90TO270.Pre{iSession}{iChan})*1000; % Doesn't taking the absolute reverse the time-points?? Is this why we are seeing this ignition??
            tempAmps = lfpStatistics.eventAmps.PA.s90TO270.Pre{iSession}{iChan};
            idx = tempTimes>=t(iBin) & tempTimes<=t(iBin+binWidth);
            meanAmplitudePrePA_90TO270(iSession,iBin,iChan) = nanmean(tempAmps(idx));
            clear tempAmps; clear tempTimes; clear idx;
            
        end
        
    end
    
end

%% Compute for PrePA vs PreBR, Session by Session

for iSession = 1:nSessions
    
    
    testSessionPA_270TO90 = meanAmplitudePrePA_270TO90(iSession,:,:);
    testSessionPA_270TO90 = squeeze(testSessionPA_270TO90);
    testSessionPA_270TO90 = testSessionPA_270TO90';
    for i = 1:250-binWidth
        meanAmpsPA_270TO90(i) = nanmean(testSessionPA_270TO90(:,i));
    end
    for i = 1:250-binWidth
        idx_PA_270TO90{i,iSession} = find(testSessionPA_270TO90(:,i)>=meanAmpsPA_270TO90(i));
        posChansPA_270TO90(iSession,i) = length(idx_PA_270TO90{i,iSession});
    end
    
    
  testSessionBR_270TO90 = meanAmplitudePreBR_270TO90(iSession,:,:);
    testSessionBR_270TO90 = squeeze(testSessionBR_270TO90);
    testSessionBR_270TO90 = testSessionBR_270TO90';
    for i = 1:250-binWidth
        meanAmpsBR_270TO90(i) = nanmean(testSessionBR_270TO90(:,i));
    end
    for i = 1:250-binWidth
        idx_BR_270TO90{i,iSession} = find(testSessionBR_270TO90(:,i)>=meanAmpsBR_270TO90(i));
        posChansBR_270TO90(iSession,i) = length(idx_BR_270TO90{i,iSession});
    end
    
    testSessionPA_90TO270 = meanAmplitudePrePA_90TO270(iSession,:,:);
    testSessionPA_90TO270 = squeeze(testSessionPA_90TO270);
    testSessionPA_90TO270 = testSessionPA_90TO270';
    for i = 1:250-binWidth
        meanAmpsPA_90TO270(i) = nanmean(testSessionPA_90TO270(:,i));
    end
    for i = 1:250-binWidth
        idx_PA_90TO270{i,iSession} = find(testSessionPA_90TO270(:,i)>=meanAmpsPA_90TO270(i));
        posChansPA_90TO270(iSession,i) = length(idx_PA_90TO270{i,iSession});
    end
    
    
  testSessionBR_90TO270 = meanAmplitudePreBR_90TO270(iSession,:,:);
    testSessionBR_90TO270 = squeeze(testSessionBR_90TO270);
    testSessionBR_90TO270 = testSessionBR_90TO270';
    for i = 1:250-binWidth
        meanAmpsBR_90TO270(i) = nanmean(testSessionBR_90TO270(:,i));
    end
    for i = 1:250-binWidth
        idx_BR_90TO270{i,iSession} = find(testSessionBR_90TO270(:,i)>=meanAmpsBR_90TO270(i));
        posChansBR_90TO270(iSession,i) = length(idx_BR_90TO270{i,iSession});
    end
   
end

%% Plot ignition movies!

% PreBR

for iDataset = 1:nSessions
    
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
    
    % open videofile
    
    filename = ['PreBR_LowFreq_IgnitedChannels_Session' '_' num2str(binWidth) '_ms' num2str(iDataset) '.avi'];
    cd(dataPath{3})
    v = VideoWriter(filename);
    v.FrameRate =15;
    open(v);
    
    % reorder the channels
    
    for iBin = 1:250-binWidth
        
        activeChannels_BR_270TO90 = chan2elec(idx_BR_270TO90{iBin,iDataset},2);
        activeChannels_BR_90TO270 = chan2elec(idx_BR_90TO270{iBin,iDataset},2);
        
        chanColours = nan(nChans,1);
        chanColours(activeChannels_BR_270TO90) = 0;
        chanColours(activeChannels_BR_90TO270) = 1;
        commonChans = intersect(activeChannels_BR_270TO90, activeChannels_BR_90TO270);
        chanColours(commonChans) = 0.5;
        image_mapArray(chanColours, map, 1);
        colormap jet
        caxis([0 1])
        xlabel('X-Electrodes')
        ylabel('Y-Electrodes')
        title(['PreBR Low Frequency Ignition Session # : ' ' ' num2str(iDataset) ' & bin # :' ' ' num2str(iBin)])
        writeVideo(v, getframe(gcf));
        
    end
    close(v);
    close all;
    
    filename = ['PrePA_LowFreq_IgnitedChannels_Session' '_' num2str(binWidth) '_ms' num2str(iDataset) '.avi'];
    cd(dataPath{3})
    v = VideoWriter(filename);
    v.FrameRate = 15;
    open(v);
    
    for iBin = 1:250-binWidth
        
        activeChannels_PA_270TO90 = chan2elec(idx_PA_270TO90{iBin,iDataset},2);
        activeChannels_PA_90TO270 = chan2elec(idx_PA_90TO270{iBin,iDataset},2);
        
        chanColours = nan(nChans,1);
        chanColours(activeChannels_PA_270TO90) = 1;
        chanColours(activeChannels_PA_90TO270) = 0;
        commonChans = intersect(activeChannels_PA_270TO90, activeChannels_PA_90TO270);
        chanColours(commonChans) = 0.5;
        image_mapArray(chanColours, map, 1);
        colormap jet
        caxis([0 1])
        xlabel('X-Electrodes')
        ylabel('Y-Electrodes')
        title(['PrePA Low Frequency Ignition Session # : ' ' ' num2str(iDataset) ' & bin # :' ' ' num2str(iBin)])
        writeVideo(v, getframe(gcf));
        
    end
    
    close(v);
    close all;
    
end



%% Collect Piecemeal

% Load piecemeal

load(dataPath{2})

meanAmplitudePrePM = zeros(nSessions,nBins-1,nChans);

for iSession = 1:nSessions
    
    for iChan = 1:nChans
        
        for iBin = 1:250-binWidth
            
            tempTimes = (lfpStatistics.eventTimes.BR.Pre{iSession}{iChan})*1000; % Doesn't taking the absolute reverse the time-points?? Is this why we are seeing this ignition??
            tempAmps = lfpStatistics.eventAmps.BR.Pre{iSession}{iChan};
            idx = tempTimes>=t(iBin) & tempTimes<=t(iBin+1);
            meanAmplitudePrePM(iSession,iBin,iChan) = nanmean(tempAmps(idx));
            clear tempAmps; clear tempTimes; clear idx;
            
        end
        
    end
    
end

%% Compute for Piecemeal session by session

for iSession = 1:nSessions

    testSession = meanAmplitudePrePM(iSession,:,:);
    testSession = squeeze(testSession);
    testSession = testSession';
    for i = 1:250-binWidth
        meanAmps(i) = nanmean(testSession(:,i));
    end
    for i = 1:250-binWidth
        idx{i,iSession} = find(testSession(:,i)>=meanAmps(i));
        posChans(iSession,i) = length(idx{i,iSession});
    end

end

for iDataset = 1:nSessions
    
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
    
    % open videofile
    
    filename = ['PrePM_LowFreq_IgnitedChannels_Session' '_' num2str(binWidth) '_ms' num2str(iDataset) '.avi'];
    cd(dataPath{3})
    v = VideoWriter(filename);
    v.FrameRate =15;
    open(v);
    
    % reorder the channels
    
    for iBin = 1:250-binWidth
        
        activeChannels= chan2elec(idx{iBin,iDataset},2);
        
        chanColours = nan(nChans,1);
        chanColours(activeChannels) = 1;
        image_mapArray(chanColours, map, 1);
        colormap jet
        caxis([0 1])
        xlabel('X-Electrodes')
        ylabel('Y-Electrodes')
        title(['PrePM Low Frequency Ignition Session # : ' ' ' num2str(iDataset) ' & bin # :' ' ' num2str(iBin)])
        writeVideo(v, getframe(gcf));
        
    end
    close(v);
    close all;
    
end
%% Plot all together

posChansPiecemeal = posChans;

fn = ['Ignition_RunningBins_' num2str(binWidth) 'ms.mat'];
save(fn);

figure(2)
plot(smooth(nanmean(posChansBR_270TO90,1)),'-r','LineWidth',2)
hold on
plot(smooth(nanmean(posChansBR_90TO270,1)),'-b','LineWidth',2)
plot(smooth(nanmean(posChansPA_270TO90,1)),'--r','LineWidth',1)
hold on
plot(smooth(nanmean(posChansPA_90TO270,1)),'--b','LineWidth',1)
plot(nanmean(posChansPiecemeal,1),'--','Color',[0.5 0.5 0.5],'LineWidth',1.25)
xlabel('running bins approaching switch')
ylabel('Number of channels Activated per Bin')
title('Grand Average Ignition')
grid on
legend('PreBR - 270TO90','PreBR - 90TO270','PrePA - 270TO90','PrePA - 90TO270','PrePM')
pause; clf;

end