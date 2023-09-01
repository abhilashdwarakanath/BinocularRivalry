function generatePulseMMLatency

dbstop if error

%% Enumerate the datasets

datasets{1} = 'B:\Results\forPrediction\InstAmp\Session_1\forPrediction';
datasets{2} = 'B:\Results\forPrediction\InstAmp\Session_2\forPrediction';
datasets{3} = 'B:\Results\forPrediction\InstAmp\Session_3\forPrediction';
datasets{4} = 'B:\Results\forPrediction\InstAmp\Session_4\forPrediction';
datasets{5} = 'B:\Results\forPrediction\InstAmp\Session_5\forPrediction';
datasets{6} = 'B:\Results\forPrediction\InstAmp\Session_6\forPrediction';

%% Load file and compute the latencies

latencies = [];

for iDataset = 1:length(datasets)
    
    cd(datasets{iDataset})
    
    load events_times.mat
    
    idx = find(events(:,1)==5 | events(:,1) == 6);
    
    for iEvent = 1:length(idx)

        pulseEventTime = events(idx(iEvent),2)./500;
        markedEvent = events(idx(iEvent)+1,1);
        if markedEvent == 14
            markedEventTime = events(idx(iEvent)+1,2)./500;
            
            latencies = [latencies (markedEventTime-pulseEventTime)*1000];
        else
            sprintf('Session %d\n',iDataset)
            sprintf('Switch %d\n',iEvent)
            sprintf('Something is missing here...\n')

        end
        
    end
    
end

%% Plot the latencies

histogram(latencies,50)
box off
vline(min(latencies),'-g')
vline(max(latencies),'-b')
vline(mean(latencies),'--k')