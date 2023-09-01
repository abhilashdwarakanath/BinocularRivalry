function generateLFPEventRatesTbyT(duration)

% This code collects all computed spectrograms across datasets and then
% creates a grand average of selective sites during Riv and during PA_FS
% for comparison

%% Enumerate the datasets for Low

% traces_ according to Selectivity during Rivalry

datasetsLfpStats{1} = ['B:\H07\12-06-2016\PFC\Bfsgrad1\LFPStatistics\MMstd4_TbyT_eventRateByTime_' num2str(duration) 'ms_Chebyshev1_' 'low' '.mat'];
datasetsLfpStats{2} = ['B:\H07\13-07-2016\PFC\Bfsgrad1\LFPStatistics\MMstd4_TbyT_eventRateByTime_' num2str(duration) 'ms_Chebyshev1_' 'low' '.mat'];
datasetsLfpStats{3} = ['B:\H07\20161019\PFC\Bfsgrad1\LFPStatistics\MMstd4_TbyT_eventRateByTime_' num2str(duration) 'ms_Chebyshev1_' 'low' '.mat'];
datasetsLfpStats{4} = ['B:\H07\20161025\PFC\Bfsgrad1\LFPStatistics\MMstd4_TbyT_eventRateByTime_' num2str(duration) 'ms_Chebyshev1_' 'low' '.mat'];
datasetsLfpStats{5} = ['B:\A11\20170305\PFC\Bfsgrad1\LFPStatistics\MMstd4_TbyT_eventRateByTime_' num2str(duration) 'ms_Chebyshev1_' 'low' '.mat'];
datasetsLfpStats{6} = ['B:\A11\20170302\PFC\Bfsgrad1\LFPStatistics\MMstd4_TbyT_eventRateByTime_' num2str(duration) 'ms_Chebyshev1_' 'low' '.mat'];

