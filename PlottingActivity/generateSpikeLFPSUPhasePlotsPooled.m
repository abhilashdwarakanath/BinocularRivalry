function generateSpikeLFPSUPhasePlotsPooled(duration)

%% Datasets and SU info

channelsPreBRSigEng(1).s270TO90=[1, 7, 19, 20, 32, 33, 34, 41, 45, 52, 56, 59, 62, 64, 77];
channelsPreBRSigEng(1).s90TO270=[5, 12, 14, 15, 42, 48, 49, 50, 55, 65, 66, 82, 87, 88, 89, 91, 93];
channelsPreBRSigEng(1).sboth=[2, 35, 36, 37, 38, 39, 40, 43, 44, 46, 47, 51, 53, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 78, 79, 80, 81, 83, 92, 96];
channelsPreBRSigEng(2).s270TO90=[5, 7, 9, 23, 24, 29, 55, 61, 64, 65, 70, 71, 73, 74, 75, 87, 91, 92, 93, 94, 96];
channelsPreBRSigEng(2).s90TO270=[3, 14, 20, 26, 38, 39, 40, 46, 47, 51, 57, 59, 60, 67, 68, 79, 82, 83, 84];
channelsPreBRSigEng(2).sboth=[1, 2, 4, 6, 11, 15, 18, 19, 21, 22, 33, 35, 36, 37, 42, 43, 44, 48, 50, 52, 66, 69, 72, 76, 77, 78, 80];
channelsPreBRSigEng(3).s270TO90=[21, 40, 41, 42, 43, 47, 49, 53, 54, 55, 56, 57, 59, 60, 61, 63, 64, 82, 91, 93];
channelsPreBRSigEng(3).s90TO270=[1, 2, 3, 4, 11, 15, 33, 36, 37, 46, 48, 65, 66, 67, 68, 69, 70, 71, 72, 81, 86];
channelsPreBRSigEng(3).sboth=[6, 12, 13, 14, 16, 18, 20, 22, 23, 44, 50, 51, 52, 73, 74, 76, 77, 78, 79, 80, 83, 84, 87, 88, 89, 90, 92, 94, 96];
channelsPreBRSigEng(4).s270TO90=[21, 25, 32, 41, 44, 45, 49, 51, 55, 57, 58, 59, 60, 62, 65, 77, 79, 80, 81, 82, 83, 84, 85, 86, 93, 96];
channelsPreBRSigEng(4).s90TO270=[1, 6, 7, 8, 9, 10, 11, 13, 14, 15, 16, 17, 19, 23, 24, 26, 27, 29, 37, 38, 47, 52, 67, 69, 72, 76];
channelsPreBRSigEng(4).sboth=[12, 18, 20, 22, 46, 53, 61, 63, 64, 70, 71, 73, 74, 75, 78, 87, 88, 89, 90, 91, 94];
channelsPreBRSigEng(5).s270TO90=[7, 9, 43, 45, 46, 59, 67, 71, 72, 76, 82, 83, 84, 85, 86, 89, 90, 91];
channelsPreBRSigEng(5).s90TO270=[3, 4, 6, 8, 13, 14, 18, 33, 34, 36, 38, 39, 54, 55, 65, 66, 68];
channelsPreBRSigEng(5).sboth=[5, 10, 11, 12, 15, 19, 21, 22, 23, 24, 25, 26, 27, 35, 40, 42, 44, 47, 50, 56, 58, 60, 61, 62, 74];
channelsPreBRSigEng(6).s270TO90=[5, 7, 11, 13, 14, 15, 20, 33, 35, 36, 37, 38, 39, 40, 43, 65, 67, 68, 70, 72, 75, 79, 81];
channelsPreBRSigEng(6).s90TO270=[4, 12, 21, 22, 23, 25, 26, 27, 31, 32, 45, 48, 51, 53, 54, 55, 56, 58, 60, 61, 62, 63, 73, 83, 87, 89];
channelsPreBRSigEng(6).sboth=[3, 8, 9, 10, 16, 18, 34, 44, 50, 66, 74, 77, 78, 80, 82, 85, 86];

dates{1} = 'H07\12-06-2016';
dates{2} = 'H07\13-07-2016';
dates{3} = 'H07\20161019';
dates{4} = 'H07\20161025';
dates{5} = 'A11\20170305';
dates{6} = 'A11\20170302';

nDatasets = length(dates);

ts = num2str(duration/1000);

