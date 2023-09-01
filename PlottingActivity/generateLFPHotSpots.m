function generateLFPHotSpots(duration,filtType)

% This code collects all computed spectrograms across datasets and then
% creates a grand average of selective sites during Riv and during PA_FS
% for comparison

%% Enumerate the datasets

% traces_ according to Selectivity during Rivalry

datasetsDS{1} = ['E:\Data\H07\12-06-2016\PFC\Bfsgrad1\LFPStatistics\blpCharacteristics_' num2str(duration) 'ms_' filtType '.mat'];
%datasetsDS{2} = ['E:\Data\H07\13-07-2016\PFC\Bfsgrad1\LFPStatistics\blpCharacteristics_' num2str(duration) 'ms_' filtType '.mat'];
%datasetsDS{3} = ['E:\Data\H07\20161019\PFC\Bfsgrad1\LFPStatistics\blpCharacteristics_' num2str(duration) 'ms_' filtType '.mat'];
%datasetsDS{4} = ['E:\Data\H07\20161025\PFC\Bfsgrad1\LFPStatistics\blpCharacteristics_' num2str(duration) 'ms_' filtType '.mat'];
%datasetsDS{5} = ['E:\Data\A11\20170305\PFC\Bfsgrad1\LFPStatistics\blpCharacteristics_' num2str(duration) 'ms_' filtType '.mat'];
%datasetsDS{6} = ['E:\Data\A11\20170302\PFC\Bfsgrad1\LFPStatistics\blpCharacteristics_' num2str(duration) 'ms_' filtType '.mat'];

%% Plot grand average for DomSels

% collect

