function generateSignalBuildUpFigurePA(params,durations)

dbstop if error

%% Params and stuff

Fs = params.Fs;
durationPre = durations.behind; %s
durationPost = durations.forward;
nChans = params.nChans;
nDatasets = params.nDatasets;

t = -durationPre:1/Fs:durationPost;

%% Collect PA

collectBefore = durationPre*Fs;
collectAfter = durationPost*Fs;

allSwitchesPA = [];

for iDataset = 1:nDatasets
    
    cd(['B:\Results\forPrediction\InstAmp\Session_' num2str(iDataset) '\forPrediction'])
    
    load events_times.mat
    
    [idx] = (events(:,1) == 14); % these two events mark the beginning of a dominance
    
    startTimes = ceil(events(idx,2)); % These are already in samples so no transformation is required
    
    chunks = zeros(nChans,length(startTimes),length(t)); % initialise collection variable
    
    for iChan = 1:nChans
        
        tic;
        
        temp = csvread(['lowInstAmp_chan' num2str(iChan) '.csv']); % Read the CSV file
        
        for iTransitions = 1:length(startTimes)
            
            chunks(iChan,iTransitions,:) = (temp(startTimes(iTransitions)-collectBefore:startTimes(iTransitions)+collectAfter)); % Collect for each transition across each channel
            
        end
        
        toc;
        
    end
    
    chunks = squeeze(nanmean(chunks,1)); % Average across the array/grid 
    
    allSwitchesPA = [allSwitchesPA;chunks]; % Pool
    
    clear chunks
    
end

%% Collect BR

collectBefore = durationPre*Fs;
collectAfter = durationPost*Fs;

allSwitchesBR = [];

for iDataset = 1:nDatasets
    
    cd(['B:\Results\forPrediction\InstAmp\Session_' num2str(iDataset) '\forPrediction'])
    
    load events_times.mat
    
    [idx] = (events(:,1) == 7 | events(:,1)==9); % these two events mark the beginning of a dominance
    
    startTimes = ceil(events(idx,2)); % These are already in samples so no transformation is required
    
    chunks = zeros(nChans,length(startTimes),length(t)); % initialise collection variable
    
    for iChan = 1:nChans
        
        tic;
        
        temp = csvread(['lowInstAmp_chan' num2str(iChan) '.csv']); % Read the CSV file
        
        for iTransitions = 1:length(startTimes)
            
            chunks(iChan,iTransitions,:) = (temp(startTimes(iTransitions)-collectBefore:startTimes(iTransitions)+collectAfter)); % Collect for each transition across each channel
            
        end
        
        toc;
        
    end
    
    chunks = squeeze(nanmean(chunks,1)); % Average across the array/grid 
    
    allSwitchesBR = [allSwitchesBR;chunks]; % Pool
    
    clear chunks
    
end


%% Plot

meanTracePA = nanmean(allSwitchesPA,1); % Get the mean
semTracePA = nanstd(allSwitchesPA,[],1)./sqrt(size(allSwitchesPA,1)); % Get the SEM

meanTraceBR = nanmean(allSwitchesBR,1); % Get the mean
semTraceBR = nanstd(allSwitchesBR,[],1)./sqrt(size(allSwitchesBR,1)); % Get the SEM

figure(1)
subplot(1,2,1)
shadedErrorBar(t(26:476),meanTracePA(26:476),semTracePA(26:476))
hold on
plot(t(26:476),meanTracePA(26:476),'-k','LineWidth',1)
xlabel('time relative to switch [s]')
ylabel('instantaneous amplitude')
box off
xlim([-0.5 0.55])
vline(0,'--b')
title('BR Switches')
subplot(1,2,2)
shadedErrorBar(t(26:476),meanTraceBR(26:476),semTraceBR(26:476))
hold on
plot(t(26:476),meanTraceBR(26:476),'-r','LineWidth',1)
xlabel('time relative to switch [s]')
ylabel('instantaneous amplitude')
title('PA Switches')
box off
xlim([-0.5 0.55])
vline(0,'--b')

figure(2)
subplot(1,2,1)
imagesc(t,1:size(allSwitchesPA,1),allSwitchesPA-mean(mean(allSwitchesPA)))
vline(0,'--w')
colormap jet
xlabel('time relative to switch [s]')
ylabel('switch number')
subplot(1,2,2)
imagesc(t,1:size(allSwitchesBR,1),allSwitchesBR-mean(mean(allSwitchesBR)))
vline(0,'--w')
colormap jet
xlabel('time relative to switch [s]')
