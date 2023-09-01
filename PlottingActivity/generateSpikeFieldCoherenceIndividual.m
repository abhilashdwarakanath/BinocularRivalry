function generateSpikeFieldCoherenceIndividual

dbstop if error

%% Enumerate datasets

datasets{1} = ['B:\H07\12-06-2016\PFC\Bfsgrad1\SFC\SFC_MUASel_1000ms_IndividualLFP.mat'];
datasets{2} = ['B:\H07\13-07-2016\PFC\Bfsgrad1\SFC\SFC_MUASel_1000ms_IndividualLFP.mat'];
datasets{3} = ['B:\H07\20161019\PFC\Bfsgrad1\SFC\SFC_MUASel_1000ms_IndividualLFP.mat'];
datasets{4} = ['B:\H07\20161025\PFC\Bfsgrad1\SFC\SFC_MUASel_1000ms_IndividualLFP.mat'];
datasets{5} = ['B:\A11\20170305\PFC\Bfsgrad1\SFC\SFC_MUASel_1000ms_IndividualLFP.mat'];
datasets{6} = ['B:\A11\20170302\PFC\Bfsgrad1\SFC\SFC_MUASel_1000ms_IndividualLFP.mat'];

%% Load and average

pre_BR_ga_dominant = [];
pre_BR_ga_suppressed = [];
post_BR_ga_dominant = [];
post_BR_ga_suppressed = [];

pre_PA_ga_dominant = [];
pre_PA_ga_suppressed = [];
post_PA_ga_dominant = [];
post_PA_ga_suppressed = [];

for iBin = 1:3

for iDataset = 1:length(datasets)
    
    load(datasets{iDataset})
    
    post_BR_ga_dominant = [post_BR_ga_dominant; nanmean(SFC(iBin).sfc_BR_sel90_s270TO90_Post,3);nanmean(SFC(iBin).sfc_BR_sel270_s90TO270_Post,3)];
    post_BR_ga_suppressed = [post_BR_ga_suppressed; nanmean(SFC(iBin).sfc_BR_sel90_s90TO270_Post,3);nanmean(SFC(iBin).sfc_BR_sel270_s270TO90_Post,3)];
    pre_BR_ga_dominant = [pre_BR_ga_dominant; nanmean(SFC(iBin).sfc_BR_sel90_s270TO90_Pre,3);nanmean(SFC(iBin).sfc_BR_sel270_s90TO270_Pre,3)];
    pre_BR_ga_suppressed = [pre_BR_ga_suppressed; nanmean(SFC(iBin).sfc_BR_sel90_s90TO270_Pre,3);nanmean(SFC(iBin).sfc_BR_sel270_s270TO90_Pre,3)];
    
    post_PA_ga_dominant = [post_PA_ga_dominant; nanmean(SFC(iBin).sfc_PA_sel90_s270TO90_Post,3);nanmean(SFC(iBin).sfc_PA_sel270_s90TO270_Post,3)];
    post_PA_ga_suppressed = [post_PA_ga_suppressed; nanmean(SFC(iBin).sfc_PA_sel90_s90TO270_Post,3);nanmean(SFC(iBin).sfc_PA_sel270_s270TO90_Post,3)];
    pre_PA_ga_dominant = [pre_PA_ga_dominant; nanmean(SFC(iBin).sfc_PA_sel90_s270TO90_Pre,3);nanmean(SFC(iBin).sfc_PA_sel270_s90TO270_Pre,3)];
    pre_PA_ga_suppressed = [pre_PA_ga_suppressed; nanmean(SFC(iBin).sfc_PA_sel90_s90TO270_Pre,3);nanmean(SFC(iBin).sfc_PA_sel270_s270TO90_Pre,3)];
    
end

%% Plot

subplot(2,2,1)
shadedErrorBar(f(3:206), smooth((nanmean(pre_PA_ga_dominant(:,3:206),1))),nanstd(pre_PA_ga_dominant(:,3:206),[],1)./sqrt(size(pre_PA_ga_dominant,1)))
hold on
plot(f(3:206),smooth((nanmean(pre_PA_ga_dominant(:,3:206),1))) ,'-k','LineWidth',1)
shadedErrorBar(f(3:206), smooth((nanmean(pre_PA_ga_suppressed(:,3:206),1))),nanstd(pre_PA_ga_suppressed(:,3:206),[],1)./sqrt(size(pre_PA_ga_suppressed,1)))
plot(f(3:206),smooth((nanmean(pre_PA_ga_suppressed(:,3:206),1))) ,'--k','LineWidth',1)
axis tight
box off
xlabel('Frequency [Hz]')
ylabel('SFC')
legend('Dominant','Suppressed')
title('Pre-PA')
set(gca,'xtick',[])

