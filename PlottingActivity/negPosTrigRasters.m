clear all
close all
clc

dbstop if error

% Collect negative, positive and low-frequency rectified events and compute some statistics and shit
% Comments will be added later. No really, I swear, I will add them.
%
%
%
% Abhilash Dwarakanath. NS. Last update - 20220111.

%% Load the master structure - go have a long walk or something while this loads. It is YUUUGE.

cd('C:\Users\Abhilash Dwarakanath\Documents\MATLAB\NeuronPaper_MasterStructure')
load('eventsData_BR_v9_500ms.mat')

%% Setup some params and time shit

params.nDatasets = length(neuralEvents);
params.elecs = 96;

t = neuralEvents(1).t;
tEvt = neuralEvents(1).tEvt;

mkdir EvtRastersPhases
cd EvtRastersPhases

%% Negative events

c1 = 0;
c2 = 0;

negPooledTrigTracesP2NP = [];
negPooledTrigTracesNP2P = [];
negPooledTrigRasterP2NP = [];
negPooledTrigRasterNP2P = [];
negPooledTrigPhaseP2NP = [];
negPooledTrigPhaseNP2P = [];

for iDataset = 1:params.nDatasets

    pref90_br = neuralEvents(iDataset).selChans.upward;
    pref270_br = neuralEvents(iDataset).selChans.downward;

    % Down to Up Switch

    for iTransition = 1:size(neuralEvents(iDataset).lfp.bb.s270TO90.negEvents,1)

        trigTraceP2NP = [];
        trigRasterP2NP = [];
        trigPhaseP2NP = [];
        trigTraceNP2P = [];
        trigRasterNP2P = [];
        trigPhaseNP2P = [];

        for iChanP = 1:length(pref270_br)

            if ~isempty(neuralEvents(iDataset).lfp.bb.s270TO90.negEvents(iTransition,pref270_br(iChanP)).times) && length(neuralEvents(iDataset).lfp.bb.s270TO90.negEvents(iTransition,pref270_br(iChanP)).times) == 1 && ~isempty(neuralEvents(iDataset).spikes.bb.s270TO90.negEvents(iTransition,pref270_br(iChanP)).negEvtTrigSpikes{1})

                %clear trigTraceP2NP; %clear trigPhaseP2NP; %clear trigRasterP2NP;
                
                trigTraceP2NP = [trigTraceP2NP;neuralEvents(iDataset).lfp.bb.s270TO90.negEvents(iTransition,pref270_br(iChanP)).negEvtTrigLFP];
                trigPhaseP2NP = [trigPhaseP2NP;neuralEvents(iDataset).lfp.bb.s270TO90.negEvents(iTransition,pref270_br(iChanP)).negEvtTrigPhase];

                spkTimes = (neuralEvents(iDataset).spikes.bb.s270TO90.negEvents(iTransition,pref270_br(iChanP)).negEvtTrigSpikes{1});

                st = zeros(1,length(tEvt));

                for iSpk = 1:length(spkTimes)
                    [~, idx(iSpk)] = min(abs(tEvt-spkTimes(iSpk)));
                end

                if ~isempty(idx)

                    st(idx) = 1; clear idx;

                end

                trigRasterP2NP = [trigRasterP2NP; st];

            end

        end

        for iChanNP = 1:length(pref90_br)

            if ~isempty(neuralEvents(iDataset).lfp.bb.s270TO90.negEvents(iTransition,pref90_br(iChanNP)).times) && length(neuralEvents(iDataset).lfp.bb.s270TO90.negEvents(iTransition,pref90_br(iChanNP)).times) == 1 && ~isempty(neuralEvents(iDataset).spikes.bb.s270TO90.negEvents(iTransition,pref90_br(iChanNP)).negEvtTrigSpikes{1})

                %clear trigTraceNP2P; %clear trigPhaseNP2P; %clear trigRasterNP2P;

                trigTraceNP2P = [trigTraceNP2P;neuralEvents(iDataset).lfp.bb.s270TO90.negEvents(iTransition,pref90_br(iChanNP)).negEvtTrigLFP];
                trigPhaseNP2P = [trigPhaseNP2P;neuralEvents(iDataset).lfp.bb.s270TO90.negEvents(iTransition,pref90_br(iChanNP)).negEvtTrigPhase];

                spkTimes = (neuralEvents(iDataset).spikes.bb.s270TO90.negEvents(iTransition,pref90_br(iChanNP)).negEvtTrigSpikes{1});

                st = zeros(1,length(tEvt));

                for iSpk = 1:length(spkTimes)
                    [~, idx(iSpk)] = min(abs(tEvt-spkTimes(iSpk)));
                end

                if ~isempty(idx)

                    st(idx) = 1; clear idx;

                end

                trigRasterNP2P = [trigRasterNP2P; st];

            end

        end
        
        
        

    end

    % Up to Down Switch

    for iTransition = 1:size(neuralEvents(iDataset).lfp.bb.s90TO270.negEvents,1)

        trigTraceP2NP = [];
        trigRasterP2NP = [];
        trigPhaseP2NP = [];
        trigTraceNP2P = [];
        trigRasterNP2P = [];
        trigPhaseNP2P = [];

        for iChanP = 1:length(pref270_br)

            if ~isempty(neuralEvents(iDataset).lfp.bb.s90TO270.negEvents(iTransition,pref270_br(iChanP)).times) && length(neuralEvents(iDataset).lfp.bb.s90TO270.negEvents(iTransition,pref270_br(iChanP)).times) == 1 && ~isempty(neuralEvents(iDataset).spikes.bb.s90TO270.negEvents(iTransition,pref270_br(iChanP)).negEvtTrigSpikes{1})

                %clear trigTraceNP2P; %clear trigPhaseNP2P; %clear trigRasterNP2P;
                
                trigTraceNP2P = [trigTraceNP2P;neuralEvents(iDataset).lfp.bb.s90TO270.negEvents(iTransition,pref270_br(iChanP)).negEvtTrigLFP];
                trigPhaseNP2P = [trigPhaseNP2P;neuralEvents(iDataset).lfp.bb.s90TO270.negEvents(iTransition,pref270_br(iChanP)).negEvtTrigPhase];

                spkTimes = (neuralEvents(iDataset).spikes.bb.s90TO270.negEvents(iTransition,pref270_br(iChanP)).negEvtTrigSpikes{1});

                st = zeros(1,length(tEvt));

                for iSpk = 1:length(spkTimes)
                    [~, idx(iSpk)] = min(abs(tEvt-spkTimes(iSpk)));
                end

                if ~isempty(idx)

                    st(idx) = 1; clear idx;

                end

                trigRasterNP2P = [trigRasterNP2P; st];

            end

        end

        for iChanNP = 1:length(pref90_br)

            if ~isempty(neuralEvents(iDataset).lfp.bb.s90TO270.negEvents(iTransition,pref90_br(iChanNP)).times) && length(neuralEvents(iDataset).lfp.bb.s90TO270.negEvents(iTransition,pref90_br(iChanNP)).times) == 1 && ~isempty(neuralEvents(iDataset).spikes.bb.s90TO270.negEvents(iTransition,pref90_br(iChanNP)).negEvtTrigSpikes{1})

                %clear trigTraceP2NP; %clear trigPhaseP2NP; %clear trigRasterP2NP;
                
                trigTraceP2NP = [trigTraceP2NP;neuralEvents(iDataset).lfp.bb.s90TO270.negEvents(iTransition,pref90_br(iChanNP)).negEvtTrigLFP];
                trigPhaseP2NP = [trigPhaseP2NP;neuralEvents(iDataset).lfp.bb.s90TO270.negEvents(iTransition,pref90_br(iChanNP)).negEvtTrigPhase];

                spkTimes = (neuralEvents(iDataset).spikes.bb.s90TO270.negEvents(iTransition,pref90_br(iChanNP)).negEvtTrigSpikes{1});

                st = zeros(1,length(tEvt));

                for iSpk = 1:length(spkTimes)
                    [~, idx(iSpk)] = min(abs(tEvt-spkTimes(iSpk)));
                end

              if ~isempty(idx)

                    st(idx) = 1; clear idx;

                end

                trigRasterP2NP = [trigRasterP2NP; st];

            end

        end

        
        negPooledTrigTracesP2NP = [negPooledTrigTracesP2NP;trigTraceP2NP];
        negPooledTrigTracesNP2P = [negPooledTrigTracesNP2P;trigTraceNP2P];
        negPooledTrigRasterP2NP = [negPooledTrigRasterP2NP;trigRasterP2NP];
        negPooledTrigRasterNP2P = [negPooledTrigRasterNP2P;trigRasterNP2P];
        negPooledTrigPhaseP2NP = [negPooledTrigPhaseP2NP;trigPhaseP2NP];
        negPooledTrigPhaseNP2P = [negPooledTrigPhaseNP2P;trigPhaseNP2P];

    end


