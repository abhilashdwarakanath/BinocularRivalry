function generateEventTriggeredSpikeFieldCoherenceAndPhase

dbstop if error

%% Enumerate datasets

datasets{1} = ['B:\Results\H07\12-06-2016\Bfsgrad\PFC\MUA\Preference_Arrays\cSwitch\eventTriggered_SFC_MUASel_1000ms.mat'];
datasets{2} = ['B:\Results\H07\13-07-2016\Bfsgrad\PFC\MUA\Preference_Arrays\cSwitch\eventTriggered_SFC_MUASel_1000ms.mat'];
datasets{3} = ['B:\Results\H07\20161019\Bfsgrad\PFC\MUA\Preference_Arrays\cSwitch\eventTriggered_SFC_MUASel_1000ms.mat'];
datasets{4} = ['B:\Results\H07\20161025\Bfsgrad\PFC\MUA\Preference_Arrays\cSwitch\eventTriggered_SFC_MUASel_1000ms.mat'];
datasets{5} = ['B:\Results\A11\20170305\Bfsgrad\PFC\MUA\Preference_Arrays\cSwitch\eventTriggered_SFC_MUASel_1000ms.mat'];
datasets{6} = ['B:\Results\A11\20170302\Bfsgrad\PFC\MUA\Preference_Arrays\cSwitch\eventTriggered_SFC_MUASel_1000ms.mat'];

%% Load and collect

ga_br_dominant_post = [];
ga_br_dominant_pre = [];
ga_br_suppressed_post = [];
ga_br_suppressed_pre = [];

ga_pa_dominant_post = [];
ga_pa_dominant_pre = [];
ga_pa_suppressed_post = [];
ga_pa_suppressed_pre = [];

