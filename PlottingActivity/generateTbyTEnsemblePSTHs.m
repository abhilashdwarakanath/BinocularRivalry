function generateTbyTEnsemblePSTHs

dbstop if error

datasets{1} = 'B:\H07\12-06-2016\PFC\Bfsgrad1';
recDate{1} = '12062016';
fileID{1} = '12-06-2016';
subjID{1} = 'Hayo';
datasets{2} = 'B:\H07\13-07-2016\PFC\Bfsgrad1';
recDate{2} = '13072016';
fileID{2} = '13-07-2016';
subjID{2} = 'Hayo';
datasets{3} = 'B:\H07\20161019\PFC\Bfsgrad1';
recDate{3} = '19102016';
fileID{3} = '20161019';
subjID{3} = 'Hayo';
datasets{4} = 'B:\H07\20161025\PFC\Bfsgrad1';
recDate{4} = '25102016';
fileID{4} = '20161025';
subjID{4} = 'Hayo';
datasets{5} = 'B:\A11\20170305\PFC\Bfsgrad1';
recDate{5} = '05032017';
fileID{5} = '20170305';
subjID{5} = 'Anton';
datasets{6} = 'B:\A11\20170302\PFC\Bfsgrad1';
recDate{6} = '02032017';
fileID{6} = '20170302';
subjID{6} = 'Anton';

prefInfoPaths{1} = 'B:\Results\H07\12-06-2016\Bfsgrad\PFC\MUA_SUA\Preference_Arrays\cSwitch';
prefInfoPaths{2} = 'B:\Results\H07\13-07-2016\Bfsgrad\PFC\MUA_SUA\Preference_Arrays\cSwitch';
prefInfoPaths{3} = 'B:\Results\H07\20161019\Bfsgrad\PFC\MUA_SUA\Preference_Arrays\cSwitch';
prefInfoPaths{4} = 'B:\Results\H07\20161025\Bfsgrad\PFC\MUA_SUA\Preference_Arrays\cSwitch';
prefInfoPaths{5} = 'B:\Results\A11\20170305\Bfsgrad\PFC\MUA_SUA\Preference_Arrays\cSwitch';
prefInfoPaths{6} = 'B:\Results\A11\20170302\Bfsgrad\PFC\MUA_SUA\Preference_Arrays\cSwitch';

%% Load SU Spikes By Time

for iDataset = 1:length(datasets)
    
    cd(datasets{iDataset})
    load SUMUSpikesByTime.mat
    load('Su_info.mat')
    
    cd(prefInfoPaths{iDataset})
    load('1000_250_1000_DF_pref_array_switch.mat')
    
%     pref90_br = find(pref_array_switch.pref_sim_switch_Riv_BsAs.com_sig_u(:,2)==2);
%     pref90_br = pref_array_switch.pref_sim_switch_Riv_BsAs.com_sig_u(pref90_br,3);
%     
%     pref270_br = find(pref_array_switch.pref_sim_switch_Riv_BsAs.com_sig_u(:,2)==1);
%     pref270_br = pref_array_switch.pref_sim_switch_Riv_BsAs.com_sig_u(pref270_br,3);
%     
%     pref90_pa = find(pref_array_switch.pref_sim_switch_Phy_BsAs.com_sig_u(:,2)==2);
%     pref90_pa = pref_array_switch.pref_sim_switch_Phy_BsAs.com_sig_u(pref90_pa,3);
%     
%     pref270_pa = find(pref_array_switch.pref_sim_switch_Phy_BsAs.com_sig_u(:,2)==1);
%     pref270_pa = pref_array_switch.pref_sim_switch_Phy_BsAs.com_sig_u(pref270_pa,3);

%     pref_90 = [pref90_pa pref90_br];
%     pref_270 = [pref270_pa pref90_br];
    

