function generateSpikeFieldPhaseLockingEnsembleSpiking

dbstop if error

%% Enumerate datasets

datasets{1} = ['B:\H07\12-06-2016\PFC\Bfsgrad1\SFC\MM_SFC_MUASel_1000ms_GlobalLFP_EnsembleSpiking.mat'];
datasets{2} = ['B:\H07\13-07-2016\PFC\Bfsgrad1\SFC\MM_SFC_MUASel_1000ms_GlobalLFP_EnsembleSpiking.mat'];
datasets{3} = ['B:\H07\20161019\PFC\Bfsgrad1\SFC\MM_SFC_MUASel_1000ms_GlobalLFP_EnsembleSpiking.mat'];
datasets{4} = ['B:\H07\20161025\PFC\Bfsgrad1\SFC\MM_SFC_MUASel_1000ms_GlobalLFP_EnsembleSpiking.mat'];
datasets{5} = ['B:\A11\20170305\PFC\Bfsgrad1\SFC\MM_SFC_MUASel_1000ms_GlobalLFP_EnsembleSpiking.mat'];
datasets{6} = ['B:\A11\20170302\PFC\Bfsgrad1\SFC\MM_SFC_MUASel_1000ms_GlobalLFP_EnsembleSpiking.mat'];

%% Load and average

