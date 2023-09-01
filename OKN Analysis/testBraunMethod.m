clear all
clc
close all

% This script tests the Jochen Braun method of detecting transitions in one dataset in both BR and PA. Let's see how it works.

%% Load the dataset

cd B:\A11\20170302\PFC\Bfsgrad1

load jMUSpikesByTime.mat
load jMUDominancesByTime.mat

%% Params

params.conds = 8;
params.Fs = 1000;
params.targetFs = 500;
displaySize = [0 750]; % pixels. However, there is an issue with the range of values in our data. Firstly, it goes -ve while theirs don't. Secondly, the range of the eye movement values don't match with my calculated size in pixels. Either I'm getting the monitor width wrong or there is some transformation I'm missing.
timeKernel = 50; % ms

% Filter
[b,a] = butter(3,20/(params.Fs/2),'low'); % From Logothetis 1989

%% PreProcessing

% Do low-pass filtering of the raw OKN signal

% BR
c = 0;
for iCond = [1 3]
    
    for iTrial = 1:length(jMUspikes.data{1}.okn.trace{iCond})
        
        tic;
        
        temp = jMUspikes.data{1}.okn.trace{iCond}{iTrial};
        
        temp = (filtfilt(b,a,temp));
        
        evts = jMUDominances.data.events{iCond}{iTrial};
        
        times = jMUDominances.data.eventTimes{iCond}{iTrial}./3e4;
        
        idx = find(evts==13); % 13 is just our marking for a "good" trial, so we remove it.
        
        if ~isempty(idx)
            
            evts(idx) = [];
            times(idx) = [];
        end
        
        idx = find(evts==11 | evts == 7 | evts == 9); % 11 is our mark for the start of the flash suppression phase OKN. 7 is start of 90 dominance and 9 is start of 270 dominance
        
        if ~isempty(idx)
            
            c = c+1;
            
            tempTimes = times*params.Fs;
            BR.s90.traces{c} = temp(tempTimes(2):end); % Only collect from stimulus onset. Discard the 300-500ms of fixation
            BR.s90.valTimes{c} = (times(idx)*params.Fs-tempTimes(2))+1;
            
        end
        
        toc;
        
    end
    
end

c = 0;
for iCond = [2 4]
    
    for iTrial = 1:length(jMUspikes.data{1}.okn.trace{iCond})
        
        tic;
        
        temp = jMUspikes.data{1}.okn.trace{iCond}{iTrial};
        
        temp = (filtfilt(b,a,temp));
        
        evts = jMUDominances.data.events{iCond}{iTrial};
        
        times = jMUDominances.data.eventTimes{iCond}{iTrial}./3e4;
        
        idx = find(evts==13);
        
        if ~isempty(idx)
            
            evts(idx) = [];
            times(idx) = [];
        end
        
        idx = find(evts==11 | evts == 7 | evts == 9);
        
        if ~isempty(idx)
            
            c = c+1;
            tempTimes = times*params.Fs;
            BR.s270.traces{c} = temp(tempTimes(2):end);
            BR.s270.valTimes{c} = (times(idx)*params.Fs-tempTimes(2))+1;
            
        end
        
        toc;
        
    end
    
end

% PA
c = 0;
for iCond = [5 7]
    
    for iTrial = 1:length(jMUspikes.data{1}.okn.trace{iCond})
        
        tic;
        
        temp = jMUspikes.data{1}.okn.trace{iCond}{iTrial};
        
        temp = (filtfilt(b,a,temp));
        
        evts = jMUDominances.data.events{iCond}{iTrial};
        
        times = jMUDominances.data.eventTimes{iCond}{iTrial}./3e4;
        
        idx = find(evts==3 | evts == 5 | evts == 6);
        
        if ~isempty(idx)
            
            c = c+1;

            tempTimes = times*params.Fs;
            PA.s90.traces{c} = temp(tempTimes(2):end);
            PA.s90.valTimes{c} = (times(idx)*params.Fs-tempTimes(2))+1;
            
        end
        
        toc;
        
    end
    
end

