clear all
close all
clc

% This script computes the OKN characteristics and statistics for a given
% dataset

%% Load the dataset

load('E:\Data\H07\12-06-2016\PFC\Bfsgrad1\jMUDominancesByTime.mat')

%% Extract the OKNs of the four conditions

% BR 90

tracesDom90BR = cell(1,1000);
c = 0;
for iCond = 1:4
for iTr = 2:length(jMUDominances.data.oknTraces.dom90{iCond})
c = c+1;
tracesDom90BR{c} = jMUDominances.data.oknTraces.dom90{iCond}{iTr}(1001:end);
end
end
emptyCells = cellfun('isempty', tracesDom90BR);
tracesDom90BR(emptyCells) = [];

% BR 270

tracesDom270BR = cell(1,1000);
c = 0;
for iCond = 1:4
for iTr = 2:length(jMUDominances.data.oknTraces.dom270{iCond})
c = c+1;
tracesDom270BR{c} = jMUDominances.data.oknTraces.dom270{iCond}{iTr}(1001:end);
end
end
emptyCells = cellfun('isempty', tracesDom270BR);
tracesDom270BR(emptyCells) = [];

% PA 90

tracesDom90PA = cell(1,1000);
c = 0;
for iCond = 5:8
for iTr = 2:length(jMUDominances.data.oknTraces.dom90{iCond})
c = c+1;
tracesDom90PA{c} = jMUDominances.data.oknTraces.dom90{iCond}{iTr}(1001:end);
end
end
emptyCells = cellfun('isempty', tracesDom90PA);
tracesDom90PA(emptyCells) = [];

% PA 270

tracesDom270PA = cell(1,1000);
c = 0;
for iCond = 5:8
for iTr = 2:length(jMUDominances.data.oknTraces.dom270{iCond})
c = c+1;
tracesDom270PA{c} = jMUDominances.data.oknTraces.dom270{iCond}{iTr}(1001:end);
end
end
emptyCells = cellfun('isempty', tracesDom270PA);
tracesDom270PA(emptyCells) = [];

%% Compute features

% BR 90