%% Different selectivity
    pref90_br_bs = find(pref_array_switch.pref_sim_switch_Riv_BsAs.pri_sig_u(:,2)==2);
    pref90_br_as = find(pref_array_switch.pref_sim_switch_Riv_BsAs.sec_sig_u(:,2)==2);
    pref90_br_bsas = find(pref_array_switch.pref_sim_switch_Riv_BsAs.com_sig_u(:,2)==2);
    pref90_br_bs = pref_array_switch.pref_sim_switch_Riv_BsAs.pri_sig_u(pref90_br_bs,3);
    pref90_br_as = pref_array_switch.pref_sim_switch_Riv_BsAs.sec_sig_u(pref90_br_as,3);
    pref90_br_bsas = pref_array_switch.pref_sim_switch_Riv_BsAs.com_sig_u(pref90_br_bsas,3);
    
    pref90_br = unique([pref90_br_bs;pref90_br_as;pref90_br_bsas]);
    
    
    pref270_br_bs = find(pref_array_switch.pref_sim_switch_Riv_BsAs.pri_sig_u(:,2)==1);
    pref270_br_as = find(pref_array_switch.pref_sim_switch_Riv_BsAs.sec_sig_u(:,2)==1);
    pref270_br_bsas = find(pref_array_switch.pref_sim_switch_Riv_BsAs.com_sig_u(:,2)==1);
    pref270_br_bs = pref_array_switch.pref_sim_switch_Riv_BsAs.pri_sig_u(pref270_br_bs,3);
    pref270_br_as = pref_array_switch.pref_sim_switch_Riv_BsAs.sec_sig_u(pref270_br_as,3);
    pref270_br_bsas = pref_array_switch.pref_sim_switch_Riv_BsAs.com_sig_u(pref270_br_bsas,3);
    
    pref270_br = unique([pref270_br_bs;pref270_br_as;pref270_br_bsas]);
    
    pref90_pa_bs = find(pref_array_switch.pref_sim_switch_Phy_BsAs.pri_sig_u(:,2)==2);
    pref90_pa_as = find(pref_array_switch.pref_sim_switch_Phy_BsAs.sec_sig_u(:,2)==2);
    pref90_pa_bsas = find(pref_array_switch.pref_sim_switch_Phy_BsAs.com_sig_u(:,2)==2);
    pref90_pa_bs = pref_array_switch.pref_sim_switch_Phy_BsAs.pri_sig_u(pref90_pa_bs,3);
    pref90_pa_as = pref_array_switch.pref_sim_switch_Phy_BsAs.sec_sig_u(pref90_pa_as,3);
    pref90_pa_bsas = pref_array_switch.pref_sim_switch_Phy_BsAs.com_sig_u(pref90_pa_bsas,3);
    
    pref90_pa = unique([pref90_pa_bs;pref90_pa_as;pref90_pa_bsas]);
    
    
    pref270_pa_bs = find(pref_array_switch.pref_sim_switch_Phy_BsAs.pri_sig_u(:,2)==1);
    pref270_pa_as = find(pref_array_switch.pref_sim_switch_Phy_BsAs.sec_sig_u(:,2)==1);
    pref270_pa_bsas = find(pref_array_switch.pref_sim_switch_Phy_BsAs.com_sig_u(:,2)==1);
    pref270_pa_bs = pref_array_switch.pref_sim_switch_Phy_BsAs.pri_sig_u(pref270_pa_bs,3);
    pref270_pa_as = pref_array_switch.pref_sim_switch_Phy_BsAs.sec_sig_u(pref270_pa_as,3);
    pref270_pa_bsas = pref_array_switch.pref_sim_switch_Phy_BsAs.com_sig_u(pref270_pa_bsas,3);
    
    pref270_pa = unique([pref270_pa_bs;pref270_pa_as;pref270_pa_bsas]);
    
    pref_90 = [pref90_pa pref90_br];
    pref_270 = [pref270_pa pref90_br];
    
    %% Params
    
    durs.switch = 250;
    durs.domForward = 1000;
    durs.domBehind = 1000;
    
    t = linspace(-durs.domForward,durs.domBehind,durs.domForward*2);
    
    %% Convert data structure
    
    % this is necessary to maitain compatability between MUA and SUA codes.
    
    % initiate variables
    
    num_su = 0;
    SUspikes_t = struct;
    SUspikes_t = [];
    spk_flashDom_su = [];
    
    
    % collect all the data
    
    for iChan = 1:length(SUMUspikes.data)
        
        if isstruct(SUMUspikes.data{iChan})
            
            for iSu = 1:size(SUMUspikes.data{iChan}.spikesUnaligned,2)
                
                num_su = num_su + 1;
                
                SUspikes_t.data{num_su}.spikesUnaligned = SUMUspikes.data{iChan}.spikesUnaligned{iSu};
                spk_flashDom_su{num_su} = SUMUspikes.data{iChan}.spikesUnaligned{iSu};
                
                %     keep information about channel number and SU_idx
                SUspikes_t.Info(num_su,:) = [iChan iSu];
                SUspikes_t.data{num_su}.okn.trace = SUMUspikes.data{iChan}.okn.trace;
            end
            
        end
        
    end
    
    nSU = num_su;
    params.elecs = nSU;
    params.conditions = 8;
    
    %% Collect clean dominances
    
    % Load relevant LFPs and Spikes
    cd(datasets{iDataset})
    
    eventfile = 'finalevents_audio.mat';
    %spikeFile = 'jMUSpikesByTime.mat';
    qnxfile = [subjID{iDataset} '_' recDate{iDataset} '_' 'Bfsgrad1' '.dgz'];
    
    load('jMUSpikesByTime.mat')
    
    fprintf('Processing Dataset %d of : %d \n',iDataset,6)
    
    % Compute Statistics and Spectrograms
    
    sav_dir = [datasets{iDataset} '\EnsemblePSTHs'];
    mkdir(sav_dir)
    if strcmp(subjID{iDataset},'Hayo')==1
        monkID = 'H07';
    else
        monkID = 'A11';
    end
    
    trialInformation = collectTrialInformationMM(params,qnxfile,eventfile,'pfc','spikes');
    [spikingActivity] = collectCleanDominancesSpikesMM(params,SUspikes_t,durs);
    
    %% Collect BR
    
    for iChan = 1:nSU
        c = 0;
        for iCond = 1:length(spikingActivity.validSection.BR.data.dom90{iChan})
            for iSwitch = 1:length(spikingActivity.validSection.BR.data.dom90{iChan}{iCond})
                c = c+1;
                cleanSwitches.BR.s270TO90{iChan}{c} = spikingActivity.validSection.BR.data.dom90{iChan}{iCond}{iSwitch};
            end
        end
    end
    for iChan = 1:nSU
        c = 0;
        for iCond = 1:length(spikingActivity.validSection.BR.data.dom270{iChan})
            for iSwitch = 1:length(spikingActivity.validSection.BR.data.dom270{iChan}{iCond})
                c = c+1;
                cleanSwitches.BR.s90TO270{iChan}{c} = spikingActivity.validSection.BR.data.dom270{iChan}{iCond}{iSwitch};
            end
        end
    end
    %% Collect PA
    for iChan = 1:nSU
        c = 0;
        for iCond = 5:length(spikingActivity.validSection.PA.data.dom90{iChan})
            for iSwitch = 1:length(spikingActivity.validSection.PA.data.dom90{iChan}{iCond})
                c = c+1;
                cleanSwitches.PA.s270TO90{iChan}{c} = spikingActivity.validSection.PA.data.dom90{iChan}{iCond}{iSwitch};
            end
        end
    end
    for iChan = 1:nSU
        c = 0;
        for iCond = 5:length(spikingActivity.validSection.PA.data.dom270{iChan})
            for iSwitch = 1:length(spikingActivity.validSection.PA.data.dom270{iChan}{iCond})
                c = c+1;
                cleanSwitches.PA.s90TO270{iChan}{c} = spikingActivity.validSection.PA.data.dom270{iChan}{iCond}{iSwitch};
            end
        end
    end
    
    %% Do binning
    
    edges = -1000:10:1000;
    
    % Sel 270, 270TO90
    for iSwitch = 1:length(cleanSwitches.BR.s270TO90{1})
        c = 0;
        for iSU = 1:length(pref270_br)
            c = c+1;
            piece = (cleanSwitches.BR.s270TO90{pref270_br(iSU)}{iSwitch});
            if ~isempty(piece)
                
                for nSpk = 1:length(piece)
                    val = piece(nSpk); %value to find
                    tmp = abs(t-val);
                    [idx idx] = min(tmp); %index of closest value
                    spkIdx(nSpk) = idx;
                end
            else
                spkIdx = [];
            end
            
            spikeTrain = zeros(1,length(t));
            spikeTrain(spkIdx) = 1;
            
            if ~isempty(piece)
                sdf_br_sel270_s270TO90(iSwitch,iSU,:) = histc(piece,edges);
            else
                sdf_br_sel270_s270TO90(iSwitch,iSU,:) = zeros(1,length(edges));
            end
            
        end
        
    end
    