c = 0;
for iCond = [6 8]
    
    for iTrial = 1:length(jMUspikes.data{1}.okn.trace{iCond})
        
        tic;
        
        temp = jMUspikes.data{1}.okn.trace{iCond}{iTrial};
        
        temp = (filtfilt(b,a,temp));
        
        evts = jMUDominances.data.events{iCond}{iTrial};
        
        times = jMUDominances.data.eventTimes{iCond}{iTrial}./3e4;
        
        idx = find(evts==3 | evts == 5 | evts ==6);
        
        if ~isempty(idx)
            
            c = c+1;
            
            tempTimes = times*params.Fs;
            PA.s270.traces{c} = temp(tempTimes(2):end);
            PA.s270.valTimes{c} = (times(idx)*params.Fs-tempTimes(2))+1;
            
        end
        
        toc;
        
    end
    
end

%% Clean up blinks and saccades - lab method. 

% This works better for us because our stimulus is only 8° in size and we
% have both negative and positive eye-positions (vertically moving
% gratings).

absvelocityThreshold = 0.5;
absaccelerationThreshold = 0.75;
absamplitudeThreshold = 700;

for i=1:length(BR.s90.traces)
        tmp_OKNtimeSeriesFilt = BR.s90.traces{i}';
        % finding the first derivative 
        tmp_dOKNtimeSeries = diff(tmp_OKNtimeSeriesFilt);
        % finding the second derivative
        tmp_d2OKNtimeSeries = diff(tmp_dOKNtimeSeries);
        % insert 1 NaN at the begining of 1 dev
        tmp_dOKNtimeSeries = [NaN tmp_dOKNtimeSeries];
        % insert 2 NaN at the begining of 2 dev
        tmp_d2OKNtimeSeries = [NaN NaN tmp_d2OKNtimeSeries];
        % find points where we pass the thresholds (velocity and acceleration threshold)
        tmpIndex = find(abs(tmp_OKNtimeSeriesFilt) >= absamplitudeThreshold);
        tmpIndex_d = find(abs(tmp_dOKNtimeSeries) >= absvelocityThreshold);
        tmpIndex_d = [tmpIndex_d find(isnan(tmp_dOKNtimeSeries))]; % get rid of the NaNs 
        tmpIndex_d = [tmpIndex_d find(isinf(tmp_dOKNtimeSeries))]; % get rid of the INFs
        tmpIndex_d2 = find(abs(tmp_d2OKNtimeSeries) >= absaccelerationThreshold);
        tmpIndex_d2 = [tmpIndex_d2 find(isnan(tmp_d2OKNtimeSeries))]; % get rid of the NaNs
        tmpIndex_d2 = [tmpIndex_d2 find(isinf(tmp_d2OKNtimeSeries))]; % get rid of the INFs
        % find the indices that cross all thresholds
        indicesAmpVel = intersect(tmpIndex,tmpIndex_d); %indices where amplitude and velocity are both beyond threshold
        indicesAmpAcc = intersect(tmpIndex,tmpIndex_d2); %indices where amplitude and acceleration are both beyond threshold
        indicesVelAcc = intersect(tmpIndex_d,tmpIndex_d2); %indices where acceleration and velocity are both beyond threshold
        indices = intersect(indicesAmpVel,tmpIndex_d2); % for when we want the points where amplitude, vlocity and acceleration all pass the threshold at the same time
        tmp_OKNtimeSeriesFilt(indices) = NaN;
        tmp_OKNtimeSeriesFilt(indicesAmpVel) = NaN;
        tmp_OKNtimeSeriesFilt(indicesAmpAcc) = NaN;
        BR.s90.traces{i} = normalise(tmp_OKNtimeSeriesFilt);
end