for iDataset = 1:length(datasets)
    
    load(datasets{iDataset})
    
    sel90_BR_270TO90_post = [];
    
    for iChan = 1:length(SFC.phi_BR_sel90_270TO90_Post)
        
        if ~isempty(SFC.phi_BR_sel90_270TO90_Post{iChan})
        
        sel90_BR_270TO90_post = [sel90_BR_270TO90_post;SFC.phi_BR_sel90_270TO90_Post{iChan}];
        
        end
        
    end
    
     sel270_BR_90TO270_post = [];
    
    for iChan = 1:length(SFC.phi_BR_sel270_90TO270_Post)
        
        if ~isempty(SFC.phi_BR_sel270_90TO270_Post{iChan})
        
        sel270_BR_90TO270_post = [sel270_BR_90TO270_post;SFC.phi_BR_sel270_90TO270_Post{iChan}];
        
        end
        
    end
    
    ga_br_dominant_post = [ga_br_dominant_post;sel90_BR_270TO90_post;sel270_BR_90TO270_post];
    
    sel90_BR_90TO270_post = [];
    
    for iChan = 1:length(SFC.phi_BR_sel90_90TO270_Post)
        
        if ~isempty(SFC.phi_BR_sel90_90TO270_Post{iChan})
        
        sel90_BR_90TO270_post = [sel90_BR_90TO270_post;SFC.phi_BR_sel90_90TO270_Post{iChan}];
        
        end
        
    end
    
     sel270_BR_270TO90_post = [];
    
    for iChan = 1:length(SFC.phi_BR_sel270_270TO90_Post)
        
        if ~isempty(SFC.phi_BR_sel270_270TO90_Post{iChan})
        
        sel270_BR_270TO90_post = [sel270_BR_270TO90_post;SFC.phi_BR_sel270_270TO90_Post{iChan}];
        
        end
        
    end
    
    ga_br_suppressed_post = [ga_br_suppressed_post;sel90_BR_90TO270_post;sel270_BR_270TO90_post];
    
    sel90_BR_90TO270_pre = [];
    
    for iChan = 1:length(SFC.phi_BR_sel90_90TO270_Pre)
        
        if ~isempty(SFC.phi_BR_sel90_90TO270_Pre{iChan})
        
        sel90_BR_90TO270_pre = [sel90_BR_90TO270_pre;SFC.phi_BR_sel90_90TO270_Pre{iChan}];
        
        end
        
    end
    
     sel270_BR_270TO90_pre = [];
    
    for iChan = 1:length(SFC.phi_BR_sel270_270TO90_Pre)
        
        if ~isempty(SFC.phi_BR_sel270_270TO90_Pre{iChan})
        
        sel270_BR_270TO90_pre = [sel270_BR_270TO90_pre;SFC.phi_BR_sel270_270TO90_Pre{iChan}];
        
        end
        
    end
    
    ga_br_dominant_pre = [ga_br_dominant_pre;sel90_BR_90TO270_pre;sel270_BR_270TO90_pre];
    
    sel90_BR_270TO90_pre = [];
    
    for iChan = 1:length(SFC.phi_BR_sel90_270TO90_Pre)
        
        if ~isempty(SFC.phi_BR_sel90_270TO90_Pre{iChan})
        
        sel90_BR_270TO90_pre = [sel90_BR_270TO90_pre;SFC.phi_BR_sel90_270TO90_Pre{iChan}];
        
        end
        
    end
    
     sel270_BR_90TO270_pre = [];
    
    for iChan = 1:length(SFC.phi_BR_sel270_90TO270_Pre)
        
        if ~isempty(SFC.phi_BR_sel270_90TO270_Pre{iChan})
        
        sel270_BR_90TO270_pre = [sel270_BR_90TO270_pre;SFC.phi_BR_sel270_90TO270_Pre{iChan}];
        
        end
        
    end
    
    ga_br_suppressed_pre = [ga_br_suppressed_pre;sel90_BR_270TO90_pre;sel270_BR_90TO270_pre];
    
    sel90_PA_270TO90_post = [];
    
    for iChan = 1:length(SFC.phi_PA_sel90_270TO90_Post)
        
        if ~isempty(SFC.phi_PA_sel90_270TO90_Post{iChan})
        
        sel90_PA_270TO90_post = [sel90_PA_270TO90_post;SFC.phi_PA_sel90_270TO90_Post{iChan}];
        
        end
        
    end
    
     sel270_PA_90TO270_post = [];
    
    for iChan = 1:length(SFC.phi_PA_sel270_90TO270_Post)
        
        if ~isempty(SFC.phi_PA_sel270_90TO270_Post{iChan})
        
        sel270_PA_90TO270_post = [sel270_PA_90TO270_post;SFC.phi_PA_sel270_90TO270_Post{iChan}];
        
        end
        
    end
    
    ga_pa_dominant_post = [ga_pa_dominant_post;sel90_PA_270TO90_post;sel270_PA_90TO270_post];
    
    sel90_PA_90TO270_post = [];
    
    for iChan = 1:length(SFC.phi_PA_sel90_90TO270_Post)
        
        if ~isempty(SFC.phi_PA_sel90_90TO270_Post{iChan})
        
        sel90_PA_90TO270_post = [sel90_PA_90TO270_post;SFC.phi_PA_sel90_90TO270_Post{iChan}];
        
        end
        
    end
    
     sel270_PA_270TO90_post = [];
    
    for iChan = 1:length(SFC.phi_PA_sel270_270TO90_Post)
        
        if ~isempty(SFC.phi_PA_sel270_270TO90_Post{iChan})
        
        sel270_PA_270TO90_post = [sel270_PA_270TO90_post;SFC.phi_PA_sel270_270TO90_Post{iChan}];
        
        end
        
    end
    
    ga_pa_suppressed_post = [ga_pa_suppressed_post;sel90_PA_90TO270_post;sel270_PA_270TO90_post];
    
    sel90_PA_90TO270_pre = [];
    
    for iChan = 1:length(SFC.phi_PA_sel90_90TO270_Pre)
        
        if ~isempty(SFC.phi_PA_sel90_90TO270_Pre{iChan})
        
        sel90_PA_90TO270_pre = [sel90_PA_90TO270_pre;SFC.phi_PA_sel90_90TO270_Pre{iChan}];
        
        end
        
    end
    
     sel270_PA_270TO90_pre = [];
    
    for iChan = 1:length(SFC.phi_PA_sel270_270TO90_Pre)
        
        if ~isempty(SFC.phi_PA_sel270_270TO90_Pre{iChan})
        
        sel270_PA_270TO90_pre = [sel270_PA_270TO90_pre;SFC.phi_PA_sel270_270TO90_Pre{iChan}];
        
        end
        
    end
    
    ga_pa_dominant_pre = [ga_pa_dominant_pre;sel90_PA_90TO270_pre;sel270_PA_270TO90_pre];
    
    sel90_PA_270TO90_pre = [];
    
    for iChan = 1:length(SFC.phi_PA_sel90_270TO90_Pre)
        
        if ~isempty(SFC.phi_PA_sel90_270TO90_Pre{iChan})
        
        sel90_PA_270TO90_pre = [sel90_PA_270TO90_pre;SFC.phi_PA_sel90_270TO90_Pre{iChan}];
        
        end
        
    end
    
     sel270_PA_90TO270_pre = [];
    
    for iChan = 1:length(SFC.phi_PA_sel270_90TO270_Pre)
        
        if ~isempty(SFC.phi_PA_sel270_90TO270_Pre{iChan})
        
        sel270_PA_90TO270_pre = [sel270_PA_90TO270_pre;SFC.phi_PA_sel270_90TO270_Pre{iChan}];
        
        end
        
    end
    
    ga_pa_suppressed_pre = [ga_pa_suppressed_pre;sel90_PA_270TO90_pre;sel270_PA_90TO270_pre];

