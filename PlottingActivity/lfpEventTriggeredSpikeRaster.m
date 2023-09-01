function lfpEventTriggeredSpikeRaster(lfpActivity, spikingActivity, domdur, sav_dir_psth)

% Collect event statistics for the four chosen LFP bands
% Abhilash D MPIBC 2017-18

cd(sav_dir_psth)

pad = 500;

filename = ['std4_evtTriggered_jMUPhaseValues_' num2str(domdur.domBehind) 'ms_Chebyshev1_' '.mat'];

t =linspace(-domdur.domBehind/1000,domdur.domForward/1000,(domdur.domBehind/2)+(domdur.domForward/2)+1);
tIdxs = 1:length(t);
[x,y] = smoothingkernel(domdur.domBehind*2/1000,1000,0.010,'alpha');
evtIdx = ceil(domdur.domBehind/2)+1;
midPoint = t(ceil(length(t)/2));
%% Setup filters

[b1,a1] = cheby1(4,0.001,[1 9]/250);
evtDur = 250;

%% Get Doms 90

buffer = 75;

for chan = 1:96
            
            % BR Dominances 90
            
            phaseDist_pre_BR_90 = [];
            phaseDist_post_BR_90 = [];
            
            for iCond = 1:size(lfpActivity.validSection.BR.data.dom90{1, chan},2)
                for nDom = 1:size(lfpActivity.validSection.BR.data.dom90{1, chan}{1, iCond},2)
                    lfppiece = lfpActivity.validSection.BR.data.dom90{1, chan}{1, iCond}{nDom};
                    spikeTimes = spikingActivity.validSection.BR.data.dom90{1, chan}{1, iCond}{nDom}./1000;
                    [val,~] = max(lfppiece);
                    if val<=750
                        lowFiltLfpPiece = filtfilt(b1,a1,lfppiece);
                        lfpAmp = abs(hilbert(lowFiltLfpPiece)); % Squaring works better
                        lfpevents = event_detection(detrend(lfpAmp),4,'stdgauss',evtDur);
                        lfpevents(lfpevents<=pad) = [];
                        lfpevents(lfpevents>=(length(t)+pad)) = [];
                        lfpevents = lfpevents-pad;
                        lowFiltLfpPiece = lowFiltLfpPiece(pad+1:end-pad);
                        
                        if ~isempty(lfpevents)
                            
                            for iEvt = 1:length(lfpevents)
                                
                                if lfpevents(iEvt) <= evtIdx && lfpevents(iEvt) > buffer
                                    
                                    lowFiltLfpPiece=(angle(hilbert(lowFiltLfpPiece)));
                                    oscIdxs = tIdxs(lfpevents(iEvt)-buffer+1:lfpevents(iEvt)+buffer);
                                    if ~isempty(spikeTimes)
                                        for nSpk = 1:length(spikeTimes)
                                            val = spikeTimes(nSpk); %value to find
                                            tmp = abs(t-val);
                                            [idx idx] = min(tmp); %index of closest value
                                            spkIdx(nSpk) = idx;
                                        end
                                    else
                                        spkIdx = [];
                                    end
                                    evtSpkIdxs = intersect(spkIdx,oscIdxs);
                                    spkPhases = lowFiltLfpPiece(evtSpkIdxs);
                                    spkPhases = spkPhases';
                                    lfppiece = [zeros(pad,1);lfppiece;zeros(pad,1)]; % To pad back for the next iteration to filter
                                    phaseDist_pre_BR_90 = [phaseDist_pre_BR_90 spkPhases];
                                    
                                elseif lfpevents(iEvt) >= evtIdx && lfpevents(iEvt) < length(t)-buffer
                                    
                                    lowFiltLfpPiece=(angle(hilbert(lowFiltLfpPiece)));
                                    oscIdxs = tIdxs(lfpevents(iEvt)-buffer+1:lfpevents(iEvt)+buffer);
                                    if ~isempty(spikeTimes)
                                        for nSpk = 1:length(spikeTimes)
                                            val = spikeTimes(nSpk); %value to find
                                            tmp = abs(t-val);
                                            [idx idx] = min(tmp); %index of closest value
                                            spkIdx(nSpk) = idx;
                                        end
                                    else
                                        spkIdx = [];
                                    end
                                    evtSpkIdxs = intersect(spkIdx,oscIdxs);
                                    spkPhases = lowFiltLfpPiece(evtSpkIdxs);
                                    spkPhases = spkPhases';
                                    lfppiece = [zeros(pad,1);lfppiece;zeros(pad,1)]; % To pad back for the next iteration to filter
                                    phaseDist_post_BR_90 = [phaseDist_post_BR_90 spkPhases];
                                    
                                    
                                end
                                
                            end
                            
                        end
                        
                    end
                    
                end
                
            end
            
            % BR Dominances 270
            
            phaseDist_pre_BR_270 = [];
            phaseDist_post_BR_270 = [];
            
            for iCond = 1:size(lfpActivity.validSection.BR.data.dom270{1, chan},2)
                for nDom = 1:size(lfpActivity.validSection.BR.data.dom270{1, chan}{1, iCond},2)
                    lfppiece = lfpActivity.validSection.BR.data.dom270{1, chan}{1, iCond}{nDom};
                    spikeTimes = spikingActivity.validSection.BR.data.dom270{1, chan}{1, iCond}{nDom}./1000;
                    [val,~] = max(lfppiece);
                    if val<=750
                        lowFiltLfpPiece = filtfilt(b1,a1,lfppiece);
                        lfpAmp = abs(hilbert(lowFiltLfpPiece)); % Squaring works better
                        lfpevents = event_detection(detrend(lfpAmp),4,'stdgauss',evtDur);
                        lfpevents(lfpevents<=pad) = [];
                        lfpevents(lfpevents>=(length(t)+pad)) = [];
                        lfpevents = lfpevents-pad;
                        lowFiltLfpPiece = lowFiltLfpPiece(pad+1:end-pad);
                        
                        if ~isempty(lfpevents)
                            
                            for iEvt = 1:length(lfpevents)
                                
                                if lfpevents(iEvt) <= evtIdx && lfpevents(iEvt) > buffer
                                    
                                    lowFiltLfpPiece=(angle(hilbert(lowFiltLfpPiece)));
                                    oscIdxs = tIdxs(lfpevents(iEvt)-buffer+1:lfpevents(iEvt)+buffer);
                                    if ~isempty(spikeTimes)
                                        for nSpk = 1:length(spikeTimes)
                                            val = spikeTimes(nSpk); %value to find
                                            tmp = abs(t-val);
                                            [idx idx] = min(tmp); %index of closest value
                                            spkIdx(nSpk) = idx;
                                        end
                                    else
                                        spkIdx = [];
                                    end
                                    evtSpkIdxs = intersect(spkIdx,oscIdxs);
                                    spkPhases = lowFiltLfpPiece(evtSpkIdxs);
                                    spkPhases = spkPhases';
                                    lfppiece = [zeros(pad,1);lfppiece;zeros(pad,1)]; % To pad back for the next iteration to filter
                                    phaseDist_pre_BR_270 = [phaseDist_pre_BR_270 spkPhases];
                                    
                                elseif lfpevents(iEvt) >= evtIdx && lfpevents(iEvt) < length(t)-buffer
                                    
                                    lowFiltLfpPiece=(angle(hilbert(lowFiltLfpPiece)));
                                    oscIdxs = tIdxs(lfpevents(iEvt)-buffer+1:lfpevents(iEvt)+buffer);
                                    if ~isempty(spikeTimes)
                                        for nSpk = 1:length(spikeTimes)
                                            val = spikeTimes(nSpk); %value to find
                                            tmp = abs(t-val);
                                            [idx idx] = min(tmp); %index of closest value
                                            spkIdx(nSpk) = idx;
                                        end
                                    else
                                        spkIdx = [];
                                    end
                                    evtSpkIdxs = intersect(spkIdx,oscIdxs);
                                    spkPhases = lowFiltLfpPiece(evtSpkIdxs);
                                    spkPhases = spkPhases';
                                    lfppiece = [zeros(pad,1);lfppiece;zeros(pad,1)]; % To pad back for the next iteration to filter
                                    phaseDist_post_BR_270 = [phaseDist_post_BR_270 spkPhases];
                                    
                                    
                                end
                                
                            end
                            
                        end
                        
                    end
                    
                end
                
            end
            
            eventTriggeredTraces(chan).BR.s270TO90.Pre.phaseDist = phaseDist_pre_BR_90;
            eventTriggeredTraces(chan).BR.s90TO270.Pre.phaseDist = phaseDist_pre_BR_270;
            
            eventTriggeredTraces(chan).BR.s270TO90.Post.phaseDist = phaseDist_post_BR_90;
            eventTriggeredTraces(chan).BR.s90TO270.Post.phaseDist = phaseDist_post_BR_270;
            
            % PA Dominances 90
            
            phaseDist_pre_PA_90 = [];
            phaseDist_post_PA_90 = [];
            
            for iCond = 1:size(lfpActivity.validSection.PA.data.dom90{1, chan},2)
                for nDom = 1:size(lfpActivity.validSection.PA.data.dom90{1, chan}{1, iCond},2)
                    lfppiece = lfpActivity.validSection.PA.data.dom90{1, chan}{1, iCond}{nDom};
                    spikeTimes = spikingActivity.validSection.PA.data.dom90{1, chan}{1, iCond}{nDom}./1000;
                    [val,~] = max(lfppiece);
                    if val<=750
                        lowFiltLfpPiece = filtfilt(b1,a1,lfppiece);
                        lfpAmp = abs(hilbert(lowFiltLfpPiece)); % Squaring works better
                        lfpevents = event_detection(detrend(lfpAmp),4,'stdgauss',evtDur);
                        lfpevents(lfpevents<=pad) = [];
                        lfpevents(lfpevents>=(length(t)+pad)) = [];
                        lfpevents = lfpevents-pad;
                        lowFiltLfpPiece = lowFiltLfpPiece(pad+1:end-pad);
                        
                        if ~isempty(lfpevents)
                            
                            for iEvt = 1:length(lfpevents)
                                
                                if lfpevents(iEvt) <= evtIdx && lfpevents(iEvt) > buffer
                                    
                                    lowFiltLfpPiece=(angle(hilbert(lowFiltLfpPiece)));
                                    oscIdxs = tIdxs(lfpevents(iEvt)-buffer+1:lfpevents(iEvt)+buffer);
                                    if ~isempty(spikeTimes)
                                        for nSpk = 1:length(spikeTimes)
                                            val = spikeTimes(nSpk); %value to find
                                            tmp = abs(t-val);
                                            [idx idx] = min(tmp); %index of closest value
                                            spkIdx(nSpk) = idx;
                                        end
                                    else
                                        spkIdx = [];
                                    end
                                    evtSpkIdxs = intersect(spkIdx,oscIdxs);
                                    spkPhases = lowFiltLfpPiece(evtSpkIdxs);
                                    spkPhases = spkPhases';
                                    lfppiece = [zeros(pad,1);lfppiece;zeros(pad,1)]; % To pad back for the next iteration to filter
                                    phaseDist_pre_PA_90 = [phaseDist_pre_PA_90 spkPhases];
                                    
                                elseif lfpevents(iEvt) >= evtIdx && lfpevents(iEvt) < length(t)-buffer
                                    
                                    lowFiltLfpPiece=(angle(hilbert(lowFiltLfpPiece)));
                                    oscIdxs = tIdxs(lfpevents(iEvt)-buffer+1:lfpevents(iEvt)+buffer);
                                    if ~isempty(spikeTimes)
                                        for nSpk = 1:length(spikeTimes)
                                            val = spikeTimes(nSpk); %value to find
                                            tmp = abs(t-val);
                                            [idx idx] = min(tmp); %index of closest value
                                            spkIdx(nSpk) = idx;
                                        end
                                    else
                                        spkIdx = [];
                                    end
                                    evtSpkIdxs = intersect(spkIdx,oscIdxs);
                                    spkPhases = lowFiltLfpPiece(evtSpkIdxs);
                                    spkPhases = spkPhases';
                                    lfppiece = [zeros(pad,1);lfppiece;zeros(pad,1)]; % To pad back for the next iteration to filter
                                    phaseDist_post_PA_90 = [phaseDist_post_PA_90 spkPhases];
                                    
                                    
                                end
                                
                            end
                            
                        end
                        
                    end
                    
                end
                
            end
            
            % PA Dominances 270
            
            phaseDist_pre_PA_270 = [];
            phaseDist_post_PA_270 = [];
            
            for iCond = 1:size(lfpActivity.validSection.PA.data.dom270{1, chan},2)
                for nDom = 1:size(lfpActivity.validSection.PA.data.dom270{1, chan}{1, iCond},2)
                    lfppiece = lfpActivity.validSection.PA.data.dom270{1, chan}{1, iCond}{nDom};
                    spikeTimes = spikingActivity.validSection.PA.data.dom270{1, chan}{1, iCond}{nDom}./1000;
                    [val,~] = max(lfppiece);
                    if val<=750
                        lowFiltLfpPiece = filtfilt(b1,a1,lfppiece);
                        lfpAmp = abs(hilbert(lowFiltLfpPiece)); % Squaring works better
                        lfpevents = event_detection(detrend(lfpAmp),4,'stdgauss',evtDur);
                        lfpevents(lfpevents<=pad) = [];
                        lfpevents(lfpevents>=(length(t)+pad)) = [];
                        lfpevents = lfpevents-pad;
                        lowFiltLfpPiece = lowFiltLfpPiece(pad+1:end-pad);
                        
                        if ~isempty(lfpevents)
                            
                            for iEvt = 1:length(lfpevents)
                                
                                if lfpevents(iEvt) <= evtIdx && lfpevents(iEvt) > buffer
                                    
                                    lowFiltLfpPiece=(angle(hilbert(lowFiltLfpPiece)));
                                    oscIdxs = tIdxs(lfpevents(iEvt)-buffer+1:lfpevents(iEvt)+buffer);
                                    if ~isempty(spikeTimes)
                                        for nSpk = 1:length(spikeTimes)
                                            val = spikeTimes(nSpk); %value to find
                                            tmp = abs(t-val);
                                            [idx idx] = min(tmp); %index of closest value
                                            spkIdx(nSpk) = idx;
                                        end
                                    else
                                        spkIdx = [];
                                    end
                                    evtSpkIdxs = intersect(spkIdx,oscIdxs);
                                    spkPhases = lowFiltLfpPiece(evtSpkIdxs);
                                    spkPhases = spkPhases';
                                    lfppiece = [zeros(pad,1);lfppiece;zeros(pad,1)]; % To pad back for the next iteration to filter
                                    phaseDist_pre_PA_270 = [phaseDist_pre_PA_270 spkPhases];
                                    
                                elseif lfpevents(iEvt) >= evtIdx && lfpevents(iEvt) < length(t)-buffer
                                    
                                    lowFiltLfpPiece=(angle(hilbert(lowFiltLfpPiece)));
                                    oscIdxs = tIdxs(lfpevents(iEvt)-buffer+1:lfpevents(iEvt)+buffer);
                                    if ~isempty(spikeTimes)
                                        for nSpk = 1:length(spikeTimes)
                                            val = spikeTimes(nSpk); %value to find
                                            tmp = abs(t-val);
                                            [idx idx] = min(tmp); %index of closest value
                                            spkIdx(nSpk) = idx;
                                        end
                                    else
                                        spkIdx = [];
                                    end
                                    evtSpkIdxs = intersect(spkIdx,oscIdxs);
                                    spkPhases = lowFiltLfpPiece(evtSpkIdxs);
                                    spkPhases = spkPhases';
                                    lfppiece = [zeros(pad,1);lfppiece;zeros(pad,1)]; % To pad back for the next iteration to filter
                                    phaseDist_post_PA_270 = [phaseDist_post_PA_270 spkPhases];
                                    
                                    
                                end
                                
                            end
                            
                        end
                        
                    end
                    
                end
                
            end
            
            eventTriggeredTraces(chan).PA.s270TO90.Pre.phaseDist = phaseDist_pre_PA_90;
            eventTriggeredTraces(chan).PA.s90TO270.Pre.phaseDist = phaseDist_pre_PA_270;
            
            eventTriggeredTraces(chan).PA.s270TO90.Post.phaseDist = phaseDist_post_PA_90;
            eventTriggeredTraces(chan).PA.s90TO270.Post.phaseDist = phaseDist_post_PA_270;
            
end

save(filename,'eventTriggeredTraces','-v7.3')
