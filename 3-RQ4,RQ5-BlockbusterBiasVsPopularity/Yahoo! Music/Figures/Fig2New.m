% subplot(3,1,1)
% w04(:,1)=BinRatesNBlockUser(:,4);
% w04(:,2)=BinRatesNBlockItem(:,4);
% w04(:,3)=BinRatesNBlockSVD(:,4);
% w04(:,4)=BinRatesNBlockSVDpp(:,4);
% w04(:,5)=BinRatesNBlockNMF(:,4);
% p04(:,1)=BinPopularity(:,4);
% w1Bar=bar(w04);
% w1Bar=legend(w1Bar, {'UserKNN' 'ItemKNN' 'SVD' 'SVD++' 'NMF'});
% hold on
% plot(p04,'HandleVisibility','off');
% xticks(0:1:20)
% title('w=0.4')

subplot(3,1,1)
a=BinRatesNBlockMostPopular(:,4);
w04(:,1)=a(1:10);
a=BinRatesNBlockRandom(:,4);
w04(:,2)=a(1:10);
a=BinRatesNBlockItemAVG(:,4);
w04(:,3)=a(1:10);
a=BinRatesNBlockUserKNN(:,4);
w04(:,4)=a(1:10);
a=BinRatesNBlockItemKNN(:,4);
w04(:,5)=a(1:10);
a=BinRatesNBlockSlopeOne(:,4);
w04(:,6)=a(1:10);
a=BinRatesNBlockSVD(:,4);
w04(:,7)=a(1:10);
a=BinRatesNBlockSVDpp(:,4);
w04(:,8)=a(1:10);
a=BinRatesNBlockNMF(:,4);
w04(:,9)=a(1:10);
a=BinRatesNBlockCoClustering(:,4);
w04(:,10)=a(1:10);
a=BinPopularity(:,4);
p04(:,1)=a(1:10);
w1Bar=bar(w04);
w1Bar=legend(w1Bar, {'MostPop' 'Random' 'ItemAvg' 'UserKNN' 'ItemKNN' 'SlopeOne' 'SVD' 'SVD++' 'NMF' 'CoClustering'});
hold on
plot(p04,'HandleVisibility','off');
xticks(0:1:10)
title('w=0.4')

% subplot(3,1,2)
% w02(:,1)=BinRatesNBlockUser(:,5);
% w02(:,2)=BinRatesNBlockItem(:,5);
% w02(:,3)=BinRatesNBlockSVD(:,5);
% w02(:,4)=BinRatesNBlockSVDpp(:,5);
% w02(:,5)=BinRatesNBlockNMF(:,5);
% p02(:,1)=BinPopularity(:,5);
% w1Bar=bar(w02);
% w1Bar=legend(w1Bar, {'UserKNN' 'ItemKNN' 'SVD' 'SVD++' 'NMF'});
% hold on
% plot(p02,'HandleVisibility','off');
% xticks(0:1:20)
% title('w=0.2')

subplot(3,1,2)
a=BinRatesNBlockMostPopular(:,5);
w0(:,1)=a(1:10);
a=BinRatesNBlockRandom(:,5);
w0(:,2)=a(1:10);
a=BinRatesNBlockItemAVG(:,5);
w0(:,3)=a(1:10);
a=BinRatesNBlockUserKNN(:,5);
w0(:,4)=a(1:10);
a=BinRatesNBlockItemKNN(:,5);
w0(:,5)=a(1:10);
a=BinRatesNBlockSlopeOne(:,5);
w0(:,6)=a(1:10);
a=BinRatesNBlockSVD(:,5);
w0(:,7)=a(1:10);
a=BinRatesNBlockSVDpp(:,5);
w0(:,8)=a(1:10);
a=BinRatesNBlockNMF(:,5);
w0(:,9)=a(1:10);
a=BinRatesNBlockCoClustering(:,5);
w0(:,10)=a(1:10);
a=BinPopularity(:,5);
p00(:,1)=a(1:10);
w1Bar=bar(w0);
w1Bar=legend(w1Bar, {'MostPop' 'Random' 'ItemAvg' 'UserKNN' 'ItemKNN' 'SlopeOne' 'SVD' 'SVD++' 'NMF' 'CoClustering'});
hold on
plot(p00,'HandleVisibility','off');
xticks(0:1:10)
title('w=0.2')

% subplot(3,1,3)
% w0(:,1)=BinRatesNBlockUser(:,6);
% w0(:,2)=BinRatesNBlockItem(:,6);
% w0(:,3)=BinRatesNBlockSVD(:,6);
% w0(:,4)=BinRatesNBlockSVDpp(:,6);
% w0(:,5)=BinRatesNBlockNMF(:,6);
% p0(:,1)=BinPopularity(:,6);
% w1Bar=bar(w0);
% w1Bar=legend(w1Bar, {'UserKNN' 'ItemKNN' 'SVD' 'SVD++' 'NMF'});
% hold on
% plot(p0,'HandleVisibility','off');
% xticks(0:1:20)
% title('w=0.6')

subplot(3,1,3)
a=BinRatesNBlockMostPopular(:,6);
w0(:,1)=a(1:10);
a=BinRatesNBlockRandom(:,6);
w0(:,2)=a(1:10);
a=BinRatesNBlockItemAVG(:,6);
w0(:,3)=a(1:10);
a=BinRatesNBlockUserKNN(:,6);
w0(:,4)=a(1:10);
a=BinRatesNBlockItemKNN(:,6);
w0(:,5)=a(1:10);
a=BinRatesNBlockSlopeOne(:,6);
w0(:,6)=a(1:10);
a=BinRatesNBlockSVD(:,6);
w0(:,7)=a(1:10);
a=BinRatesNBlockSVDpp(:,6);
w0(:,8)=a(1:10);
a=BinRatesNBlockNMF(:,6);
w0(:,9)=a(1:10);
a=BinRatesNBlockCoClustering(:,6);
w0(:,10)=a(1:10);
a=BinPopularity(:,6);
p00(:,1)=a(1:10);
w1Bar=bar(w0);
w1Bar=legend(w1Bar, {'MostPop' 'Random' 'ItemAvg' 'UserKNN' 'ItemKNN' 'SlopeOne' 'SVD' 'SVD++' 'NMF' 'CoClustering'});
hold on
plot(p00,'HandleVisibility','off');
xticks(0:1:10)
title('w=0')

