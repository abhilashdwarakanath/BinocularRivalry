clear all
close all
clc

dbstop if error

% Collect negative, positive and low-frequency rectified events and compute some statistics and shit
% Comments will be added later. No really, I swear, I will add them.
%
%
% MOST IMPORTANT UPDATE TO DO - When events are checked for correspondence in number, limit their correspondence to within 4-8samples of (either way) shift ONLY. IF YES KEEP
% THEM, IF NOT, DISCARD.
%
% THEN RE-DO STATISTICS
%
% Abhilash Dwarakanath. NS. Last update - 20221208.
%
% REPEAT THIS ANALYSIS FOR RANDOMLY TRIGGERED PERIODS IN RESTING STATE

%% Load the master structure - go have a long walk or something while this loads. It is YUUUGE.

cd('C:\Users\Abhilash Dwarakanath\Documents\MATLAB\NeuronPaper_MasterStructure')
load('eventsData_BR_v7_500ms.mat')

%% Setup some params and time shit

params.nDatasets = length(neuralEvents);
params.elecs = 96;

t = neuralEvents(1).t;
tEvt = neuralEvents(1).tEvt;


%% Loop through and collect shit

negativeEvents_s90TO270 = [];
positiveEvents_s90TO270 = [];
lowEvents_forNeg_s90TO270 = [];
lowEvents_forPos_s90TO270 = [];

negativeEvents_s270TO90 = [];
positiveEvents_s270TO90 = [];
lowEvents_forNeg_s270TO90 = [];
lowEvents_forPos_s270TO90 = [];

c1 = 0;
c2 = 0;