for i=1:length(BR.s270.traces)
        tmp_OKNtimeSeriesFilt = BR.s270.traces{i}';
        % finding the first derivative 
        tmp_dOKNtimeSeries = diff(tmp_OKNtimeSeriesFilt);
        % finding the second derivative
        tmp_d2OKNtimeSeries = diff(tmp_dOKNtimeSeries);
        % insert 1 NaN at the begining of 1 dev
        tmp_dOKNtimeSeries = [NaN tmp_dOKNtimeSeries];
        % insert 2 NaN at the begining of 2 dev
        tmp_d2OKNtimeSeries = [NaN NaN tmp_d2OKNtimeSeries];
        % find points where we pass the thresholds (velocity and acceleration threshold)
        tmpIndex = find(abs(tmp_OKNtimeSeriesFilt) >= absamplitudeThreshold);
        tmpIndex_d = find(abs(tmp_dOKNtimeSeries) >= absvelocityThreshold);
        tmpIndex_d = [tmpIndex_d find(isnan(tmp_dOKNtimeSeries))]; % get rid of the NaNs 
        tmpIndex_d = [tmpIndex_d find(isinf(tmp_dOKNtimeSeries))]; % get rid of the INFs
        tmpIndex_d2 = find(abs(tmp_d2OKNtimeSeries) >= absaccelerationThreshold);
        tmpIndex_d2 = [tmpIndex_d2 find(isnan(tmp_d2OKNtimeSeries))]; % get rid of the NaNs
        tmpIndex_d2 = [tmpIndex_d2 find(isinf(tmp_d2OKNtimeSeries))]; % get rid of the INFs
        % find the indices that cross all thresholds
        indicesAmpVel = intersect(tmpIndex,tmpIndex_d); %indices where amplitude and velocity are both beyond threshold
        indicesAmpAcc = intersect(tmpIndex,tmpIndex_d2); %indices where amplitude and acceleration are both beyond threshold
        indicesVelAcc = intersect(tmpIndex_d,tmpIndex_d2); %indices where acceleration and velocity are both beyond threshold
        indices = intersect(indicesAmpVel,tmpIndex_d2); % for when we want the points where amplitude, vlocity and acceleration all pass the threshold at the same time
        tmp_OKNtimeSeriesFilt(indices) = NaN;
        tmp_OKNtimeSeriesFilt(indicesAmpVel) = NaN;
        tmp_OKNtimeSeriesFilt(indicesAmpAcc) = NaN;
        BR.s270.traces{i} = normalise(tmp_OKNtimeSeriesFilt);
end

for i=1:length(PA.s90.traces)
        tmp_OKNtimeSeriesFilt = PA.s90.traces{i}';
        % finding the first derivative 
        tmp_dOKNtimeSeries = diff(tmp_OKNtimeSeriesFilt);
        % finding the second derivative
        tmp_d2OKNtimeSeries = diff(tmp_dOKNtimeSeries);
        % insert 1 NaN at the begining of 1 dev
        tmp_dOKNtimeSeries = [NaN tmp_dOKNtimeSeries];
        % insert 2 NaN at the begining of 2 dev
        tmp_d2OKNtimeSeries = [NaN NaN tmp_d2OKNtimeSeries];
        % find points where we pass the thresholds (velocity and acceleration threshold)
        tmpIndex = find(abs(tmp_OKNtimeSeriesFilt) >= absamplitudeThreshold);
        tmpIndex_d = find(abs(tmp_dOKNtimeSeries) >= absvelocityThreshold);
        tmpIndex_d = [tmpIndex_d find(isnan(tmp_dOKNtimeSeries))]; % get rid of the NaNs 
        tmpIndex_d = [tmpIndex_d find(isinf(tmp_dOKNtimeSeries))]; % get rid of the INFs
        tmpIndex_d2 = find(abs(tmp_d2OKNtimeSeries) >= absaccelerationThreshold);
        tmpIndex_d2 = [tmpIndex_d2 find(isnan(tmp_d2OKNtimeSeries))]; % get rid of the NaNs
        tmpIndex_d2 = [tmpIndex_d2 find(isinf(tmp_d2OKNtimeSeries))]; % get rid of the INFs
        % find the indices that cross all thresholds
        indicesAmpVel = intersect(tmpIndex,tmpIndex_d); %indices where amplitude and velocity are both beyond threshold
        indicesAmpAcc = intersect(tmpIndex,tmpIndex_d2); %indices where amplitude and acceleration are both beyond threshold
        indicesVelAcc = intersect(tmpIndex_d,tmpIndex_d2); %indices where acceleration and velocity are both beyond threshold
        indices = intersect(indicesAmpVel,tmpIndex_d2); % for when we want the points where amplitude, vlocity and acceleration all pass the threshold at the same time
        tmp_OKNtimeSeriesFilt(indices) = NaN;
        tmp_OKNtimeSeriesFilt(indicesAmpVel) = NaN;
        tmp_OKNtimeSeriesFilt(indicesAmpAcc) = NaN;
        PA.s90.traces{i} = normalise(tmp_OKNtimeSeriesFilt);
end

