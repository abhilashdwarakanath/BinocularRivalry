clear all
clc
close all

%% Datasets and SU info

channelsPreBRSigEng(1).s270TO90=[1, 7, 19, 20, 32, 33, 34, 41, 45, 52, 56, 59, 62, 64, 77];
channelsPreBRSigEng(1).s90TO270=[5, 12, 14, 15, 42, 48, 49, 50, 55, 65, 66, 82, 87, 88, 89, 91, 93];
channelsPreBRSigEng(1).sboth=[2, 35, 36, 37, 38, 39, 40, 43, 44, 46, 47, 51, 53, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 78, 79, 80, 81, 83, 92, 96];

cd B:\Results\H07\12-06-2016\Bfsgrad\PFC\SUA\Preference_Arrays\cSwitch
load 500_250_500_DF_pref_array_switch.mat
load Su_info.mat

cd B:\Results\SpikeLFPCoupling\PhaseDistribution\0.5s
load SpikeLFPCoupling_SU_Low.mat
%% 270TO90 modulated channels

clear phaseDist_NP2P_270
clear phaseDist_P2NP_270

clear phaseDist_NP2P_90
clear phaseDist_P2NP_90

for iDataset = 1:1
    phaseDist_P2NP_90 = [];
    phaseDist_NP2P_90 = [];
    
    phaseDist_P2NP_270 = [];
    phaseDist_NP2P_270 = [];
    [elec, su] = size(spikeLFPCoupling(iDataset).PhaseDistribution);
    for i = channelsPreBRSigEng(iDataset).s270TO90
        for j = 1:su
            if isstruct(spikeLFPCoupling(iDataset).PhaseDistribution{i,j})
                [idx ~] = find(prefInfo(:,5)==i & prefInfo(:,6)==j)
                if prefInfo(idx,2) == 1
                    
                    prefSU = prefInfo(idx,3);
                    
                    if prefSU == 1 % Downward preference
                        tempDistP2NP_270 = spikeLFPCoupling(iDataset).PhaseDistribution{i,j}.PA.s270TO90.Post.phaseDist;
                        phaseDist_P2NP_270 = [phaseDist_P2NP_270 tempDistP2NP_270];
                        tempDistNP2P_270 = spikeLFPCoupling(iDataset).PhaseDistribution{i,j}.PA.s90TO270.Post.phaseDist;
                        phaseDist_NP2P_270 = [phaseDist_NP2P_270 tempDistNP2P_270];
                    else % Upward Preference
                        tempDistP2NP_90 = spikeLFPCoupling(iDataset).PhaseDistribution{i,j}.PA.s270TO90.Post.phaseDist;
                        phaseDist_P2NP_90 = [phaseDist_P2NP_90 tempDistP2NP_90];
                        tempDistNP2P_90 = spikeLFPCoupling(iDataset).PhaseDistribution{i,j}.PA.s90TO270.Post.phaseDist;
                        phaseDist_NP2P_90 = [phaseDist_NP2P_90 tempDistNP2P_90];
                    end
                    
                end
                
            end
            
        end
        
    end
    
end

    figure(3)
    subplot(1,2,1)
    polarhistogram(rad2deg(wrapTo2Pi(phaseDist_P2NP_270)),24,'Normalization','pdf')
    hold on
    polarhistogram(rad2deg(wrapTo2Pi(phaseDist_NP2P_270)),24,'Normalization','pdf')
    title('270TO90 Switch')
    
    subplot(1,2,2)
    polarhistogram(rad2deg(wrapTo2Pi(phaseDist_P2NP_90)),24,'Normalization','pdf')
    hold on
    polarhistogram(rad2deg(wrapTo2Pi(phaseDist_NP2P_90)),24,'Normalization','pdf')
    title('90TO270 Switch')
    legend('P2NP','NP2P')
    suptitle(['PA Session #'  num2str(iDataset) ' ' '270TO90 LF Modulated'])
    
%% 90TO270 Modulated Channels

clear phaseDist_NP2P_270
clear phaseDist_P2NP_270

clear phaseDist_NP2P_90
clear phaseDist_P2NP_90