end

%% Plot

subplot(2,2,3)
shadedErrorBar(f, smooth((circ_mean(ga_pa_dominant_pre,[],1))),circ_std(ga_pa_dominant_pre,[],[],1)./sqrt(size(ga_pa_dominant_pre,1)))
hold on
plot(f,smooth((circ_mean(ga_pa_dominant_pre,[],1))) ,'-k','LineWidth',1)
shadedErrorBar(f, smooth((circ_mean(ga_pa_suppressed_pre,[],1))),circ_std(ga_pa_suppressed_pre,[],[],1)./sqrt(size(ga_pa_suppressed_pre,1)))
plot(f,smooth((circ_mean(ga_pa_suppressed_pre,[],1))) ,'--k','LineWidth',1)
axis tight
box off
ylabel('phi')
title('Pre-PA')
xlabel('Frequency [Hz]')

subplot(2,2,4)
shadedErrorBar(f, smooth((circ_mean(ga_pa_dominant_post,[],1))),circ_std(ga_pa_dominant_post,[],[],1)./sqrt(size(ga_pa_dominant_post,1)))
hold on
plot(f,smooth((circ_mean(ga_pa_dominant_post,[],1))) ,'-k','LineWidth',1)
shadedErrorBar(f, smooth((circ_mean(ga_pa_suppressed_post,[],1))),circ_std(ga_pa_suppressed_post,[],[],1)./sqrt(size(ga_pa_suppressed_post,1)))
plot(f,smooth((circ_mean(ga_pa_suppressed_post,[],1))) ,'--k','LineWidth',1)
axis tight
box off
title('Post-PA')
xlabel('Frequency [Hz]')

subplot(2,2,1)
shadedErrorBar(f, smooth((circ_mean(ga_br_dominant_pre,[],1))),circ_std(ga_br_dominant_pre,[],[],1)./sqrt(size(ga_br_dominant_pre,1)))
hold on
plot(f,smooth((circ_mean(ga_br_dominant_pre,[],1))) ,'-r','LineWidth',1)
shadedErrorBar(f, smooth((circ_mean(ga_br_suppressed_pre,[],1))),circ_std(ga_br_suppressed_pre,[],[],1)./sqrt(size(ga_br_suppressed_pre,1)))
plot(f,smooth((circ_mean(ga_br_suppressed_pre,[],1))) ,'--r','LineWidth',1)
axis tight
box off
ylabel('phi')
title('Pre-BR')
set(gca,'xtick',[])

