function oknLags = computeOKNlags(OKNstruct,t)

[b,a]= butter(3,20/500,'low');

% BR 90

nTr = 1;
oknLags = [];

for j = 1: size(OKNstruct,1)
    okntracechunk =  OKNstruct{j}';
    filtOknTrace = filtfilt(b,a,okntracechunk);
    [peakIndices]=cell2mat(detectOKNpeaks({filtOknTrace}));
    if ~isempty(peakIndices)
        peakIndices = peakIndices(peakIndices<=ceil(length(t)/2)); % Only pick peaks before the switch.
    end
    if numel(peakIndices) > 1
        peakIndices = peakIndices(end); % Get the last before the switch
    end
    oknLags = [oknLags (peakIndices-ceil(length(t)/2))]; % Subtract the switch-time to get the times relative to the switch (all will be negative)
end