for i=1:length(PA.s270.traces)
        tmp_OKNtimeSeriesFilt = PA.s270.traces{i}';
        % finding the first derivative 
        tmp_dOKNtimeSeries = diff(tmp_OKNtimeSeriesFilt);
        % finding the second derivative
        tmp_d2OKNtimeSeries = diff(tmp_dOKNtimeSeries);
        % insert 1 NaN at the begining of 1 dev
        tmp_dOKNtimeSeries = [NaN tmp_dOKNtimeSeries];
        % insert 2 NaN at the begining of 2 dev
        tmp_d2OKNtimeSeries = [NaN NaN tmp_d2OKNtimeSeries];
        % find points where we pass the thresholds (velocity and acceleration threshold)
        tmpIndex = find(abs(tmp_OKNtimeSeriesFilt) >= absamplitudeThreshold);
        tmpIndex_d = find(abs(tmp_dOKNtimeSeries) >= absvelocityThreshold);
        tmpIndex_d = [tmpIndex_d find(isnan(tmp_dOKNtimeSeries))]; % get rid of the NaNs 
        tmpIndex_d = [tmpIndex_d find(isinf(tmp_dOKNtimeSeries))]; % get rid of the INFs
        tmpIndex_d2 = find(abs(tmp_d2OKNtimeSeries) >= absaccelerationThreshold);
        tmpIndex_d2 = [tmpIndex_d2 find(isnan(tmp_d2OKNtimeSeries))]; % get rid of the NaNs
        tmpIndex_d2 = [tmpIndex_d2 find(isinf(tmp_d2OKNtimeSeries))]; % get rid of the INFs
        % find the indices that cross all thresholds
        indicesAmpVel = intersect(tmpIndex,tmpIndex_d); %indices where amplitude and velocity are both beyond threshold
        indicesAmpAcc = intersect(tmpIndex,tmpIndex_d2); %indices where amplitude and acceleration are both beyond threshold
        indicesVelAcc = intersect(tmpIndex_d,tmpIndex_d2); %indices where acceleration and velocity are both beyond threshold
        indices = intersect(indicesAmpVel,tmpIndex_d2); % for when we want the points where amplitude, vlocity and acceleration all pass the threshold at the same time
        tmp_OKNtimeSeriesFilt(indices) = NaN;
        tmp_OKNtimeSeriesFilt(indicesAmpVel) = NaN;
        tmp_OKNtimeSeriesFilt(indicesAmpAcc) = NaN;
        PA.s270.traces{i} = normalise(tmp_OKNtimeSeriesFilt);
end

%% Run the Aleshin algorithm

nSplines = 500;
subsampleFactor = 1/100;

