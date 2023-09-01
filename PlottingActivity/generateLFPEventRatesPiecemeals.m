function generateLFPEventRatesPiecemeals(duration)

% This code collects all computed spectrograms across datasets and then
% creates a grand average of selective sites during Riv and during PA_FS
% for comparison

%% Enumerate the datasets for Low

% traces_ according to Selectivity during Rivalry

datasetsLfpStats{1} = ['B:\H07\12-06-2016\PFC\Bfsgrad1\LFPStatisticsPiecemeals\MMstd4_eventRateByTime_Piecemeals_' num2str(duration) 'ms_Chebyshev1_' 'low' '.mat'];
datasetsLfpStats{2} = ['B:\H07\13-07-2016\PFC\Bfsgrad1\LFPStatisticsPiecemeals\MMstd4_eventRateByTime_Piecemeals_' num2str(duration) 'ms_Chebyshev1_' 'low' '.mat'];
datasetsLfpStats{3} = ['B:\H07\20161019\PFC\Bfsgrad1\LFPStatisticsPiecemeals\MMstd4_eventRateByTime_Piecemeals_' num2str(duration) 'ms_Chebyshev1_' 'low' '.mat'];
datasetsLfpStats{4} = ['B:\H07\20161025\PFC\Bfsgrad1\LFPStatisticsPiecemeals\MMstd4_eventRateByTime_Piecemeals_' num2str(duration) 'ms_Chebyshev1_' 'low' '.mat'];
datasetsLfpStats{5} = ['B:\A11\20170305\PFC\Bfsgrad1\LFPStatisticsPiecemeals\MMstd4_eventRateByTime_Piecemeals_' num2str(duration) 'ms_Chebyshev1_' 'low' '.mat'];
datasetsLfpStats{6} = ['B:\A11\20170302\PFC\Bfsgrad1\LFPStatisticsPiecemeals\MMstd4_eventRateByTime_Piecemeals_' num2str(duration) 'ms_Chebyshev1_' 'low' '.mat'];

