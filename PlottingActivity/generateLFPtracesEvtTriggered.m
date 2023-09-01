function generateLFPtracesEvtTriggered(duration)

% This code collects all computed spectrograms across datasets and then
% creates a grand average of selective sites during Riv and during PA_FS
% for comparison

%% Enumerate the datasets

% traces_ according to Selectivity during Rivalry

datasetsDS{1} = ['B:\H07\12-06-2016\PFC\Bfsgrad1\LFPStatistics\EventTriggeredTraces\evtTriggered_blpTraces_' num2str(duration) 'ms_Chebyshev1_'  '.mat'];
datasetsDS{2} = ['B:\H07\13-07-2016\PFC\Bfsgrad1\LFPStatistics\EventTriggeredTraces\evtTriggered_blpTraces_' num2str(duration) 'ms_Chebyshev1_'  '.mat'];
datasetsDS{3} = ['B:\H07\20161019\PFC\Bfsgrad1\LFPStatistics\EventTriggeredTraces\evtTriggered_blpTraces_' num2str(duration) 'ms_Chebyshev1_'  '.mat'];
datasetsDS{4} = ['B:\H07\20161025\PFC\Bfsgrad1\LFPStatistics\EventTriggeredTraces\evtTriggered_blpTraces_' num2str(duration) 'ms_Chebyshev1_'  '.mat'];
datasetsDS{5} = ['B:\A11\20170305\PFC\Bfsgrad1\LFPStatistics\EventTriggeredTraces\evtTriggered_blpTraces_' num2str(duration) 'ms_Chebyshev1_'  '.mat'];
datasetsDS{6} = ['B:\A11\20170302\PFC\Bfsgrad1\LFPStatistics\EventTriggeredTraces\evtTriggered_blpTraces_' num2str(duration) 'ms_Chebyshev1_'  '.mat'];

%% Plot grand average for DomSels

% collect

pre_BR_low = [];
pre_BR_beta = [];
post_PA_low = [];
post_PA_beta = [];

post_BR_low = [];
post_BR_beta = [];
pre_PA_low = [];
pre_PA_beta = [];

