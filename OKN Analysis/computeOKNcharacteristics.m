function oknevents = computeOKNcharacteristics(OKNstruct)

[b,a]= butter(3,20/500,'low');

% BR 90

nTr = 1;
oknevents.nTr = 1;
oknevents.nEvent = zeros(1, nTr);
oknevents.Shape{nTr} = [];
oknevents.startEvent{nTr} = [];
oknevents.endEvent{nTr} = [];
oknevents.Duration{nTr} = [];
oknevents.startSlowPhase{nTr} = [];
oknevents.endSlowPhase{nTr} = [];
oknevents.Address{nTr} = [];

oknevents.Features {1,1} = zeros(8,1);

okntrace = [];
for j = 1: size(OKNstruct,1)
    okntracechunk =  OKNstruct{j}';
    filtOknTrace = filtfilt(b,a,okntracechunk);
    [peakIndices{j}]=detectOKNpeaks({filtOknTrace});
    [incides] = find_zeroCrossing(filtOknTrace);
    okneventsTemp = extractOKNEshapes({filtOknTrace},peakIndices{j});
    eventLabelsTemp = ones(1,okneventsTemp.nEvent);
    oknfeaturesTemp = extractOKNfeatures(okneventsTemp, {filtOknTrace});
    oknevents.nEvent = oknevents.nEvent + okneventsTemp.nEvent;
    oknevents.Shape{1} = horzcat(oknevents.Shape{1},okneventsTemp.Shape{1});
    oknevents.startEvent{1} = horzcat(oknevents.startEvent{1},okneventsTemp.startEvent{1});
    oknevents.endEvent{1} = horzcat(oknevents.endEvent{1},okneventsTemp.endEvent{1});
    oknevents.Duration{1} = horzcat(oknevents.Duration{1},okneventsTemp.Duration{1});
    oknevents.startSlowPhase{1} = horzcat(oknevents.startSlowPhase{1},okneventsTemp.startSlowPhase{1});
    oknevents.endSlowPhase{1} = horzcat(oknevents.endSlowPhase{1},okneventsTemp.endSlowPhase{1});
    oknevents.frequency{j} = numel(cell2mat(peakIndices{j}))/(length(filtOknTrace)/1000);
    oknevents.domdur(j) = (length(filtOknTrace)/1000);
    if ~isempty(okneventsTemp.iniLag)
        oknevents.iniLag{j} = okneventsTemp.iniLag{1}(1);
    end
    oknevents.peakIndices{j} = peakIndices{j};
    if ~isempty(okntrace)&& ~isempty(okneventsTemp.Address{1})
         temp = ones(1,size(okneventsTemp.Address{1}(2,:),2))* size(okntrace,2);
         okneventsTemp.Address{1}(2,:)=  okneventsTemp.Address{1}(2,:) + temp;
    end
    oknevents.Address{1} = horzcat(oknevents.Address{1}, okneventsTemp.Address{1});
    
    oknevents.Features {1,1} = horzcat(oknevents.Features {1,1}, oknfeaturesTemp.Features{1,1});
    
    okntrace = [okntrace okntracechunk];
end