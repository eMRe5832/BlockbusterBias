function DistPlot()
MLP = [0.0611, 0.1137, 0.2715, 0.3417, 0.2120];
MLM = [0.0562, 0.1075, 0.2611, 0.3489, 0.2263];
Ciao = [0.0633, 0.0492, 0.1193, 0.2677, 0.5005];
YM = [0.3139, 0.1272, 0.1576, 0.1555, 0.2457];
GB = [0.0216, 0.0633, 0.2394, 0.3575, 0.3181];

% Create a vertical bar chart using the bar function
subplot(1,1,1);
bar(1:5, [MLP' MLM' Ciao' YM' GB'], 1)
% Set the axis limits
axis([0 6 0 1])
set(gca, 'XTick', 1:5)
set(gca,'xticklabel',{'1','2','3','4','5'})
% Add title and axis labels
ylabel('Rating probability')
xlabel('Rating values')
% Add a legend
legend('ML-100K', 'ML-1M', 'Ciao', 'YM', 'GB')

return
end