for iDataset = [1 2 3 4 5 6]
    
    load(datasetsDS{iDataset});
    folderName = ['B:\Results\TracesMeans\Pooled\EventTriggered\std4\' num2str(duration/1000) 's'];
    mkdir(folderName)
    cd(folderName)
    
    for i = 1:96
        pre_BR_low = zscore([pre_BR_low abs(hilbert(eventTriggeredTraces(i).BR.dom90.Pre.low)) abs(hilbert(eventTriggeredTraces(i).BR.dom270.Pre.low))],[],1);
        pre_BR_beta = zscore([pre_BR_beta abs(hilbert(eventTriggeredTraces(i).BR.dom90.Pre.beta)) abs(hilbert(eventTriggeredTraces(i).BR.dom270.Pre.beta))],[],1);
        post_PA_low = zscore([post_PA_low abs(hilbert(eventTriggeredTraces(i).PA.dom90.Post.low)) abs(hilbert(eventTriggeredTraces(i).PA.dom270.Post.low))],[],1);
        post_PA_beta = zscore([post_PA_beta abs(hilbert(eventTriggeredTraces(i).PA.dom90.Post.beta)) abs(hilbert(eventTriggeredTraces(i).PA.dom270.Post.beta))],[],1);
        
        post_BR_low = zscore([post_BR_low abs(hilbert(eventTriggeredTraces(i).BR.dom90.Post.low)) abs(hilbert(eventTriggeredTraces(i).BR.dom270.Post.low))],[],1);
        post_BR_beta = zscore([post_BR_beta abs(hilbert(eventTriggeredTraces(i).BR.dom90.Post.beta)) abs(hilbert(eventTriggeredTraces(i).BR.dom270.Post.beta))],[],1);
        pre_PA_low = zscore([pre_PA_low abs(hilbert(eventTriggeredTraces(i).PA.dom90.Pre.low)) abs(hilbert(eventTriggeredTraces(i).PA.dom270.Pre.low))],[],1);
        pre_PA_beta = zscore([pre_PA_beta abs(hilbert(eventTriggeredTraces(i).PA.dom90.Pre.beta)) abs(hilbert(eventTriggeredTraces(i).PA.dom270.Pre.beta))],[],1);
    end
    
end



%% Plot the pooled traces

t = linspace(-0.35,0.35,350);

sem_BR_low_pre = std(pre_BR_low,[],2)./sqrt(350);
sem_BR_beta_pre = std(pre_BR_beta,[],2)./sqrt(350);
sem_PA_low_post = std(post_PA_low,[],2)./sqrt(350);
sem_PA_beta_post = std(post_PA_beta,[],2)./sqrt(350);

sem_BR_low_post = std(post_BR_low,[],2)./sqrt(350);
sem_BR_beta_post = std(post_BR_beta,[],2)./sqrt(350);
sem_PA_low_pre = std(pre_PA_low,[],2)./sqrt(350);
sem_PA_beta_pre = std(pre_PA_beta,[],2)./sqrt(350);


figure(2)

subplot(2,2,1)
H(1)=shadedErrorBar(t,normalise(nanmean((pre_BR_low),2)),(sem_BR_low_pre));
hold on
P(1)=plot(t,normalise(nanmean((pre_BR_low),2)),'-r','LineWidth',3);
H(2)=shadedErrorBar(t,normalise(nanmean((pre_BR_beta),2)),sem_BR_beta_pre);
P(2)=plot(t,normalise(nanmean(pre_BR_beta,2)),'--r','LineWidth',3);
xlabel('time in s')
ylabel('lfp amplitude')
axis tight;
box off; grid on;
vline(0,'--k')
legend([P(1) H(1).patch P(2) H(2).patch], 'BR Pre Low', 'BR Pre Low SEM', 'BR Pre Beta', 'BR Pre Beta SEM', 'Location','SouthEast');
title(['Low event triggered Beta-Low Overlay - Pre Switch - BR'])

subplot(2,2,2)
H(1)=shadedErrorBar(t,normalise(nanmean((pre_PA_low),2)),sem_PA_low_pre);
hold on
P(1)=plot(t,normalise(nanmean((pre_PA_low),2)),'-k','LineWidth',3);
H(2)=shadedErrorBar(t,normalise(nanmean((pre_PA_beta),2)),sem_PA_beta_pre);
P(2)=plot(t,normalise(nanmean(pre_PA_beta,2)),'--k','LineWidth',3);
xlabel('time in s')
ylabel('lfp amplitude')
axis tight;
box off; grid on;
vline(0,'--k')
legend([P(1) H(1).patch P(2) H(2).patch], 'PA Pre Low', 'PA Pre Low SEM', 'PA Pre Beta', 'PA Pre Beta SEM', 'Location','SouthEast');
title(['Low event triggered Beta-Low Overlay - Pre Switch - PA'])

subplot(2,2,3)
H(1)=shadedErrorBar(t,normalise(nanmean((post_BR_low),2)),sem_BR_low_post);
hold on
P(1)=plot(t,normalise(nanmean((post_BR_low),2)),'-r','LineWidth',3);
H(2)=shadedErrorBar(t,normalise(nanmean((post_BR_beta),2)),sem_BR_beta_post);
P(2)=plot(t,normalise(nanmean(post_BR_beta,2)),'--r','LineWidth',3);
xlabel('time in s')
ylabel('lfp amplitude')
axis tight;
box off; grid on;
vline(0,'--k')
legend([P(1) H(1).patch P(2) H(2).patch], 'BR post Low', 'BR post Low SEM', 'BR post Beta', 'BR post Beta SEM', 'Location','SouthEast');
title(['Low event triggered Beta-Low Overlay - post Switch - BR'])

subplot(2,2,4)
H(1)=shadedErrorBar(t,normalise(nanmean((post_PA_low),2)),sem_PA_low_post);
hold on
P(1)=plot(t,normalise(nanmean((post_PA_low),2)),'-k','LineWidth',3);
H(2)=shadedErrorBar(t,normalise(nanmean((post_PA_beta),2)),sem_PA_beta_post);
P(2)=plot(t,normalise(nanmean(post_PA_beta,2)),'--k','LineWidth',3);
xlabel('time in s')
ylabel('lfp amplitude')
axis tight;
box off; grid on;
vline(0,'--k')
legend([P(1) H(1).patch P(2) H(2).patch], 'PA post Low', 'PA post Low SEM', 'PA post Beta', 'PA post Beta SEM', 'Location','SouthEast');
title(['Low event triggered Beta-Low Overlay - post Switch - PA'])
%set(gcf, 'Position', get(0, 'Screensize'));
saveas(gcf,'EventTriggered_Normalised_Hilbert_Traces','png')
saveas(gcf,'EventTriggered_Normalised_Hilbert_Traces','fig')

%% Do the spectrograms

pre_BR = [];
post_PA = [];

pre_BR_norm1 = [];
pre_BR_norm2 = [];

post_PA_norm1 = [];
post_PA_norm2 = [];

for iDataset = [1 2 3 4 5 6]
    
    load(datasetsDS{iDataset});
    folderName = ['B:\Results\TracesMeans\Pooled\EventTriggered\Spectrograms\' num2str(duration/1000) 's'];
    mkdir(folderName)
    cd(folderName)
    
    for iChan = 1:96
        
        if ~isempty(eventTriggeredTraces(iChan).BR.dom90.Pre.specgram) && ~isempty(eventTriggeredTraces(iChan).BR.dom270.Pre.specgram)
            pre_BR = cat(3,pre_BR, cat(3,eventTriggeredTraces(iChan).BR.dom90.Pre.specgram,eventTriggeredTraces(iChan).BR.dom270.Pre.specgram));
        end
        
         if ~isempty(eventTriggeredTraces(iChan).PA.dom90.Post.specgram) && ~isempty(eventTriggeredTraces(iChan).PA.dom270.Post.specgram)
            post_PA = cat(3,post_PA, cat(3,eventTriggeredTraces(iChan).PA.dom90.Post.specgram,eventTriggeredTraces(iChan).PA.dom270.Post.specgram));
        end
        
         if ~isempty(eventTriggeredTraces(iChan).BR.dom90.Pre.specgram_norm1) && ~isempty(eventTriggeredTraces(iChan).BR.dom270.Pre.specgram_norm1)
            pre_BR_norm1 = cat(3,pre_BR_norm1, cat(3,eventTriggeredTraces(iChan).BR.dom90.Pre.specgram_norm1,eventTriggeredTraces(iChan).BR.dom270.Pre.specgram_norm1));
        end
        
         if ~isempty(eventTriggeredTraces(iChan).PA.dom90.Post.specgram_norm1) && ~isempty(eventTriggeredTraces(iChan).PA.dom270.Post.specgram_norm1)
            post_PA_norm1 = cat(3,post_PA_norm1, cat(3,eventTriggeredTraces(iChan).PA.dom90.Post.specgram_norm1,eventTriggeredTraces(iChan).PA.dom270.Post.specgram_norm1));
        end
        
         if ~isempty(eventTriggeredTraces(iChan).BR.dom90.Pre.specgram_norm2) && ~isempty(eventTriggeredTraces(iChan).BR.dom270.Pre.specgram_norm2)
            pre_BR_norm2 = cat(3,pre_BR_norm2, cat(3,eventTriggeredTraces(iChan).BR.dom90.Pre.specgram_norm2,eventTriggeredTraces(iChan).BR.dom270.Pre.specgram_norm2));
        end
        
         if ~isempty(eventTriggeredTraces(iChan).PA.dom90.Post.specgram_norm2) && ~isempty(eventTriggeredTraces(iChan).PA.dom270.Post.specgram_norm2)
            post_PA_norm2 = cat(3,post_PA_norm2, cat(3,eventTriggeredTraces(iChan).PA.dom90.Post.specgram_norm2,eventTriggeredTraces(iChan).PA.dom270.Post.specgram_norm2));
        end
        
    end
    
end

ga_pre_BR_norm1 = nanmean(pre_BR_norm1,3);
ga_pre_BR_norm2 = nanmean(pre_BR_norm2,3);

ga_post_PA_norm1 = nanmean(post_PA_norm1,3);
ga_post_PA_norm2 = nanmean(post_PA_norm2,3);

ga_pre_BR = nanmean(pre_BR,3);
ga_post_PA = nanmean(post_PA,3);

% Plot

Yticks = 2.^(round(log2(min(f))):round(log2(max(f))));

figure(100)
subplot(1,2,1)
imagesc(t,log2((f)),ga_pre_BR_norm1); shading('interp')
xlabel('time in s');
ylabel('Hz')
vline(0,'--w'); AX = gca;
set(AX, 'YTick',log2(Yticks(:)), 'YTickLabel',num2str(sprintf('%g\n',Yticks)))
AX.YLim = log2([min(f), max(f)]);
axis xy
colormap jet
colorbar
AX = gca;
AX.CLim = [0 0.5];
title('Pre-BR - Event Triggered - Pooled')
subplot(1,2,2)
imagesc(t,log2((f)),ga_post_PA_norm1); shading('interp')
xlabel('time in s');
ylabel('Hz')
vline(0,'--w'); AX = gca;
set(AX, 'YTick',log2(Yticks(:)), 'YTickLabel',num2str(sprintf('%g\n',Yticks)))
AX.YLim = log2([min(f), max(f)]);
axis xy
colormap jet
AX = gca;
colorbar
AX.CLim = [0 0.5];
title('PostPA - Event Triggered - Pooled')
saveas(gcf,'FreqZscored_LogScale_05s_EventTriggered_Specgrams','png')
saveas(gcf,'FreqZscored_LogScale_05s_EventTriggered_Specgrams','fig')

figure(200)
subplot(1,2,1)
imagesc(t,log2((f)),ga_pre_BR_norm2); shading('interp')
xlabel('time in s');
ylabel('Hz')
vline(0,'--w'); AX = gca;
set(AX, 'YTick',log2(Yticks(:)), 'YTickLabel',num2str(sprintf('%g\n',Yticks)))
AX.YLim = log2([min(f), max(f)]);
axis xy
colormap jet
colorbar
AX = gca;
AX.CLim = [0 0.5];
title('Pre-BR - Event Triggered - Pooled')
subplot(1,2,2)
imagesc(t,log2((f)),ga_post_PA_norm2); shading('interp')
xlabel('time in s');
ylabel('Hz')
vline(0,'--w'); AX = gca;
set(AX, 'YTick',log2(Yticks(:)), 'YTickLabel',num2str(sprintf('%g\n',Yticks)))
AX.YLim = log2([min(f), max(f)]);
axis xy
colormap jet
AX = gca;
colorbar
AX.CLim = [0 0.5];
title('PostPA - Event Triggered - Pooled')
saveas(gcf,'TimeZscored_LogScale_05s_EventTriggered_Specgrams','png')
saveas(gcf,'TimeZscored_LogScale_05s_EventTriggered_Specgrams','fig')

figure(300)
subplot(1,2,1)
pcolor(t,log2((f)),ga_pre_BR-mean(mean(ga_pre_BR))); shading('interp')
xlabel('time in s');
ylabel('Hz')
vline(0,'--w'); AX = gca;
set(AX, 'YTick',log2(Yticks(:)), 'YTickLabel',num2str(sprintf('%g\n',Yticks)))
AX.YLim = log2([min(f), max(f)]);
axis xy
colormap jet
colorbar
AX = gca;
AX.CLim = [0 50];
title('Pre-BR - Event Triggered - Pooled')
subplot(1,2,2)
pcolor(t,log2((f)),ga_post_PA-mean(mean(ga_post_PA))); shading('interp')
xlabel('time in s');
ylabel('Hz')
vline(0,'--w'); AX = gca;
set(AX, 'YTick',log2(Yticks(:)), 'YTickLabel',num2str(sprintf('%g\n',Yticks)))
AX.YLim = log2([min(f), max(f)]);
axis xy
colormap jet
AX = gca;
colorbar
AX.CLim = [0 50];
title('PostPA - Event Triggered - Pooled')
saveas(gcf,'Raw_LogScale_05s_EventTriggered_Specgrams','png')
saveas(gcf,'Raw_LogScale_05s_EventTriggered_Specgrams','fig')

