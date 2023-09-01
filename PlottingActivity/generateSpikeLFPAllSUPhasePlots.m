function generateSpikeLFPAllSUPhasePlots(duration)

%% Datasets and SU info

dates{1} = 'H07\12-06-2016';
dates{2} = 'H07\13-07-2016';
dates{3} = 'H07\20161019';
dates{4} = 'H07\20161025';
dates{5} = 'A11\20170305';
dates{6} = 'A11\20170302';

nDatasets = length(dates);

cd (['B:\Results\SpikeLFPCoupling\PhaseDistribution\' num2str(duration/1000) 's']);
load evtTriggered_SU_low.mat
%% 270TO90 modulated channels

nSU_diff_piOrLarger = 0;
nSU_depolP2NP_hyperpolNP2P_270 = 0;
nSU_depolNP2P_hyperpolP2NP_270 = 0;
nSU_depolP2NP_hyperpolNP2P_90 = 0;
nSU_depolNP2P_hyperpolP2NP_90 = 0;
nSU = 0;
totalSU = 0;

diffPref90 = [];
diffPref270 = [];

for iDataset = 1:6
    
    cd(['B:\Results\' dates{iDataset} '\Bfsgrad\PFC\SUA\Preference_Arrays\cSwitch'])
    load('1000_250_1000_DF_pref_array_switch.mat')
    cd(['B:\' dates{iDataset} '\PFC\Bfsgrad1'])
    load('Su_info.mat')
    prefInfo = [table2array(pref_array_switch.bs_Phy_table(:,1:3)) table2array(pref_array_switch.bs_Phy_table(:,5))];
    prefInfo = cell2mat(prefInfo);
    prefInfo = [prefInfo SU_info];
    
    [elec, su] = size(spikeLFPCoupling(iDataset).PhaseDistribution);
    totalSU = totalSU + size(SU_info,1);
    for i = 1:elec
        for j = 1:su
            if isstruct(spikeLFPCoupling(iDataset).PhaseDistribution{i,j})
                [idx ~] = find(prefInfo(:,5)==i & prefInfo(:,6)==j);
                if prefInfo(idx,2) == 1
                    
                    prefSU = prefInfo(idx,3);
                    nSU = nSU+1;
                    
                    if prefSU == 1 % Downward preference
                        
                        phaseDist_P2NP_270 = [];
                        phaseDist_NP2P_270 = [];
                        tempDistP2NP_270 = spikeLFPCoupling(iDataset).PhaseDistribution{i,j}.BR.s270TO90.Pre.phaseDist;
                        phaseDist_P2NP_270 = [phaseDist_P2NP_270 wrapTo2Pi(tempDistP2NP_270)];
                        tempDistNP2P_270 = spikeLFPCoupling(iDataset).PhaseDistribution{i,j}.BR.s90TO270.Pre.phaseDist;
                        phaseDist_NP2P_270 = [phaseDist_NP2P_270 wrapTo2Pi(tempDistNP2P_270)];
                        
                        if ~isempty(phaseDist_NP2P_270) && ~isempty(phaseDist_P2NP_270)
                            r_p2np270 = abs(mean(exp(1i*phaseDist_P2NP_270)));
                            m_p2np270 = (angle(mean(exp(1i*phaseDist_P2NP_270))));
                            
                            r_np2p270 = abs(mean(exp(1i*phaseDist_NP2P_270))); % Get the resultant length
                            m_np2p270 = (angle(mean(exp(1i*phaseDist_NP2P_270)))); % Get the mean angle
                            
                            R_NP2P270(nSU) = r_np2p270;
                            M_NP2P270(nSU) = m_np2p270;
                            
                            R_P2NP270(nSU) = r_p2np270;
                            M_P2NP270(nSU) = m_p2np270;
                            
%                             polarplot([m_p2np270 m_p2np270],[0 r_p2np270],'LineWidth',3)
%                             hold on
%                             polarplot([m_np2p270 m_np2p270],[0 r_np2p270],'LineWidth',3)
%                             legend('P2NP','NP2P')
%                             title(['SUnumber : ' num2str(nSU) ' Downward Preference'])
%                             cd B:\Results\SpikeLFPCoupling\PhaseDistribution\AllSUs\0.75s
%                             saveas(gcf,['MeanVector_SUnumber_' num2str(nSU) '_Downward Preference'],'png')
%                             close all
                            
                            diff_pref270 = abs(m_p2np270-m_np2p270);
                            
                            diffPref270 = [diffPref270 diff_pref270];
                            
                            if diff_pref270 >= (pi-pi/8) && diff_pref270 <= (pi+pi/8)
                            %if abs(diff_pref270) >= pi
                                nSU_diff_piOrLarger = nSU_diff_piOrLarger+1;
                            end
                            
                            if (wrapTo2Pi(m_p2np270) > pi && wrapTo2Pi(m_p2np270) <= 2*pi) && (wrapTo2Pi(m_np2p270) >= 0 && wrapTo2Pi(m_np2p270) <= pi)
                                    nSU_depolNP2P_hyperpolP2NP_270 = nSU_depolNP2P_hyperpolP2NP_270+1;
                            elseif (wrapTo2Pi(m_p2np270) >= 0 && wrapTo2Pi(m_p2np270) <= pi) && (wrapTo2Pi(m_np2p270) > pi && wrapTo2Pi(m_np2p270) <= 2*pi) 
                                    nSU_depolP2NP_hyperpolNP2P_270 = nSU_depolP2NP_hyperpolNP2P_270+1;
                            end
                            
                        end
                    else % Upward Preference
                        phaseDist_P2NP_90 = [];
                        phaseDist_NP2P_90 = [];
                        tempDistP2NP_90 = spikeLFPCoupling(iDataset).PhaseDistribution{i,j}.BR.s90TO270.Pre.phaseDist;
                        phaseDist_P2NP_90 = [phaseDist_P2NP_90 wrapTo2Pi(tempDistP2NP_90)];
                        tempDistNP2P_90 = spikeLFPCoupling(iDataset).PhaseDistribution{i,j}.BR.s270TO90.Pre.phaseDist;
                        phaseDist_NP2P_90 = [phaseDist_NP2P_90 wrapTo2Pi(tempDistNP2P_90)];
                        if ~isempty(phaseDist_NP2P_90) && ~isempty(phaseDist_P2NP_90)
                            r_p2np90 = abs(mean(exp(1i*phaseDist_P2NP_90)));
                            m_p2np90 = (angle(mean(exp(1i*phaseDist_P2NP_90))));
                            
                            r_np2p90 = abs(mean(exp(1i*phaseDist_NP2P_90))); % Get the resultant length
                            m_np2p90 = (angle(mean(exp(1i*phaseDist_NP2P_90)))); % Get the mean angle
                            
                            R_NP2P90(nSU) = r_np2p90;
                            M_NP2P90(nSU) = m_np2p90;
                            
                            R_P2NP90(nSU) = r_p2np90;
                            M_P2NP90(nSU) = m_p2np90;
                            
%                             polarplot([m_p2np90 m_p2np90],[0 r_p2np90],'LineWidth',3)
%                             hold on
%                             polarplot([m_np2p90 m_np2p90],[0 r_np2p90],'LineWidth',3)
%                             legend('P2NP','NP2P')
%                             title(['SUnumber : ' num2str(nSU) ' Upward Preference'])
%                             cd B:\Results\SpikeLFPCoupling\PhaseDistribution\AllSUs\0.75s
%                             saveas(gcf,['MeanVector_SUnumber_' num2str(nSU) '_Upward Preference'],'png')
%                             close all
                            
                            diff_pref90 = abs(m_p2np90-m_np2p90);
                            
                            diffPref90 = [diffPref90 diff_pref90];
                            
                            if diff_pref90 >= (pi-pi/8) && diff_pref90 <= (pi+pi/8)
                            %if abs(diff_pref90) >= pi
                                nSU_diff_piOrLarger = nSU_diff_piOrLarger+1;
                            end
                            
                            if (wrapTo2Pi(m_p2np90) > pi && wrapTo2Pi(m_p2np90) <= 2*pi) && (wrapTo2Pi(m_np2p90) >= 0 && wrapTo2Pi(m_np2p90) <= pi)
                                    nSU_depolNP2P_hyperpolP2NP_90 = nSU_depolNP2P_hyperpolP2NP_90+1;
                            elseif (wrapTo2Pi(m_p2np90) >= 0 && wrapTo2Pi(m_p2np90) <= pi) && (wrapTo2Pi(m_np2p90) > pi && wrapTo2Pi(m_np2p90) <= 2*pi) 
                                    nSU_depolP2NP_hyperpolNP2P_90 = nSU_depolP2NP_hyperpolNP2P_90+1;
                            end
                            
                        end
                    end
                    
                end
                
            end
            
        end
        
        
    end
    
end

% for i = 1:length(M_P2NP90)
% polarplot([M_P2NP90(i) M_P2NP90(i)],[0 R_P2NP90(i)],'-b','LineWidth',3)
% hold on
% polarplot([M_NP2P90(i) M_NP2P90(i)],[0 R_NP2P90(i)],'-r','LineWidth',3)
% legend('P2NP','NP2P')
% title(['Upward Preference'])
% end
% saveas(gcf,'nSU_MeanVectorsPooled_UpwardPref','fig')
% close all
% 
% for i = 1:length(M_P2NP270)
% polarplot([M_P2NP270(i) M_P2NP270(i)],[0 R_P2NP270(i)],'-b','LineWidth',3)
% hold on
% polarplot([M_NP2P270(i) M_NP2P270(i)],[0 R_NP2P270(i)],'-r','LineWidth',3)
% legend('P2NP','NP2P')
% title(['Downward Preference'])
% end
% saveas(gcf,'nSU_MeanVectorsPooled_DownwardPref','fig')
% close all

%% Plot Bar Graph

barData(1) = (nSU_diff_piOrLarger/nSU)*100;
barData(2) = ((nSU_depolNP2P_hyperpolP2NP_270+nSU_depolNP2P_hyperpolP2NP_90)/nSU)*100;
barData(3) = ((nSU_depolP2NP_hyperpolNP2P_270+nSU_depolP2NP_hyperpolNP2P_90)/nSU)*100;
barData(4) = barData(3)+barData(2);

colours = ['k', 'b', 'r','c'];

categoryNames = [{'nSU P2NP-NP2P Around Pi'}; {'NP2PDepol-P2NPHyppol'}; {'NP2PHyppol-P2NPDepol'}; {'Opposite phases'}];

for i = 1:length(barData)
    hold on
    bar(i,barData(i),colours(i))
end
grid on
box off
ylabel('Percentage of Selective Neurons')
title('Phase Characterisation - All Selective SUs')
xticks([1 2 3 4])
set(gca,'xticklabel',categoryNames)
text(1:length(barData),1:4,num2str(barData'),'vert','bottom','horiz','center');

figure(2)
polarhistogram((diffPref270),16,'Normalization','pdf')
hold on
polarhistogram((diffPref90),16,'Normalization','pdf')
r_diff90 = abs(mean(exp(1i*diffPref90))); % Get the resultant length
m_diff90 = angle(mean(exp(1i*diffPref90))); % Get the resultant length
m_diff270 = angle(mean(exp(1i*diffPref270))); % Get the resultant length
r_diff270 = abs(mean(exp(1i*diffPref270))); % Get the resultant length
polarplot([m_diff270 m_diff270],[0 r_diff270],'LineWidth',2)
hold on
polarplot([m_diff90 m_diff90],[0 r_diff90],'LineWidth',2)

cd ..