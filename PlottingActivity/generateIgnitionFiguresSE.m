function generateIgnitionFiguresSE(dataPath)

% This function generates the ingition plot and the ignited hotspots for a
% given dataset. Just pass in the dataPath. the variable that will be
% loaded will be called lfpStatistics and it has a...complicated structure.
% Ask me.

%% Load the dataset
load(dataPath{1});

%% Define the usual crap

nBins = 5;
nTransitions = length(lfpStatistics.signalEnergy.BR.Pre{1}{1});
nSessions = length(lfpStatistics.signalEnergy.BR.Pre); % Number of sessions
nChans = length(lfpStatistics.signalEnergy.BR.Pre{1}); % Number of channels

%% Calculate mean amplitudes in each bin.

% Compute for Pre-BR

switch type
    
    case{'spon','spontaneous','rivalry'}
        
        meanAmplitudePreBR = zeros(nSessions,nBins-1,nChans);
        
        for iSession = 1:nSessions
            
            for iChan = 1:nChans
                
                for iBin = 1:nBins-1
                    
                    tempTimes = abs(lfpStatistics.eventTimes.BR.Pre{iSession}{iChan})*1000; % Doesn't taking the absolute reverse the time-points?? Is this why we are seeing this ignition??
                    tempAmps = lfpStatistics.eventAmps.BR.Pre{iSession}{iChan};
                    idx = tempTimes>=bins(iBin) & tempTimes<=bins(iBin+1);
                    meanAmplitudePreBR(iSession,iBin,iChan) = nanmean(tempAmps(idx));
                    clear tempAmps; clear tempTimes; clear idx;
                    
                end
                
            end
            
        end
        
        % Do PrePA
        
        % Compute for Pre-PA
        
        meanAmplitudePrePA = zeros(nSessions,nBins-1,nChans);
        
        for iSession = 1:nSessions
            
            for iChan = 1:nChans
                
                for iBin = 1:nBins-1
                    
                    tempTimes = abs(lfpStatistics.eventTimes.PA.Pre{iSession}{iChan})*1000; % Doesn't taking the absolute reverse the time-points?? Is this why we are seeing this ignition??
                    tempAmps = lfpStatistics.eventAmps.PA.Pre{iSession}{iChan};
                    idx = tempTimes>=bins(iBin) & tempTimes<=bins(iBin+1);
                    meanAmplitudePrePA(iSession,iBin,iChan) = nanmean(tempAmps(idx));
                    clear tempAmps; clear tempTimes; clear idx;
                    
                end
                
            end
            
        end
        
        %% Plot for PrePA vs PreBR, Session by Session
        
        for iSession = 1:nSessions
            
            % Pre PA
            
            testSessionPA = meanAmplitudePrePA(iSession,:,:);
            testSessionPA = squeeze(testSessionPA);
            testSessionPA = testSessionPA';
            for i = 1:nBins-1
                meanAmpsPA(i) = nanmean(testSessionPA(:,i));
            end
            for i = 1:nBins-1
                idx = testSessionPA(:,i)>=meanAmpsPA(i);
                posChansPA(i) = sum(idx);
            end
            
            % Pre BR
            
            testSessionBR = meanAmplitudePreBR(iSession,:,:);
            testSessionBR = squeeze(testSessionBR);
            testSessionBR = testSessionBR';
            for i = 1:nBins-1
                meanAmpsBR(i) = nanmean(testSessionBR(:,i));
            end
            for i = 1:nBins-1
                idx = testSessionBR(:,i)>=meanAmpsBR(i);
                posChansBR(i) = sum(idx);
            end
            plot(posChansBR)
            hold on
            plot(posChansPA)
            legend('PreBR', 'PrePA');
            xlabel('binCentre')
            ylabel('Number of channels')
            title(['Session : ' num2str(iSession)])
            grid on;
            pause; clf;
        end
        
    case{'piecemeal','piecemeals'}
        
        meanAmplitudePreBR = zeros(nSessions,nBins-1,nChans);
        
        for iSession = 1:nSessions
            
            for iChan = 1:nChans
                
                for iBin = 1:nBins-1
                    
                    tempTimes = abs(lfpStatistics.eventTimes.BR.Pre{iSession}{iChan})*1000; % Doesn't taking the absolute reverse the time-points?? Is this why we are seeing this ignition??
                    tempAmps = lfpStatistics.eventAmps.BR.Pre{iSession}{iChan};
                    idx = tempTimes>=bins(iBin) & tempTimes<=bins(iBin+1);
                    meanAmplitudePreBR(iSession,iBin,iChan) = nanmean(tempAmps(idx));
                    clear tempAmps; clear tempTimes; clear idx;
                    
                end
                
            end
            
        end
        
        %% Plot for PrePA vs PreBR, Session by Session
        
        for iSession = 1:nSessions
            
            % Pre BR
            
            testSessionBR = meanAmplitudePreBR(iSession,:,:);
            testSessionBR = squeeze(testSessionBR);
            testSessionBR = testSessionBR';
            for i = 1:nBins-1
                meanAmpsBR(i) = nanmean(testSessionBR(:,i));
            end
            for i = 1:nBins-1
                idx = testSessionBR(:,i)>=meanAmpsBR(i);
                posChansBR(i) = sum(idx);
            end
            plot(posChansBR)
            legend('Piecemeal');
            xlabel('binCentre')
            ylabel('Number of channels')
            title(['Session : ' num2str(iSession)])
            grid on;
            pause; clf;
        end
        
        %% Plot Hotspots here

end