function generateLowFrequencyActivityProfilesGradual(duration)

dbstop if error

%% Enumerate the datasets

datasets{1} = ['B:\H07\12-06-2016\PFC\Bfsgrad1\LFPStatistics\EventTriggeredTraces\TbyT_eventShapes_Times_low_' num2str(duration/1000) 's_back_' num2str(duration/1000) 's.mat'];
datasets{2} = ['B:\H07\13-07-2016\PFC\Bfsgrad1\LFPStatistics\EventTriggeredTraces\TbyT_eventShapes_Times_low_' num2str(duration/1000) 's_back_' num2str(duration/1000) 's.mat'];
datasets{3} = ['B:\H07\20161019\PFC\Bfsgrad1\LFPStatistics\EventTriggeredTraces\TbyT_eventShapes_Times_low_' num2str(duration/1000) 's_back_' num2str(duration/1000) 's.mat'];
datasets{4} = ['B:\H07\20161025\PFC\Bfsgrad1\LFPStatistics\EventTriggeredTraces\TbyT_eventShapes_Times_low_' num2str(duration/1000) 's_back_' num2str(duration/1000) 's.mat'];
datasets{5} = ['B:\A11\20170305\PFC\Bfsgrad1\LFPStatistics\EventTriggeredTraces\TbyT_eventShapes_Times_low_' num2str(duration/1000) 's_back_' num2str(duration/1000) 's.mat'];
datasets{6} = ['B:\A11\20170302\PFC\Bfsgrad1\LFPStatistics\EventTriggeredTraces\TbyT_eventShapes_Times_low_' num2str(duration/1000) 's_back_' num2str(duration/1000) 's.mat'];

%% Compute activity profiles for each transition

t = linspace(-duration/1000,duration/1000,duration+1);
midPoint = find(t==0);
bins = (t(1):length(t)/5000:t(midPoint));
bins = [bins 0];

t_pre = linspace(-duration/1000,0,midPoint);