for iDataset = 1:1
    phaseDist_P2NP_90 = [];
    phaseDist_NP2P_90 = [];
    
    phaseDist_P2NP_270 = [];
    phaseDist_NP2P_270 = [];
    [elec, su] = size(spikeLFPCoupling(iDataset).PhaseDistribution);
    for i = channelsPreBRSigEng(iDataset).s90TO270
        for j = 1:su
            if isstruct(spikeLFPCoupling(iDataset).PhaseDistribution{i,j})
                [idx ~] = find(prefInfo(:,5)==i & prefInfo(:,6)==j)
                if prefInfo(idx,2) == 1
                    
                    prefSU = prefInfo(idx,3);
                    
                    if prefSU == 1 % Downward preference
                        tempDistP2NP_270 = spikeLFPCoupling(iDataset).PhaseDistribution{i,j}.PA.s270TO90.Post.phaseDist;
                        phaseDist_P2NP_270 = [phaseDist_P2NP_270 tempDistP2NP_270];
                        tempDistNP2P_270 = spikeLFPCoupling(iDataset).PhaseDistribution{i,j}.PA.s90TO270.Post.phaseDist;
                        phaseDist_NP2P_270 = [phaseDist_NP2P_270 tempDistNP2P_270];
                    else % Upward Preference
                        tempDistP2NP_90 = spikeLFPCoupling(iDataset).PhaseDistribution{i,j}.PA.s270TO90.Post.phaseDist;
                        phaseDist_P2NP_90 = [phaseDist_P2NP_90 tempDistP2NP_90];
                        tempDistNP2P_90 = spikeLFPCoupling(iDataset).PhaseDistribution{i,j}.PA.s90TO270.Post.phaseDist;
                        phaseDist_NP2P_90 = [phaseDist_NP2P_90 tempDistNP2P_90];
                    end
                    
                end
                
            end
            
        end
        
    end
    
end

    figure(4)
    subplot(1,2,1)
    polarhistogram(rad2deg(wrapTo2Pi(phaseDist_P2NP_270)),24,'Normalization','pdf')
    hold on
    polarhistogram(rad2deg(wrapTo2Pi(phaseDist_NP2P_270)),24,'Normalization','pdf')
    title('270TO90 Switch')
    
    subplot(1,2,2)
    polarhistogram(rad2deg(wrapTo2Pi(phaseDist_P2NP_90)),24,'Normalization','pdf')
    hold on
    polarhistogram(rad2deg(wrapTo2Pi(phaseDist_NP2P_90)),24,'Normalization','pdf')
    title('90TO270 Switch')
    legend('P2NP','NP2P')
    suptitle(['PA Session #'  num2str(iDataset) ' ' '90TO270 LF Modulated'])
    
%% Both modulated channels

clear phaseDist_NP2P_270
clear phaseDist_P2NP_270

clear phaseDist_NP2P_90
clear phaseDist_P2NP_90

for iDataset = 1:1
    phaseDist_P2NP_90 = [];
    phaseDist_NP2P_90 = [];
    
    phaseDist_P2NP_270 = [];
    phaseDist_NP2P_270 = [];
    [elec, su] = size(spikeLFPCoupling(iDataset).PhaseDistribution);
    for i = channelsPreBRSigEng(iDataset).sboth
        for j = 1:su
            if isstruct(spikeLFPCoupling(iDataset).PhaseDistribution{i,j})
                [idx ~] = find(prefInfo(:,5)==i & prefInfo(:,6)==j)
                if prefInfo(idx,2) == 1
                    
                    prefSU = prefInfo(idx,3); % Collect the actual preference
                    
                    if prefSU == 1 % Downward preference
                        tempDistP2NP_270 = spikeLFPCoupling(iDataset).PhaseDistribution{i,j}.PA.s270TO90.Post.phaseDist;
                        phaseDist_P2NP_270 = [phaseDist_P2NP_270 tempDistP2NP_270];
                        tempDistNP2P_270 = spikeLFPCoupling(iDataset).PhaseDistribution{i,j}.PA.s90TO270.Post.phaseDist;
                        phaseDist_NP2P_270 = [phaseDist_NP2P_270 tempDistNP2P_270];
                    else % Upward Preference
                        tempDistP2NP_90 = spikeLFPCoupling(iDataset).PhaseDistribution{i,j}.PA.s270TO90.Post.phaseDist;
                        phaseDist_P2NP_90 = [phaseDist_P2NP_90 tempDistP2NP_90];
                        tempDistNP2P_90 = spikeLFPCoupling(iDataset).PhaseDistribution{i,j}.PA.s90TO270.Post.phaseDist;
                        phaseDist_NP2P_90 = [phaseDist_NP2P_90 tempDistNP2P_90];
                    end
                    
                end
                
            end
            
        end
        
    end
    