%     sdf_br_sel270_s270TO90 = sum(sdf_br_sel270_s270TO90,2);
%     sdf_br_sel270_s270TO90 = squeeze(sdf_br_sel270_s270TO90);
    
    if ~isempty(pref90_br)
        for iSwitch = 1:length(cleanSwitches.BR.s270TO90{1})
            c = 0;
            for iSU = 1:length(pref90_br)
                c = c+1;
                piece = (cleanSwitches.BR.s270TO90{pref90_br(iSU)}{iSwitch});
                if ~isempty(piece)
                    
                    for nSpk = 1:length(piece)
                        val = piece(nSpk); %value to find
                        tmp = abs(t-val);
                        [idx idx] = min(tmp); %index of closest value
                        spkIdx(nSpk) = idx;
                    end
                else
                    spkIdx = [];
                end
                
                spikeTrain = zeros(1,length(t));
                spikeTrain(spkIdx) = 1;
                
                if ~isempty(piece)
                    sdf_br_sel90_s270TO90(iSwitch,iSU,:) = histc(piece,edges);
                else
                    sdf_br_sel90_s270TO90(iSwitch,iSU,:) = zeros(1,length(edges));
                end
            end
            
        end
        
    else
        
        sdf_br_sel90_s270TO90 = zeros(1,length(edges));
        
    end
    
