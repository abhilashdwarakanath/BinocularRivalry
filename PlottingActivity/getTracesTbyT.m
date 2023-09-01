function [traces] = getTracesTbyT(lfpActivity,sav_dir_psth,durs,tag)

% Computes spectrograms for clean dominances. Also cleans up trials and
% takes care of padding. CWT is used with a Morse wavelet. 24 octaves.
% Abhilash D. MPIBC 2017-18

cd(sav_dir_psth)

filename = ['traces_trialByTrial_' tag '.mat'];

%% Setup filters

[b2,a2] = cheby1(8,0.001,[20 40]/250); % beta
[b1,a1] = cheby1(4,0.001,[1 9]/250); % low

%% Collect activity

% BR

c = 0;
for iCond = 1:size(lfpActivity.validSection.BR.data.dom90{1, 1},2)
    for nDom = 1:size(lfpActivity.validSection.BR.data.dom90{1, 1}{1, iCond},2)
        c = c+1;
        for iChan = 1:96
            piece = (lfpActivity.validSection.BR.data.dom90{1, iChan}{1, iCond}{nDom});
            if ~isnan(piece) & max(piece) < 750
                trace = filtfilt(b1,a1,piece);
                lowTrace_BR_90(c,iChan,:) = trace(501:end-500);
                trace = filtfilt(b2,a2,piece);
                betaTrace_BR_90(c,iChan,:) = trace(501:end-500);
                clear trace
            end
        end
    end
end

lowTrace_BR_90 = squeeze(nanmean(lowTrace_BR_90,2));
betaTrace_BR_90 = squeeze(nanmean(betaTrace_BR_90,2));


c = 0;
for iCond = 1:size(lfpActivity.validSection.BR.data.dom270{1, 1},2)
    for nDom = 1:size(lfpActivity.validSection.BR.data.dom270{1, 1}{1, iCond},2)
        c = c+1;
        for iChan = 1:96
            piece = (lfpActivity.validSection.BR.data.dom270{1, iChan}{1, iCond}{nDom});
            if ~isnan(piece) & max(piece) < 750
                trace = filtfilt(b1,a1,piece);
                lowTrace_BR_270(c,iChan,:) = trace(501:end-500);
                trace = filtfilt(b2,a2,piece);
                betaTrace_BR_270(c,iChan,:) = trace(501:end-500);
                clear trace
            end
        end
    end
end

lowTrace_BR_270 = squeeze(nanmean(lowTrace_BR_270,2));
betaTrace_BR_270 = squeeze(nanmean(betaTrace_BR_270,2));

% Collect both together

lowTrace_BR = cat(1,lowTrace_BR_90,lowTrace_BR_270);
betaTrace_BR = cat(1,betaTrace_BR_90,betaTrace_BR_270);

clear lowTrace_BR_90; clear lowTrace_BR_270;
clear betaTrace_BR_90; clear betaTrace_BR_270;

% PA

c = 0;
for iCond = 1:size(lfpActivity.validSection.PA.data.dom90{1, 1},2)
    for nDom = 1:size(lfpActivity.validSection.PA.data.dom90{1, 1}{1, iCond},2)
        c = c+1;
        for iChan = 1:96
            piece = (lfpActivity.validSection.PA.data.dom90{1, iChan}{1, iCond}{nDom});
            if ~isnan(piece) & max(piece) < 750
                trace = filtfilt(b1,a1,piece);
                lowTrace_PA_90(c,iChan,:) = trace(501:end-500);
                trace = filtfilt(b2,a2,piece);
                betaTrace_PA_90(c,iChan,:) = trace(501:end-500);
                clear trace
            end
        end
    end
end

lowTrace_PA_90 = squeeze(nanmean(lowTrace_PA_90,2));
betaTrace_PA_90 = squeeze(nanmean(betaTrace_PA_90,2));


c = 0;
for iCond = 1:size(lfpActivity.validSection.PA.data.dom270{1, 1},2)
    for nDom = 1:size(lfpActivity.validSection.PA.data.dom270{1, 1}{1, iCond},2)
        c = c+1;
        for iChan = 1:96
            piece = (lfpActivity.validSection.PA.data.dom270{1, iChan}{1, iCond}{nDom});
            if ~isnan(piece) & max(piece) < 750
                trace = filtfilt(b1,a1,piece);
                lowTrace_PA_270(c,iChan,:) = trace(501:end-500);
                trace = filtfilt(b2,a2,piece);
                betaTrace_PA_270(c,iChan,:) = trace(501:end-500);
                clear trace
            end
        end
    end
end

lowTrace_PA_270 = squeeze(nanmean(lowTrace_PA_270,2));
betaTrace_PA_270 = squeeze(nanmean(betaTrace_PA_270,2));

% Collect both together

lowTrace_PA = cat(1,lowTrace_PA_90,lowTrace_PA_270);
betaTrace_PA = cat(1,betaTrace_PA_90,betaTrace_PA_270);

clear lowTrace_PA_90; clear lowTrace_PA_270;
clear betaTrace_PA_90; clear betaTrace_PA_270;

fprintf('Computation of spectrograms done, saving...\n')

%% Collect the output

traces.PA.low = lowTrace_PA;
traces.PA.beta = betaTrace_PA;
traces.BR.low = lowTrace_BR;
traces.BR.beta = betaTrace_BR;

save(filename,'traces','-v7.3');

end
