function generateSpikingActivityFigureBR

dbstop if error

%% Directories

prefInfoPaths{1} = 'B:\Results\H07\12-06-2016\Bfsgrad\PFC\MUA\Preference_Arrays\cSwitch';
prefInfoPaths{2} = 'B:\Results\H07\13-07-2016\Bfsgrad\PFC\MUA\Preference_Arrays\cSwitch';
prefInfoPaths{3} = 'B:\Results\H07\20161019\Bfsgrad\PFC\MUA\Preference_Arrays\cSwitch';
prefInfoPaths{4} = 'B:\Results\H07\20161025\Bfsgrad\PFC\MUA\Preference_Arrays\cSwitch';
prefInfoPaths{5} = 'B:\Results\A11\20170305\Bfsgrad\PFC\MUA\Preference_Arrays\cSwitch';
prefInfoPaths{6} = 'B:\Results\A11\20170302\Bfsgrad\PFC\MUA\Preference_Arrays\cSwitch';


datasets{1} = 'B:\H07\12-06-2016\PFC';
recDate{1} = '12062016';
fileID{1} = '12-06-2016';
subjID{1} = 'Hayo';
datasets{2} = 'B:\H07\13-07-2016\PFC';
recDate{2} = '13072016';
fileID{2} = '13-07-2016';
subjID{2} = 'Hayo';
datasets{3} = 'B:\H07\20161019\PFC';
recDate{3} = '19102016';
fileID{3} = '20161019';
subjID{3} = 'Hayo';
datasets{4} = 'B:\H07\20161025\PFC';
recDate{4} = '25102016';
fileID{4} = '20161025';
subjID{4} = 'Hayo';
datasets{5} = 'B:\A11\20170305\PFC';
recDate{5} = '05032017';
fileID{5} = '20170305';
subjID{5} = 'Anton';
datasets{6} = 'B:\A11\20170302\PFC';
recDate{6} = '02032017';
fileID{6} = '20170302';
subjID{6} = 'Anton';

nDatasets = 6;

%% Collect PA

allSwitches_sel90_s270TO90 = [];
allSwitches_sel270_s90TO270 = [];