end

%% Positive events

c1 = 0;
c2 = 0;

posPooledTrigTracesP2NP = [];
posPooledTrigTracesNP2P = [];
posPooledTrigRasterP2NP = [];
posPooledTrigRasterNP2P = [];
posPooledTrigPhaseP2NP = [];
posPooledTrigPhaseNP2P = [];

for iDataset = 1:params.nDatasets

    pref90_br = neuralEvents(iDataset).selChans.upward;
    pref270_br = neuralEvents(iDataset).selChans.downward;

    % Down to Up Switch

    for iTransition = 1:size(neuralEvents(iDataset).lfp.bb.s270TO90.posEvents,1)

        trigTraceP2NP = [];
        trigRasterP2NP = [];
        trigPhaseP2NP = [];
        trigTraceNP2P = [];
        trigRasterNP2P = [];
        trigPhaseNP2P = [];

        for iChanP = 1:length(pref270_br)

            if ~isempty(neuralEvents(iDataset).lfp.bb.s270TO90.posEvents(iTransition,pref270_br(iChanP)).times) && length(neuralEvents(iDataset).lfp.bb.s270TO90.posEvents(iTransition,pref270_br(iChanP)).times) == 1 && ~isempty(neuralEvents(iDataset).spikes.bb.s270TO90.posEvents(iTransition,pref270_br(iChanP)).posEvtTrigSpikes{1})

                %clear trigTraceP2NP; %clear trigPhaseP2NP; %clear trigRasterP2NP;
                
                trigTraceP2NP = [trigTraceP2NP;neuralEvents(iDataset).lfp.bb.s270TO90.posEvents(iTransition,pref270_br(iChanP)).posEvtTrigLFP];
                trigPhaseP2NP = [trigPhaseP2NP;neuralEvents(iDataset).lfp.bb.s270TO90.posEvents(iTransition,pref270_br(iChanP)).posEvtTrigPhase];

                spkTimes = (neuralEvents(iDataset).spikes.bb.s270TO90.posEvents(iTransition,pref270_br(iChanP)).posEvtTrigSpikes{1});

                st = zeros(1,length(tEvt));

                for iSpk = 1:length(spkTimes)
                    [~, idx(iSpk)] = min(abs(tEvt-spkTimes(iSpk)));
                end

                st(idx) = 1; clear idx;

                trigRasterP2NP = [trigRasterP2NP; st];

            end

        end

        for iChanNP = 1:length(pref90_br)

            if ~isempty(neuralEvents(iDataset).lfp.bb.s270TO90.posEvents(iTransition,pref90_br(iChanNP)).times) && length(neuralEvents(iDataset).lfp.bb.s270TO90.posEvents(iTransition,pref90_br(iChanNP)).times) == 1 && ~isempty(neuralEvents(iDataset).spikes.bb.s270TO90.posEvents(iTransition,pref90_br(iChanNP)).posEvtTrigSpikes{1})

                %clear trigTraceNP2P; %clear trigPhaseNP2P; %clear trigRasterNP2P;
                
                trigTraceNP2P = [trigTraceNP2P;neuralEvents(iDataset).lfp.bb.s270TO90.posEvents(iTransition,pref90_br(iChanNP)).posEvtTrigLFP];
                trigPhaseNP2P = [trigPhaseNP2P;neuralEvents(iDataset).lfp.bb.s270TO90.posEvents(iTransition,pref90_br(iChanNP)).posEvtTrigPhase];

                spkTimes = (neuralEvents(iDataset).spikes.bb.s270TO90.posEvents(iTransition,pref90_br(iChanNP)).posEvtTrigSpikes{1});

                st = zeros(1,length(tEvt));

                for iSpk = 1:length(spkTimes)
                    [~, idx(iSpk)] = min(abs(tEvt-spkTimes(iSpk)));
                end

                st(idx) = 1; clear idx;

                trigRasterNP2P = [trigRasterNP2P; st];

            end

        end
        
        
        

    end

    % Up to Down Switch

    for iTransition = 1:size(neuralEvents(iDataset).lfp.bb.s90TO270.posEvents,1)

        trigTraceP2NP = [];
        trigRasterP2NP = [];
        trigPhaseP2NP = [];
        trigTraceNP2P = [];
        trigRasterNP2P = [];
        trigPhaseNP2P = [];
        for iChanP = 1:length(pref270_br)

            if ~isempty(neuralEvents(iDataset).lfp.bb.s90TO270.posEvents(iTransition,pref270_br(iChanP)).times) && length(neuralEvents(iDataset).lfp.bb.s90TO270.posEvents(iTransition,pref270_br(iChanP)).times) == 1 && ~isempty(neuralEvents(iDataset).spikes.bb.s90TO270.posEvents(iTransition,pref270_br(iChanP)).posEvtTrigSpikes{1})

                %clear trigTraceNP2P; %clear trigPhaseNP2P; %clear trigRasterNP2P;
                
                trigTraceNP2P = [trigTraceNP2P;neuralEvents(iDataset).lfp.bb.s90TO270.posEvents(iTransition,pref270_br(iChanP)).posEvtTrigLFP];
                trigPhaseNP2P = [trigPhaseNP2P;neuralEvents(iDataset).lfp.bb.s90TO270.posEvents(iTransition,pref270_br(iChanP)).posEvtTrigPhase];

                spkTimes = (neuralEvents(iDataset).spikes.bb.s90TO270.posEvents(iTransition,pref270_br(iChanP)).posEvtTrigSpikes{1});

                st = zeros(1,length(tEvt));

                for iSpk = 1:length(spkTimes)
                    [~, idx(iSpk)] = min(abs(tEvt-spkTimes(iSpk)));
                end

                st(idx) = 1; clear idx;

                trigRasterNP2P = [trigRasterNP2P; st];

            end

        end

        for iChanNP = 1:length(pref90_br)

            if ~isempty(neuralEvents(iDataset).lfp.bb.s90TO270.posEvents(iTransition,pref90_br(iChanNP)).times) && length(neuralEvents(iDataset).lfp.bb.s90TO270.posEvents(iTransition,pref90_br(iChanNP)).times) == 1 && ~isempty(neuralEvents(iDataset).spikes.bb.s90TO270.posEvents(iTransition,pref90_br(iChanNP)).posEvtTrigSpikes{1})

                %clear trigTraceP2NP; %clear trigPhaseP2NP; %clear trigRasterP2NP;
                
                trigTraceP2NP = [trigTraceP2NP;neuralEvents(iDataset).lfp.bb.s90TO270.posEvents(iTransition,pref90_br(iChanNP)).posEvtTrigLFP];
                trigPhaseP2NP = [trigPhaseP2NP;neuralEvents(iDataset).lfp.bb.s90TO270.posEvents(iTransition,pref90_br(iChanNP)).posEvtTrigPhase];

                spkTimes = (neuralEvents(iDataset).spikes.bb.s90TO270.posEvents(iTransition,pref90_br(iChanNP)).posEvtTrigSpikes{1});

                st = zeros(1,length(tEvt));

                for iSpk = 1:length(spkTimes)
                    [~, idx(iSpk)] = min(abs(tEvt-spkTimes(iSpk)));
                end

                st(idx) = 1; clear idx;

                trigRasterP2NP = [trigRasterP2NP; st];

            end

        end

        
        posPooledTrigTracesP2NP = [posPooledTrigTracesP2NP;trigTraceP2NP];
        posPooledTrigTracesNP2P = [posPooledTrigTracesNP2P;trigTraceNP2P];
        posPooledTrigRasterP2NP = [posPooledTrigRasterP2NP;trigRasterP2NP];
        posPooledTrigRasterNP2P = [posPooledTrigRasterNP2P;trigRasterNP2P];
        posPooledTrigPhaseP2NP = [posPooledTrigPhaseP2NP;trigPhaseP2NP];
        posPooledTrigPhaseNP2P = [posPooledTrigPhaseNP2P;trigPhaseNP2P];

    end


end

%% Plot shit

t = 1;

% BB Trace Means and errors

meanNegEvtTrigTraceNP2P = nanmean(negPooledTrigTracesNP2P,1);
meanNegEvtTrigTraceP2NP = nanmean(negPooledTrigTracesP2NP,1);
meanPosEvtTrigTraceNP2P = nanmean(posPooledTrigTracesNP2P,1);
meanPosEvtTrigTraceP2NP = nanmean(posPooledTrigTracesP2NP,1);

meanNegEvtTrigPhaseNP2P = circ_mean(negPooledTrigPhaseNP2P,[],1);
meanNegEvtTrigPhaseP2NP = circ_mean(negPooledTrigPhaseP2NP,[],1);
meanPosEvtTrigPhaseNP2P = circ_mean(posPooledTrigPhaseNP2P,[],1);
meanPosEvtTrigPhaseP2NP = circ_mean(posPooledTrigPhaseP2NP,[],1);