subplot(2,2,2)
shadedErrorBar(f(3:206), smooth((nanmean(post_PA_ga_dominant(:,3:206),1))),nanstd(post_PA_ga_dominant(:,3:206),[],1)./sqrt(size(post_PA_ga_dominant,1)))
hold on
plot(f(3:206),smooth((nanmean(post_PA_ga_dominant(:,3:206),1))) ,'-k','LineWidth',1)
shadedErrorBar(f(3:206), smooth((nanmean(post_PA_ga_suppressed(:,3:206),1))),nanstd(post_PA_ga_suppressed(:,3:206),[],1)./sqrt(size(post_PA_ga_suppressed,1)))
plot(f(3:206),smooth((nanmean(post_PA_ga_suppressed(:,3:206),1))) ,'--k','LineWidth',1)
axis tight
box off
xlabel('Frequency [Hz]')
ylabel('SFC')
legend('Dominant','Suppressed')
title('Post-PA')
set(gca,'xtick',[])

subplot(2,2,3)
shadedErrorBar(f(3:206), smooth((nanmean(pre_BR_ga_dominant(:,3:206),1))),nanstd(pre_BR_ga_dominant(:,3:206),[],1)./sqrt(size(pre_BR_ga_dominant,1)))
hold on
plot(f(3:206),smooth((nanmean(pre_BR_ga_dominant(:,3:206),1))) ,'-r','LineWidth',1)
shadedErrorBar(f(3:206), smooth((nanmean(pre_BR_ga_suppressed(:,3:206),1))),nanstd(pre_BR_ga_suppressed(:,3:206),[],1)./sqrt(size(pre_BR_ga_suppressed,1)))
plot(f(3:206),smooth((nanmean(pre_BR_ga_suppressed(:,3:206),1))) ,'--r','LineWidth',1)
axis tight
box off
xlabel('Frequency [Hz]')
ylabel('SFC')
legend('Dominant','Suppressed')
title('Pre-BR')

subplot(2,2,4)
shadedErrorBar(f(3:206), smooth((nanmean(post_BR_ga_dominant(:,3:206),1))),nanstd(post_BR_ga_dominant(:,3:206),[],1)./sqrt(size(post_BR_ga_dominant,1)))
hold on
plot(f(3:206),smooth((nanmean(post_BR_ga_dominant(:,3:206),1))) ,'-r','LineWidth',1)
shadedErrorBar(f(3:206), smooth((nanmean(post_BR_ga_suppressed(:,3:206),1))),nanstd(post_BR_ga_suppressed(:,3:206),[],1)./sqrt(size(post_BR_ga_suppressed,1)))
plot(f(3:206),smooth((nanmean(post_BR_ga_suppressed(:,3:206),1))) ,'--r','LineWidth',1)
axis tight
box off
xlabel('Frequency [Hz]')
ylabel('SFC')
legend('Dominant','Suppressed')
title('Post-BR')

%% Statistics

f_low = 3:10;
f_beta = 42:84;
f_gamma = 124:206;

% BR
pre_BR_ga_dominant_low = pre_BR_ga_dominant(:,f_low);
pre_BR_ga_dominant_beta = pre_BR_ga_dominant(:,f_beta);
pre_BR_ga_suppressed_low = pre_BR_ga_suppressed(:,f_low);
pre_BR_ga_suppressed_beta = pre_BR_ga_suppressed(:,f_beta);
pre_BR_ga_dominant_gamma = pre_BR_ga_dominant(:,f_gamma);
pre_BR_ga_suppressed_gamma = pre_BR_ga_suppressed(:,f_gamma);

post_BR_ga_dominant_low = post_BR_ga_dominant(:,f_low);
post_BR_ga_dominant_beta = post_BR_ga_dominant(:,f_beta);
post_BR_ga_suppressed_low = post_BR_ga_suppressed(:,f_low);
post_BR_ga_suppressed_beta = post_BR_ga_suppressed(:,f_beta);
post_BR_ga_dominant_gamma = post_BR_ga_dominant(:,f_gamma);
post_BR_ga_suppressed_gamma = post_BR_ga_suppressed(:,f_gamma);

