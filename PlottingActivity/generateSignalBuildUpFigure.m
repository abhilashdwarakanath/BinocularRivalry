function generateSignalBuildUpFigure(params,durations)

dbstop if error

%% Params and stuff

Fs = params.Fs;
durationPre = durations.behind; %s
durationPost = durations.forward;
nChans = params.nChans;
nDatasets = params.nDatasets;

t = -durationPre:1/Fs:durationPost;

%% Collect

collectBefore = durationPre*Fs;
collectAfter = durationPost*Fs;

allSwitches = [];

for iDataset = 1:nDatasets
    
    cd(['B:\Results\forPrediction\Session_' num2str(iDataset)])
    
    load events_times.mat
    
    [idx] = (events(:,1) == 7 | events(:,1)==9); % these two events mark the beginning of a dominance
    
    startTimes = ceil(events(idx,2)); % These are already in samples so no transformation is required
    
    chunks = zeros(nChans,length(startTimes),length(t)); % initialise collection variable
    
    for iChan = 1:nChans
        
        tic;
        
        temp = csvread(['low_chan' num2str(iChan) '.csv']); % Read the CSV file
        
        for iTransitions = 1:length(startTimes)
            
            chunks(iChan,iTransitions,:) = (temp(startTimes(iTransitions)-collectBefore:startTimes(iTransitions)+collectAfter)); % Collect for each transition across each channel
            
        end
        
        toc;
        
    end
    
    chunks = squeeze(nanmean(chunks,1)); % Average across the array/grid 
    
    allSwitches = [allSwitches;chunks]; % Pool
    
    clear chunks
    
end

%% Plot

meanTrace = nanmean(allSwitches,1); % Get the mean
semTrace = nanstd(allSwitches,[],1)./sqrt(size(allSwitches,1)); % Get the SEM

figure
shadedErrorBar(t(26:476),meanTrace(26:476),semTrace(26:476))
hold on
plot(t(26:476),meanTrace(26:476),'-r','LineWidth',1)
xlabel('time relative to switch [s]')
ylabel('instantaneous amplitude')
title('Grid averaged activity')
box off
xlim([-0.5 0.55])
ylim([22.4 24.5])
vline(0,'--b')