%     sdf_br_sel90_s270TO90 = sum(sdf_br_sel90_s270TO90,2);
%     sdf_br_sel90_s270TO90 = squeeze(sdf_br_sel90_s270TO90);
    
    
    % Sel 270, 90TO270
    for iSwitch = 1:length(cleanSwitches.BR.s90TO270{1})
        c = 0;
        for iSU = 1:length(pref270_br)
            c = c+1;
            piece = (cleanSwitches.BR.s90TO270{pref270_br(iSU)}{iSwitch});
            if ~isempty(piece)
                
                for nSpk = 1:length(piece)
                    val = piece(nSpk); %value to find
                    tmp = abs(t-val);
                    [idx idx] = min(tmp); %index of closest value
                    spkIdx(nSpk) = idx;
                end
            else
                spkIdx = [];
            end
            
            spikeTrain = zeros(1,length(t));
            spikeTrain(spkIdx) = 1;
            
            if ~isempty(piece)
                sdf_br_sel270_s90TO270(iSwitch,iSU,:) = histc(piece,edges);
            else
                sdf_br_sel270_s90TO270(iSwitch,iSU,:) = zeros(1,length(edges));
            end
            
        end
        
    end
    
%     sdf_br_sel270_s90TO270 = sum(sdf_br_sel270_s90TO270,2);
%     sdf_br_sel270_s90TO270 = squeeze(sdf_br_sel270_s90TO270);
    
    if ~isempty(pref90_br)
        
        for iSwitch = 1:length(cleanSwitches.BR.s90TO270{1})
            c = 0;
            for iSU = 1:length(pref90_br)
                c = c+1;
                piece = (cleanSwitches.BR.s90TO270{pref90_br(iSU)}{iSwitch});
                if ~isempty(piece)
                    
                    for nSpk = 1:length(piece)
                        val = piece(nSpk); %value to find
                        tmp = abs(t-val);
                        [idx idx] = min(tmp); %index of closest value
                        spkIdx(nSpk) = idx;
                    end
                else
                    spkIdx = [];
                end
                
                spikeTrain = zeros(1,length(t));
                spikeTrain(spkIdx) = 1;
                
                if ~isempty(piece)
                    sdf_br_sel90_s90TO270(iSwitch,iSU,:) = histc(piece,edges);
                else
                    sdf_br_sel90_s90TO270(iSwitch,iSU,:) = zeros(1,length(edges));
                end
            end
            
        end
        
    else
        
        sdf_br_sel90_s90TO270 = zeros(1,length(edges));
    end
    
