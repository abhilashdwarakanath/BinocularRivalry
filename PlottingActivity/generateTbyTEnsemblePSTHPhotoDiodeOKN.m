function generateTbyTEnsemblePSTHPhotoDiodeOKN

dbstop if error

% datasets{1} = 'B:\H07\12-06-2016\PFC\Bfsgrad1';
% recDate{1} = '12062016';
% fileID{1} = '12-06-2016';
% subjID{1} = 'Hayo';
% datasets{2} = 'B:\H07\13-07-2016\PFC\Bfsgrad1';
% recDate{2} = '13072016';
% fileID{2} = '13-07-2016';
% subjID{2} = 'Hayo';
% datasets{3} = 'B:\H07\20161019\PFC\Bfsgrad1';
% recDate{3} = '19102016';
% fileID{3} = '20161019';
% subjID{3} = 'Hayo';
% datasets{4} = 'B:\H07\20161025\PFC\Bfsgrad1';
% recDate{4} = '25102016';
% fileID{4} = '20161025';
% subjID{4} = 'Hayo';
datasets{1} = 'B:\A11\20170305\PFC\Bfsgrad1';
recDate{1} = '05032017';
fileID{1} = '20170305';
subjID{1} = 'Anton';
% datasets{6} = 'B:\A11\20170302\PFC\Bfsgrad1';
% recDate{6} = '02032017';
% fileID{6} = '20170302';
% subjID{6} = 'Anton';

%prefInfoPaths{1} = 'B:\Results\H07\12-06-2016\Bfsgrad\PFC\MUA\Preference_Arrays\cSwitch';
%prefInfoPaths{2} = 'B:\Results\H07\13-07-2016\Bfsgrad\PFC\MUA\Preference_Arrays\cSwitch';
%prefInfoPaths{3} = 'B:\Results\H07\20161019\Bfsgrad\PFC\MUA\Preference_Arrays\cSwitch';
%prefInfoPaths{4} = 'B:\Results\H07\20161025\Bfsgrad\PFC\MUA\Preference_Arrays\cSwitch';
prefInfoPaths{1} = 'B:\Results\A11\20170305\Bfsgrad\PFC\MUA\Preference_Arrays\cSwitch';
%prefInfoPaths{6} = 'B:\Results\A11\20170302\Bfsgrad\PFC\MUA\Preference_Arrays\cSwitch';

%% Load SU Spikes By Time