for iDataset = 1:length(datasetsDS)
    
    load(datasetsDS{iDataset});
    
    if iDataset <= 4
        load('E:\Data\H07\H07ElectrodeInfo.mat')
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
        load('E:\Data\A11\A11ElectrodeInfo.mat')
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
    
    folderName = ['E:\Data\Results\Traces\Maps\HotSpots\' filtType '\Dataset' num2str(iDataset) '\' num2str(duration/1000) 's'];
    mkdir(folderName)
    cd(folderName)

    sigLength = size(blpCharacteristics(1).BR.dom90.traces,2);
    t = linspace((-sigLength+1)/1000,(sigLength-1)/1000,sigLength);
    
    figure(1)
    suptitle(['Dataset # : ' num2str(iDataset) ' - ' '90 Dominance BR Pre Switch ' filtType])
    
    for iElec = 1:96
        elec(iElec) = chan2elec(iElec,2);

            br90(iElec)=(1/(length(t)/2)).*sum(nanmean(blpCharacteristics(iElec).BR.dom90.traces(:,1:ceil(length(t)/2),1).^2));

    end
    br90 = zscore(br90);
    br90elec = br90(elec);
    image_mapArray(br90elec', map, 1);
    colormap jet
    colorbar
    caxis([-2.5 2.5])
    saveas(gcf,'dom90_BR_Pre','png')
    close all;
    
    figure(2)
    suptitle(['Dataset # : ' num2str(iDataset) ' - ' '90 Dominance BR Post Switch ' filtType])
    
    for iElec = 1:96
        elec(iElec) = chan2elec(iElec,2);

            br90(iElec)=(1/(length(t)/2)).*sum(nanmean(blpCharacteristics(iElec).BR.dom90.traces(:,ceil(length(t)/2)+1:end,1).^2));

    end
    br90 = zscore(br90);
    br90elec = br90(elec);
    image_mapArray(br90elec', map, 1);
    colormap jet
    colorbar
    caxis([-2.5 2.5])
    saveas(gcf,'dom90_BR_Post','png')
    close all;
    
    figure(3)
    suptitle(['Dataset # : ' num2str(iDataset) ' - ' '90 Dominance PA Post Switch ' filtType])
    
   for iElec = 1:96
        elec(iElec) = chan2elec(iElec,2);

            pa90(iElec)=(1/(length(t)/2)).*sum(nanmean(blpCharacteristics(iElec).PA.dom90.traces(:,ceil(length(t)/2):end,1).^2));

    end
    pa90 = zscore(pa90);
    pa90elec = pa90(elec);
    image_mapArray(pa90elec', map, 1);
    colormap jet
    colorbar
    caxis([-2.5 2.5])
    saveas(gcf,'dom90_PA_Post','png')
    close all;
    
    figure(4)
    suptitle(['Dataset # : ' num2str(iDataset) ' - ' '90 Dominance PA Pre Switch ' filtType])
    
   for iElec = 1:96
        elec(iElec) = chan2elec(iElec,2);

            pa90(iElec)=(1/(length(t)/2)).*sum(nanmean(blpCharacteristics(iElec).PA.dom90.traces(:,1:ceil(length(t)/2),1).^2));

    end
    pa90 = zscore(pa90);
    pa90elec = pa90(elec);
    image_mapArray(pa90elec', map, 1);
    colormap jet
    colorbar
    caxis([-2.5 2.5])
    saveas(gcf,'dom90_PA_Pre','png')
    close all;
    
    figure(5)
    suptitle(['Dataset # : ' num2str(iDataset) ' - ' '270 Dominance BR Pre Switch ' filtType])
    
    for iElec = 1:96
        elec(iElec) = chan2elec(iElec,2);

            br270(iElec)=(1/(length(t)/2)).*sum(nanmean(blpCharacteristics(iElec).BR.dom270.traces(:,1:ceil(length(t)/2),1).^2));

    end
    br270 = zscore(br270);
    br270elec = br270(elec);
    image_mapArray(br270elec', map, 1);
    colormap jet
    colorbar
    caxis([-2.5 2.5])
    saveas(gcf,'dom270_BR_Pre','png')
    close all;
    
    figure(6)
    suptitle(['Dataset # : ' num2str(iDataset) ' - ' '270 Dominance BR Post Switch ' filtType])
    
    for iElec = 1:96
        elec(iElec) = chan2elec(iElec,2);

            br270(iElec)=(1/(length(t)/2)).*sum(nanmean(blpCharacteristics(iElec).BR.dom270.traces(:,ceil(length(t)/2)+1:end,1).^2));

    end
    br270 = zscore(br270);
    br270elec = br270(elec);
    image_mapArray(br270elec', map, 1);
    colormap jet
    colorbar
    caxis([-2.5 2.5])
    saveas(gcf,'dom270_BR_Post','png')
    close all;
    
    figure(7)
    suptitle(['Dataset # : ' num2str(iDataset) ' - ' '270 Dominance PA Post Switch ' filtType])
    
   for iElec = 1:96
        elec(iElec) = chan2elec(iElec,2);

            pa270(iElec)=(1/(length(t)/2)).*sum(nanmean(blpCharacteristics(iElec).PA.dom270.traces(:,ceil(length(t)/2):end,1).^2));

    end
    pa270 = zscore(pa270);
    pa270elec = pa270(elec);
    image_mapArray(pa270elec', map, 1);
    colormap jet
    colorbar
    caxis([-2.5 2.5])
    saveas(gcf,'dom270_PA_Post','png')
    close all;
    
    figure(8)
    suptitle(['Dataset # : ' num2str(iDataset) ' - ' '270 Dominance PA Pre Switch ' filtType])
    
   for iElec = 1:96
        elec(iElec) = chan2elec(iElec,2);

            pa270(iElec)=(1/(length(t)/2)).*sum(nanmean(blpCharacteristics(iElec).PA.dom270.traces(:,1:ceil(length(t)/2),1).^2));

    end
    pa270 = zscore(pa270);
    pa270elec = pa270(elec);
    image_mapArray(pa270elec', map, 1);
    colormap jet
    colorbar
    caxis([-2.5 2.5])
    saveas(gcf,'dom270_PA_Pre','png')
    close all;
    
end