%     sdf_br_sel90_s90TO270 = sum(sdf_br_sel90_s90TO270,2);
%     sdf_br_sel90_s90TO270 = squeeze(sdf_br_sel90_s90TO270);
    
    
    %% Do for Chronux PA
    
    % Sel 270, 270TO90
    for iSwitch = 1:length(cleanSwitches.PA.s270TO90{1})
        c = 0;
        for iSU = 1:length(pref270_pa)
            c = c+1;
            piece = (cleanSwitches.PA.s270TO90{pref270_pa(iSU)}{iSwitch});
            if ~isempty(piece)
                
                for nSpk = 1:length(piece)
                    val = piece(nSpk); %value to find
                    tmp = abs(t-val);
                    [idx idx] = min(tmp); %index of closest value
                    spkIdx(nSpk) = idx;
                end
            else
                spkIdx = [];
            end
            
            spikeTrain = zeros(1,length(t));
            spikeTrain(spkIdx) = 1;
            
            if ~isempty(piece)
                sdf_pa_sel270_s270TO90(iSwitch,iSU,:) = histc(piece,edges);
            else
                sdf_pa_sel270_s270TO90(iSwitch,iSU,:) = zeros(1,length(edges));
            end
            
        end
        
    end
    
%     sdf_pa_sel270_s270TO90 = sum(sdf_pa_sel270_s270TO90,2);
%     sdf_pa_sel270_s270TO90 = squeeze(sdf_pa_sel270_s270TO90);
    
    for iSwitch = 1:length(cleanSwitches.PA.s270TO90{1})
        c = 0;
        for iSU = 1:length(pref90_pa)
            c = c+1;
            piece = (cleanSwitches.PA.s270TO90{pref90_pa(iSU)}{iSwitch});
            if ~isempty(piece)
                
                for nSpk = 1:length(piece)
                    val = piece(nSpk); %value to find
                    tmp = abs(t-val);
                    [idx idx] = min(tmp); %index of closest value
                    spkIdx(nSpk) = idx;
                end
            else
                spkIdx = [];
            end
            
            spikeTrain = zeros(1,length(t));
            spikeTrain(spkIdx) = 1;
            
            if ~isempty(piece)
                sdf_pa_sel90_s270TO90(iSwitch,iSU,:) = histc(piece,edges);
            else
                sdf_pa_sel90_s270TO90(iSwitch,iSU,:) = zeros(1,length(edges));
            end
        end
        
    end
    
%     sdf_pa_sel90_s270TO90 = sum(sdf_pa_sel90_s270TO90,2);
%     sdf_pa_sel90_s270TO90 = squeeze(sdf_pa_sel90_s270TO90);
    
    
    % Sel 270, 90TO270
    for iSwitch = 1:length(cleanSwitches.PA.s90TO270{1})
        c = 0;
        for iSU = 1:length(pref270_pa)
            c = c+1;
            piece = (cleanSwitches.PA.s90TO270{pref270_pa(iSU)}{iSwitch});
            if ~isempty(piece)
                
                for nSpk = 1:length(piece)
                    val = piece(nSpk); %value to find
                    tmp = abs(t-val);
                    [idx idx] = min(tmp); %index of closest value
                    spkIdx(nSpk) = idx;
                end
            else
                spkIdx = [];
            end
            
            spikeTrain = zeros(1,length(t));
            spikeTrain(spkIdx) = 1;
            
            if ~isempty(piece)
                sdf_pa_sel270_s90TO270(iSwitch,iSU,:) = histc(piece,edges);
            else
                sdf_pa_sel270_s90TO270(iSwitch,iSU,:) = zeros(1,length(edges));
            end
            
        end
        
    end
    
%     sdf_pa_sel270_s90TO270 = sum(sdf_pa_sel270_s90TO270,2);
%     sdf_pa_sel270_s90TO270 = squeeze(sdf_pa_sel270_s90TO270);
    
    for iSwitch = 1:length(cleanSwitches.PA.s90TO270{1})
        c = 0;
        for iSU = 1:length(pref90_pa)
            c = c+1;
            piece = (cleanSwitches.PA.s90TO270{pref90_pa(iSU)}{iSwitch});
            if ~isempty(piece)
                
                for nSpk = 1:length(piece)
                    val = piece(nSpk); %value to find
                    tmp = abs(t-val);
                    [idx idx] = min(tmp); %index of closest value
                    spkIdx(nSpk) = idx;
                end
            else
                spkIdx = [];
            end
            
            spikeTrain = zeros(1,length(t));
            spikeTrain(spkIdx) = 1;
            
            if ~isempty(piece)
                sdf_pa_sel90_s90TO270(iSwitch,iSU,:) = histc(piece,edges);
            else
                sdf_pa_sel90_s90TO270(iSwitch,iSU,:) = zeros(1,length(edges));
            end
        end
        
    end
    