datasets_parentDir{1} = ['B:\H07\12-06-2016\PFC\Bfsgrad1\'];
datasets_parentDir{2} = ['B:\H07\13-07-2016\PFC\Bfsgrad1\'];
datasets_parentDir{3} = ['B:\H07\20161019\PFC\Bfsgrad1\'];
datasets_parentDir{4} = ['B:\H07\20161025\PFC\Bfsgrad1\'];
datasets_parentDir{5} = ['B:\A11\20170305\PFC\Bfsgrad1\'];
datasets_parentDir{6} = ['B:\A11\20170302\PFC\Bfsgrad1\'];

%% Plot grand average for DomSels

% collect

for iDataset = [1 2 3 4 5 6]
    
    load(datasetsLfpStats{iDataset});

    folderName = ['B:\Results\LFP_Statistics\EventRateByTime\Piecemeals\std3.5\' 'low' '\' num2str(duration/1000) 's'];
    mkdir(folderName)
    cd(folderName)
    
    t = linspace((-duration)/1000,(duration)/1000,duration+1);
    cd(datasets_parentDir{iDataset})
    load('nTransitionsPiecemeals_0.5s.mat')
    
    nTransitions_BR_90TO270(iDataset) = nTransitions_BR_270;
    nTransitions_BR_270TO90(iDataset) = nTransitions_BR_90;
    
    % Do for BR90
    
    for iElec = 1:96
        
        
       low_eventRate_BR_270TO90(iDataset,iElec,:) = zscore((1/nTransitions_BR_270TO90(iDataset)).*nanmean(eventRatePerTransition(iElec).BR.dom90));
       low_eventRate_BR_90TO270(iDataset,iElec,:) = zscore((1/nTransitions_BR_90TO270(iDataset)).*nanmean(eventRatePerTransition(iElec).BR.dom270));
       
    end
    
end

%% Plotting

% Plot individual sessions
% cd(folderName)
% 
% % Plot individual sessions
% figure
% 
% nCols = iDataset/2;
% 
% for i = 1:iDataset
%     subplot(nCols,2,i)
%     
%     plot(t,(squeeze(nanmean(low_eventRate_BR_270TO90(i,:,:),2))),'-r','LineWidth',2)
%     hold on
%     plot(t,(squeeze(nanmean(low_eventRate_BR_90TO270(i,:,:),2))),'--r','LineWidth',2)
%     plot(t,(squeeze(nanmean(low_eventRate_PA_270TO90(i,:,:),2))),'-k','LineWidth',2)
%     plot(t,(squeeze(nanmean(low_eventRate_PA_90TO270(i,:,:),2))),'--k','LineWidth',2)
%     axis tight;
%     vline(0,'--b')
%     grid on; box off;
%     title(['Session : ' num2str(i)])
%     if i == 1
%         legend('BR 270TO90', 'BR 90TO270', 'PA 270TO90', 'PA 90TO270')
%     end
%     
%     if mod(i,2) ~= 0
%         ylabel('d event rate')
%     end
%     
%     if i == 5 || i == 6
%         xlabel('time in s (switch at 0)')
%     end
%     
% end
% suptitle('Low (1-9 Hz) Normalised Event Rates (per transition per electrode)')
% set(gcf, 'Position', get(0, 'Screensize'));
% saveas(gcf,'IndividualSessions_eventRate','png')
% pause(2); close all;

% Plot pooled
low_pooled_eventRate_BR_270TO90 = (reshape(low_eventRate_BR_270TO90,6*96,length(t)));
low_pooled_eventRate_BR_90TO270 = (reshape(low_eventRate_BR_90TO270,6*96,length(t)));

low_mean_eventRate_BR_270TO90 = (nanmean(low_pooled_eventRate_BR_270TO90,1));
low_mean_eventRate_BR_90TO270 = (nanmean(low_pooled_eventRate_BR_90TO270,1));

low_std_eventRate_BR_270TO90 = (nanstd(low_pooled_eventRate_BR_270TO90,[],1))/(sqrt(576));
low_std_eventRate_BR_90TO270 = (nanstd(low_pooled_eventRate_BR_90TO270,[],1))/(sqrt(576));

% figure(2)
% subplot(1,2,1)
% H(1)=shadedErrorBar(t,low_mean_eventRate_BR_270TO90,low_std_eventRate_BR_270TO90);
% hold on
% P(1)=plot(t,low_mean_eventRate_BR_270TO90,'-r','LineWidth',2);
% xlabel('time in s')
% ylabel('d event rate')
% axis tight;
% vline(0,'--k')
% title('Pooled Low (1-9 Hz) Normalised Event Rate - Piecemeal to 90')
% grid on; box off;
% legend([P(1)], 'BR 270TO90', 'Location', 'NorthEast');
% 
% subplot(1,2,2)
% H(1)=shadedErrorBar(t,low_mean_eventRate_BR_90TO270,low_std_eventRate_BR_90TO270);
% hold on
% P(1)=plot(t,low_mean_eventRate_BR_90TO270,'-r','LineWidth',2);
% xlabel('time in s')
% ylabel('d event rate')
% axis tight;
% vline(0,'--k')
% title('Pooled Low (1-9 Hz) Normalised Event Rate - Piecemeal to 270')
% grid on; box off;
% legend([P(1)], 'BR 90TO270', 'Location', 'NorthEast');
% set(gcf, 'Position', get(0, 'Screensize'));
% saveas(gcf,'Pooled_eventRate_Piecemeals','png')
% pause(2); close all;

%% Do for Beta

datasetsLfpStats{1} = ['B:\H07\12-06-2016\PFC\Bfsgrad1\LFPStatisticsPiecemeals\MMstd4_eventRateByTime_Piecemeals_' num2str(duration) 'ms_Chebyshev1_' 'beta' '.mat'];
datasetsLfpStats{2} = ['B:\H07\13-07-2016\PFC\Bfsgrad1\LFPStatisticsPiecemeals\MMstd4_eventRateByTime_Piecemeals_' num2str(duration) 'ms_Chebyshev1_' 'beta' '.mat'];
datasetsLfpStats{3} = ['B:\H07\20161019\PFC\Bfsgrad1\LFPStatisticsPiecemeals\MMstd4_eventRateByTime_Piecemeals_' num2str(duration) 'ms_Chebyshev1_' 'beta' '.mat'];
datasetsLfpStats{4} = ['B:\H07\20161025\PFC\Bfsgrad1\LFPStatisticsPiecemeals\MMstd4_eventRateByTime_Piecemeals_' num2str(duration) 'ms_Chebyshev1_' 'beta' '.mat'];
datasetsLfpStats{5} = ['B:\A11\20170305\PFC\Bfsgrad1\LFPStatisticsPiecemeals\MMstd4_eventRateByTime_Piecemeals_' num2str(duration) 'ms_Chebyshev1_' 'beta' '.mat'];
datasetsLfpStats{6} = ['B:\A11\20170302\PFC\Bfsgrad1\LFPStatisticsPiecemeals\MMstd4_eventRateByTime_Piecemeals_' num2str(duration) 'ms_Chebyshev1_' 'beta' '.mat'];

for iDataset = [1 2 3 4 5 6]
    
    load(datasetsLfpStats{iDataset});

    folderName = ['B:\Results\LFP_Statistics\EventRateByTime\Piecemeals\std3.5\' 'beta' '\' num2str(duration/1000) 's'];
    mkdir(folderName)
    cd(folderName)
    
    t = linspace((-duration)/1000,(duration)/1000,duration+1);
    cd(datasets_parentDir{iDataset})
    load('nTransitions_0.5s.mat')

    nTransitions_BR_90TO270(iDataset) = nTransitions_BR_270;
    nTransitions_BR_270TO90(iDataset) = nTransitions_BR_90;
    
    % Do for BR90
    
    for iElec = 1:96
        
        
       beta_eventRate_BR_270TO90(iDataset,iElec,:) = zscore((1/nTransitions_BR_270TO90(iDataset)).*nanmean(eventRatePerTransition(iElec).BR.dom90));
       beta_eventRate_BR_90TO270(iDataset,iElec,:) = zscore((1/nTransitions_BR_90TO270(iDataset)).*nanmean(eventRatePerTransition(iElec).BR.dom270));
    end
    
end

%% Plotting

% Plot individual sessions
cd(folderName)
% 
% % Plot individual sessions
% figure
% 
% nCols = iDataset/2;
% 
% for i = 1:iDataset
%     subplot(nCols,2,i)
%     
%     plot(t,(squeeze(nanmean(beta_eventRate_BR_270TO90(i,:,:),2))),'-r','LineWidth',2)
%     hold on
%     plot(t,(squeeze(nanmean(beta_eventRate_BR_90TO270(i,:,:),2))),'--r','LineWidth',2)
%     plot(t,(squeeze(nanmean(beta_eventRate_PA_270TO90(i,:,:),2))),'-k','LineWidth',2)
%     plot(t,(squeeze(nanmean(beta_eventRate_PA_90TO270(i,:,:),2))),'--k','LineWidth',2)
%     axis tight;
%     vline(0,'--b')
%     grid on; box off;
%     title(['Session : ' num2str(i)])
%     if i == 1
%         legend('BR 270TO90', 'BR 90TO270', 'PA 270TO90', 'PA 90TO270')
%     end
%     
%     if mod(i,2) ~= 0
%         ylabel('d event rate')
%     end
%     
%     if i == 5 || i == 6
%         xlabel('time in s (switch at 0)')
%     end
%     
% end
% suptitle('Beta (20-40 Hz) Normalised Event Rates (per transition per electrode)')
% set(gcf, 'Position', get(0, 'Screensize'));
% saveas(gcf,'IndividualSessions_eventRate','png')
% pause(2); close all;

% Plot pooled
beta_pooled_eventRate_BR_270TO90 = (reshape(beta_eventRate_BR_270TO90,6*96,length(t)));
beta_pooled_eventRate_BR_90TO270 = (reshape(beta_eventRate_BR_90TO270,6*96,length(t)));

beta_mean_eventRate_BR_270TO90 = (nanmean(beta_pooled_eventRate_BR_270TO90,1));
beta_mean_eventRate_BR_90TO270 = (nanmean(beta_pooled_eventRate_BR_90TO270,1));

beta_std_eventRate_BR_270TO90 = (nanstd(beta_pooled_eventRate_BR_270TO90,[],1))/(sqrt(576));
beta_std_eventRate_BR_90TO270 = (nanstd(beta_pooled_eventRate_BR_90TO270,[],1))/(sqrt(576));


% figure(2)
% subplot(1,2,1)
% H(1)=shadedErrorBar(t,beta_mean_eventRate_BR_270TO90,beta_std_eventRate_BR_270TO90);
% hold on
% P(1)=plot(t,beta_mean_eventRate_BR_270TO90,'-r','LineWidth',2);
% xlabel('time in s')
% ylabel('d event rate')
% axis tight;
% vline(0,'--k')
% title('Pooled Beta (20-40 Hz) Normalised Event Rate - Piecemeal to 90')
% grid on; box off;
% legend([P(1)], 'BR 270TO90', 'Location', 'NorthEast');
% 
% subplot(1,2,2)
% H(1)=shadedErrorBar(t,beta_mean_eventRate_BR_90TO270,beta_std_eventRate_BR_90TO270);
% hold on
% P(1)=plot(t,beta_mean_eventRate_BR_90TO270,'-r','LineWidth',2);
% xlabel('time in s')
% ylabel('d event rate')
% axis tight;
% vline(0,'--k')
% title('Pooled Beta (20-40 Hz) Normalised Event Rate - Piecemeal to 270')
% grid on; box off;
% legend([P(1)], 'BR 90TO270', 'Location', 'NorthEast');
% set(gcf, 'Position', get(0, 'Screensize'));
% saveas(gcf,'Pooled_eventRate_Piecemeals','png')
% pause(2); close all;

%% Plot pooled Low vs Beta

% figure(2)
% subplot(2,2,1)
% H(1)=shadedErrorBar(t,low_mean_eventRate_BR_270TO90,low_std_eventRate_BR_270TO90);
% hold on
% P(1)=plot(t,low_mean_eventRate_BR_270TO90,'-r','LineWidth',1.25);
% H(2)=shadedErrorBar(t,beta_mean_eventRate_BR_270TO90,beta_std_eventRate_BR_270TO90);
% P(2)=plot(t,beta_mean_eventRate_BR_270TO90,'--r','LineWidth',1.25);
% xlabel('time in s')
% ylabel('normalised event rate')
% axis tight;
% vline(0,'--k')
% title('Pooled Low vs Beta Normalised Event Rate - BR 270TO90 Switch')
% grid on; box off;
% legend([P(1) P(2)], 'Low BR 270TO90', 'Beta BR 270TO90', 'Location', 'NorthEast');
% 
% subplot(2,2,2)
% H(1)=shadedErrorBar(t,low_mean_eventRate_BR_90TO270,low_std_eventRate_BR_90TO270);
% hold on
% P(1)=plot(t,low_mean_eventRate_BR_90TO270,'-r','LineWidth',1.25);
% H(2)=shadedErrorBar(t,beta_mean_eventRate_BR_90TO270,beta_std_eventRate_BR_90TO270);
% P(2)=plot(t,beta_mean_eventRate_BR_90TO270,'--r','LineWidth',1.25);
% xlabel('time in s')
% ylabel('normalised event rate')
% axis tight;
% vline(0,'--k')
% title('Pooled Low vs Beta Normalised Event Rate - BR 90TO270 Switch')
% grid on; box off;
% legend([P(1) P(2)], 'Low BR 90TO270', 'Beta BR 90TO270', 'Location', 'NorthEast');
% 
% subplot(2,2,3)
% H(1)=shadedErrorBar(t,low_mean_eventRate_PA_270TO90,low_std_eventRate_PA_270TO90);
% hold on
% P(1)=plot(t,low_mean_eventRate_PA_270TO90,'-k','LineWidth',1.25);
% H(2)=shadedErrorBar(t,beta_mean_eventRate_PA_270TO90,beta_std_eventRate_PA_270TO90);
% P(2)=plot(t,beta_mean_eventRate_PA_270TO90,'--k','LineWidth',1.25);
% xlabel('time in s')
% ylabel('normalised event rate')
% axis tight;
% vline(0,'--k')
% title('Pooled Low vs Beta Normalised Event Rate - PA 270TO90 Switch')
% grid on;  box off;
% legend([P(1) P(2)], 'Low PA 270TO90', 'Beta PA 270TO90', 'Location', 'NorthEast');
% 
% subplot(2,2,4)
% H(1)=shadedErrorBar(t,low_mean_eventRate_PA_90TO270,low_std_eventRate_PA_90TO270);
% hold on
% P(1)=plot(t,low_mean_eventRate_PA_90TO270,'-k','LineWidth',1.25);
% H(2)=shadedErrorBar(t,beta_mean_eventRate_PA_90TO270,beta_std_eventRate_PA_90TO270);
% P(2)=plot(t,beta_mean_eventRate_PA_90TO270,'--k','LineWidth',1.25);
% xlabel('time in s')
% ylabel('normalised event rate')
% axis tight;
% vline(0,'--k')
% title('Pooled Low vs Beta Normalised Event Rate - PA 90TO270 Switch')
% grid on; box off;
% legend([P(1) P(2)], 'Low PA 90TO270', 'Beta PA 90TO270', 'Location', 'NorthEast');
% set(gcf, 'Position', get(0, 'Screensize'));
% cd ..
% cd ..
% %saveas(gcf,'lowerTolerance_Overlaid_Pooled_eventRate','png')
% pause(2); close all;

% subplot(1,2,1)
% shadedErrorBar(t(76:426),low_mean_eventRate_BR_270TO90(76:426), low_std_eventRate_BR_270TO90(76:426))
% hold on
% plot(t(76:426),low_mean_eventRate_BR_270TO90(76:426),'-r')
% shadedErrorBar(t(76:426),beta_mean_eventRate_BR_270TO90(76:426), beta_std_eventRate_BR_270TO90(76:426))
% hold on
% plot(t(76:426),beta_mean_eventRate_BR_270TO90(76:426),'--r')
% vline(0,'--b')
% 
% subplot(1,2,2)
% shadedErrorBar(t(76:426),low_mean_eventRate_BR_90TO270(76:426), low_std_eventRate_BR_90TO270(76:426))
% hold on
% plot(t(76:426),low_mean_eventRate_BR_90TO270(76:426),'-r')
% shadedErrorBar(t(76:426),beta_mean_eventRate_BR_90TO270(76:426), low_std_eventRate_BR_90TO270(76:426))
% hold on
% plot(t(76:426),beta_mean_eventRate_BR_90TO270(76:426),'--r')
% vline(0,'--b')
% set(gca,'yticklabel',[])
% set(gca,'ytick',[])

figure

low_eventRate = mean([low_pooled_eventRate_BR_270TO90;low_pooled_eventRate_BR_90TO270],1);
low_eventRate_sem = nanstd([low_pooled_eventRate_BR_270TO90;low_pooled_eventRate_BR_90TO270],1)./sqrt(1152);
beta_eventRate = mean([beta_pooled_eventRate_BR_270TO90;beta_pooled_eventRate_BR_90TO270],1);
beta_eventRate_sem = nanstd([beta_pooled_eventRate_BR_270TO90;beta_pooled_eventRate_BR_90TO270],1)./sqrt(1152);

shadedErrorBar(t(26:476),low_eventRate(26:476), low_eventRate_sem(26:476))
hold on
plot(t(26:476),low_eventRate(26:476),'-','Color',[0.75 0.75 0.75])
shadedErrorBar(t(76:426),beta_eventRate(76:426), beta_eventRate_sem(76:426))
hold on
plot(t(76:426),beta_eventRate(76:426),'--','Color',[0.75 0.75 0.75])
vline(0,'--b')


%% Distributions

for i = 1:576
[val idx] = max(low_pooled_eventRate_BR_270TO90(i,1:251));
lowPeak_BR_270TO90(i) = val;
betaVal_BR_270TO90(i) = beta_pooled_eventRate_BR_270TO90(i,idx);
end

for i = 1:576
[val idx] = max(low_pooled_eventRate_BR_90TO270(i,1:251));
lowPeak_BR_90TO270(i) = val;
betaVal_BR_90TO270(i) = beta_pooled_eventRate_BR_90TO270(i,idx);
end