subplot(2,2,2)
shadedErrorBar(f, smooth((circ_mean(ga_br_dominant_post,[],1))),circ_std(ga_br_dominant_post,[],[],1)./sqrt(size(ga_br_dominant_post,1)))
hold on
plot(f,smooth((circ_mean(ga_br_dominant_post,[],1))) ,'-r','LineWidth',1)
shadedErrorBar(f, smooth((circ_mean(ga_br_suppressed_post,[],1))),circ_std(ga_br_suppressed_post,[],[],1)./sqrt(size(ga_br_suppressed_post,1)))
plot(f,smooth((circ_mean(ga_br_suppressed_post,[],1))) ,'--r','LineWidth',1)
axis tight
box off
xlabel('Frequency [Hz]')
title('Post-BR')
set(gca,'xtick',[])

%% Plot Coherence

ga_br_dominant_post = [];
ga_br_dominant_pre = [];
ga_br_suppressed_post = [];
ga_br_suppressed_pre = [];

ga_pa_dominant_post = [];
ga_pa_dominant_pre = [];
ga_pa_suppressed_post = [];
ga_pa_suppressed_pre = [];

for iDataset = 1:length(datasets)
    
    load(datasets{iDataset})
    
    sel90_BR_270TO90_post = [];
    
    for iChan = 1:length(SFC.sfc_BR_sel90_270TO90_Post)
        
        if ~isempty(SFC.sfc_BR_sel90_270TO90_Post{iChan})
        
        sel90_BR_270TO90_post = [sel90_BR_270TO90_post;SFC.sfc_BR_sel90_270TO90_Post{iChan}];
        
        end
        
    end
    
     sel270_BR_90TO270_post = [];
    
    for iChan = 1:length(SFC.sfc_BR_sel270_90TO270_Post)
        
        if ~isempty(SFC.sfc_BR_sel270_90TO270_Post{iChan})
        
        sel270_BR_90TO270_post = [sel270_BR_90TO270_post;SFC.sfc_BR_sel270_90TO270_Post{iChan}];
        
        end
        
    end
    
    ga_br_dominant_post = [ga_br_dominant_post;sel90_BR_270TO90_post;sel270_BR_90TO270_post];
    
    sel90_BR_90TO270_post = [];
    
    for iChan = 1:length(SFC.sfc_BR_sel90_90TO270_Post)
        
        if ~isempty(SFC.sfc_BR_sel90_90TO270_Post{iChan})
        
        sel90_BR_90TO270_post = [sel90_BR_90TO270_post;SFC.sfc_BR_sel90_90TO270_Post{iChan}];
        
        end
        
    end
    
     sel270_BR_270TO90_post = [];
    
    for iChan = 1:length(SFC.sfc_BR_sel270_270TO90_Post)
        
        if ~isempty(SFC.sfc_BR_sel270_270TO90_Post{iChan})
        
        sel270_BR_270TO90_post = [sel270_BR_270TO90_post;SFC.sfc_BR_sel270_270TO90_Post{iChan}];
        
        end
        
    end
    
    ga_br_suppressed_post = [ga_br_suppressed_post;sel90_BR_90TO270_post;sel270_BR_270TO90_post];
    
    sel90_BR_90TO270_pre = [];
    
    for iChan = 1:length(SFC.sfc_BR_sel90_90TO270_Pre)
        
        if ~isempty(SFC.sfc_BR_sel90_90TO270_Pre{iChan})
        
        sel90_BR_90TO270_pre = [sel90_BR_90TO270_pre;SFC.sfc_BR_sel90_90TO270_Pre{iChan}];
        
        end
        
    end
    
     sel270_BR_270TO90_pre = [];
    
    for iChan = 1:length(SFC.sfc_BR_sel270_270TO90_Pre)
        
        if ~isempty(SFC.sfc_BR_sel270_270TO90_Pre{iChan})
        
        sel270_BR_270TO90_pre = [sel270_BR_270TO90_pre;SFC.sfc_BR_sel270_270TO90_Pre{iChan}];
        
        end
        
    end
    
    ga_br_dominant_pre = [ga_br_dominant_pre;sel90_BR_90TO270_pre;sel270_BR_270TO90_pre];
    
    sel90_BR_270TO90_pre = [];
    
    for iChan = 1:length(SFC.sfc_BR_sel90_270TO90_Pre)
        
        if ~isempty(SFC.sfc_BR_sel90_270TO90_Pre{iChan})
        
        sel90_BR_270TO90_pre = [sel90_BR_270TO90_pre;SFC.sfc_BR_sel90_270TO90_Pre{iChan}];
        
        end
        
    end
    
     sel270_BR_90TO270_pre = [];
    
    for iChan = 1:length(SFC.sfc_BR_sel270_90TO270_Pre)
        
        if ~isempty(SFC.sfc_BR_sel270_90TO270_Pre{iChan})
        
        sel270_BR_90TO270_pre = [sel270_BR_90TO270_pre;SFC.sfc_BR_sel270_90TO270_Pre{iChan}];
        
        end
        
    end
    
    ga_br_suppressed_pre = [ga_br_suppressed_pre;sel90_BR_270TO90_pre;sel270_BR_90TO270_pre];
    
    sel90_PA_270TO90_post = [];
    
    for iChan = 1:length(SFC.sfc_PA_sel90_270TO90_Post)
        
        if ~isempty(SFC.sfc_PA_sel90_270TO90_Post{iChan})
        
        sel90_PA_270TO90_post = [sel90_PA_270TO90_post;SFC.sfc_PA_sel90_270TO90_Post{iChan}];
        
        end
        
    end
    
     sel270_PA_90TO270_post = [];
    
    for iChan = 1:length(SFC.sfc_PA_sel270_90TO270_Post)
        
        if ~isempty(SFC.sfc_PA_sel270_90TO270_Post{iChan})
        
        sel270_PA_90TO270_post = [sel270_PA_90TO270_post;SFC.sfc_PA_sel270_90TO270_Post{iChan}];
        
        end
        
    end
    
    ga_pa_dominant_post = [ga_pa_dominant_post;sel90_PA_270TO90_post;sel270_PA_90TO270_post];
    
    sel90_PA_90TO270_post = [];
    
    for iChan = 1:length(SFC.sfc_PA_sel90_90TO270_Post)
        
        if ~isempty(SFC.sfc_PA_sel90_90TO270_Post{iChan})
        
        sel90_PA_90TO270_post = [sel90_PA_90TO270_post;SFC.sfc_PA_sel90_90TO270_Post{iChan}];
        
        end
        
    end
    
     sel270_PA_270TO90_post = [];
    
    for iChan = 1:length(SFC.sfc_PA_sel270_270TO90_Post)
        
        if ~isempty(SFC.sfc_PA_sel270_270TO90_Post{iChan})
        
        sel270_PA_270TO90_post = [sel270_PA_270TO90_post;SFC.sfc_PA_sel270_270TO90_Post{iChan}];
        
        end
        
    end
    
    ga_pa_suppressed_post = [ga_pa_suppressed_post;sel90_PA_90TO270_post;sel270_PA_270TO90_post];
    
    sel90_PA_90TO270_pre = [];
    
    for iChan = 1:length(SFC.sfc_PA_sel90_90TO270_Pre)
        
        if ~isempty(SFC.sfc_PA_sel90_90TO270_Pre{iChan})
        
        sel90_PA_90TO270_pre = [sel90_PA_90TO270_pre;SFC.sfc_PA_sel90_90TO270_Pre{iChan}];
        
        end
        
    end
    
     sel270_PA_270TO90_pre = [];
    
    for iChan = 1:length(SFC.sfc_PA_sel270_270TO90_Pre)
        
        if ~isempty(SFC.sfc_PA_sel270_270TO90_Pre{iChan})
        
        sel270_PA_270TO90_pre = [sel270_PA_270TO90_pre;SFC.sfc_PA_sel270_270TO90_Pre{iChan}];
        
        end
        
    end
    
    ga_pa_dominant_pre = [ga_pa_dominant_pre;sel90_PA_90TO270_pre;sel270_PA_270TO90_pre];
    
    sel90_PA_270TO90_pre = [];
    
    for iChan = 1:length(SFC.sfc_PA_sel90_270TO90_Pre)
        
        if ~isempty(SFC.sfc_PA_sel90_270TO90_Pre{iChan})
        
        sel90_PA_270TO90_pre = [sel90_PA_270TO90_pre;SFC.sfc_PA_sel90_270TO90_Pre{iChan}];
        
        end
        
    end
    
     sel270_PA_90TO270_pre = [];
    
    for iChan = 1:length(SFC.sfc_PA_sel270_90TO270_Pre)
        
        if ~isempty(SFC.sfc_PA_sel270_90TO270_Pre{iChan})
        
        sel270_PA_90TO270_pre = [sel270_PA_90TO270_pre;SFC.sfc_PA_sel270_90TO270_Pre{iChan}];
        
        end
        
    end
    
    ga_pa_suppressed_pre = [ga_pa_suppressed_pre;sel90_PA_270TO90_pre;sel270_PA_90TO270_pre];