BR_90_oknevents = computeOKNcharacteristics(tracesDom90BR');

% BR 270
BR_270_oknevents = computeOKNcharacteristics(tracesDom270BR');

% PA 90
PA_90_oknevents = computeOKNcharacteristics(tracesDom90PA');

% PA 270
PA_270_oknevents = computeOKNcharacteristics(tracesDom270PA');

%% Distribution plot of OKN Frequency

figure(1)

subplot(2,2,1)
evts = cell2mat(PA_90_oknevents.frequency);
evts(evts>4) = [];
hist(evts,20)
h = findobj(gca,'Type','patch');
h.EdgeColor = [1 1 1];
h.FaceColor = [0 0 0];
hold on
y=get(gca,'ylim');
plot([nanmean(evts) nanmean(evts)],y,'--b');
legend('OKN Frequencies','Mean')
xlabel('OKN Frequency in events/s')
ylabel('event count')
xlim([0 4])
title('OKN Frequency - PA 90')
grid on; box off; clear evts;

subplot(2,2,2)
evts = cell2mat(BR_90_oknevents.frequency);
evts(evts>4) = [];
hist(evts,20)
h = findobj(gca,'Type','patch');
h.EdgeColor = [1 1 1];
h.FaceColor = [1 0 0];
hold on
y=get(gca,'ylim');
plot([nanmean(evts) nanmean(evts)],y,'--b');
legend('OKN Frequencies','Mean')
xlabel('OKN Frequency in events/s')
ylabel('event count')
xlim([0 4])
title('OKN Frequency - BR 90')
grid on; box off; clear evts;

subplot(2,2,3)
evts = cell2mat(PA_270_oknevents.frequency);
evts(evts>4) = [];
hist(evts,20)
h = findobj(gca,'Type','patch');
h.EdgeColor = [1 1 1];
h.FaceColor = [0 0 0];
hold on
y=get(gca,'ylim');
plot([nanmean(evts) nanmean(evts)],y,'--b');
legend('OKN Frequencies','Mean')
xlabel('OKN Frequency in events/s')
ylabel('event count')
title('OKN Frequency - PA 270')
grid on; box off; clear evts;

subplot(2,2,4)
evts = cell2mat(BR_270_oknevents.frequency);
evts(evts>4) = [];
hist(evts,20)
h = findobj(gca,'Type','patch');
h.EdgeColor = [1 1 1];
h.FaceColor = [1 0 0];
hold on
y=get(gca,'ylim');
plot([nanmean(evts) nanmean(evts)],y,'--b');
legend('OKN Frequencies','Mean')
xlabel('OKN Frequency in events/s')
ylabel('event count')
xlim([0 4])
title('OKN Frequency - BR 270')
grid on; box off; clear evts;

suptitle('Distributions of OKN Frequencies across conditions')

%% Distribution plot of OKN Slopes

figure(2)

subplot(2,2,1)
evts = cell2mat(PA_90_oknevents.Features{1}(1,:));
hist(evts,20)
h = findobj(gca,'Type','patch');
h.EdgeColor = [1 1 1];
h.FaceColor = [0 0 0];
hold on
y=get(gca,'ylim');
plot([nanmean(evts) nanmean(evts)],y,'--b');
legend('OKN Slopes','Mean')
xlabel('OKN Slope in events/s')
ylabel('event count')
title('OKN Slope - PA 90')
grid on; box off; clear evts;

subplot(2,2,2)
evts = cell2mat(BR_90_oknevents.Features{1}(1,:));
hist(evts,20)
h = findobj(gca,'Type','patch');
h.EdgeColor = [1 1 1];
h.FaceColor = [1 0 0];
hold on
y=get(gca,'ylim');
plot([nanmean(evts) nanmean(evts)],y,'--b');
legend('OKN Slopes','Mean')
xlabel('OKN Slope in events/s')
ylabel('event count')
title('OKN Slope - BR 90')
grid on; box off; clear evts;

subplot(2,2,3)
evts = cell2mat(PA_270_oknevents.Features{1}(1,:));
hist(evts,20)
h = findobj(gca,'Type','patch');
h.EdgeColor = [1 1 1];
h.FaceColor = [0 0 0];
hold on
y=get(gca,'ylim');
plot([nanmean(evts) nanmean(evts)],y,'--b');
legend('OKN Slopes','Mean')
xlabel('OKN Slope in events/s')
ylabel('event count')
title('OKN Slope - PA 270')
grid on; box off; clear evts;

subplot(2,2,4)
evts = cell2mat(BR_270_oknevents.Features{1}(1,:));
hist(evts,20)
h = findobj(gca,'Type','patch');
h.EdgeColor = [1 1 1];
h.FaceColor = [1 0 0];
hold on
y=get(gca,'ylim');
plot([nanmean(evts) nanmean(evts)],y,'--b');
legend('OKN Slopes','Mean')
xlabel('OKN Slope in events/s')
ylabel('event count')
title('OKN Slope - BR 270')
grid on; box off; clear evts;

suptitle('Distributions of OKN Slopes across conditions')

%% Distribution of OKN latencies

figure(3)

subplot(1,2,1)
evts = cell2mat(PA_90_oknevents.iniLag);
hist(evts,20)
h = findobj(gca,'Type','patch');
h.EdgeColor = [1 1 1];
h.FaceColor = [0 0 0];
hold on
y=get(gca,'ylim');
plot([nanmean(evts) nanmean(evts)],y,'--b');
legend('OKN Latencies','Mean')
xlabel('OKN Latency in ms')
ylabel('event count')
title('OKN Latency - PA 90')
grid on; box off; clear evts;

subplot(1,2,2)
evts = cell2mat(PA_270_oknevents.iniLag);
hist(evts,20)
h = findobj(gca,'Type','patch');
h.EdgeColor = [1 1 1];
h.FaceColor = [0 0 0];
hold on
y=get(gca,'ylim');
plot([nanmean(evts) nanmean(evts)],y,'--b');
legend('OKN Latencies','Mean')
xlabel('OKN Latency in ms')
ylabel('event count')
title('OKN Latency - PA 270')
grid on; box off; clear evts;

suptitle('Distributions of OKN Latencies across PA conditions')