for iDataset = 1:params.nDatasets

    % Down to Up Transitions

    for iTransition = 1:size(neuralEvents(iDataset).lfp.bb.s270TO90.negEvents,1)

        c1 = c1+1;

        % Make rasters and collect corresponding events

        negBBRaster = zeros(params.elecs,length(neuralEvents(iDataset).t));
        posBBRaster = zeros(params.elecs,length(neuralEvents(iDataset).t));
        lowRaster = zeros(params.elecs,length(neuralEvents(iDataset).t));

        for iChan = 1:params.elecs

            if ~isempty(neuralEvents(iDataset).lfp.bb.s270TO90.negEvents(iTransition,iChan).times)

                for iEvt = 1:length(neuralEvents(iDataset).lfp.bb.s270TO90.negEvents(iTransition,iChan).times)

                    [idx, idx] = min(abs(t-neuralEvents(iDataset).lfp.bb.s270TO90.negEvents(iTransition,iChan).times(iEvt)));

                    negBBRaster(iChan,idx) = 1;

                end

            end

            if ~isempty(neuralEvents(iDataset).lfp.bb.s270TO90.posEvents(iTransition,iChan).times)

                for iEvt = 1:length(neuralEvents(iDataset).lfp.bb.s270TO90.posEvents(iTransition,iChan).times)

                    [idx, idx] = min(abs(t-neuralEvents(iDataset).lfp.bb.s270TO90.posEvents(iTransition,iChan).times(iEvt)));

                    posBBRaster(iChan,idx) = 2; % Change colour. But by how much?

                end

            end

            if ~isempty(neuralEvents(iDataset).lfp.low.s270TO90.events(iTransition,iChan).times)

                for iEvt = 1:length(neuralEvents(iDataset).lfp.low.s270TO90.events(iTransition,iChan).times)

                    [idx, idx] = min(abs(t-neuralEvents(iDataset).lfp.low.s270TO90.events(iTransition,iChan).times(iEvt))); %#ok<*ASGLU> 

                    lowRaster(iChan,idx) = 3; % Change colour. But by how much?

                end

            end

            if length(neuralEvents(iDataset).lfp.bb.s270TO90.negEvents(iTransition,iChan).times) == length(neuralEvents(iDataset).lfp.low.s270TO90.events(iTransition,iChan).times)

                negativeEvents_s270TO90 = [negativeEvents_s270TO90 neuralEvents(iDataset).lfp.bb.s270TO90.negEvents(iTransition,iChan).times];
                lowEvents_forNeg_s270TO90 = [lowEvents_forNeg_s270TO90 neuralEvents(iDataset).lfp.low.s270TO90.events(iTransition,iChan).times];

            end

            if length(neuralEvents(iDataset).lfp.bb.s270TO90.posEvents(iTransition,iChan).times) == length(neuralEvents(iDataset).lfp.low.s270TO90.events(iTransition,iChan).times)

                positiveEvents_s270TO90 = [positiveEvents_s270TO90 neuralEvents(iDataset).lfp.bb.s270TO90.posEvents(iTransition,iChan).times]; %#ok<*AGROW> 
                lowEvents_forPos_s270TO90 = [lowEvents_forPos_s270TO90 neuralEvents(iDataset).lfp.low.s270TO90.events(iTransition,iChan).times];

            end

        end

        negBBRaster_s270TO90(c1,:,:) = negBBRaster; %#ok<*SAGROW> 
        posBBRaster_s270TO90(c1,:,:) = posBBRaster;
        lowRaster_s270TO90(c1,:,:) = lowRaster;

    end

    % Up to Down Transitions

    for iTransition = 1:size(neuralEvents(iDataset).lfp.bb.s90TO270.negEvents,1)

        c2 = c2+1;

        % Make rasters and collect corresponding events

        negBBRaster = zeros(params.elecs,length(neuralEvents(iDataset).t));
        posBBRaster = zeros(params.elecs,length(neuralEvents(iDataset).t));
        lowRaster = zeros(params.elecs,length(neuralEvents(iDataset).t));

        for iChan = 1:params.elecs

            if ~isempty(neuralEvents(iDataset).lfp.bb.s90TO270.negEvents(iTransition,iChan).times)

                for iEvt = 1:length(neuralEvents(iDataset).lfp.bb.s90TO270.negEvents(iTransition,iChan).times)

                    [idx, idx] = min(abs(t-neuralEvents(iDataset).lfp.bb.s90TO270.negEvents(iTransition,iChan).times(iEvt))); %#ok<*NCOMMA> 

                    negBBRaster(iChan,idx) = 1;

                end

            end

            if ~isempty(neuralEvents(iDataset).lfp.bb.s90TO270.posEvents(iTransition,iChan).times)

                for iEvt = 1:length(neuralEvents(iDataset).lfp.bb.s90TO270.posEvents(iTransition,iChan).times)

                    [idx, idx] = min(abs(t-neuralEvents(iDataset).lfp.bb.s90TO270.posEvents(iTransition,iChan).times(iEvt)));

                    posBBRaster(iChan,idx) = 2; % Change colour. But by how much?

                end

            end

            if ~isempty(neuralEvents(iDataset).lfp.low.s90TO270.events(iTransition,iChan).times)

                for iEvt = 1:length(neuralEvents(iDataset).lfp.low.s90TO270.events(iTransition,iChan).times)

                    [idx, idx] = min(abs(t-neuralEvents(iDataset).lfp.low.s90TO270.events(iTransition,iChan).times(iEvt)));

                    lowRaster(iChan,idx) = 3; % Change colour. But by how much?

                end

            end

            if length(neuralEvents(iDataset).lfp.bb.s90TO270.negEvents(iTransition,iChan).times) == length(neuralEvents(iDataset).lfp.low.s90TO270.events(iTransition,iChan).times)

                negativeEvents_s90TO270 = [negativeEvents_s90TO270 neuralEvents(iDataset).lfp.bb.s90TO270.negEvents(iTransition,iChan).times];
                lowEvents_forNeg_s90TO270 = [lowEvents_forNeg_s90TO270 neuralEvents(iDataset).lfp.low.s90TO270.events(iTransition,iChan).times];

            end

            if length(neuralEvents(iDataset).lfp.bb.s90TO270.posEvents(iTransition,iChan).times) == length(neuralEvents(iDataset).lfp.low.s90TO270.events(iTransition,iChan).times)

                positiveEvents_s90TO270 = [positiveEvents_s90TO270 neuralEvents(iDataset).lfp.bb.s90TO270.posEvents(iTransition,iChan).times];
                lowEvents_forPos_s90TO270 = [lowEvents_forPos_s90TO270 neuralEvents(iDataset).lfp.low.s90TO270.events(iTransition,iChan).times];

            end

        end

        negBBRaster_s90TO270(c2,:,:) = negBBRaster;
        posBBRaster_s90TO270(c2,:,:) = posBBRaster;
        lowRaster_s90TO270(c2,:,:) = lowRaster;

    end

end

%% Plot scatter plot and compute r

negativeEvents = [negativeEvents_s90TO270 negativeEvents_s270TO90];
positiveEvents = [positiveEvents_s90TO270 positiveEvents_s270TO90];
lowEventsForPos = [lowEvents_forPos_s90TO270 lowEvents_forPos_s270TO90];
lowEventsForNeg = [lowEvents_forNeg_s90TO270 lowEvents_forNeg_s270TO90];

