function generateLFPtracesBaselinedPooled(duration,filtType)

% This code collects all computed spectrograms across datasets and then
% creates a grand average of selective sites during Riv and during PA_FS
% for comparison

%% Enumerate the datasets

% traces_ according to Selectivity during Rivalry

datasetsDS{1} = ['B:\H07\12-06-2016\PFC\Bfsgrad1\LFPStatistics\std4_blpCharacteristics_' num2str(duration) 'ms_Chebyshev1_' filtType '.mat'];
datasetsDS{2} = ['B:\H07\13-07-2016\PFC\Bfsgrad1\LFPStatistics\std4_blpCharacteristics_' num2str(duration) 'ms_Chebyshev1_' filtType '.mat'];
datasetsDS{3} = ['B:\H07\20161019\PFC\Bfsgrad1\LFPStatistics\std4_blpCharacteristics_' num2str(duration) 'ms_Chebyshev1_' filtType '.mat'];
datasetsDS{4} = ['B:\H07\20161025\PFC\Bfsgrad1\LFPStatistics\std4_blpCharacteristics_' num2str(duration) 'ms_Chebyshev1_' filtType '.mat'];
datasetsDS{5} = ['B:\A11\20170305\PFC\Bfsgrad1\LFPStatistics\std4_blpCharacteristics_' num2str(duration) 'ms_Chebyshev1_' filtType '.mat'];
datasetsDS{6} = ['B:\A11\20170302\PFC\Bfsgrad1\LFPStatistics\std4_blpCharacteristics_' num2str(duration) 'ms_Chebyshev1_' filtType '.mat'];

%% Plot grand average for DomSels

% collect

dom90BRtraces = [];
dom270BRtraces = [];
dom90PAtraces = [];
dom270PAtraces = [];

