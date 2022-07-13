% subplot(3,1,1)
% w1(:,1)=BinRatesNBlockUser(:,1);
% w1(:,2)=BinRatesNBlockItem(:,1);
% w1(:,3)=BinRatesNBlockSVD(:,1);
% w1(:,4)=BinRatesNBlockSVDpp(:,1);
% w1(:,5)=BinRatesNBlockNMF(:,1);
% p1(:,1)=BinPopularity(:,1);
% w1Bar=bar(w1);
% w1Bar=legend(w1Bar, {'UserKNN' 'ItemKNN' 'SVD' 'SVD++' 'NMF'});
% hold on
% plot(p1,'HandleVisibility','off');
% xticks(0:1:20)
% title('w=1')

subplot(3,1,1)
a=BinRatesNBlockMostPopular(:,1);
w1(:,1)=a(1:10);
a=BinRatesNBlockRandom(:,1);
w1(:,2)=a(1:10);
a=BinRatesNBlockItemAVG(:,1);
w1(:,3)=a(1:10);
a=BinRatesNBlockUserKNN(:,1);
w1(:,4)=a(1:10);
a=BinRatesNBlockItemKNN(:,1);
w1(:,5)=a(1:10);
a=BinRatesNBlockSlopeOne(:,1);
w1(:,6)=a(1:10);
a=BinRatesNBlockSVD(:,1);
w1(:,7)=a(1:10);
a=BinRatesNBlockSVDpp(:,1);
w1(:,8)=a(1:10);
a=BinRatesNBlockNMF(:,1);
w1(:,9)=a(1:10);
a=BinRatesNBlockCoClustering(:,1);
w1(:,10)=a(1:10);
a=BinPopularity(:,1);
p1(:,1)=a(1:10);
w1Bar=bar(w1);
w1Bar=legend(w1Bar, {'MostPop' 'Random' 'ItemAvg' 'UserKNN' 'ItemKNN' 'SlopeOne' 'SVD' 'SVD++' 'NMF' 'CoClustering'});
hold on
plot(p1,'HandleVisibility','off');
xticks(0:1:10)
title('w=1')

subplot(3,1,2)
a=BinRatesNBlockMostPopular(:,2);
w08(:,1)=a(1:10);
a=BinRatesNBlockRandom(:,2);
w08(:,2)=a(1:10);
a=BinRatesNBlockItemAVG(:,2);
w08(:,3)=a(1:10);
a=BinRatesNBlockUserKNN(:,2);
w08(:,4)=a(1:10);
a=BinRatesNBlockItemKNN(:,2);
w08(:,5)=a(1:10);
a=BinRatesNBlockSlopeOne(:,2);
w08(:,6)=a(1:10);
a=BinRatesNBlockSVD(:,2);
w08(:,7)=a(1:10);
a=BinRatesNBlockSVDpp(:,2);
w08(:,8)=a(1:10);
a=BinRatesNBlockNMF(:,2);
w08(:,9)=a(1:10);
a=BinRatesNBlockCoClustering(:,2);
w08(:,10)=a(1:10);
a=BinPopularity(:,2);
p1(:,1)=a(1:10);
w1Bar=bar(w08);
w1Bar=legend(w1Bar, {'MostPop' 'Random' 'ItemAvg' 'UserKNN' 'ItemKNN' 'SlopeOne' 'SVD' 'SVD++' 'NMF' 'CoClustering'});
hold on
plot(p1,'HandleVisibility','off');
xticks(0:1:10)
title('w=0.8')

% subplot(3,1,2)
% w08(:,1)=BinRatesNBlockUser(:,2);
% w08(:,2)=BinRatesNBlockItem(:,2);
% w08(:,3)=BinRatesNBlockSVD(:,2);
% w08(:,4)=BinRatesNBlockSVDpp(:,2);
% w08(:,5)=BinRatesNBlockNMF(:,2);
% p08(:,1)=BinPopularity(:,2);
% w1Bar=bar(w08);
% w1Bar=legend(w1Bar, {'UserKNN' 'ItemKNN' 'SVD' 'SVD++' 'NMF'});
% hold on
% plot(p08,'HandleVisibility','off');
% xticks(0:1:20)
% title('w=0.8')

subplot(3,1,3)
a=BinRatesNBlockMostPopular(:,3);
w06(:,1)=a(1:10);
a=BinRatesNBlockRandom(:,3);
w06(:,2)=a(1:10);
a=BinRatesNBlockItemAVG(:,3);
w06(:,3)=a(1:10);
a=BinRatesNBlockUserKNN(:,3);
w06(:,4)=a(1:10);
a=BinRatesNBlockItemKNN(:,3);
w06(:,5)=a(1:10);
a=BinRatesNBlockSlopeOne(:,3);
w06(:,6)=a(1:10);
a=BinRatesNBlockSVD(:,3);
w06(:,7)=a(1:10);
a=BinRatesNBlockSVDpp(:,3);
w06(:,8)=a(1:10);
a=BinRatesNBlockNMF(:,3);
w06(:,9)=a(1:10);
a=BinRatesNBlockCoClustering(:,3);
w06(:,10)=a(1:10);
a=BinPopularity(:,3);
p06(:,1)=a(1:10);
w1Bar=bar(w06);
w1Bar=legend(w1Bar, {'MostPop' 'Random' 'ItemAvg' 'UserKNN' 'ItemKNN' 'SlopeOne' 'SVD' 'SVD++' 'NMF' 'CoClustering'});
hold on
plot(p06,'HandleVisibility','off');
xticks(0:1:20)
title('w=0.6')

% subplot(3,1,3)
% w06(:,1)=BinRatesNBlockUser(:,3);
% w06(:,2)=BinRatesNBlockItem(:,3);
% w06(:,3)=BinRatesNBlockSVD(:,3);
% w06(:,4)=BinRatesNBlockSVDpp(:,3);
% w06(:,5)=BinRatesNBlockNMF(:,3);
% p06(:,1)=BinPopularity(:,3);
% w1Bar=bar(w06);
% w1Bar=legend(w1Bar, {'UserKNN' 'ItemKNN' 'SVD' 'SVD++' 'NMF'});
% hold on
% plot(p06,'HandleVisibility','off');
% xticks(0:1:20)
% title('w=0.6')