% Remove times beyond 0

inputDataNeg = [negativeEvents' lowEventsForNeg'];

c = 0;

for iEvt = 1:size(inputDataNeg,1)

    if inputDataNeg(iEvt,1) > 0 || inputDataNeg(iEvt,2) > 0

        c = c+1;

        remIdxNeg(c) = iEvt;
    end

end

inputDataNeg(remIdxNeg,:) = [];

inputDataPos = [positiveEvents' lowEventsForPos'];

c = 0;

for iEvt = 1:size(inputDataPos,1)

    if inputDataPos(iEvt,1) > 0 || inputDataPos(iEvt,2) > 0

        c = c+1;

        remIdxPos(c) = iEvt;

    end

end

inputDataPos(remIdxPos,:) = [];

[r_neg, p_neg] = corrcoef(inputDataNeg(:,1),inputDataNeg(:,2));
[r_pos, p_pos] = corrcoef(inputDataPos(:,1),inputDataPos(:,2));

figure;
subplot(1,2,1)
densityScatterChart(inputDataNeg(:,1),inputDataNeg(:,2));
%box off; 
xlim([-0.55 0.05]); ylim([-0.55 0.05]);
xlabel('time of negative broadband deflection [s]')
ylabel('time of corresponding 1-9Hz event [s]')
title(['r = ' num2str(r_neg(2))])
colormap jet

subplot(1,2,2)
densityScatterChart(inputDataPos(:,1),inputDataPos(:,2));
%box off; 
xlim([-0.55 0.05]); ylim([-0.55 0.05]);
xlabel('time of positive broadband deflection [s]')
ylabel('time of corresponding 1-9Hz event [s]')
title(['r = ' num2str(r_pos(2))])
colormap jet


%% Next shit...

c = 0;
for iDataset = 1:length(neuralEvents)
    for iCond = 1:size(neuralEvents(iDataset).lfp.bb.s270TO90.negEvents,1) % Replace neuralEvents(iDataset) with neuralEvents(1 to 6) for the 6 different datasets
        for iChan = 1:size(neuralEvents(iDataset).lfp.bb.s270TO90.negEvents,2) % Replace s270TO90 with s90TO270 for the other switch type
            for iEvt = 1:length(neuralEvents(iDataset).lfp.bb.s270TO90.negEvents(iCond,iChan).times) % replace negEvents with posEvents for positive events

                c = c+1;
                tic;

                negEvtTrigPooledLFP_s270TO90(c,:) = neuralEvents(iDataset).lfp.bb.s270TO90.negEvents(iCond,iChan).negEvtTrigLFP(iEvt,:);
                negEvtTrigPooledCWT_s270TO90(c,:,:) = squeeze(neuralEvents(iDataset).lfp.bb.s270TO90.negEvents(iCond,iChan).negEvtTrigCWT(iEvt,:,:));

                toc;

            end
        end
    end
end

c = 0;
for iDataset = 1:length(neuralEvents)
    for iCond = 1:size(neuralEvents(iDataset).lfp.bb.s270TO90.posEvents,1) % Replace neuralEvents(iDataset) with neuralEvents(1 to 6) for the 6 different datasets
        for iChan = 1:size(neuralEvents(iDataset).lfp.bb.s270TO90.posEvents,2) % Replace s270TO90 with s90TO270 for the other switch type
            for iEvt = 1:length(neuralEvents(iDataset).lfp.bb.s270TO90.posEvents(iCond,iChan).times) % replace posEvents with posEvents for positive events

                c = c+1;

                tic;

                posEvtTrigPooledLFP_s270TO90(c,:) = neuralEvents(iDataset).lfp.bb.s270TO90.posEvents(iCond,iChan).posEvtTrigLFP(iEvt,:);
                posEvtTrigPooledCWT_s270TO90(c,:,:) = squeeze(neuralEvents(iDataset).lfp.bb.s270TO90.posEvents(iCond,iChan).posEvtTrigCWT(iEvt,:,:));

                toc;

            end
        end
    end
end