% BR
for iTrial = 1:length(BR.s90.traces)
    
    tic;
    gx = BR.s90.traces{iTrial};
    vel = abs(diff(gx));
    pd = fitdist(vel','kernel');
    velT = linspace(min(vel),max(vel),250);
    pdfunc = pdf(pd,velT);
    [~,locs] = findpeaks(pdfunc,'NPeaks',3); % Because we assume bimodality
    testPart = pdfunc(locs(2):locs(3));
    testY = nan(1,length(velT));
    testY(locs(2):locs(3)) = testPart;
    [val idx] = min(testY);
    velThreshold = velT(idx); % Sort of saddle point. It works decently well and is rather similar to Aleshin et al's value
    acc = diff(diff(gx));
    aThreshold = quantile(acc,0.95);
    gx_pursuit = extractPursuit(gx,displaySize,timeKernel,velThreshold,aThreshold);
    gx_cont = shiftPursuits(gx_pursuit,timeKernel);
    BR.s90.csp{iTrial} = gx_cont;
    sigLoss = (sum(isnan(gx_cont))/length(gx_cont))*100; %age of signal loss
    
    if sigLoss <=50
        fprintf('Good SNR. May work...\n')
        gx_spline = splineEMT(gx_cont,nSplines, subsampleFactor);
        splineVel = getVelocity(gx_spline);
        splineVelThreshold =nanmedian(abs(splineVel(2,:))); % Justify this threshold
        %splineVelThreshold = 0.4;
        [SwitchTime, Percept] = getReversals(splineVel, splineVelThreshold);
        valTimes = double(int32(BR.s90.valTimes{iTrial}(1))); % Reject false positives detected before the presentation of the mask
        SwitchTime(SwitchTime<=valTimes) = [];
        BR.s90.predSwitches{iTrial} = SwitchTime;
        
    else
        fprintf('Too much signal loss. Not processing...\n')
        BR.s90.predSwitches{iTrial} = NaN;
        
    end
    
    toc
    
end

for iTrial = 1:length(BR.s270.traces)
    
    tic;
    gx = BR.s270.traces{iTrial};
    vel = abs(diff(gx));
    pd = fitdist(vel','kernel');
    velT = linspace(min(vel),max(vel),250);
    pdfunc = pdf(pd,velT);
    [~,locs] = findpeaks(pdfunc,'NPeaks',3); % Because we assume bimodality
    testPart = pdfunc(locs(2):locs(3));
    testY = nan(1,length(velT));
    testY(locs(2):locs(3)) = testPart;
    [val idx] = min(testY);
    velThreshold = velT(idx); % Sort of saddle point.
    acc = diff(diff(gx));
    aThreshold = quantile(acc,0.95);
    gx_pursuit = extractPursuit(gx,displaySize,timeKernel,velThreshold,aThreshold);
    gx_cont = shiftPursuits(gx_pursuit,timeKernel);
    BR.s270.csp{iTrial} = gx_cont;
    sigLoss = (sum(isnan(gx_cont))/length(gx_cont))*100;
    
    if sigLoss <=50
        fprintf('Good SNR. May work...\n')
        gx_spline = splineEMT(gx_cont,nSplines, subsampleFactor);
        splineVel = getVelocity(gx_spline);
        splineVelThreshold =nanmedian(abs(splineVel(2,:))); % Justify this threshold
        %splineVelThreshold = 0.6;
        [SwitchTime, Percept] = getReversals(splineVel, splineVelThreshold);
        valTimes = double(int32(BR.s270.valTimes{iTrial}(1))); % Reject false positives detected before the presentation of the mask
        SwitchTime(SwitchTime<=valTimes) = [];
        BR.s270.predSwitches{iTrial} = SwitchTime;
        
    else
        fprintf('Too much signal loss. Not processing...\n')
        BR.s270.predSwitches{iTrial} = NaN;
        
    end
    
    toc
    
end

% PA

for iTrial = 1:length(PA.s90.traces)
    
    tic;
    gx = PA.s90.traces{iTrial};
    vel = abs(diff(gx));
    pd = fitdist(vel','kernel');
    velT = linspace(min(vel),max(vel),250);
    pdfunc = pdf(pd,velT);
    [~,locs] = findpeaks(pdfunc,'NPeaks',3); % Because we assume bimodality
    testPart = pdfunc(locs(2):locs(3));
    testY = nan(1,length(velT));
    testY(locs(2):locs(3)) = testPart;
    [val idx] = min(testY);
    velThreshold = velT(idx); % Sort of saddle point.
    acc = diff(diff(gx));
    aThreshold = quantile(acc,0.95);
    gx_pursuit = extractPursuit(gx,displaySize,timeKernel,velThreshold,aThreshold);
    gx_cont = shiftPursuits(gx_pursuit,timeKernel);
    PA.s90.csp{iTrial} = gx_cont;
    sigLoss = (sum(isnan(gx_cont))/length(gx_cont))*100;
    
    if sigLoss <=50
        fprintf('Good SNR. May work...\n')
        gx_spline = splineEMT(gx_cont,nSplines, subsampleFactor);
        splineVel = getVelocity(gx_spline);
        splineVelThreshold =nanmedian(abs(splineVel(2,:))); % Justify this threshold
        %splineVelThreshold = 0.6;
        [SwitchTime, Percept] = getReversals(splineVel, splineVelThreshold);
        valTimes = double(int32(PA.s90.valTimes{iTrial}(1))); % Reject false positives detected before the presentation of the mask
        SwitchTime(SwitchTime<=valTimes) = [];
        PA.s90.predSwitches{iTrial} = SwitchTime;
        
    else
        fprintf('Too much signal loss. Not processing...\n')
        PA.s90.predSwitches{iTrial} = NaN;
        
    end
    
    toc
    
end

for iTrial = 1:length(PA.s270.traces)
    
    tic;
    gx = PA.s270.traces{iTrial};
    vel = abs(diff(gx));
    pd = fitdist(vel','kernel');
    velT = linspace(min(vel),max(vel),250);
    pdfunc = pdf(pd,velT);
    [~,locs] = findpeaks(pdfunc,'NPeaks',3); % Because we assume bimodality
    testPart = pdfunc(locs(2):locs(3));
    testY = nan(1,length(velT));
    testY(locs(2):locs(3)) = testPart;
    [val idx] = min(testY);
    velThreshold = velT(idx); % Sort of saddle point.
    acc = diff(diff(gx));
    aThreshold = quantile(acc,0.95); %The paper uses the 95th quantile value
    gx_pursuit = extractPursuit(gx,displaySize,timeKernel,velThreshold,aThreshold);
    gx_cont = shiftPursuits(gx_pursuit,timeKernel);
    PA.s270.csp{iTrial} = gx_cont;
    sigLoss = (sum(isnan(gx_cont))/length(gx_cont))*100;
    
    if sigLoss <=50
        fprintf('Good SNR. May work...\n')
        gx_spline = splineEMT(gx_cont,nSplines, subsampleFactor);
        splineVel = getVelocity(gx_spline);
        splineVelThreshold =nanmedian(abs(splineVel(2,:))); % Justify this threshold
        %splineVelThreshold = 0.6;
        [SwitchTime, Percept] = getReversals(splineVel, splineVelThreshold);
        valTimes = double(int32(PA.s270.valTimes{iTrial}(1))); % Reject false positives detected before the presentation of the mask
        SwitchTime(SwitchTime<=valTimes) = [];
        PA.s270.predSwitches{iTrial} = SwitchTime;
        
    else
        fprintf('Too much signal loss. Not processing...\n')
        PA.s270.predSwitches{iTrial} = NaN;
        
    end
    
    toc
    
end

%% Plot Comparisons

% BR
figure(1)
for i = 1:length(BR.s90.traces)
subplot(8,7,i)
plot(BR.s90.traces{i},'LineWidth',1.25)
hold on
plot(BR.s90.csp{i},'--g','LineWidth',1.25) % Also plot the cumulative smooth pursuit to see its shape and kinks
if ~isempty(BR.s90.valTimes{i})
vline(BR.s90.valTimes{i},'--k')
end
if ~isempty(BR.s90.predSwitches{i})
vline(BR.s90.predSwitches{i},'--r')
end
axis tight; box off;
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
end
suptitle('Manual Marking (BLACK) vs Predicted (RED) - BR90TO270')

figure(2)
for i = 1:length(BR.s270.traces)
subplot(10,5,i)
plot(BR.s270.traces{i},'LineWidth',1.25)
hold on
plot(BR.s270.csp{i},'--g','LineWidth',1.25)
if ~isempty(BR.s270.valTimes{i})
vline(BR.s270.valTimes{i},'--k')
end
if ~isempty(BR.s270.predSwitches{i})
vline(BR.s270.predSwitches{i},'--r')
end
axis tight; box off;
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
end
suptitle('Manual Marking (BLACK) vs Predicted (RED) - BR270TO90')

figure(1)
for i = 1:length(PA.s90.traces)
subplot(8,7,i)
plot(PA.s90.traces{i},'LineWidth',1.25)
hold on
plot(PA.s90.csp{i},'--g','LineWidth',1.25)
if ~isempty(PA.s90.valTimes{i})
vline(PA.s90.valTimes{i},'--k')
end
if ~isempty(PA.s90.predSwitches{i})
vline(PA.s90.predSwitches{i},'--r')
end
axis tight; box off;
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
end
suptitle('Manual Marking (BLACK) vs Predicted (RED) - PA90TO270')

figure(2)
for i = 1:length(PA.s270.traces)
subplot(8,7,i)
plot(PA.s270.traces{i},'LineWidth',1.25)
hold on
plot(PA.s270.csp{i},'--g','LineWidth',1.25)
if ~isempty(PA.s270.valTimes{i})
vline(PA.s270.valTimes{i},'--k')
end
if ~isempty(PA.s270.predSwitches{i})
vline(PA.s270.predSwitches{i},'--r')
end
axis tight; box off;
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
end
suptitle('Manual Marking (BLACK) vs Predicted (RED) - PA270TO90')