for iDataset = [1 2 3 4 5 6]
    
    load(datasetsDS{iDataset});
    folderName = ['B:\\Results\TracesMeans\Pooled\BaselinedNormalised\' filtType '\' num2str(duration/1000) 's'];
    mkdir(folderName)
    cd(folderName)
    
    % Do for BR 90
    c=0;
    for iElec = 1:96
        
        if ~isempty(blpCharacteristics(iElec).BR)
            
            c = c+1;
            
            dom90BRtraces = [dom90BRtraces blpCharacteristics(iElec).BR.dom90.traces'];
            dom90PAtraces = [dom90PAtraces blpCharacteristics(iElec).PA.dom90.traces'];
            
        end
        
    end
    
    c=0;
    for iElec = 1:96
        
        if ~isempty(blpCharacteristics(iElec).BR)
            
            c = c+1;
            
            dom270BRtraces = [dom270BRtraces blpCharacteristics(iElec).BR.dom270.traces'];
            dom270PAtraces = [dom270PAtraces blpCharacteristics(iElec).PA.dom270.traces'];
            
        end
        
    end
    
    
end

%% Plot the pooled traces

sigLength = size(dom90BRtraces,1);
t = linspace((-sigLength+1)/1000,(sigLength-1)/1000,sigLength);

[val,idx] = max(dom90BRtraces,[],1);
idx = find(val>500);
dom90BRtraces(:,idx) = [];
clear val; clear idx;

[val,idx] = max(dom270BRtraces,[],1);
idx = find(val>500);
dom270BRtraces(:,idx) = [];

[val,idx] = max(dom90PAtraces,[],1);
idx = find(val>500);
dom90PAtraces(:,idx) = [];
clear val; clear idx;

[val,idx] = max(dom270PAtraces,[],1);
idx = find(val>500);
dom270PAtraces(:,idx) = [];

PAtraces = [dom90PAtraces dom270PAtraces];
BRtraces = [dom90BRtraces dom270BRtraces];
baseline = mean(PAtraces,2);


figure(1)
subplot(1,2,1)
sem = normalise(std((BRtraces-baseline),[],2))/sqrt(length(t));
H(1)=shadedErrorBar(t,normalise(nanmean((BRtraces-baseline),2)),sem,'lineProps','-b');
hold on
P(1)=plot(t,normalise(nanmean((BRtraces-baseline),2)),'-r','LineWidth',3);
%sem = normalise(std(dom90PAtraces,[],2))/sqrt(length(t));
%H(2)=shadedErrorBar(t,normalise(nanmean(dom90PAtraces,2)),sem,'lineProps','-g');
hold on
%P(2)=plot(t,normalise(nanmean(dom90PAtraces,2)),'-k','LineWidth',3);
xlabel('time in s')
ylabel('lfp amplitude')
vline(0,'--k')
legend([P(1) H(1).patch], 'BR Mean', 'BR STD', 'Location', 'NorthEast');
axis tight; box off; grid on;
title(['PA and Baselined BR Pooled traces in band : ' filtType])

subplot(1,2,2)
sem = normalise(std((dom270BRtraces-baseline270),[],2))/sqrt(length(t));
H(1)=shadedErrorBar(t,normalise(nanmean((dom270BRtraces-baseline270),2)),sem,'lineProps','-b');
hold on
P(1)=plot(t,normalise(nanmean((dom270BRtraces-baseline270),2)),'-r','LineWidth',3);
%sem = normalise(std(dom270PAtraces,[],2))/sqrt(length(t));
%H(1)=shadedErrorBar(t,normalise(nanmean(dom270PAtraces,2)),sem,'lineProps','-g');
hold on
%P(2)=plot(t,normalise(nanmean(dom270PAtraces,2)),'-k','LineWidth',3);
xlabel('time in s')
ylabel('lfp amplitude')
vline(0,'--k')
legend([P(1) H(1).patch], ...
'BR 270 Mean', 'BR270 STD', ...
'Location', 'NorthEast');
title(['PA and Baselined BR Pooled traces in band : ' filtType ' Upward to Downward Switch'])
grid on; axis tight; box off;
set(gcf, 'Position', get(0, 'Screensize'));
saveas(gcf,'PooledTraces','png')
pause(2); close all;

midPoint = ceil((length(t)/2));

figure(2)
subplot(1,2,1)
sem = normalise(std((dom90BRtraces),[],2))/sqrt(length(t));
H(1)=shadedErrorBar(t,normalise(nanmean((dom90BRtraces),2)),sem,'lineProps','-b');
hold on
P(1)=plot(t,normalise(nanmean((dom90BRtraces),2)),'-r','LineWidth',3);
sem = normalise(std(dom90PAtraces,[],2))/sqrt(length(t));
H(2)=shadedErrorBar(t,normalise(nanmean(dom90PAtraces,2)),sem,'lineProps','-g');
hold on
P(2)=plot(t,normalise(nanmean(dom90PAtraces,2)),'-k','LineWidth',3);
xlabel('time in s')
ylabel('lfp amplitude')
vline(0,'--k')
P(3) = plot(0,0,'.w'); % Dummy point to act as placeholder for P-value lol
P(4) = plot(0,0,'.w');
[p1,~] = ranksum(nanmean(dom90BRtraces(1:midPoint-1,:),2),baseline90(1:midPoint-1,:));
[p2,~] = ranksum(nanmean(dom90BRtraces(midPoint:end,:),2),baseline90(midPoint:end,:));
legend([P(1) H(1).patch P(2) H(2).patch P(3) P(4)], 'BR 90 Mean', 'BR90 STD', 'PA90 Mean', 'PA90 STD', ['pre p-value = ' num2str(p1)],['post p-value = ' num2str(p2)], 'Location', 'NorthEast');
axis tight; box off; grid on;
title(['PA and BR Pooled traces in band : ' filtType ' Downward to Upward Switch'])

subplot(1,2,2)
sem = normalise(std((dom270BRtraces),[],2))/sqrt(length(t));
H(1)=shadedErrorBar(t,normalise(nanmean((dom270BRtraces),2)),sem,'lineProps','-b');
hold on
P(1)=plot(t,normalise(nanmean((dom270BRtraces),2)),'-r','LineWidth',3);
sem = normalise(std(dom270PAtraces,[],2))/sqrt(length(t));
H(2)=shadedErrorBar(t,normalise(nanmean(dom270PAtraces,2)),sem,'lineProps','-g');
hold on
P(2)=plot(t,normalise(nanmean(dom270PAtraces,2)),'-k','LineWidth',3);
xlabel('time in s')
ylabel('lfp amplitude')
vline(0,'--k')
P(3) = plot(0,0,'.w'); % Dummy point to act as placeholder for P-value lol
P(3) = plot(0,0,'.w'); % Dummy point to act as placeholder for P-value lol
P(4) = plot(0,0,'.w');
[p1,~] = ranksum(nanmean(dom270BRtraces(1:midPoint-1,:),2),baseline270(1:midPoint-1,:));
[p2,~] = ranksum(nanmean(dom270BRtraces(midPoint:end,:),2),baseline270(midPoint:end,:));
legend([P(1) H(1).patch P(2) H(2).patch P(3) P(4)], 'BR 270 Mean', 'BR270 STD', 'PA270 Mean', 'PA270 STD', ['pre-value = ' num2str(p1)],['post p-value = ' num2str(p2)], 'Location', 'NorthEast');
axis tight; box off; grid on;
title(['PA and BR Pooled traces in band : ' filtType ' Upward to Downward Switch'])
set(gcf, 'Position', get(0, 'Screensize'));
saveas(gcf,'PooledTraces_nonBaselined','png')
pause(2); close all;

ref = dom90PAtraces(:,1:size(dom90BRtraces,2));
[rho,pval] = corr(dom90BRtraces',ref');

figure(3)
subplot(1,2,1)
imagesc(t,t,pval)
vline(0,'--w')
hline(0,'--w')
colormap jet
colorbar
xlabel('time in s - BR')
ylabel('time in s - PA')
caxis([0.05 1])
title(['Upward Dominance PA vs BR trial by trial time by time p-Values :' filtType])
subplot(1,2,2)
imagesc(t,t,rho)
vline(0,'--w')
hline(0,'--w')
colormap jet
colorbar
xlabel('time in s - BR')
ylabel('time in s - PA')
caxis([0 0.035])
title(['Upward Dominance PA vs BR trial by trial time by time CorrCoeff :' filtType])
clear pval, clear rho; clear ref;
set(gcf, 'Position', get(0, 'Screensize'));
saveas(gcf,'pVals_Rho_90','png')
pause(2); close all;

ref = dom270PAtraces(:,1:size(dom270BRtraces,2));
[rho,pval] = corr(dom270BRtraces',ref');

figure(4)
subplot(1,2,1)
imagesc(t,t,pval)
vline(0,'--w')
hline(0,'--w')
colormap jet
colorbar
xlabel('time in s - BR')
ylabel('time in s - PA')
caxis([0.05 1])
title(['Downward Dominance PA vs BR trial by trial time by time p-Values :' filtType])
subplot(1,2,2)
imagesc(t,t,rho)
vline(0,'--w')
hline(0,'--w')
colormap jet
colorbar
xlabel('time in s - BR')
ylabel('time in s - PA')
caxis([0 0.035])
title(['Downward Dominance PA vs BR trial by trial time by time CorrCoeff :' filtType])
clear pval, clear rho; clear ref;
set(gcf, 'Position', get(0, 'Screensize'));
saveas(gcf,'pVals_Rho_270','png')
pause(2); close all;