c = 0;
for iDataset = 1:length(neuralEvents)
    for iCond = 1:size(neuralEvents(iDataset).lfp.bb.s90TO270.negEvents,1) % Replace neuralEvents(iDataset) with neuralEvents(1 to 6) for the 6 different datasets
        for iChan = 1:size(neuralEvents(iDataset).lfp.bb.s90TO270.negEvents,2) % Replace s90TO270 with s90TO270 for the other switch type
            for iEvt = 1:length(neuralEvents(iDataset).lfp.bb.s90TO270.negEvents(iCond,iChan).times) % replace negEvents with posEvents for positive events

                c = c+1;

                tic;

                negEvtTrigPooledLFP_s90TO270(c,:) = neuralEvents(iDataset).lfp.bb.s90TO270.negEvents(iCond,iChan).negEvtTrigLFP(iEvt,:);
                negEvtTrigPooledCWT_s90TO270(c,:,:) = squeeze(neuralEvents(iDataset).lfp.bb.s90TO270.negEvents(iCond,iChan).negEvtTrigCWT(iEvt,:,:));

                toc;

            end
        end
    end
end

c = 0;
for iDataset = 1:length(neuralEvents)
    for iCond = 1:size(neuralEvents(iDataset).lfp.bb.s90TO270.posEvents,1) % Replace neuralEvents(iDataset) with neuralEvents(1 to 6) for the 6 different datasets
        for iChan = 1:size(neuralEvents(iDataset).lfp.bb.s90TO270.posEvents,2) % Replace s90TO270 with s90TO270 for the other switch type
            for iEvt = 1:length(neuralEvents(iDataset).lfp.bb.s90TO270.posEvents(iCond,iChan).times) % replace posEvents with posEvents for positive events

                c = c+1;

                toc;

                posEvtTrigPooledLFP_s90TO270(c,:) = neuralEvents(iDataset).lfp.bb.s90TO270.posEvents(iCond,iChan).posEvtTrigLFP(iEvt,:);
                posEvtTrigPooledCWT_s90TO270(c,:,:) = squeeze(neuralEvents(iDataset).lfp.bb.s90TO270.posEvents(iCond,iChan).posEvtTrigCWT(iEvt,:,:));

                toc;

            end
        end
    end
end

%% Plot grand avg LFP

negEvtTrigPooledLFP = [negEvtTrigPooledLFP_s270TO90; negEvtTrigPooledLFP_s90TO270];
posEvtTrigPooledLFP = [posEvtTrigPooledLFP_s270TO90; posEvtTrigPooledLFP_s90TO270];

figure
subplot(1,2,1)
plot(tEvt,nanmean(negEvtTrigPooledLFP,1),'LineWidth',2)
xlabel('time relative to negative deflection [s]')
ylabel('amplitude of broadband LFP [uV]')
vline(0,'--k')
box off
grid on
title('Broadband LFP triggered at Negative Event')

subplot(1,2,2)
plot(tEvt,nanmean(posEvtTrigPooledLFP,1),'-r','LineWidth',2)
xlabel('time relative to positive deflection [s]')
ylabel('amplitude of broadband LFP [uV]')
vline(0,'--k')
box off
grid on
title('Broadband LFP triggered at Negative Event')

%% Plot grand avg CWT

negEvtTrigPooledCWT = cat(1,negEvtTrigPooledCWT_s270TO90,negEvtTrigPooledCWT_s90TO270);
posEvtTrigPooledCWT = cat(1,posEvtTrigPooledCWT_s270TO90,posEvtTrigPooledCWT_s90TO270);


f = neuralEvents(iDataset).f;
Yticks = 2.^(round(log2(min(f))):round(log2(max(f))));


figure
subplot(1,2,1)
imagesc(tEvt,log2(f),squeeze(nanmean(negEvtTrigPooledCWT,1)))
vline(0,'--w')
xlabel('time relative to negative deflection [s]')
ylabel('Frequency [Hz]')
title('Spectral activity relative to Negative deflection')
colormap jet
AX = gca;
set(AX, 'YTick',log2(Yticks(:)), 'YTickLabel',num2str(sprintf('%g\n',Yticks)))
AX.YLim = log2([min(f), max(f)]);
axis xy
colormap jet
AX.CLim = [0 0.75];

subplot(1,2,2)
imagesc(tEvt,log2(f),squeeze(nanmean(posEvtTrigPooledCWT,1)))
vline(0,'--w')
xlabel('time relative to positive deflection [s]')
ylabel('Frequency [Hz]')
title('Spectral activity relative to Positive deflection')
colormap jet
AX = gca;
set(AX, 'YTick',log2(Yticks(:)), 'YTickLabel',num2str(sprintf('%g\n',Yticks)))
AX.YLim = log2([min(f), max(f)]);
axis xy
colormap jet
AX.CLim = [0 0.75];