for iDataset = 1:length(datasets)
    
    %% Load the maps
    
    if iDataset <= 4
        
        cd B:\H07\
        
        load H07ElectrodeInfo.mat
        
        chan2elec = H07.PFC.electrodeInfo;
        map = H07.PFC.map;
        
    else
        
        cd B:\A11\
        
        load A11ElectrodeInfo.mat
        
        chan2elec = A11.PFC.electrodeInfo;
        map = A11.PFC.map;
        
    end
    
    cd(datasets{iDataset})
    load jMUSpikesByTime.mat
    
    cd(prefInfoPaths{iDataset})
    load('1000_250_1000_DF_pref_array_switch.mat')
    
    
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
    
    %% Params
    
    durs.switch = 250;
    durs.domForward = 1000;
    durs.domBehind = 1000;
    
    t = linspace(-durs.domForward,durs.domBehind,durs.domForward*2);
    
    %% Convert data structure
    
    % initiate variables
    
    nSU = 96;
    params.elecs = nSU;
    params.conditions = 8;
    
    %% Collect clean dominances
    
    % Load relevant LFPs and Spikes
    cd(datasets{iDataset})
    
    eventfile = 'finalevents_audio.mat';
    spikeFile = 'jMUSpikesByTime.mat';
    qnxfile = [subjID{iDataset} '_' recDate{iDataset} '_' 'Bfsgrad1' '.dgz'];
    
    load('jMUSpikesByTime.mat')
    
    fprintf('Processing Dataset %d of : %d \n',iDataset,6)
    
    % Compute Statistics and Spectrograms
    
    sav_dir = [datasets{iDataset} '\EnsemblePSTHs\OKNPD\Transitions\SpecificSel'];
    mkdir(sav_dir)
    if strcmp(subjID{iDataset},'Hayo')==1
        monkID = 'H07';
    else
        monkID = 'A11';
    end
    
    trialInformation = collectTrialInformationMM(params,qnxfile,eventfile,'pfc','spikes');
    [spikingActivity] = collectCleanDominancesSpikesPDOKNMM(params,jMUspikes,durs);
    
    %% Collect BR
    
    for iChan = 1:nSU
        c = 0;
        for iCond = 1:length(spikingActivity.validSection.BR.data.dom90{iChan})
            for iSwitch = 1:length(spikingActivity.validSection.BR.data.dom90{iChan}{iCond})
                c = c+1;
                cleanSwitches.BR.s270TO90{iChan}{c} = spikingActivity.validSection.BR.data.dom90{iChan}{iCond}{iSwitch};
                okn.BR.s270TO90{c} = spikingActivity.validOKN.BR.data.dom90{iCond}{iSwitch};
                pd.BR.s270TO90{c}(1,:) = spikingActivity.validPD.X.BR.data.dom90{iCond}{iSwitch};
                pd.BR.s270TO90{c}(2,:) = spikingActivity.validPD.Y.BR.data.dom90{iCond}{iSwitch};
            end
        end
    end
    for iChan = 1:nSU
        c = 0;
        for iCond = 1:length(spikingActivity.validSection.BR.data.dom270{iChan})
            for iSwitch = 1:length(spikingActivity.validSection.BR.data.dom270{iChan}{iCond})
                c = c+1;
                cleanSwitches.BR.s90TO270{iChan}{c} = spikingActivity.validSection.BR.data.dom270{iChan}{iCond}{iSwitch};
                okn.BR.s90TO270{c} = spikingActivity.validOKN.BR.data.dom270{iCond}{iSwitch};
                pd.BR.s90TO270{c}(1,:) = spikingActivity.validPD.X.BR.data.dom270{iCond}{iSwitch};
                pd.BR.s90TO270{c}(2,:) = spikingActivity.validPD.Y.BR.data.dom270{iCond}{iSwitch};
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
                okn.PA.s270TO90{c} = spikingActivity.validOKN.PA.data.dom90{iCond}{iSwitch};
                pd.PA.s270TO90{c}(1,:) = spikingActivity.validPD.X.PA.data.dom90{iCond}{iSwitch};
                pd.PA.s270TO90{c}(2,:) = spikingActivity.validPD.Y.PA.data.dom90{iCond}{iSwitch};
            end
        end
    end
    for iChan = 1:nSU
        c = 0;
        for iCond = 5:length(spikingActivity.validSection.PA.data.dom270{iChan})
            for iSwitch = 1:length(spikingActivity.validSection.PA.data.dom270{iChan}{iCond})
                c = c+1;
                cleanSwitches.PA.s90TO270{iChan}{c} = spikingActivity.validSection.PA.data.dom270{iChan}{iCond}{iSwitch};
                okn.PA.s90TO270{c} = spikingActivity.validOKN.PA.data.dom270{iCond}{iSwitch};
                pd.PA.s90TO270{c}(1,:) = spikingActivity.validPD.X.PA.data.dom270{iCond}{iSwitch};
                pd.PA.s90TO270{c}(2,:) = spikingActivity.validPD.Y.PA.data.dom270{iCond}{iSwitch};
            end
        end
    end
    
    %% Get SDFs
    
    
    edges = -1000:50:1000;

    % BR 270TO90
    
    clear r; clear c;
    for iSwitch = 1:length(cleanSwitches.BR.s270TO90{1})
        
        sdf_br_s270TO90{iSwitch} = nan(100,length(edges)-1);
        counts_br_s270TO90{iSwitch} = nan(100,length(edges)-1);

        for iSU = 1:nSU

            piece = (cleanSwitches.BR.s270TO90{iSU}{iSwitch});
          
            elec = chan2elec(iSU,2);
            
            if ismember(iSU,pref270_br)|| ismember(iSU,pref90_br)
                
                if ~isempty(piece)
                   
                    counts_br_s270TO90{iSwitch}(elec,:) = histcounts(piece,edges);
                    temp = normalise(smooth(histcounts(piece,edges)));
                    sdf_br_s270TO90{iSwitch}(elec,:) = temp;
                else
                    counts_br_s270TO90{iSwitch}(elec,:) = zeros(1,length(edges)-1);
                    sdf_br_s270TO90{iSwitch}(elec,:) = zeros(1,length(edges)-1);
                end
            end
            
        end
        
    end
    
    % BR 270TO90
    
    clear r; clear c;
    for iSwitch = 1:length(cleanSwitches.BR.s90TO270{1})
        
        sdf_br_s90TO270{iSwitch} = nan(100,length(edges)-1);
        counts_br_s90TO270{iSwitch} = nan(100,length(edges)-1);

        for iSU = 1:nSU

            piece = (cleanSwitches.BR.s90TO270{iSU}{iSwitch});
          
            elec = chan2elec(iSU,2);
            
            if ismember(iSU,pref270_br)|| ismember(iSU,pref90_br)
                
                if ~isempty(piece)
                   
                    counts_br_s90TO270{iSwitch}(elec,:) = histcounts(piece,edges);
                    sdf_br_s90TO270{iSwitch}(elec,:) = normalise(smooth(histcounts(piece,edges)));
                else
                    counts_br_s90TO270{iSwitch}(elec,:) = zeros(1,length(edges)-1);
                    sdf_br_s90TO270{iSwitch}(elec,:) = zeros(1,length(edges)-1);
                end
            end
            
        end
        
    end
    
    % PA 270TO90
    
    clear r; clear c;
    for iSwitch = 1:length(cleanSwitches.PA.s270TO90{1})
        
        sdf_pa_s270TO90{iSwitch} = nan(100,length(edges)-1);
        counts_pa_s270TO90{iSwitch} = nan(100,length(edges)-1);

        for iSU = 1:nSU

            piece = (cleanSwitches.PA.s270TO90{iSU}{iSwitch});
          
            elec = chan2elec(iSU,2);
            
            if ismember(iSU,pref270_pa)|| ismember(iSU,pref90_pa)
                
                if ~isempty(piece)
                   
                    counts_pa_s270TO90{iSwitch}(elec,:) = histcounts(piece,edges);
                    sdf_pa_s270TO90{iSwitch}(elec,:) = normalise(smooth(histcounts(piece,edges)));
                else
                    counts_pa_s270TO90{iSwitch}(elec,:) = zeros(1,length(edges)-1);
                    sdf_pa_s270TO90{iSwitch}(elec,:) = zeros(1,length(edges)-1);
                end
            end
            
        end
        
    end
    
    % PA 90TO270
    
    clear r; clear c;
    for iSwitch = 1:length(cleanSwitches.PA.s90TO270{1})
        
        sdf_pa_s90TO270{iSwitch} = nan(100,length(edges)-1);
        counts_pa_s90TO270{iSwitch} = nan(100,length(edges)-1);

        for iSU = 1:nSU

            piece = (cleanSwitches.PA.s90TO270{iSU}{iSwitch});
          
            elec = chan2elec(iSU,2);
            
            if ismember(iSU,pref270_pa)|| ismember(iSU,pref90_pa)
                
                if ~isempty(piece)
                   
                    counts_pa_s90TO270{iSwitch}(elec,:) = histcounts(piece,edges);
                    temp = normalise(smooth(histcounts(piece,edges)));
                    sdf_pa_s90TO270{iSwitch}(elec,:) = temp;
                else
                    counts_pa_s90TO270{iSwitch}(elec,:) = zeros(1,length(edges)-1);
                    sdf_pa_s90TO270{iSwitch}(elec,:) = zeros(1,length(edges)-1);
                end
            end
            
        end
        
    end
    
    
    %% Generate movies
    
    cd(sav_dir)
    
    tOKN = linspace(-1,1,2001);
    
    % BR 
    
    % Get all preference electrodes
    clear r_270; clear r_90; clear c_90; clear c_270;
    
    edges = linspace(-1,1,length(edges)-1);
    
    for iUnit = 1:length(pref270_br)
        elec = chan2elec(pref270_br(iUnit),2);
        [r_270(iUnit), c_270(iUnit)] = channelLocFinder2(elec, map);
    end
    
    for iUnit = 1:length(pref90_br)
        elec = chan2elec(pref90_br(iUnit),2);
        [r_90(iUnit), c_90(iUnit)] = channelLocFinder2(elec, map);
    end
    
    for iSwitch = 1:length(sdf_br_s270TO90)
        
        pref270Traces = normalise(smooth(nanmean(counts_br_s270TO90{iSwitch}(chan2elec(pref270_br,2),:),1)));
        pref90Traces = normalise(smooth(nanmean(counts_br_s270TO90{iSwitch}(chan2elec(pref90_br,2),:),1)));
        
     
        figure;
        
        subplot(3,1,1)
        plot(tOKN,smooth(okn.BR.s270TO90{iSwitch}),'-k','LineWidth',2)
        axis tight
        vline(0,'--g')
        box off
        subplot(3,1,2)
        plot(tOKN,normalise(smooth(pd.BR.s270TO90{iSwitch}(1,:))),'LineWidth',1)
        hold on
        plot(tOKN,normalise(smooth(pd.BR.s270TO90{iSwitch}(2,:))),'LineWidth',1)
        vline(0,'--g')
        axis tight
        box off
        subplot(3,1,3)
        plot(edges(3:end-2),pref270Traces(3:end-2),'Color',[0.56,0.82,0.31],'LineWidth',1)
        hold on
        plot(edges(3:end-2),pref90Traces(3:end-2),'Color',[0.91,0.7,0.7],'LineWidth',1)
        vline(0,'--g')
        xlim([-1 1])
        box off
        suptitle(['BR Transition s270TO90 # : ' num2str(iSwitch)])
        saveas(gca,['BR_Transition_S270TO90_' num2str(iSwitch)],'fig')
        pause(2)
        close all
        
    end
    
    for iSwitch = 1:length(sdf_br_s90TO270)
        
        pref270Traces = normalise(smooth(nanmean(counts_br_s90TO270{iSwitch}(chan2elec(pref270_br,2),:),1)));
        pref90Traces = normalise(smooth(nanmean(counts_br_s90TO270{iSwitch}(chan2elec(pref90_br,2),:),1)));
        
    
        figure;
        
        subplot(3,1,1)
        plot(tOKN,smooth(okn.BR.s90TO270{iSwitch}),'-k','LineWidth',2)
        axis tight
        vline(0,'--g')
        box off
        subplot(3,1,2)
        plot(tOKN,normalise(smooth(pd.BR.s90TO270{iSwitch}(1,:))),'LineWidth',1)
        hold on
        plot(tOKN,normalise(smooth(pd.BR.s90TO270{iSwitch}(2,:))),'LineWidth',1)
        vline(0,'--g')
        axis tight
        box off
        subplot(3,1,3)
        plot(edges(3:end-2),pref270Traces(3:end-2),'Color',[0.56,0.82,0.31],'LineWidth',1)
        hold on
        plot(edges(3:end-2),pref90Traces(3:end-2),'Color',[0.91,0.7,0.7],'LineWidth',1)
        vline(0,'--g')
        xlim([-1 1])
        box off
        suptitle(['BR Transition s90TO270 # : ' num2str(iSwitch)])
        saveas(gca,['BR_Transition_S270TO90_' num2str(iSwitch)],'fig')
        pause(2)
        close all
        
    end
    
    clear r_270; clear r_90; clear c_90; clear c_270;
    
    % PA 
    
    % Get all preference electrodes
    
    for iUnit = 1:length(pref270_pa)
        elec = chan2elec(pref270_pa(iUnit),2);
        [r_270(iUnit), c_270(iUnit)] = channelLocFinder2(elec, map);
    end
    
    for iUnit = 1:length(pref90_pa)
        elec = chan2elec(pref90_pa(iUnit),2);
        [r_90(iUnit), c_90(iUnit)] = channelLocFinder2(elec, map);
    end
    
    for iSwitch = 1:length(sdf_pa_s270TO90)
        
        pref270Traces = normalise(smooth(nanmean(counts_pa_s270TO90{iSwitch}(chan2elec(pref270_pa,2),:),1)));
        pref90Traces = normalise(smooth(nanmean(counts_pa_s270TO90{iSwitch}(chan2elec(pref90_pa,2),:),1)));
        
     
        figure;
        
        subplot(3,1,1)
        plot(tOKN,smooth(okn.PA.s270TO90{iSwitch}),'-k','LineWidth',2)
        axis tight
        vline(0,'--g')
        box off
        subplot(3,1,2)
        plot(tOKN,normalise(smooth(pd.PA.s270TO90{iSwitch}(1,:))),'LineWidth',1)
        hold on
        plot(tOKN,normalise(smooth(pd.PA.s270TO90{iSwitch}(2,:))),'LineWidth',1)
        vline(0,'--g')
        axis tight
        box off
        subplot(3,1,3)
        plot(edges(3:end-2),pref270Traces(3:end-2),'Color',[0.56,0.82,0.31],'LineWidth',1)
        hold on
        plot(edges(3:end-2),pref90Traces(3:end-2),'Color',[0.91,0.7,0.7],'LineWidth',1)
        vline(0,'--g')
        xlim([-1 1])
        box off
        suptitle(['PA Transition s270TO90 # : ' num2str(iSwitch)])
        saveas(gca,['PA_Transition_S270TO90_' num2str(iSwitch)],'fig')
        pause(2)
        close all
        
    end
    
    for iSwitch = 1:length(sdf_pa_s90TO270)
        
        pref270Traces = normalise(smooth(nanmean(counts_pa_s90TO270{iSwitch}(chan2elec(pref270_pa,2),:),1)));
        pref90Traces = normalise(smooth(nanmean(counts_pa_s90TO270{iSwitch}(chan2elec(pref90_pa,2),:),1)));
        
      
        figure;
        
       subplot(3,1,1)
        plot(tOKN,smooth(okn.PA.s90TO270{iSwitch}),'-k','LineWidth',2)
        axis tight
        vline(0,'--g')
        box off
        subplot(3,1,2)
        plot(tOKN,normalise(smooth(pd.PA.s90TO270{iSwitch}(1,:))),'LineWidth',1)
        hold on
        plot(tOKN,normalise(smooth(pd.PA.s90TO270{iSwitch}(2,:))),'LineWidth',1)
        vline(0,'--g')
        axis tight
        box off
        subplot(3,1,3)
        plot(edges(3:end-2),pref270Traces(3:end-2),'Color',[0.56,0.82,0.31],'LineWidth',1)
        hold on
        plot(edges(3:end-2),pref90Traces(3:end-2),'Color',[0.91,0.7,0.7],'LineWidth',1)
        vline(0,'--g')
        xlim([-1 1])
        box off
        suptitle(['PA Transition s90TO270 # : ' num2str(iSwitch)])
        saveas(gca,['PA_Transition_S270TO90_' num2str(iSwitch)],'fig')
        pause(2)
        close all
        
    end


    %% Clear everything
    clear sdf_br_s270TO90; clear sdf_br_s90TO270; clear sdf_br_s270TO90; clear sdf_br_s90TO270; clear r_270; clear r_90; clear c_90; clear c_270;
    clear sdf_pa_s270TO90; clear sdf_pa_s90TO270; clear sdf_pa_s270TO90; clear sdf_pa_s90TO270;
    clear spikingActivity; clear spikingActivityPerTransition; clear cleanSwitches; clear SUspikes; clear num_SU; clear nSU;
end