end

%% Plot

subplot(2,2,3)
shadedErrorBar(f, smooth((nanmean(ga_pa_dominant_pre,1))),nanstd(ga_pa_dominant_pre,[],1)./sqrt(size(ga_pa_dominant_pre,1)))
hold on
plot(f,smooth((nanmean(ga_pa_dominant_pre,1))) ,'-k','LineWidth',1)
shadedErrorBar(f, smooth((nanmean(ga_pa_suppressed_pre,1))),nanstd(ga_pa_suppressed_pre,[],1)./sqrt(size(ga_pa_suppressed_pre,1)))
plot(f,smooth((nanmean(ga_pa_suppressed_pre,1))) ,'--k','LineWidth',1)
axis tight
box off
ylabel('sfc')
title('Pre-PA')
xlabel('Frequency [Hz]')

subplot(2,2,4)
shadedErrorBar(f, smooth((nanmean(ga_pa_dominant_post,1))),nanstd(ga_pa_dominant_post,[],1)./sqrt(size(ga_pa_dominant_post,1)))
hold on
plot(f,smooth((nanmean(ga_pa_dominant_post,1))) ,'-k','LineWidth',1)
shadedErrorBar(f, smooth((nanmean(ga_pa_suppressed_post,1))),nanstd(ga_pa_suppressed_post,[],1)./sqrt(size(ga_pa_suppressed_post,1)))
plot(f,smooth((nanmean(ga_pa_suppressed_post,1))) ,'--k','LineWidth',1)
axis tight
box off
title('Post-PA')
xlabel('Frequency [Hz]')