datasets_parentDir{1} = ['B:\H07\12-06-2016\PFC\Bfsgrad1\'];
datasets_parentDir{2} = ['B:\H07\13-07-2016\PFC\Bfsgrad1\'];
datasets_parentDir{3} = ['B:\H07\20161019\PFC\Bfsgrad1\'];
datasets_parentDir{4} = ['B:\H07\20161025\PFC\Bfsgrad1\'];
datasets_parentDir{5} = ['B:\A11\20170305\PFC\Bfsgrad1\'];
datasets_parentDir{6} = ['B:\A11\20170302\PFC\Bfsgrad1\'];

%% Plot grand average for DomSels

% collect

low_eventRate_BR_270TO90 = [];
low_eventRate_BR_90TO270 = [];
low_eventRate_PA_270TO90 = [];
low_eventRate_PA_90TO270 = [];

for iDataset = [1 2 3 4 5 6]
    
    load(datasetsLfpStats{iDataset});

    folderName = ['B:\Results\LFP_Statistics\EventRateByTime\MM\std4\TbyT\' 'low' '\' num2str(duration/1000) 's'];
    mkdir(folderName)
    cd(folderName)
    
    t = linspace((-duration)/1000,(duration)/1000,duration+1);
    cd(datasets_parentDir{iDataset})
    load('nTransitions_0.5s.mat')
    
    nTransitions_PA_90TO270(iDataset) = nTransitions_PA_270;
    nTransitions_PA_270TO90(iDataset) = nTransitions_PA_90;
    nTransitions_BR_90TO270(iDataset) = nTransitions_BR_270;
    nTransitions_BR_270TO90(iDataset) = nTransitions_BR_90;
    
    % Do for BR90

        
        
       low_eventRate_BR_270TO90 = [low_eventRate_BR_270TO90;zscore((1/nTransitions_BR_270TO90(iDataset)).*squeeze(nanmean(eventRatePerTransition.BR.dom90,2)),[],2)];
       low_eventRate_BR_90TO270 = [low_eventRate_BR_90TO270;zscore((1/nTransitions_BR_90TO270(iDataset)).*squeeze(nanmean(eventRatePerTransition.BR.dom270,2)),[],2)];
       
       low_eventRate_PA_270TO90 = [low_eventRate_PA_270TO90;zscore((1/nTransitions_PA_270TO90(iDataset)).*squeeze(nanmean(eventRatePerTransition.PA.dom90,2)),[],2)];
       low_eventRate_PA_90TO270 = [low_eventRate_PA_90TO270;zscore((1/nTransitions_PA_90TO270(iDataset)).*squeeze(nanmean(eventRatePerTransition.PA.dom270,2)),[],2)];

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

low_mean_eventRate_BR_270TO90 = (nanmean(low_eventRate_BR_270TO90,1));
low_mean_eventRate_BR_90TO270 = (nanmean(low_eventRate_BR_90TO270,1));
low_mean_eventRate_PA_270TO90 = (nanmean(low_eventRate_PA_270TO90,1));
low_mean_eventRate_PA_90TO270 = (nanmean(low_eventRate_PA_90TO270,1));

low_std_eventRate_BR_270TO90 = (nanstd(low_eventRate_BR_270TO90,[],1))/(sqrt(size(low_eventRate_BR_270TO90,1)));
low_std_eventRate_BR_90TO270 = (nanstd(low_eventRate_BR_90TO270,[],1))/(sqrt(size(low_eventRate_BR_90TO270,1)));
low_std_eventRate_PA_270TO90 = (nanstd(low_eventRate_PA_270TO90,[],1))/(sqrt(size(low_eventRate_PA_270TO90,1)));
low_std_eventRate_PA_90TO270 = (nanstd(low_eventRate_PA_90TO270,[],1))/(sqrt(size(low_eventRate_PA_90TO270,1)));

% figure(2)
% subplot(1,2,1)
% H(1)=shadedErrorBar(t,low_mean_eventRate_BR_270TO90,low_std_eventRate_BR_270TO90);
% hold on
% P(1)=plot(t,low_mean_eventRate_BR_270TO90,'-r','LineWidth',2);
% H(2)=shadedErrorBar(t,low_mean_eventRate_PA_270TO90,low_std_eventRate_PA_270TO90);
% P(2)=plot(t,low_mean_eventRate_PA_270TO90,'-k','LineWidth',2);
% xlabel('time in s')
% ylabel('d event rate')
% axis tight;
% vline(0,'--k')
% title('Pooled Low (1-9 Hz) Normalised Event Rate - 270TO90 Switch')
% grid on; box off;
% legend([P(1) P(2)], 'BR 270TO90', 'PA 270TO90', 'Location', 'NorthEast');
% 
% subplot(1,2,2)
% H(1)=shadedErrorBar(t,low_mean_eventRate_BR_90TO270,low_std_eventRate_BR_90TO270);
% hold on
% P(1)=plot(t,low_mean_eventRate_BR_90TO270,'-r','LineWidth',2);
% H(2)=shadedErrorBar(t,low_mean_eventRate_PA_90TO270,low_std_eventRate_PA_90TO270);
% P(2)=plot(t,low_mean_eventRate_PA_90TO270,'-k','LineWidth',2);
% xlabel('time in s')
% ylabel('d event rate')
% axis tight;
% vline(0,'--k')
% title('Pooled Low (1-9 Hz) Normalised Event Rate - 90TO270 Switch')
% grid on; box off;
% legend([P(1) P(2)], 'BR 90TO270', 'PA 90TO270', 'Location', 'NorthEast');
% set(gcf, 'Position', get(0, 'Screensize'));
% saveas(gcf,'Pooled_eventRate','png')
% pause(2); close all;

%% Do for Beta

datasetsLfpStats{1} = ['B:\H07\12-06-2016\PFC\Bfsgrad1\LFPStatistics\MMstd4_TbyT_eventRateByTime_' num2str(duration) 'ms_Chebyshev1_' 'beta' '.mat'];
datasetsLfpStats{2} = ['B:\H07\13-07-2016\PFC\Bfsgrad1\LFPStatistics\MMstd4_TbyT_eventRateByTime_' num2str(duration) 'ms_Chebyshev1_' 'beta' '.mat'];
datasetsLfpStats{3} = ['B:\H07\20161019\PFC\Bfsgrad1\LFPStatistics\MMstd4_TbyT_eventRateByTime_' num2str(duration) 'ms_Chebyshev1_' 'beta' '.mat'];
datasetsLfpStats{4} = ['B:\H07\20161025\PFC\Bfsgrad1\LFPStatistics\MMstd4_TbyT_eventRateByTime_' num2str(duration) 'ms_Chebyshev1_' 'beta' '.mat'];
datasetsLfpStats{5} = ['B:\A11\20170305\PFC\Bfsgrad1\LFPStatistics\MMstd4_TbyT_eventRateByTime_' num2str(duration) 'ms_Chebyshev1_' 'beta' '.mat'];
datasetsLfpStats{6} = ['B:\A11\20170302\PFC\Bfsgrad1\LFPStatistics\MMstd4_TbyT_eventRateByTime_' num2str(duration) 'ms_Chebyshev1_' 'beta' '.mat'];

beta_eventRate_BR_270TO90 = [];
beta_eventRate_BR_90TO270 = [];
beta_eventRate_PA_270TO90 = [];
beta_eventRate_PA_90TO270 = [];

for iDataset = [1 2 3 4 5 6]
    
    load(datasetsLfpStats{iDataset});

    folderName = ['B:\Results\LFP_Statistics\EventRateByTime\MM\std4\TbyT\' 'beta' '\' num2str(duration/1000) 's'];
    mkdir(folderName)
    cd(folderName)
    
    t = linspace((-duration)/1000,(duration)/1000,duration+1);
    cd(datasets_parentDir{iDataset})
    load('nTransitions_0.5s.mat')
    
    nTransitions_PA_90TO270(iDataset) = nTransitions_PA_270;
    nTransitions_PA_270TO90(iDataset) = nTransitions_PA_90;
    nTransitions_BR_90TO270(iDataset) = nTransitions_BR_270;
    nTransitions_BR_270TO90(iDataset) = nTransitions_BR_90;
    
    % Do for BR90

        
        
       beta_eventRate_BR_270TO90 = [beta_eventRate_BR_270TO90;zscore((1/nTransitions_BR_270TO90(iDataset)).*squeeze(nanmean(eventRatePerTransition.BR.dom90,2)),[],2)];
       beta_eventRate_BR_90TO270 = [beta_eventRate_BR_90TO270;zscore((1/nTransitions_BR_90TO270(iDataset)).*squeeze(nanmean(eventRatePerTransition.BR.dom270,2)),[],2)];
       
       beta_eventRate_PA_270TO90 = [beta_eventRate_PA_270TO90;zscore((1/nTransitions_PA_270TO90(iDataset)).*squeeze(nanmean(eventRatePerTransition.PA.dom90,2)),[],2)];
       beta_eventRate_PA_90TO270 = [beta_eventRate_PA_90TO270;zscore((1/nTransitions_PA_90TO270(iDataset)).*squeeze(nanmean(eventRatePerTransition.PA.dom270,2)),[],2)];

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

beta_mean_eventRate_BR_270TO90 = (nanmean(beta_eventRate_BR_270TO90,1));
beta_mean_eventRate_BR_90TO270 = (nanmean(beta_eventRate_BR_90TO270,1));
beta_mean_eventRate_PA_270TO90 = (nanmean(beta_eventRate_PA_270TO90,1));
beta_mean_eventRate_PA_90TO270 = (nanmean(beta_eventRate_PA_90TO270,1));

beta_std_eventRate_BR_270TO90 = (nanstd(beta_eventRate_BR_270TO90,[],1))/(sqrt(size(beta_eventRate_BR_270TO90,1)));
beta_std_eventRate_BR_90TO270 = (nanstd(beta_eventRate_BR_90TO270,[],1))/(sqrt(size(beta_eventRate_BR_90TO270,1)));
beta_std_eventRate_PA_270TO90 = (nanstd(beta_eventRate_PA_270TO90,[],1))/(sqrt(size(beta_eventRate_PA_270TO90,1)));
beta_std_eventRate_PA_90TO270 = (nanstd(beta_eventRate_PA_90TO270,[],1))/(sqrt(size(beta_eventRate_PA_90TO270,1)));

for i = 1:size(low_eventRate_BR_270TO90,1)
[val idx] = max(low_eventRate_BR_270TO90(i,1:251));
lowPeak_BR_270TO90(i) = val;
betaVal_BR_270TO90(i) = beta_eventRate_BR_270TO90(i,idx);
end
for i = 1:size(low_eventRate_BR_90TO270)
[val idx] = max(low_eventRate_BR_90TO270(i,1:251));
lowPeak_BR_90TO270(i) = val;
betaVal_BR_90TO270(i) = beta_eventRate_BR_90TO270(i,idx);
end

% figure(2)
% subplot(1,2,1)
% H(1)=shadedErrorBar(t,beta_mean_eventRate_BR_270TO90,beta_std_eventRate_BR_270TO90);
% hold on
% P(1)=plot(t,beta_mean_eventRate_BR_270TO90,'-r','LineWidth',2);
% H(2)=shadedErrorBar(t,beta_mean_eventRate_PA_270TO90,beta_std_eventRate_PA_270TO90);
% P(2)=plot(t,beta_mean_eventRate_PA_270TO90,'-k','LineWidth',2);
% xlabel('time in s')
% ylabel('d event rate')
% axis tight;
% vline(0,'--k')
% title('Pooled Beta (20-40 Hz) Normalised Event Rate - 270TO90 Switch')
% grid on; box off;
% legend([P(1) P(2)], 'BR 270TO90', 'PA 270TO90', 'Location', 'NorthEast');
% 
% subplot(1,2,2)
% H(1)=shadedErrorBar(t,beta_mean_eventRate_BR_90TO270,beta_std_eventRate_BR_90TO270);
% hold on
% P(1)=plot(t,beta_mean_eventRate_BR_90TO270,'-r','LineWidth',2);
% H(2)=shadedErrorBar(t,beta_mean_eventRate_PA_90TO270,beta_std_eventRate_PA_90TO270);
% P(2)=plot(t,beta_mean_eventRate_PA_90TO270,'-k','LineWidth',2);
% xlabel('time in s')
% ylabel('d event rate')
% axis tight;
% vline(0,'--k')
% title('Pooled Beta (20-40 Hz) Normalised Event Rate - 90TO270 Switch')
% grid on; box off;
% legend([P(1) P(2)], 'BR 90TO270', 'PA 90TO270', 'Location', 'NorthEast');
% set(gcf, 'Position', get(0, 'Screensize'));
% saveas(gcf,'Pooled_eventRate','png')
% pause(2); close all;

%% Plot pooled Low vs Beta

figure(2)
subplot(2,2,1)
H(1)=shadedErrorBar(t,low_mean_eventRate_BR_270TO90,low_std_eventRate_BR_270TO90);
hold on
P(1)=plot(t,low_mean_eventRate_BR_270TO90,'-r','LineWidth',1.25);
H(2)=shadedErrorBar(t,beta_mean_eventRate_BR_270TO90,beta_std_eventRate_BR_270TO90);
P(2)=plot(t,beta_mean_eventRate_BR_270TO90,'--r','LineWidth',1.25);
xlabel('time in s')
ylabel('normalised event rate')
axis tight;
vline(0,'--k')
title('Pooled Low vs Beta Normalised Event Rate - BR 270TO90 Switch')
grid on; box off;
legend([P(1) P(2)], 'Low BR 270TO90', 'Beta BR 270TO90', 'Location', 'NorthEast');

subplot(2,2,2)
H(1)=shadedErrorBar(t,low_mean_eventRate_BR_90TO270,low_std_eventRate_BR_90TO270);
hold on
P(1)=plot(t,low_mean_eventRate_BR_90TO270,'-r','LineWidth',1.25);
H(2)=shadedErrorBar(t,beta_mean_eventRate_BR_90TO270,beta_std_eventRate_BR_90TO270);
P(2)=plot(t,beta_mean_eventRate_BR_90TO270,'--r','LineWidth',1.25);
xlabel('time in s')
ylabel('normalised event rate')
axis tight;
vline(0,'--k')
title('Pooled Low vs Beta Normalised Event Rate - BR 90TO270 Switch')
grid on; box off;
legend([P(1) P(2)], 'Low BR 90TO270', 'Beta BR 90TO270', 'Location', 'NorthEast');

subplot(2,2,3)
H(1)=shadedErrorBar(t,low_mean_eventRate_PA_270TO90,low_std_eventRate_PA_270TO90);
hold on
P(1)=plot(t,low_mean_eventRate_PA_270TO90,'-k','LineWidth',1.25);
H(2)=shadedErrorBar(t,beta_mean_eventRate_PA_270TO90,beta_std_eventRate_PA_270TO90);
P(2)=plot(t,beta_mean_eventRate_PA_270TO90,'--k','LineWidth',1.25);
xlabel('time in s')
ylabel('normalised event rate')
axis tight;
vline(0,'--k')
title('Pooled Low vs Beta Normalised Event Rate - PA 270TO90 Switch')
grid on;  box off;
legend([P(1) P(2)], 'Low PA 270TO90', 'Beta PA 270TO90', 'Location', 'NorthEast');

subplot(2,2,4)
H(1)=shadedErrorBar(t,low_mean_eventRate_PA_90TO270,low_std_eventRate_PA_90TO270);
hold on
P(1)=plot(t,low_mean_eventRate_PA_90TO270,'-k','LineWidth',1.25);
H(2)=shadedErrorBar(t,beta_mean_eventRate_PA_90TO270,beta_std_eventRate_PA_90TO270);
P(2)=plot(t,beta_mean_eventRate_PA_90TO270,'--k','LineWidth',1.25);
xlabel('time in s')
ylabel('normalised event rate')
axis tight;
vline(0,'--k')
title('Pooled Low vs Beta Normalised Event Rate - PA 90TO270 Switch')
grid on; box off;
legend([P(1) P(2)], 'Low PA 90TO270', 'Beta PA 90TO270', 'Location', 'NorthEast');
% set(gcf, 'Position', get(0, 'Screensize'));
% cd ..
% cd ..
% %saveas(gcf,'lowerTolerance_Overlaid_Pooled_eventRate','png')
% pause(2); close all;

subplot(2,2,1)
shadedErrorBar(t(26:476),low_mean_eventRate_BR_270TO90(26:476), low_std_eventRate_BR_270TO90(26:476))
hold on
plot(t(26:476),low_mean_eventRate_BR_270TO90(26:476),'-r')
shadedErrorBar(t(26:476),beta_mean_eventRate_BR_270TO90(26:476), beta_std_eventRate_BR_270TO90(26:476))
hold on
plot(t(26:476),beta_mean_eventRate_BR_270TO90(26:476),'--r')
xlim([-0.5 0.5])
vline(0,'--b')
set(gca,'xticklabel',[])
set(gca,'xtick',[])

subplot(2,2,2)
shadedErrorBar(t(26:476),low_mean_eventRate_BR_90TO270(26:476), low_std_eventRate_BR_90TO270(26:476))
hold on
plot(t(26:476),low_mean_eventRate_BR_90TO270(26:476),'-r')
shadedErrorBar(t(26:476),beta_mean_eventRate_BR_90TO270(26:476), low_std_eventRate_BR_90TO270(26:476))
hold on
plot(t(26:476),beta_mean_eventRate_BR_90TO270(26:476),'--r')
xlim([-0.5 0.5])
vline(0,'--b')
set(gca,'xticklabel',[])
set(gca,'xtick',[])

subplot(2,2,3)
shadedErrorBar(t(26:476),low_mean_eventRate_PA_270TO90(26:476), low_std_eventRate_PA_270TO90(26:476))
hold on
plot(t(26:476),low_mean_eventRate_PA_270TO90(26:476),'-k')
shadedErrorBar(t(26:476),beta_mean_eventRate_PA_270TO90(26:476), beta_std_eventRate_PA_270TO90(26:476))
hold on
plot(t(26:476),beta_mean_eventRate_PA_270TO90(26:476),'--k')
vline(0,'--b')
xlim([-0.5 0.5])

subplot(2,2,4)
shadedErrorBar(t(26:476),low_mean_eventRate_PA_90TO270(26:476), low_std_eventRate_PA_90TO270(26:476))
hold on
plot(t(26:476),low_mean_eventRate_PA_90TO270(26:476),'-k')
shadedErrorBar(t(26:476),beta_mean_eventRate_PA_90TO270(26:476), low_std_eventRate_PA_90TO270(26:476))
hold on
plot(t(26:476),beta_mean_eventRate_PA_90TO270(26:476),'--k')
xlim([-0.5 0.5])
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

for i = 1:576
[val idx] = max(low_pooled_eventRate_PA_270TO90(i,252:end));
lowPeak_PA_270TO90(i) = val;
betaVal_PA_270TO90(i) = beta_pooled_eventRate_PA_270TO90(i,idx);
end

for i = 1:576
[val idx] = max(low_pooled_eventRate_PA_90TO270(i,252:end));
lowPeak_PA_90TO270(i) = val;
betaVal_PA_90TO270(i) = beta_pooled_eventRate_PA_90TO270(i,idx);
end

%% Distribution for times

for i = 1:576
[~, idx] = max(low_pooled_eventRate_BR_270TO90(i,1:350));
lowPeakTime_BR_270TO90(i) = tChopped(idx);
end

clear idx;

for i = 1:576
[~, idx] = max(low_pooled_eventRate_BR_90TO270(i,1:350));
lowPeakTime_BR_90TO270(i) = tChopped(idx);
end

clear idx;

for i = 1:576
[~, idx] = max(low_pooled_eventRate_PA_270TO90(i,252:end));
lowPeakTime_PA_270TO90(i) = t(idx+251);
end
clear idx

for i = 1:576
[~, idx] = max(low_pooled_eventRate_PA_90TO270(i,252:end));
lowPeakTime_PA_90TO270(i) = t(idx+251);
end
clear idx

for i = 1:576
[~, idx] = max(low_pooled_eventRate_BR_270TO90(i,:));
full_lowPeakTime_BR_270TO90(i) = t(idx);
end

clear idx;

for i = 1:576
[~, idx] = max(low_pooled_eventRate_BR_90TO270(i,:));
full_lowPeakTime_BR_90TO270(i) = t(idx);
end

clear idx;

for i = 1:576
[~, idx] = max(low_pooled_eventRate_PA_270TO90(i,:));
full_lowPeakTime_PA_270TO90(i) = t(idx);
end
clear idx

for i = 1:576
[~, idx] = max(low_pooled_eventRate_PA_90TO270(i,:));
full_lowPeakTime_PA_90TO270(i) = t(idx);
end
clear idx