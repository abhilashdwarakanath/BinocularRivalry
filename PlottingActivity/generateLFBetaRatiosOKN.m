function generateLFBetaRatiosOKN

%% Dataset paths

dbstop if error

datasets{1} = ['B:\H07\12-06-2016\PFC\Bfsgrad1\'];
datasets{2} = ['B:\H07\13-07-2016\PFC\Bfsgrad1\'];
datasets{3} = ['B:\H07\20161019\PFC\Bfsgrad1\'];
datasets{4} = ['B:\H07\20161025\PFC\Bfsgrad1\'];
datasets{5} = ['B:\A11\20170305\PFC\Bfsgrad1\'];
datasets{6} = ['B:\A11\20170302\PFC\Bfsgrad1\'];

%% Plot

for iDataset = 3:length(datasets)
    
    cd(datasets{iDataset})
    
    load jMUSpikesByTime.mat
    
    cd LFPFullTrials
    
    load ChannelAvgeredSpecs_FullTrial_LFP_Hilberts_RawRatios.mat
    
    % BR
    f = trialTraces.BR.f;
    c = 0;
    for iCond = 1:4
        
        for iTrial = 1:length(jMUspikes.data{1}.okn.trace{iCond})
            
            c = c+1;
            
            trialLength = length(trialTraces.BR.lowBetaRatioTrial{iCond}{iTrial})/500;
            t = linspace(0,trialLength,length(trialTraces.BR.lowBetaRatioTrial{iCond}{iTrial}));
            okn = downsample(jMUspikes.data{1}.okn.trace{iCond}{iTrial},2);
            
            if length(okn) > length(t)
                
                okn = okn(1:length(t));
                tOKN = t;
                
            elseif length(t) > length(okn)
                
                tOKN = t(1:length(okn));
                
            elseif length(t) == length(okn)
                
                tOKN = t;
                
            end
            
            figure
            plot(t,detrend(trialTraces.BR.bbTrace{iCond}{iTrial}).*0.35,'LineWidth',1)
            hold on
            plot(t,trialTraces.BR.lowHilbertTrial{iCond}{iTrial}+35,'LineWidth',1)
            plot(t,(trialTraces.BR.betaHilbertTrial{iCond}{iTrial})+125,'LineWidth',1)
            ttrace = log(trialTraces.BR.betaHilbertTrial{iCond}{iTrial});
            ttrace(isinf(ttrace))=NaN;
            traceMax = nanmax(ttrace);
            plot(tOKN,(okn./40)+traceMax+175,'-r')
            axis tight
            box off
            eventTimes = trialTraces.BR.eventTimes{iCond}{iTrial};
            vline(eventTimes(2:end-1),'--r')
            xlabel('time in s')
            ylabel('a.u.')
            title(['BR Trial # : ' ' ' num2str(c)])
            saveas(gcf,['BB_BR_Trial_' num2str(c)],'fig')
            close all
            
            figure
            imagesc(t,log2(f),trialTraces.BR.spectrogram{iCond}{iTrial})
            Yticks = 2.^(round(log2(min(f))):round(log2(max(f))));
            ylabel('Frequency [Hz]')
            xlabel('time [s]')
            AX = gca;
            set(AX, 'YTick',log2(Yticks(:)), 'YTickLabel',num2str(sprintf('%g\n',Yticks)))
            AX.YLim = log2([min(f), max(f)]);
            axis xy
            colormap jet
            vline(eventTimes(2:end-1),'--w')
            AX.CLim = [0 4.5];
            title(['BR Trial # : ' ' ' num2str(c)])
            saveas(gcf,['Spectrogram_BR_Trial_' num2str(c)],'fig')
            close all
            
        end
        
    end
    
     % PA
    f = trialTraces.PA.f;
    c = 0;
     
    for iCond = 5:8
        
        for iTrial = 1:length(trialTraces.PA.lowBetaRatioTrial{iCond})
            
            c = c+1;
            
            figure
            
            trialLength = length(trialTraces.PA.lowBetaRatioTrial{iCond}{iTrial})/500;
            t = linspace(0,trialLength,length(trialTraces.PA.lowBetaRatioTrial{iCond}{iTrial}));
            okn = downsample(jMUspikes.data{1}.okn.trace{iCond}{iTrial},2);
            
            if length(okn) > length(t)
                
                okn = okn(1:length(t));
                tOKN = t;
                
            elseif length(t) > length(okn)
                
                tOKN = t(1:length(okn));
                
            elseif length(t) == length(okn)
                
                tOKN = t;
                
            end
            
            plot(t,detrend(trialTraces.PA.bbTrace{iCond}{iTrial}).*0.35,'LineWidth',1)
            hold on
            plot(t,trialTraces.PA.lowHilbertTrial{iCond}{iTrial}+35,'LineWidth',1)
            plot(t,(trialTraces.PA.betaHilbertTrial{iCond}{iTrial})+125,'LineWidth',1)
            ttrace = log(trialTraces.PA.betaHilbertTrial{iCond}{iTrial});
            ttrace(isinf(ttrace))=NaN;
            traceMax = nanmax(ttrace);
            plot(tOKN,(okn./40)+traceMax+175,'-k')
            axis tight
            box off
            eventTimes = trialTraces.PA.eventTimes{iCond}{iTrial};
            events = trialTraces.PA.events{iCond}{iTrial};
            idx = find(events==5 | events==6);
            eventTimes(idx) = [];
            vline(eventTimes(2:end-1),'--k')
            xlabel('time in s')
            ylabel('a.u.')
            title(['PA Trial # : ' ' ' num2str(c)])
            saveas(gcf,['BB_PA_Trial_' num2str(c)],'fig')
            close all
            
            figure
            imagesc(t,log2(f),trialTraces.PA.spectrogram{iCond}{iTrial})
            Yticks = 2.^(round(log2(min(f))):round(log2(max(f))));
            ylabel('Frequency [Hz]')
            xlabel('time [s]')
            AX = gca;
            set(AX, 'YTick',log2(Yticks(:)), 'YTickLabel',num2str(sprintf('%g\n',Yticks)))
            AX.YLim = log2([min(f), max(f)]);
            axis xy
            colormap jet
            vline(eventTimes(2:end-1),'--w')
            AX.CLim = [0 4.5];
            title(['PA Trial # : ' ' ' num2str(c)])
            saveas(gcf,['Spectrogram_PA_Trial_' num2str(c)],'fig')
            close all
            
        end
        
    end
    
end

end