[~,p_low_dom_vs_sup_pre_BR] = ttest(pre_BR_ga_dominant_low,pre_BR_ga_suppressed_low);
sigFreqs.low_pre_BR = f(f_low(p_low_dom_vs_sup_pre_BR<=0.05));
[~,p_low_dom_vs_sup_post_BR] = ttest(post_BR_ga_dominant_low,post_BR_ga_suppressed_low);
sigFreqs.low_post_BR = f(f_low(p_low_dom_vs_sup_post_BR<=0.05));

[~,p_beta_dom_vs_sup_pre_BR] = ttest(pre_BR_ga_dominant_beta,pre_BR_ga_suppressed_beta);
sigFreqs.beta_pre_BR = f(f_beta(p_beta_dom_vs_sup_pre_BR<=0.05));
[~,p_beta_dom_vs_sup_post_BR] = ttest(post_BR_ga_dominant_beta,post_BR_ga_suppressed_beta);
sigFreqs.beta_post_BR = f(f_beta(p_beta_dom_vs_sup_post_BR<=0.05));

[~,p_gamma_dom_vs_sup_pre_BR] = ttest(pre_BR_ga_dominant_gamma,pre_BR_ga_suppressed_gamma);
sigFreqs.gamma_pre_BR = f(f_gamma(p_gamma_dom_vs_sup_pre_BR<=0.05));
[~,p_gamma_dom_vs_sup_post_BR] = ttest(post_BR_ga_dominant_gamma,post_BR_ga_suppressed_gamma);
sigFreqs.gamma_post_BR = f(f_gamma(p_gamma_dom_vs_sup_post_BR<=0.05));

% PA 
pre_PA_ga_dominant_low = pre_PA_ga_dominant(:,f_low);
pre_PA_ga_dominant_beta = pre_PA_ga_dominant(:,f_beta);
pre_PA_ga_suppressed_low = pre_PA_ga_suppressed(:,f_low);
pre_PA_ga_suppressed_beta = pre_PA_ga_suppressed(:,f_beta);
pre_PA_ga_dominant_gamma = pre_PA_ga_dominant(:,f_gamma);
pre_PA_ga_suppressed_gamma = pre_PA_ga_suppressed(:,f_gamma);

post_PA_ga_dominant_low = post_PA_ga_dominant(:,f_low);
post_PA_ga_dominant_beta = post_PA_ga_dominant(:,f_beta);
post_PA_ga_suppressed_low = post_PA_ga_suppressed(:,f_low);
post_PA_ga_suppressed_beta = post_PA_ga_suppressed(:,f_beta);
post_PA_ga_dominant_gamma = post_PA_ga_dominant(:,f_gamma);
post_PA_ga_suppressed_gamma = post_PA_ga_suppressed(:,f_gamma);

[~,p_low_dom_vs_sup_pre_PA] = ttest(pre_PA_ga_dominant_low,pre_PA_ga_suppressed_low);
sigFreqs.low_pre_PA = f(f_low(p_low_dom_vs_sup_pre_PA<=0.05));
[~,p_low_dom_vs_sup_post_PA] = ttest(post_PA_ga_dominant_low,post_PA_ga_suppressed_low);
sigFreqs.low_post_PA = f(f_low(p_low_dom_vs_sup_post_PA<=0.05));

[~,p_beta_dom_vs_sup_pre_PA] = ttest(pre_PA_ga_dominant_beta,pre_PA_ga_suppressed_beta);
sigFreqs.beta_pre_PA = f(f_beta(p_beta_dom_vs_sup_pre_PA<=0.05));
[~,p_beta_dom_vs_sup_post_PA] = ttest(post_PA_ga_dominant_beta,post_PA_ga_suppressed_beta);
sigFreqs.beta_post_PA = f(f_beta(p_beta_dom_vs_sup_post_PA<=0.05));

[~,p_gamma_dom_vs_sup_pre_PA] = ttest(pre_PA_ga_dominant_gamma,pre_PA_ga_suppressed_gamma);
sigFreqs.gamma_pre_PA = f(f_gamma(p_gamma_dom_vs_sup_pre_PA<=0.05));
[~,p_gamma_dom_vs_sup_post_PA] = ttest(post_PA_ga_dominant_gamma,post_PA_ga_suppressed_gamma);
sigFreqs.gamma_post_PA = f(f_gamma(p_gamma_dom_vs_sup_post_PA<=0.05));

cd B:\Results\SFC
mkdir Statistics
cd Statistics
save('Statistical_Testing_IndividualLFP_1000ms.mat','sigFreqs');

end
