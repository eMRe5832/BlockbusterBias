function [BinRatesNBlock, BinRatesPop, BinRatesPopsOfNblock]=BlockBuster(Dataset,Predictions)

a=Dataset;

a(a==0)=NaN;
% Item'ların ortalaması
Ort=nanmean(a);
Ort(isnan(Ort))=0;
Pop=sum(Dataset~=0,1);

%% Min-Max Normalization to transform same range
MaxOrt=max(Ort); MinOrt=min(Ort);
MaxPop=max(Pop); MinPop=min(Pop);
for i=1:size(Pop,2)
    NOrt(1,i)=(Ort(1,i)-MinOrt)/(MaxOrt-MinOrt);
    NPop(1,i)=(Pop(1,i)-MinPop)/(MaxPop-MinPop);
end

% For all weights
weights=[1 0.8 0.6 0.4 0.2 0];
for w=1:size(weights,2)
    
    for i=1:size(Pop,2)
        NBlock(1,i)=(1-(weights(1,w)))*NOrt(1,i)+(weights(1,w))*NPop(1,i);
    end
    
    [outPop,idxPop]=sort(NPop,'descend');
    [outNBlock,idxNBlock] = sort(NBlock,'descend');
    
    % Hold Pops of NBlockItems
    for i=1:size(outNBlock,2)
        outPopsOfNBlock(1,i)=(NPop(1,i));
    end
    %% Producing top10 list of items for each member
    for i=1:size(a,1)
        [val,idx]=maxk(Predictions(i,:),10);
        topn(i,:)=idx;
    end
    
   
    
    %% Merging produced every ranked list
    topnItems=topn(1,:);
    for i=2:size(topn,1)
        topnItems = cat(2,topnItems,topn(i,:));
    end
    
    %% Transform indices items in the merged list with the sorted STD idx
    
    % for i=1:size(topnItems,2)
    % resultPop(1,i)=find(idxPop==topnItems(1,i));
    % resultBlock(1,i)=find(idxNBlock==topnItems(1,i));
    % end
    
    
    %% Count the frequency of recommendation for each item
    for i=1:size(NBlock,2)
        CountNBlock(1,i)=nnz(idxNBlock(1,i)==topnItems);
        CountPop(1,i)=nnz(idxPop(1,i)==topnItems);
    end
    
    %% Split 20 bins counts of recommended items
    bin=19;
    splitlength = floor(size(CountNBlock,2)/bin)-1;
    % for CountNBlock
    sublengths = ones(1, ceil(numel(CountNBlock)/splitlength)) * splitlength;
    sublengths(end) = sublengths(end) + numel(CountNBlock) - sum(sublengths); %adjust length of last block
    subCountNBlock = mat2cell(CountNBlock, 1, sublengths);
    
    % for idxNBlock
    sublengths = ones(1, ceil(numel(idxNBlock)/splitlength)) * splitlength;
    sublengths(end) = sublengths(end) + numel(idxNBlock) - sum(sublengths); %adjust length of last block
    subidxNBlock = mat2cell(idxNBlock, 1, sublengths);
    
    % for CountNPop
    sublengths = ones(1, ceil(numel(CountPop)/splitlength)) * splitlength;
    sublengths(end) = sublengths(end) + numel(CountPop) - sum(sublengths); %adjust length of last block
    subCountPop = mat2cell(CountPop, 1, sublengths);
    
    %% Estimate pops of sorted Nblock items
    subPOPsOfNblock=subidxNBlock;
    for i=1:size(subCountNBlock,2)
        for k=1:size(subidxNBlock{i},2)
            subPOPsOfNblock{i}(1,k)=Pop(1,subidxNBlock{i}(1,k));
        end
    end
    
    %% Estimate Bin Counts
    for i=1:size(subCountNBlock,2)
        BinCountsNBlock(i,w)=sum(subCountNBlock{1,i});
        BinCountsPop(i,w)=sum(subCountPop{1,i});
        BinCountsPopsOfNblock(i,w)=sum(subPOPsOfNblock{1,i});
    end
    
    for i=1:size(BinCountsNBlock,1)
        BinRatesNBlock(i,w)=BinCountsNBlock(i,w)/sum(BinCountsNBlock(:,w));
        BinRatesPop(i,w)=BinCountsPop(i,w)/sum(BinCountsPop(:,w));
        BinRatesPopsOfNblock(i,w)=BinCountsPopsOfNblock(i,w)/sum(BinCountsPopsOfNblock(:,w));
    end
end

subplot(3,2,1)
bar(BinRatesNBlock(:,1));
hold on
b=plot(BinRatesPopsOfNblock(:,1));
hold off
legend([b],'Popularity');
title('w=1')



subplot(3,2,2)
bar(BinRatesNBlock(:,2))
hold on
b=plot(BinRatesPopsOfNblock(:,2));
legend([b],'Popularity');
title('w=0.8')

subplot(3,2,3)
bar(BinRatesNBlock(:,3))
hold on
b=plot(BinRatesPopsOfNblock(:,3));
title('w=0.6')
legend([b],'Popularity');

subplot(3,2,4)
bar(BinRatesNBlock(:,4))
hold on
b=plot(BinRatesPopsOfNblock(:,4));
title('w=0.4')
legend([b],'Popularity');

subplot(3,2,5)
bar(BinRatesNBlock(:,5))
hold on
b=plot(BinRatesPopsOfNblock(:,5));
title('w=0.2')
legend([b],'Popularity');

subplot(3,2,6)
bar(BinRatesNBlock(:,6))
hold on
b=plot(BinRatesPopsOfNblock(:,6));
title('w=0')
legend([b],'Popularity');
return
end
