f = linspace(1.9,50,50);

t = linspace(-0.8,0.8,size(sfc_np2p,2));

for i = 1:324

    temp1 = zscore(squeeze(sfc_np2p(i,:,:)),[],2);
    temp2 = zscore(squeeze(sfc_p2np(i,:,:)),[],2);

    diffCohgram(i,:,:) = temp2-temp1;

end

figure

imagesc(t,f,squeeze(nanmean(diffCohgram,1)))
AX = gca;
axis xy
vline(0,'--w')
colormap jet
colorbar
AX.CLim = [0 0.25]
title('SFC P2NP-NP2P')
ylabel('Frequency [Hz]')
xlabel('time [s]')

figure

subplot(1,2,1)
imagesc(t,f,squeeze(nanmean(sfc_np2p,1))')
AX = gca;
axis xy
vline(0,'--w')
colormap jet
colorbar
AX.CLim = [0.375 0.425]
title('SFC NP2P')
ylabel('Frequency [Hz]')

subplot(1,2,2)
imagesc(t,f,squeeze(nanmean(sfc_p2np,1))')
AX = gca;
axis xy
vline(0,'--w')
colormap jet
colorbar
AX.CLim = [0.375 0.425]
title('SFC P2NP')
xlabel('time [s]')