cd(['B:\Results\SpikeLFPCoupling\PhaseDistribution\' ts 's'])
load evtTriggered_SU_low.mat
%% 270TO90 modulated channels

phaseDist_P2NP_90 = [];
phaseDist_NP2P_90 = [];

phaseDist_P2NP_270 = [];
phaseDist_NP2P_270 = [];

for iDataset = 1:nDatasets
    
    clear prefInfo;
    cd(['B:\Results\' dates{iDataset} '\Bfsgrad\PFC\SUA\Preference_Arrays\cSwitch'])
    load([num2str(duration) '_250_' num2str(duration) '_DF_pref_array_switch.mat'])
    cd(['B:\' dates{iDataset} '\PFC\Bfsgrad1'])
    load('Su_info.mat')
    prefInfo = [table2array(pref_array_switch.bs_Phy_table(:,1:3)) table2array(pref_array_switch.bs_Phy_table(:,5))];
    prefInfo = cell2mat(prefInfo);
    prefInfo = [prefInfo SU_info];
    
    
    [elec, su] = size(spikeLFPCoupling(iDataset).PhaseDistribution);
    
    for i = channelsPreBRSigEng(iDataset).s270TO90
        for j = 1:su
            if isstruct(spikeLFPCoupling(iDataset).PhaseDistribution{i,j})
                [idx ~] = find(prefInfo(:,5)==i & prefInfo(:,6)==j)
                if prefInfo(idx,2) == 1
                    
                    prefSU = prefInfo(idx,3);
                    
                    if prefSU == 1 % Downward preference
                        tempDistP2NP_270 = spikeLFPCoupling(iDataset).PhaseDistribution{i,j}.BR.s270TO90.Pre.phaseDist;
                        phaseDist_P2NP_270 = [phaseDist_P2NP_270 tempDistP2NP_270];
                        tempDistNP2P_270 = spikeLFPCoupling(iDataset).PhaseDistribution{i,j}.BR.s90TO270.Pre.phaseDist;
                        phaseDist_NP2P_270 = [phaseDist_NP2P_270 tempDistNP2P_270];
                    else % Upward Preference
                        tempDistP2NP_90 = spikeLFPCoupling(iDataset).PhaseDistribution{i,j}.BR.s90TO270.Pre.phaseDist;
                        phaseDist_P2NP_90 = [phaseDist_P2NP_90 tempDistP2NP_90];
                        tempDistNP2P_90 = spikeLFPCoupling(iDataset).PhaseDistribution{i,j}.BR.s270TO90.Pre.phaseDist;
                        phaseDist_NP2P_90 = [phaseDist_NP2P_90 tempDistNP2P_90];
                    end
                    
                end
                
            end
            
        end
        
    end
    
end

figure('units','normalized','outerposition',[0 0 1 1])
subplot(3,2,1)
polarhistogram(rad2deg(wrapTo2Pi(phaseDist_P2NP_270)),16,'Normalization','pdf')
hold on
polarhistogram(rad2deg(wrapTo2Pi(phaseDist_NP2P_270)),16,'Normalization','pdf')
title('270TO90 Modulated Chans - 270TO90 Switch')

subplot(3,2,2)
polarhistogram(rad2deg(wrapTo2Pi(phaseDist_P2NP_90)),16,'Normalization','pdf')
hold on
polarhistogram(rad2deg(wrapTo2Pi(phaseDist_NP2P_90)),16,'Normalization','pdf')
title('270TO90 Modulated Chans - 90TO270 Switch')

clear phaseDist_NP2P_270
clear phaseDist_P2NP_270

clear phaseDist_NP2P_90
clear phaseDist_P2NP_90

phaseDist_P2NP_90 = [];
phaseDist_NP2P_90 = [];

phaseDist_P2NP_270 = [];
phaseDist_NP2P_270 = [];

for iDataset = 1:nDatasets
    
    clear prefInfo;
    cd(['B:\Results\' dates{iDataset} '\Bfsgrad\PFC\SUA\Preference_Arrays\cSwitch'])
    load([num2str(duration) '_250_' num2str(duration) '_DF_pref_array_switch.mat'])
    cd(['B:\' dates{iDataset} '\PFC\Bfsgrad1'])
    load('Su_info.mat')
    prefInfo = [table2array(pref_array_switch.bs_Phy_table(:,1:3)) table2array(pref_array_switch.bs_Phy_table(:,5))];
    prefInfo = cell2mat(prefInfo);
    prefInfo = [prefInfo SU_info];
    [elec, su] = size(spikeLFPCoupling(iDataset).PhaseDistribution);
    for i = channelsPreBRSigEng(iDataset).s90TO270
        for j = 1:su
            if isstruct(spikeLFPCoupling(iDataset).PhaseDistribution{i,j})
                [idx ~] = find(prefInfo(:,5)==i & prefInfo(:,6)==j)
                if prefInfo(idx,2) == 1
                    
                    prefSU = prefInfo(idx,3);
                    
                    if prefSU == 1 % Downward preference
                        tempDistP2NP_270 = spikeLFPCoupling(iDataset).PhaseDistribution{i,j}.BR.s270TO90.Pre.phaseDist;
                        phaseDist_P2NP_270 = [phaseDist_P2NP_270 tempDistP2NP_270];
                        tempDistNP2P_270 = spikeLFPCoupling(iDataset).PhaseDistribution{i,j}.BR.s90TO270.Pre.phaseDist;
                        phaseDist_NP2P_270 = [phaseDist_NP2P_270 tempDistNP2P_270];
                    else % Upward Preference
                        tempDistP2NP_90 = spikeLFPCoupling(iDataset).PhaseDistribution{i,j}.BR.s90TO270.Pre.phaseDist;
                        phaseDist_P2NP_90 = [phaseDist_P2NP_90 tempDistP2NP_90];
                        tempDistNP2P_90 = spikeLFPCoupling(iDataset).PhaseDistribution{i,j}.BR.s270TO90.Pre.phaseDist;
                        phaseDist_NP2P_90 = [phaseDist_NP2P_90 tempDistNP2P_90];
                    end
                    
                end
                
            end
            
        end
        
    end
    
end

subplot(3,2,3)
polarhistogram(rad2deg(wrapTo2Pi(phaseDist_P2NP_270)),16,'Normalization','pdf')
hold on
polarhistogram(rad2deg(wrapTo2Pi(phaseDist_NP2P_270)),16,'Normalization','pdf')
title('90TO270 Modulated Chans - 270TO90 Switch')

subplot(3,2,4)
polarhistogram(rad2deg(wrapTo2Pi(phaseDist_P2NP_90)),16,'Normalization','pdf')
hold on
polarhistogram(rad2deg(wrapTo2Pi(phaseDist_NP2P_90)),16,'Normalization','pdf')
title('90TO270 Modulated Chans - 90TO270 Switch')

clear phaseDist_NP2P_270
clear phaseDist_P2NP_270

clear phaseDist_NP2P_90
clear phaseDist_P2NP_90

phaseDist_P2NP_90 = [];
phaseDist_NP2P_90 = [];

phaseDist_P2NP_270 = [];
phaseDist_NP2P_270 = [];

for iDataset = 1:nDatasets
    
    clear prefInfo;
    cd(['B:\Results\' dates{iDataset} '\Bfsgrad\PFC\SUA\Preference_Arrays\cSwitch'])
    load([num2str(duration) '_250_' num2str(duration) '_DF_pref_array_switch.mat'])
    cd(['B:\' dates{iDataset} '\PFC\Bfsgrad1'])
    load('Su_info.mat')
    prefInfo = [table2array(pref_array_switch.bs_Phy_table(:,1:3)) table2array(pref_array_switch.bs_Phy_table(:,5))];
    prefInfo = cell2mat(prefInfo);
    prefInfo = [prefInfo SU_info];
    
    [elec, su] = size(spikeLFPCoupling(iDataset).PhaseDistribution);
    for i = channelsPreBRSigEng(iDataset).sboth
        for j = 1:su
            if isstruct(spikeLFPCoupling(iDataset).PhaseDistribution{i,j})
                [idx ~] = find(prefInfo(:,5)==i & prefInfo(:,6)==j)
                if prefInfo(idx,2) == 1
                    
                    prefSU = prefInfo(idx,3); % Collect the actual preference
                    
                    if prefSU == 1 % Downward preference
                        tempDistP2NP_270 = spikeLFPCoupling(iDataset).PhaseDistribution{i,j}.BR.s270TO90.Pre.phaseDist;
                        phaseDist_P2NP_270 = [phaseDist_P2NP_270 tempDistP2NP_270];
                        tempDistNP2P_270 = spikeLFPCoupling(iDataset).PhaseDistribution{i,j}.BR.s90TO270.Pre.phaseDist;
                        phaseDist_NP2P_270 = [phaseDist_NP2P_270 tempDistNP2P_270];
                    else % Upward Preference
                        tempDistP2NP_90 = spikeLFPCoupling(iDataset).PhaseDistribution{i,j}.BR.s90TO270.Pre.phaseDist;
                        phaseDist_P2NP_90 = [phaseDist_P2NP_90 tempDistP2NP_90];
                        tempDistNP2P_90 = spikeLFPCoupling(iDataset).PhaseDistribution{i,j}.BR.s270TO90.Pre.phaseDist;
                        phaseDist_NP2P_90 = [phaseDist_NP2P_90 tempDistNP2P_90];
                    end
                    
                end
                
            end
            
        end
        
    end
    
end

subplot(3,2,5)
polarhistogram(rad2deg(wrapTo2Pi(phaseDist_P2NP_270)),16,'Normalization','pdf')
hold on
polarhistogram(rad2deg(wrapTo2Pi(phaseDist_NP2P_270)),16,'Normalization','pdf')
title('Both Modulated Chans - 270TO90 Switch')

subplot(3,2,6)
polarhistogram(rad2deg(wrapTo2Pi(phaseDist_P2NP_90)),16,'Normalization','pdf')
hold on
polarhistogram(rad2deg(wrapTo2Pi(phaseDist_NP2P_90)),16,'Normalization','pdf')
title('Both Modulated Chans - 90TO270 Switch')
legend('P2NP','NP2P')
suptitle(['Pooled SU Spike Phase Distributions'])
cd(['B:\Results\SpikeLFPCoupling\PhaseDistribution\' ts 's'])
fn = ['spikeLFPPhasePlot_Pooled' '_' num2str(duration) 'ms'];
saveas(gcf,fn,'png');
saveas(gcf,fn,'fig');

end