for iDataset = 1:6
    
    clear s270TO90_Traces; clear s90TO270_Traces;
    
    load(datasets{iDataset},'lowTraces')
    
    chanProfile(iDataset).s270TO90.nEarlyChans = zeros(size(lowTraces.s270TO90,1),96);
    chanProfile(iDataset).s270TO90.nEarlyMiddleChans = zeros(size(lowTraces.s270TO90,1),96);
    chanProfile(iDataset).s270TO90.nMiddleChans = zeros(size(lowTraces.s270TO90,1),96);
    chanProfile(iDataset).s270TO90.nMiddleLateChans = zeros(size(lowTraces.s270TO90,1),96);
    chanProfile(iDataset).s270TO90.nLateChans = zeros(size(lowTraces.s270TO90,1),96);
    chanProfile(iDataset).s270TO90.nEarlyLate = zeros(size(lowTraces.s270TO90,1),96);
    chanProfile(iDataset).s270TO90.nNoActivity = zeros(size(lowTraces.s270TO90,1),96);
    chanProfile(iDataset).s270TO90.nMultiProfile = zeros(size(lowTraces.s270TO90,1),96);
    
    % s270TO90
    for iTrace = 1:size(lowTraces.s270TO90,1)
        
        for iChan = 1:96
            
            s270TO90_Traces(iTrace,iChan,:) = lowTraces.s270TO90(iTrace,iChan).BR.Pre';
            
        end
        
    end
    
    for iTrace = 1:size(s270TO90_Traces,1)
        
        testPop = squeeze(s270TO90_Traces(iTrace,:,:));
        
        for iChan = 1:96
            
            chanTrace = testPop(iChan,:);
            
            traceNoise = median(abs(chanTrace)/0.6745);
            
            tmp = findpeaks(chanTrace,traceNoise);
            peaks = tmp.loc;
            peaks = t_pre(peaks');
            
            peakProfile = histcounts(peaks,bins);
            
            zeroBins = sum(peakProfile==0);
            
            if zeroBins == 5
                
                chanProfile(iDataset).s270TO90.nNoActivity(iTrace,iChan) = chanProfile(iDataset).s270TO90.nNoActivity(iTrace,iChan)+1;
                
            end
            
            if zeroBins == 0
                
                chanProfile(iDataset).s270TO90.nMultiProfile(iTrace,iChan) = chanProfile(iDataset).s270TO90.nMultiProfile(iTrace,iChan)+1;

            end
            
            if zeroBins == 3
                
                idxs = find(peakProfile~=0);
                
                if sum(idxs == [1 2]) == 2
                    
                    chanProfile(iDataset).s270TO90.nEarlyMiddleChans(iTrace,iChan) = chanProfile(iDataset).s270TO90.nEarlyMiddleChans(iTrace,iChan)+1;

                    
                elseif sum(idxs == [2 3]) == 2
                    
                    chanProfile(iDataset).s270TO90.nMiddleLateChans(iTrace,iChan) = chanProfile(iDataset).s270TO90.nMiddleLateChans(iTrace,iChan)+1;
                    
                elseif sum(idxs == [1 3]) == 2
                    
                    chanProfile(iDataset).s270TO90.nEarlyLate(iTrace,iChan) = chanProfile(iDataset).s270TO90.nEarlyLate(iTrace,iChan)+1;
                    
                end
                
            end
            
            if zeroBins == 4
                
                idx = find(peakProfile~=0);
                
                if idx==1
                    
                    chanProfile(iDataset).s270TO90.nEarlyChans(iTrace,iChan) = chanProfile(iDataset).s270TO90.nEarlyChans(iTrace,iChan)+1;
                    chanProfile(iDataset).s270TO90.chanIdEarlyChans(iTrace,iChan) = 1;
                    
                elseif idx == 2
                    
                    chanProfile(iDataset).s270TO90.nMiddleChans(iTrace,iChan) = chanProfile(iDataset).s270TO90.nMiddleChans(iTrace,iChan)+1;
                    chanProfile(iDataset).s270TO90.chanIdMiddleChans(iTrace,iChan) = 1;
                    
                elseif idx == 3
                    
                    chanProfile(iDataset).s270TO90.nLateChans(iTrace,iChan) = chanProfile(iDataset).s270TO90.nLateChans(iTrace,iChan)+1;
                    chanProfile(iDataset).s270TO90.chanIdLateChans(iTrace,iChan) = 1;
                    
                end
                
            end
            
        end
        
    end
    
    chanProfile(iDataset).s90TO270.nEarlyChans = zeros(size(lowTraces.s90TO270,1),96);
    chanProfile(iDataset).s90TO270.nEarlyMiddleChans = zeros(size(lowTraces.s90TO270,1),96);
    chanProfile(iDataset).s90TO270.nMiddleChans = zeros(size(lowTraces.s90TO270,1),96);
    chanProfile(iDataset).s90TO270.nMiddleLateChans = zeros(size(lowTraces.s90TO270,1),96);
    chanProfile(iDataset).s90TO270.nLateChans = zeros(size(lowTraces.s90TO270,1),96);
    chanProfile(iDataset).s90TO270.nEarlyLate = zeros(size(lowTraces.s90TO270,1),96);
    chanProfile(iDataset).s90TO270.nNoActivity = zeros(size(lowTraces.s90TO270,1),96);
    chanProfile(iDataset).s90TO270.nMultiProfile = zeros(size(lowTraces.s90TO270,1),96);
    
    % s90TO270
    
    for iTrace = 1:size(lowTraces.s90TO270,1)
        
        for iChan = 1:96
            
            s90TO270_Traces(iTrace,iChan,:) = lowTraces.s90TO270(iTrace,iChan).BR.Pre';
            
        end
        
    end
    
    for iTrace = 1:size(s90TO270_Traces,1)
        
        testPop = squeeze(s90TO270_Traces(iTrace,:,:));
        
        for iChan = 1:96
            
            chanTrace = testPop(iChan,:);
            
            traceNoise = median(abs(chanTrace)/0.6745);
            
            tmp = findpeaks(chanTrace,traceNoise);
            peaks = tmp.loc;
            peaks = t_pre(peaks');
            
            peakProfile = histcounts(peaks,bins);
            
            zeroBins = sum(peakProfile==0);
            
            if zeroBins == 5
                
                chanProfile(iDataset).s90TO270.nNoActivity(iTrace,iChan) = chanProfile(iDataset).s90TO270.nNoActivity(iTrace,iChan)+1;
                
            end
            
            if zeroBins == 0
                
                chanProfile(iDataset).s90TO270.nMultiProfile(iTrace,iChan) = chanProfile(iDataset).s90TO270.nMultiProfile(iTrace,iChan)+1;

            end
            
            if zeroBins == 3
                
                idxs = find(peakProfile~=0);
                
                if sum(idxs == [1 2]) == 2
                    
                    chanProfile(iDataset).s90TO270.nEarlyMiddleChans(iTrace,iChan) = chanProfile(iDataset).s90TO270.nEarlyMiddleChans(iTrace,iChan)+1;
                    
                elseif sum(idxs == [2 3]) == 2
                    
                    chanProfile(iDataset).s90TO270.nMiddleLateChans(iTrace,iChan) = chanProfile(iDataset).s90TO270.nMiddleLateChans(iTrace,iChan)+1;
                    
                elseif sum(idxs == [1 3]) == 2
                    
                    chanProfile(iDataset).s90TO270.nEarlyLate(iTrace,iChan) = chanProfile(iDataset).s90TO270.nEarlyLate(iTrace,iChan)+1;

                end
                
            end
            
            if zeroBins == 4
                
                idx = find(peakProfile~=0);
                
                if idx==1
                    
                    chanProfile(iDataset).s90TO270.nEarlyChans(iTrace,iChan) = chanProfile(iDataset).s90TO270.nEarlyChans(iTrace,iChan)+1;
                    
                elseif idx == 2
                    
                    chanProfile(iDataset).s90TO270.nMiddleChans(iTrace,iChan) = chanProfile(iDataset).s90TO270.nMiddleChans(iTrace,iChan)+1;
                    
                elseif idx == 3
                    
                    chanProfile(iDataset).s90TO270.nLateChans(iTrace,iChan) = chanProfile(iDataset).s90TO270.nLateChans(iTrace,iChan)+1;
                    
                end
                
            end
            
        end
        
    end
    
    chanSummary(iDataset).s270TO90.propEarlyChans = (sum(sum(chanProfile(iDataset).s270TO90.nEarlyChans,2)./96,1)./size(lowTraces.s270TO90,1))*100;
    chanSummary(iDataset).s270TO90.propEarlyMiddleChans = (sum(sum(chanProfile(iDataset).s270TO90.nEarlyMiddleChans,2)./96,1)./size(lowTraces.s270TO90,1))*100;
    chanSummary(iDataset).s270TO90.propMiddleChans = (sum(sum(chanProfile(iDataset).s270TO90.nMiddleChans,2)./96,1)./size(lowTraces.s270TO90,1))*100;
    chanSummary(iDataset).s270TO90.propMiddleLateChans = (sum(sum(chanProfile(iDataset).s270TO90.nMiddleLateChans,2)./96,1)./size(lowTraces.s270TO90,1))*100;
    chanSummary(iDataset).s270TO90.propLateChans = (sum(sum(chanProfile(iDataset).s270TO90.nLateChans,2)./96,1)./size(lowTraces.s270TO90,1))*100;
    chanSummary(iDataset).s270TO90.propEarlyLate = (sum(sum(chanProfile(iDataset).s270TO90.nEarlyLate,2)./96,1)./size(lowTraces.s270TO90,1))*100;
    chanSummary(iDataset).s270TO90.propMultiProfile = (sum(sum(chanProfile(iDataset).s270TO90.nMultiProfile,2)./96,1)./size(lowTraces.s270TO90,1))*100;
    chanSummary(iDataset).s270TO90.propNoActivity = (sum(sum(chanProfile(iDataset).s270TO90.nNoActivity,2)./96,1)./size(lowTraces.s270TO90,1))*100;
    
    chanSummary(iDataset).s90TO270.propEarlyChans = (sum(sum(chanProfile(iDataset).s90TO270.nEarlyChans,2)./96,1)./size(lowTraces.s90TO270,1))*100;
    chanSummary(iDataset).s90TO270.propEarlyMiddleChans = (sum(sum(chanProfile(iDataset).s90TO270.nEarlyMiddleChans,2)./96,1)./size(lowTraces.s90TO270,1))*100;
    chanSummary(iDataset).s90TO270.propMiddleChans = (sum(sum(chanProfile(iDataset).s90TO270.nMiddleChans,2)./96,1)./size(lowTraces.s90TO270,1))*100;
    chanSummary(iDataset).s90TO270.propMiddleLateChans = (sum(sum(chanProfile(iDataset).s90TO270.nMiddleLateChans,2)./96,1)./size(lowTraces.s90TO270,1))*100;
    chanSummary(iDataset).s90TO270.propLateChans = (sum(sum(chanProfile(iDataset).s90TO270.nLateChans,2)./96,1)./size(lowTraces.s90TO270,1))*100;
    chanSummary(iDataset).s90TO270.propEarlyLate = (sum(sum(chanProfile(iDataset).s90TO270.nEarlyLate,2)./96,1)./size(lowTraces.s90TO270,1))*100;
    chanSummary(iDataset).s90TO270.propMultiProfile = (sum(sum(chanProfile(iDataset).s90TO270.nMultiProfile,2)./96,1)./size(lowTraces.s90TO270,1))*100;
    chanSummary(iDataset).s90TO270.propNoActivity = (sum(sum(chanProfile(iDataset).s90TO270.nNoActivity,2)./96,1)./size(lowTraces.s90TO270,1))*100;
    
    clear s270TO90_Traces; clear s90TO270_Traces;
    
end

%% Take average across datasets and the two types of transitions

propEarlyChans = 0;
propEarlyMiddleChans = 0;
propMiddleChans = 0;
propMiddleLateChans = 0;
propLateChans = 0;
propMultiProfile = 0;
propEarlyLate = 0;
propNoActivity = 0;

for iDataset = 1:6
    
    propEarlyChans = propEarlyChans+chanSummary(iDataset).s270TO90.propEarlyChans+chanSummary(iDataset).s90TO270.propEarlyChans;
    propEarlyMiddleChans = propEarlyMiddleChans+chanSummary(iDataset).s270TO90.propEarlyMiddleChans+chanSummary(iDataset).s90TO270.propEarlyMiddleChans;
    propMiddleChans = propMiddleChans+chanSummary(iDataset).s270TO90.propMiddleChans+chanSummary(iDataset).s90TO270.propMiddleChans;
    propMiddleLateChans = propMiddleLateChans+chanSummary(iDataset).s270TO90.propMiddleLateChans+chanSummary(iDataset).s90TO270.propMiddleLateChans;
    propLateChans = propLateChans+chanSummary(iDataset).s270TO90.propLateChans+chanSummary(iDataset).s90TO270.propLateChans;
    propEarlyLate = propEarlyLate+chanSummary(iDataset).s270TO90.propEarlyLate+chanSummary(iDataset).s90TO270.propEarlyLate;
    propMultiProfile = propMultiProfile+chanSummary(iDataset).s270TO90.propMultiProfile+chanSummary(iDataset).s90TO270.propMultiProfile;
    propNoActivity = propNoActivity+chanSummary(iDataset).s270TO90.propNoActivity+chanSummary(iDataset).s90TO270.propNoActivity;
    
end

plot([1 2 3 4 5],[propEarlyChans./12 propEarlyMiddleChans./12 propMiddleChans./12 propMiddleLateChans./12 propLateChans./12],'-or','LineWidth',2)
%xlim([0.75 3.25])
box off
ylabel('Proportion of active channels')
set(gca,'xticklabel',[])
