subplot(3,1,1)
w1(:,1)=BinRatesNBlockUser(:,1);
w1(:,2)=BinRatesNBlockItem(:,1);
w1(:,3)=BinRatesNBlockSVD(:,1);
w1(:,4)=BinRatesNBlockSVDpp(:,1);
w1(:,5)=BinRatesNBlockNMF(:,1);
p1(:,1)=BinPopularity(:,1);
w1Bar=bar(w1);
w1Bar=legend(w1Bar, {'UserKNN' 'ItemKNN' 'SVD' 'SVD++' 'NMF'});
hold on
plot(p1,'HandleVisibility','off');
xticks(0:1:20)
title('w=1')

subplot(3,1,2)
w08(:,1)=BinRatesNBlockUser(:,2);
w08(:,2)=BinRatesNBlockItem(:,2);
w08(:,3)=BinRatesNBlockSVD(:,2);
w08(:,4)=BinRatesNBlockSVDpp(:,2);
w08(:,5)=BinRatesNBlockNMF(:,2);
p08(:,1)=BinPopularity(:,2);
w1Bar=bar(w08);
w1Bar=legend(w1Bar, {'UserKNN' 'ItemKNN' 'SVD' 'SVD++' 'NMF'});
hold on
plot(p08,'HandleVisibility','off');
xticks(0:1:20)
title('w=0.8')

subplot(3,1,3)
w06(:,1)=BinRatesNBlockUser(:,3);
w06(:,2)=BinRatesNBlockItem(:,3);
w06(:,3)=BinRatesNBlockSVD(:,3);
w06(:,4)=BinRatesNBlockSVDpp(:,3);
w06(:,5)=BinRatesNBlockNMF(:,3);
p06(:,1)=BinPopularity(:,3);
w1Bar=bar(w06);
w1Bar=legend(w1Bar, {'UserKNN' 'ItemKNN' 'SVD' 'SVD++' 'NMF'});
hold on
plot(p06,'HandleVisibility','off');
xticks(0:1:20)
title('w=0.6')