for iBin = 1:4
    
    pre_BR_ga_dominant = [];
    pre_BR_ga_suppressed = [];
    post_BR_ga_dominant = [];
    post_BR_ga_suppressed = [];
    
    pre_PA_ga_dominant = [];
    pre_PA_ga_suppressed = [];
    post_PA_ga_dominant = [];
    post_PA_ga_suppressed = [];
    
    % Dominant and suppressed pooling
    for iDataset = 1:length(datasets)
        
        load(datasets{iDataset})
        
        post_BR_ga_dominant = [post_BR_ga_dominant; SFC(iBin).phi_BR_sel90_270TO90_Post;SFC(iBin).phi_BR_sel270_90TO270_Post];
        post_BR_ga_suppressed = [post_BR_ga_suppressed; SFC(iBin).phi_BR_sel90_90TO270_Post;SFC(iBin).phi_BR_sel270_270TO90_Post];
        pre_BR_ga_dominant = [pre_BR_ga_dominant; SFC(iBin).phi_BR_sel90_90TO270_Pre;SFC(iBin).phi_BR_sel270_270TO90_Pre];
        pre_BR_ga_suppressed = [pre_BR_ga_suppressed; SFC(iBin).phi_BR_sel90_270TO90_Pre;SFC(iBin).phi_BR_sel270_90TO270_Pre];
        
        post_PA_ga_dominant = [post_PA_ga_dominant; SFC(iBin).phi_PA_sel90_270TO90_Post;SFC(iBin).phi_PA_sel270_90TO270_Post];
        post_PA_ga_suppressed = [post_PA_ga_suppressed; SFC(iBin).phi_PA_sel90_90TO270_Post;SFC(iBin).phi_PA_sel270_270TO90_Post];
        pre_PA_ga_dominant = [pre_PA_ga_dominant; SFC(iBin).phi_PA_sel90_90TO270_Pre;SFC(iBin).phi_PA_sel270_270TO90_Pre];
        pre_PA_ga_suppressed = [pre_PA_ga_suppressed; SFC(iBin).phi_PA_sel90_270TO90_Pre;SFC(iBin).phi_PA_sel270_90TO270_Pre];
        
    end
    
    % Remove nan rows
    post_BR_ga_dominant(~any(~isnan(post_BR_ga_dominant), 2),:)=[];
    post_BR_ga_suppressed(~any(~isnan(post_BR_ga_suppressed), 2),:)=[];
    pre_BR_ga_dominant(~any(~isnan(pre_BR_ga_dominant), 2),:)=[];
    pre_BR_ga_suppressed(~any(~isnan(pre_BR_ga_suppressed), 2),:)=[];
    
    post_PA_ga_dominant(~any(~isnan(post_PA_ga_dominant), 2),:)=[];
    post_PA_ga_suppressed(~any(~isnan(post_PA_ga_suppressed), 2),:)=[];
    pre_PA_ga_dominant(~any(~isnan(pre_PA_ga_dominant), 2),:)=[];
    pre_PA_ga_suppressed(~any(~isnan(pre_PA_ga_suppressed), 2),:)=[];
    
    % Get the correct frequency space
    
    f1 = 0.5;
    f2 = 50;
    
    f_pre_BR = f.BR.pre(iBin).freqs;
    [~, f1_pre_BR] = min(abs(f_pre_BR-f1));
    [~, f2_pre_BR] = min(abs(f_pre_BR-f2));
    f_post_BR = f.BR.post(iBin).freqs;
    [~, f1_post_BR] = min(abs(f_post_BR-f1));
    [~, f2_post_BR] = min(abs(f_post_BR-f2));
    
    f_pre_PA = f.PA.pre(iBin).freqs;
    [~, f1_pre_PA] = min(abs(f_pre_PA-f1));
    [~, f2_pre_PA] = min(abs(f_pre_PA-f2));
    f_post_PA = f.PA.post(iBin).freqs;
    [~, f1_post_PA] = min(abs(f_post_PA-f1));
    [~, f2_post_PA] = min(abs(f_post_PA-f2));
    
    
    %% Plot
    
    subplot(2,2,3)
    shadedErrorBar(f_pre_PA(f1_pre_PA:f2_pre_PA), smooth((circ_mean(pre_PA_ga_dominant(:,f1_pre_PA:f2_pre_PA),[],1))),circ_std(pre_PA_ga_dominant(:,f1_pre_PA:f2_pre_PA),[],[],1)./sqrt(size(pre_PA_ga_dominant,1)))
    hold on
    plot(f_pre_PA(f1_pre_PA:f2_pre_PA),smooth((circ_mean(pre_PA_ga_dominant(:,f1_pre_PA:f2_pre_PA),[],1))) ,'-k','LineWidth',1)
    shadedErrorBar(f_pre_PA(f1_pre_PA:f2_pre_PA), smooth((circ_mean(pre_PA_ga_suppressed(:,f1_pre_PA:f2_pre_PA),[],1))),circ_std(pre_PA_ga_suppressed(:,f1_pre_PA:f2_pre_PA),[],[],1)./sqrt(size(pre_PA_ga_suppressed,1)))
    plot(f_pre_PA(f1_pre_PA:f2_pre_PA),smooth((circ_mean(pre_PA_ga_suppressed(:,f1_pre_PA:f2_pre_PA),[],1))) ,'--k','LineWidth',1)
    axis tight
    box off
    ylabel('Phi')
    xlabel('Frequency [Hz]')
    title('Pre-PA')
    
    subplot(2,2,4)
    shadedErrorBar(f_post_PA(f1_post_PA:f2_post_PA), smooth((circ_mean(post_PA_ga_dominant(:,f1_post_PA:f2_post_PA),[],1))),circ_std(post_PA_ga_dominant(:,f1_post_PA:f2_post_PA),[],[],1)./sqrt(size(post_PA_ga_dominant,1)))
    hold on
    plot(f_post_PA(f1_post_PA:f2_post_PA),smooth((circ_mean(post_PA_ga_dominant(:,f1_post_PA:f2_post_PA),[],1))) ,'-k','LineWidth',1)
    shadedErrorBar(f_post_PA(f1_post_PA:f2_post_PA), smooth((circ_mean(post_PA_ga_suppressed(:,f1_post_PA:f2_post_PA),[],1))),circ_std(post_PA_ga_suppressed(:,f1_post_PA:f2_post_PA),[],[],1)./sqrt(size(post_PA_ga_suppressed,1)))
    plot(f_post_PA(f1_post_PA:f2_post_PA),smooth((circ_mean(post_PA_ga_suppressed(:,f1_post_PA:f2_post_PA),[],1))) ,'--k','LineWidth',1)
    axis tight
    box off
    xlabel('Frequency [Hz]')
    title('Post-PA')
    
    subplot(2,2,1)
    shadedErrorBar(f_pre_BR(f1_pre_BR:f2_pre_BR), smooth((circ_mean(pre_BR_ga_dominant(:,f1_pre_BR:f2_pre_BR),[],1))),circ_std(pre_BR_ga_dominant(:,f1_pre_BR:f2_pre_BR),[],[],1)./sqrt(size(pre_BR_ga_dominant,1)))
    hold on
    plot(f_pre_BR(f1_pre_BR:f2_pre_BR),smooth((circ_mean(pre_BR_ga_dominant(:,f1_pre_BR:f2_pre_BR),[],1))) ,'-r','LineWidth',1)
    shadedErrorBar(f_pre_BR(f1_pre_BR:f2_pre_BR), smooth((circ_mean(pre_BR_ga_suppressed(:,f1_pre_BR:f2_pre_BR),[],1))),circ_std(pre_BR_ga_suppressed(:,f1_pre_BR:f2_pre_BR),[],[],1)./sqrt(size(pre_BR_ga_suppressed,1)))
    plot(f_pre_BR(f1_pre_BR:f2_pre_BR),smooth((circ_mean(pre_BR_ga_suppressed(:,f1_pre_BR:f2_pre_BR),[],1))) ,'--r','LineWidth',1)
    axis tight
    box off
    ylabel('Phi')
    set(gca,'xtick',[])
    title('Pre-BR')
    
    subplot(2,2,2)
    shadedErrorBar(f_post_BR(f1_post_BR:f2_post_BR), smooth((circ_mean(post_BR_ga_dominant(:,f1_post_BR:f2_post_BR),[],1))),circ_std(post_BR_ga_dominant(:,f1_post_BR:f2_post_BR),[],[],1)./sqrt(size(post_BR_ga_dominant,1)))
    hold on
    plot(f_post_BR(f1_post_BR:f2_post_BR),smooth((circ_mean(post_BR_ga_dominant(:,f1_post_BR:f2_post_BR),[],1))) ,'-r','LineWidth',1)
    shadedErrorBar(f_post_BR(f1_post_BR:f2_post_BR), smooth((circ_mean(post_BR_ga_suppressed(:,f1_post_BR:f2_post_BR),[],1))),circ_std(post_BR_ga_suppressed(:,f1_post_BR:f2_post_BR),[],[],1)./sqrt(size(post_BR_ga_suppressed,1)))
    plot(f_post_BR(f1_post_BR:f2_post_BR),smooth((circ_mean(post_BR_ga_suppressed(:,f1_post_BR:f2_post_BR),[],1))) ,'--r','LineWidth',1)
    axis tight
    box off
    set(gca,'xtick',[])
    title('Post-BR')
    
    if iBin == 1
        
        titleText = ['Phi: Ensemble Spiking vs Global LFP - Full Period'];
        fileNameText = ['cutoff_raw_Phi_Ensemble_Spiking_vs_Global_LFP_Full_Period.fig'];
        
    elseif iBin == 2
        
        titleText = ['Phi: Ensemble Spiking vs Global LFP. Pre: -1:-0.5. Post: 0:0.5'];
        fileNameText = ['cutoff_raw_Phi_Ensemble_Spiking_vs_Global_LFP_Pre_-1_-0.5_Post_0_0.5.fig'];
        
    elseif iBin == 3
        
        titleText = ['Phi: Ensemble Spiking vs Global LFP. Pre: -0.5:0. Post: 0.5:1'];
        fileNameText = ['cutoff_raw_Phi_Ensemble_Spiking_vs_Global_LFP_Pre_-0.5_0_Post_0.5_1.fig'];
        
    elseif iBin == 4
        
        titleText = ['Phi: Ensemble Spiking vs Global LFP. Pre: -1:-0.25 Post: 0.25:1'];
        fileNameText = ['cutoff_raw_Phi_Ensemble_Spiking_vs_Global_LFP_Pre_-1_0.25_Post_0.25_1.fig'];
        
    end
    
    suptitle(titleText)
    
    %% Statistics
    
    [~,sigFreqs.p_dom_vs_sup_pre_PA] = ttest2(pre_PA_ga_dominant,pre_PA_ga_suppressed);
    sigFreqs.sigVec_pre_PA = sigFreqs.p_dom_vs_sup_pre_PA<=0.05;
    sigFreqs.sigVec_pre_PA = sigFreqs.sigVec_pre_PA(f1_pre_PA:f2_pre_PA);
    sigFreqs.pre_PA = f_pre_PA(sigFreqs.p_dom_vs_sup_pre_PA<=0.05);
    [~,sigFreqs.p_dom_vs_sup_post_PA] = ttest2(post_PA_ga_dominant,post_PA_ga_suppressed);
    sigFreqs.sigVec_post_PA = sigFreqs.p_dom_vs_sup_post_PA<=0.05;
    sigFreqs.sigVec_post_PA = sigFreqs.sigVec_post_PA(f1_post_PA:f2_post_PA);
    sigFreqs.post_PA = f_post_PA(sigFreqs.p_dom_vs_sup_post_PA<=0.05);
    [~,sigFreqs.p_dom_vs_sup_pre_BR] = ttest2(pre_BR_ga_dominant,pre_BR_ga_suppressed);
    sigFreqs.sigVec_pre_BR = sigFreqs.p_dom_vs_sup_pre_BR<=0.05;
    sigFreqs.sigVec_pre_BR = sigFreqs.sigVec_pre_BR(f1_pre_BR:f2_pre_BR);
    sigFreqs.pre_BR = f_pre_BR(sigFreqs.p_dom_vs_sup_pre_BR<=0.05);
    [~,sigFreqs.p_dom_vs_sup_post_BR] = ttest2(post_BR_ga_dominant,post_BR_ga_suppressed);
    sigFreqs.sigVec_post_BR = sigFreqs.p_dom_vs_sup_post_BR<=0.05;
    sigFreqs.sigVec_post_BR = sigFreqs.sigVec_post_BR(f1_post_BR:f2_post_BR);
    sigFreqs.post_BR = f_post_BR(sigFreqs.p_dom_vs_sup_post_BR<=0.05);
    
    cd B:\Results\SFC
    mkdir MM
    cd MM
    mkdir Figures
    cd Figures
    saveas(gca,fileNameText,'fig')
    cd B:\Results\SFC
    mkdir MM
    cd MM
    mkdir Statistics
    cd Statistics
    save(['sigStats_' fileNameText '.mat'],'sigFreqs');
    pause(2)
    close all
    
end
