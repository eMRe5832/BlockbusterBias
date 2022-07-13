subplot(3,1,1)
w04(:,1)=BinRatesNBlockUser(:,4);
w04(:,2)=BinRatesNBlockItem(:,4);
w04(:,3)=BinRatesNBlockSVD(:,4);
w04(:,4)=BinRatesNBlockSVDpp(:,4);
w04(:,5)=BinRatesNBlockNMF(:,4);
p04(:,1)=BinPopularity(:,4);
w1Bar=bar(w04);
w1Bar=legend(w1Bar, {'UserKNN' 'ItemKNN' 'SVD' 'SVD++' 'NMF'});
hold on
plot(p04,'HandleVisibility','off');
xticks(0:1:20)
title('w=0.4')

subplot(3,1,2)
w02(:,1)=BinRatesNBlockUser(:,5);
w02(:,2)=BinRatesNBlockItem(:,5);
w02(:,3)=BinRatesNBlockSVD(:,5);
w02(:,4)=BinRatesNBlockSVDpp(:,5);
w02(:,5)=BinRatesNBlockNMF(:,5);
p02(:,1)=BinPopularity(:,5);
w1Bar=bar(w02);
w1Bar=legend(w1Bar, {'UserKNN' 'ItemKNN' 'SVD' 'SVD++' 'NMF'});
hold on
plot(p02,'HandleVisibility','off');
xticks(0:1:20)
title('w=0.2')

subplot(3,1,3)
w0(:,1)=BinRatesNBlockUser(:,6);
w0(:,2)=BinRatesNBlockItem(:,6);
w0(:,3)=BinRatesNBlockSVD(:,6);
w0(:,4)=BinRatesNBlockSVDpp(:,6);
w0(:,5)=BinRatesNBlockNMF(:,6);
p0(:,1)=BinPopularity(:,6);
w1Bar=bar(w0);
w1Bar=legend(w1Bar, {'UserKNN' 'ItemKNN' 'SVD' 'SVD++' 'NMF'});
hold on
plot(p0,'HandleVisibility','off');
xticks(0:1:20)
title('w=0.6')

