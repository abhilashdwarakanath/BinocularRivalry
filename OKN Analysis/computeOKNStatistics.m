function [oknLags] = computeOKNStatistics(lfpActivity,endDomTimes,durs,sav_dir,tag)

% This script computes the OKN characteristics and statistics for a given
% dataset

%% Load the dataset

filename = ['oknLags_' tag '.mat'];

%% Extract the OKNs of the four conditions

% BR 90

c = 0;
for iCond = 1:size(lfpActivity.validOKN.BR.data.dom90,2)
    for nDom = 1:size(lfpActivity.validOKN.BR.data.dom90{1, iCond},2)
        piece = (lfpActivity.validOKN.BR.data.dom90{1, iCond}{nDom});
        if ~isnan(piece)
            c = c+1;
            tracesDom90BR{c} = piece;
        end
    end
end

% BR 270

c = 0;
for iCond = 1:size(lfpActivity.validOKN.BR.data.dom270,2)
    for nDom = 1:size(lfpActivity.validOKN.BR.data.dom270{1, iCond},2)
        piece = (lfpActivity.validOKN.BR.data.dom270{1, iCond}{nDom});
        if ~isnan(piece)
            c = c+1;
            tracesDom270BR{c} = piece;
        end
    end
end

c = 0;
for iCond = 1:size(lfpActivity.validOKN.PA.data.dom90,2)
    for nDom = 1:size(lfpActivity.validOKN.PA.data.dom90{1, iCond},2)
        piece = (lfpActivity.validOKN.PA.data.dom90{1, iCond}{nDom});
        if ~isnan(piece)
            c = c+1;
            tracesDom90PA{c} = piece;
        end
    end
end

% PA 270

c = 0;
for iCond = 1:size(lfpActivity.validOKN.PA.data.dom270,2)
    for nDom = 1:size(lfpActivity.validOKN.PA.data.dom270{1, iCond},2)
        piece = (lfpActivity.validOKN.PA.data.dom270{1, iCond}{nDom});
        if ~isnan(piece)
            c = c+1;
            tracesDom270PA{c} = piece;
        end
    end
end

%% Compute features

t = linspace(-durs.domBehind/1000,durs.domForward/1000,(durs.domBehind)+(durs.domForward)+1);

% BR 90

oknLags.BR.dom90 = computeOKNlags(tracesDom90BR',t);

% BR 270
oknLags.BR.dom270 = computeOKNlags(tracesDom270BR',t);

% PA 90
oknLags.PA.dom90 = computeOKNlags(tracesDom90PA',t);

% PA 270
oknLags.PA.dom270 = computeOKNlags(tracesDom270PA',t);

save([sav_dir '\' filename],'endDomTimes','oknLags','t','-v7.3');