for iDataset = 1:nDatasets
    
    % Load PFC Spikes
    
    cd(datasets{iDataset})
    
    load PFCSpikes.mat
    
    % Load preferences
    
    cd(prefInfoPaths{iDataset})
    load('1000_250_1000_DF_pref_array_switch.mat')
    
    pref90_pa_bs = find(pref_array_switch.pref_sim_switch_Riv_BsAs.pri_sig_u(:,2)==2);
    pref90_pa_as = find(pref_array_switch.pref_sim_switch_Riv_BsAs.sec_sig_u(:,2)==2);
    pref90_pa_bsas = find(pref_array_switch.pref_sim_switch_Riv_BsAs.com_sig_u(:,2)==2);
    pref90_pa_bs = pref_array_switch.pref_sim_switch_Riv_BsAs.pri_sig_u(pref90_pa_bs,3);
    pref90_pa_as = pref_array_switch.pref_sim_switch_Riv_BsAs.sec_sig_u(pref90_pa_as,3);
    pref90_pa_bsas = pref_array_switch.pref_sim_switch_Riv_BsAs.com_sig_u(pref90_pa_bsas,3);
    
    pref90_pa = unique([pref90_pa_bs;pref90_pa_as;pref90_pa_bsas]);
    
    
    pref270_pa_bs = find(pref_array_switch.pref_sim_switch_Riv_BsAs.pri_sig_u(:,2)==1);
    pref270_pa_as = find(pref_array_switch.pref_sim_switch_Riv_BsAs.sec_sig_u(:,2)==1);
    pref270_pa_bsas = find(pref_array_switch.pref_sim_switch_Riv_BsAs.com_sig_u(:,2)==1);
    pref270_pa_bs = pref_array_switch.pref_sim_switch_Riv_BsAs.pri_sig_u(pref270_pa_bs,3);
    pref270_pa_as = pref_array_switch.pref_sim_switch_Riv_BsAs.sec_sig_u(pref270_pa_as,3);
    pref270_pa_bsas = pref_array_switch.pref_sim_switch_Riv_BsAs.com_sig_u(pref270_pa_bsas,3);
    
    pref270_pa = unique([pref270_pa_bs;pref270_pa_as;pref270_pa_bsas]);
    
    
    t = linspace(-1250,1250,1250);
    
    [x,y] = smoothingkernel(2.5,500,0.05,'gaussian');
    tSamp = 1.25*3e4;
    % Load event times
    
    cd(['B:\Results\forPrediction\Session_' num2str(iDataset) '\forPrediction'])
    
    load events_times.mat
    
    % First do for 270TO90
    
    [idx] = (events(:,1) == 7); % these two events mark the beginning of a dominance
    
    startTimes = ceil(events(idx,2)*60); % transform to samples
    
    switches_sel90_s270TO90 = zeros(length(pref90_pa),length(startTimes),length(t)); % initialise collection variable
    
    for iTransitions = 1:length(startTimes)
        
        for iChan = 1:length(pref90_pa)
            
            spikes = spikesPFC{pref90_pa(iChan)}.times;
            
            tic;
            
            temp = spikes(spikes>=(startTimes(iTransitions)-tSamp) &  spikes<=(startTimes(iTransitions)+tSamp));
            temp = temp-startTimes(iTransitions);
            temp = temp./30;
            
            st = zeros(1,length(t));
            
            if ~isempty(temp)
                
                for nSpk = 1:length(temp)
                    val = temp(nSpk); %value to find
                    tmp = abs(t-val);
                    [idx idx] = min(tmp); %index of closest value
                    spkIdx(nSpk) = idx;
                end
                
                st(spkIdx) = 1;
                clear spkIdx;
                psth = conv(st,y,'same');
                switches_sel90_s270TO90(iChan,iTransitions,:) = psth;
                clear temp; clear st; clear tmp;
                
            else
                switches_sel90_s270TO90(iChan,iTransitions,:) = zeros(1,length(t));
                
            end
            
            
        end
        
        toc;
        
    end
    
    allSwitches_sel90_s270TO90 = [allSwitches_sel90_s270TO90;squeeze(nanmean(switches_sel90_s270TO90,1))];
    
    % First do for 90TO270
    
    [idx] = (events(:,1) == 9); % these two events mark the beginning of a dominance
    
    startTimes = ceil(events(idx,2)*60); % transform to samples
    
    switches_sel270_s90TO270 = zeros(length(pref270_pa),length(startTimes),length(t)); % initialise collection variable
    
    for iTransitions = 1:length(startTimes)
        
        for iChan = 1:length(pref270_pa)
            
            spikes = spikesPFC{pref270_pa(iChan)}.times;
            
            tic;
            
            temp = spikes(spikes>=(startTimes(iTransitions)-tSamp) &  spikes<=(startTimes(iTransitions)+tSamp));
            temp = temp-startTimes(iTransitions);
            temp = temp./30;
            
            st = zeros(1,length(t));
            
            if ~isempty(temp)
                
                for nSpk = 1:length(temp)
                    val = temp(nSpk); %value to find
                    tmp = abs(t-val);
                    [idx idx] = min(tmp); %index of closest value
                    spkIdx(nSpk) = idx;
                end
                
                st(spkIdx) = 1;
                clear spkIdx;
                psth = conv(st,y,'same');
                switches_sel270_s90TO270(iChan,iTransitions,:) = psth;
                clear temp; clear st;
                
            else
                switches_sel270_s90TO270(iChan,iTransitions,:) = zeros(1,length(t));
                
            end
            
            
        end
        
        toc;
        
    end
    
    allSwitches_sel270_s90TO270 = [allSwitches_sel270_s90TO270;squeeze(nanmean(switches_sel270_s90TO270,1))];
    
end


%% Plot and check

subplot(2,2,1)
imagesc(t(126:1125)./1000,1:size(allSwitches_sel90_s270TO90,1),allSwitches_sel90_s270TO90-mean(mean(allSwitches_sel90_s270TO90)));
colormap jet
vline(0,'--w')
xlabel('time relative to switch [s]')
ylabel('# of switches')
AX = gca;
AX.CLim = [0 5];
box off
title('270 to 90 Switches BR')

subplot(2,2,2)
plot(t(126:1125)./1000,nanmean(allSwitches_sel90_s270TO90(:,126:1125),1),'LineWidth',2)
xlabel('time relative to switch [s]')
ylabel('mean spikes/s')
box off
vline(0,'--k')
title('Mean PSTH 270 to 90 Switches BR')

subplot(2,2,3)
imagesc(t(126:1125)./1000,1:size(allSwitches_sel270_s90TO270,1),allSwitches_sel270_s90TO270-mean(mean(allSwitches_sel270_s90TO270)));
colormap jet
vline(0,'--w')
xlabel('time relative to switch [s]')
ylabel('# of switches')
AX = gca;
AX.CLim = [0 5];
box off
title('90 to 270 Switches BR')

subplot(2,2,4)
plot(t(126:1125)./1000,nanmean(allSwitches_sel270_s90TO270(:,126:1125),1),'-r','LineWidth',2)
xlabel('time relative to switch [s]')
ylabel('mean spikes/s')
box off
vline(0,'--k')
title('Mean PSTH 90 to 270 Switches BR')