subplot(2,2,1)
shadedErrorBar(f, smooth((nanmean(ga_br_dominant_pre,1))),nanstd(ga_br_dominant_pre,[],1)./sqrt(size(ga_br_dominant_pre,1)))
hold on
plot(f,smooth((nanmean(ga_br_dominant_pre,1))) ,'-r','LineWidth',1)
shadedErrorBar(f, smooth((nanmean(ga_br_suppressed_pre,1))),nanstd(ga_br_suppressed_pre,[],1)./sqrt(size(ga_br_suppressed_pre,1)))
plot(f,smooth((nanmean(ga_br_suppressed_pre,1))) ,'--r','LineWidth',1)
axis tight
box off
ylabel('sfc')
title('Pre-BR')
set(gca,'xtick',[])

subplot(2,2,2)
shadedErrorBar(f, smooth((nanmean(ga_br_dominant_post,1))),nanstd(ga_br_dominant_post,[],1)./sqrt(size(ga_br_dominant_post,1)))
hold on
plot(f,smooth((nanmean(ga_br_dominant_post,1))) ,'-r','LineWidth',1)
shadedErrorBar(f, smooth((nanmean(ga_br_suppressed_post,1))),nanstd(ga_br_suppressed_post,[],1)./sqrt(size(ga_br_suppressed_post,1)))
plot(f,smooth((nanmean(ga_br_suppressed_post,1))) ,'--r','LineWidth',1)
axis tight
box off
xlabel('Frequency [Hz]')
title('Post-BR')
set(gca,'xtick',[])