%     sdf_pa_sel90_s90TO270 = sum(sdf_pa_sel90_s90TO270,2);
%     sdf_pa_sel90_s90TO270 = squeeze(sdf_pa_sel90_s90TO270);
    
    
    %% Consolidate into a structure
    
    spikingActivityPerTransition.sel90.BR.s270TO90 = sdf_br_sel90_s270TO90;
    spikingActivityPerTransition.sel90.PA.s270TO90 = sdf_pa_sel90_s270TO90;
    spikingActivityPerTransition.sel90.BR.s90TO270 = sdf_br_sel90_s90TO270;
    spikingActivityPerTransition.sel90.PA.s90TO270 = sdf_pa_sel90_s90TO270;
    spikingActivityPerTransition.sel270.BR.s270TO90 = sdf_br_sel270_s270TO90;
    spikingActivityPerTransition.sel270.PA.s270TO90 = sdf_pa_sel270_s270TO90;
    spikingActivityPerTransition.sel270.BR.s90TO270 = sdf_br_sel270_s90TO270;
    spikingActivityPerTransition.sel270.PA.s90TO270 = sdf_pa_sel270_s90TO270;
    
    figure
    subplot(2,2,1)
    plot(edges(3:end-2)./1000,smooth(normalise(nanmean(spikingActivityPerTransition.sel90.BR.s90TO270(:,3:end-2),1))))
    hold on
    plot(edges(3:end-2)./1000,smooth(normalise(nanmean(spikingActivityPerTransition.sel270.BR.s90TO270(:,3:end-2),1))))
    vline(0,'--b')
    title('90TO270 - BR')
    legend('90 Selective','270 Selective')
    subplot(2,2,2)
    plot(edges(3:end-2)./1000,smooth(normalise(nanmean(spikingActivityPerTransition.sel90.BR.s270TO90(:,3:end-2),1))))
    hold on
    plot(edges(3:end-2)./1000,smooth(normalise(nanmean(spikingActivityPerTransition.sel270.BR.s270TO90(:,3:end-2),1))))
    vline(0,'--b')
    title('270TO90 - BR')
    legend('90 Selective','270 Selective')
    
    subplot(2,2,3)
    plot(edges(3:end-2)./1000,smooth(normalise(nanmean(spikingActivityPerTransition.sel90.PA.s90TO270(:,3:end-2),1))),'--')
    hold on
    plot(edges(3:end-2)./1000,smooth(normalise(nanmean(spikingActivityPerTransition.sel270.PA.s90TO270(:,3:end-2),1))),'--')
    vline(0,'--b')
    title('90TO270 - PA')
    legend('90 Selective','270 Selective')
    subplot(2,2,4)
    plot(edges(3:end-2)./1000,smooth(normalise(nanmean(spikingActivityPerTransition.sel90.PA.s270TO90(:,3:end-2),1))),'--')
    hold on
    plot(edges(3:end-2)./1000,smooth(normalise(nanmean(spikingActivityPerTransition.sel270.PA.s270TO90(:,3:end-2),1))),'--')
    vline(0,'--b')
    title('270TO90 - PA')
    legend('90 Selective','270 Selective')
    pause(3)
    
    cd(sav_dir)
    saveas(gcf,'10ms_MM_EnsemblePSTHs_BRPASel_OnlyBSAS','fig')
    save('10ms_MM_EnsemblePSTHs_SUMU_1000ms_BRPASel_OnlyBSAS.mat','spikingActivityPerTransition','t','-v7.3')
    
    clear sdf_br_sel270_s270TO90; clear sdf_br_sel270_s90TO270; clear sdf_br_sel90_s270TO90; clear sdf_br_sel90_s90TO270;
    clear sdf_pa_sel270_s270TO90; clear sdf_pa_sel270_s90TO270; clear sdf_pa_sel90_s270TO90; clear sdf_pa_sel90_s90TO270;
    clear spikingActivity; clear spikingActivityPerTransition; clear cleanSwitches; clear SUspikes; clear SUspikes_t; clear num_SU; clear nSU;
end