end

    figure(7)
    subplot(1,2,1)
    polarhistogram(rad2deg(wrapTo2Pi(phaseDist_P2NP_270)),24,'Normalization','pdf')
    hold on
    polarhistogram(rad2deg(wrapTo2Pi(phaseDist_NP2P_270)),24,'Normalization','pdf')
    title('270TO90 Switch')
    
    subplot(1,2,2)
    polarhistogram(rad2deg(wrapTo2Pi(phaseDist_P2NP_90)),24,'Normalization','pdf')
    hold on
    polarhistogram(rad2deg(wrapTo2Pi(phaseDist_NP2P_90)),24,'Normalization','pdf')
    title('90TO270 Switch')
    legend('P2NP','NP2P')
    suptitle(['PA Session #'  num2str(iDataset) ' ' 'Both Modulated'])
%% All Channels

clear phaseDist_NP2P_270
clear phaseDist_P2NP_270

clear phaseDist_NP2P_90
clear phaseDist_P2NP_90

for iDataset = 1:1
    phaseDist_P2NP_90 = [];
    phaseDist_NP2P_90 = [];
    
    phaseDist_P2NP_270 = [];
    phaseDist_NP2P_270 = [];
    [elec, su] = size(spikeLFPCoupling(iDataset).PhaseDistribution);
    for i = 1:96
        for j = 1:su
            if isstruct(spikeLFPCoupling(iDataset).PhaseDistribution{i,j})
                [idx ~] = find(prefInfo(:,5)==i & prefInfo(:,6)==j)
                if prefInfo(idx,2) == 1
                    
                    prefSU = prefInfo(idx,3);
                    
                    if prefSU == 1 % Downward preference
                        tempDistP2NP_270 = spikeLFPCoupling(iDataset).PhaseDistribution{i,j}.PA.s270TO90.Post.phaseDist;
                        phaseDist_P2NP_270 = [phaseDist_P2NP_270 tempDistP2NP_270];
                        tempDistNP2P_270 = spikeLFPCoupling(iDataset).PhaseDistribution{i,j}.PA.s90TO270.Post.phaseDist;
                        phaseDist_NP2P_270 = [phaseDist_NP2P_270 tempDistNP2P_270];
                    else % Upward Preference
                        tempDistP2NP_90 = spikeLFPCoupling(iDataset).PhaseDistribution{i,j}.PA.s270TO90.Post.phaseDist;
                        phaseDist_P2NP_90 = [phaseDist_P2NP_90 tempDistP2NP_90];
                        tempDistNP2P_90 = spikeLFPCoupling(iDataset).PhaseDistribution{i,j}.PA.s90TO270.Post.phaseDist;
                        phaseDist_NP2P_90 = [phaseDist_NP2P_90 tempDistNP2P_90];
                    end
                    
                end
                
            end
            
        end
        
    end
    
end

    figure(5)
    subplot(1,2,1)
    polarhistogram(rad2deg(wrapTo2Pi(phaseDist_P2NP_270)),24,'Normalization','pdf')
    hold on
    polarhistogram(rad2deg(wrapTo2Pi(phaseDist_NP2P_270)),24,'Normalization','pdf')
    title('270TO90 Switch')
    
    subplot(1,2,2)
    polarhistogram(rad2deg(wrapTo2Pi(phaseDist_P2NP_90)),24,'Normalization','pdf')
    hold on
    polarhistogram(rad2deg(wrapTo2Pi(phaseDist_NP2P_90)),24,'Normalization','pdf')
    title('90TO270 Switch')
    legend('P2NP','NP2P')
    suptitle(['PA Session #'  num2str(iDataset) ' ' 'All Significant SUs'])