function [BinRatesNBlock, BinRatesPop, BinRatesPopsOfNblock]=BlockBusterForYM(LastCiao,Predictions)

%% 1- Construct Dataset et least 20 ratings for items and users
% ItemNumber=max(Ciao(:,2));
% UserNumber=max(Ciao(:,1));
% TransformedCiao=[];
%
% for row=1:size(Ciao,1)
%     UserID=Ciao(row,1);
%     ItemID=Ciao(row,2);
%     Items=find(Ciao(:,2)==ItemID);
%     Users=find(Ciao(:,1)==UserID);
%
%     if(size(Items,1)>20 && size(Users,1)>20)
%         fprintf('%d \n',row);
%         TransformedCiao=[TransformedCiao;Ciao(row,:)];
%     end
% end
%
% LastCiao=TransformedCiao;
% ItemSet=unique(TransformedCiao(:,2));
% UserSet=unique(TransformedCiao(:,1));
%
% for i=1:size(ItemSet,1)
%     ItemIDX=find(TransformedCiao(:,2)==ItemSet(i,1));
%     for k=1:size(ItemIDX,1)
%         LastCiao(ItemIDX(k,1),2)=i;
%     end
% end
%
% for i=1:size(UserSet,1)
%     UserIDX=find(TransformedCiao(:,1)==UserSet(i,1));
%     for k=1:size(UserIDX,1)
%         LastCiao(UserIDX(k,1),1)=i;
%     end
% end

%% 2- Write ratings to txt.file (3278 Users-1351 Items-52717 Ratings)
% fileName={'CiaoRatings.txt'};
% fid=fopen('CiaoRatings.txt','w');
% for i=1:size(LastCiao,1)
%     fprintf(fid, '%d\t%d\t%d\n', [LastCiao(i,1),LastCiao(i,2),LastCiao(i,3)]');
% end
% fclose(fid)



%% 3)Producing top10 list of items for each member
UserNumber=size(unique(LastCiao(:,1)),1);

for i=1:UserNumber
    fprintf('%d \n',i);
    Pred=[];
    UserPredictionsID=find(Predictions(:,1)==i);
    for k=1:size(UserPredictionsID,1)
        Pred=[Pred; Predictions(UserPredictionsID(k,1),:)];
    end
    %Producing top10 list of items for each member
    [val,idx]=maxk(Pred(:,3),10);
    for t=1:size(idx,1)
        topn(i,t)=Pred(idx(t,1),2);
    end
end

%% 4) Find Popularity-Mean of the items
ItemNumber=max(LastCiao(:,2));
Pop=zeros(1,ItemNumber);
Ort=zeros(1,ItemNumber);

for i=1:ItemNumber
    fprintf('%d\n',i);
    Rows=[];
    idx=find(LastCiao(:,2)==i);
    if(isempty(idx))
        Ort(1,i)=0;
        Pop(1,i)=0;
    else
        for k=1:size(idx,1)
            Rows=[Rows;LastCiao(idx(k,1),:)];
        end
        Ort(1,i)=mean(Rows(:,3));
        Pop(1,i)=size(Rows,1);
    end
end

%% 5) Min-Max Normalization for Pop and Ort

%% Min-Max Normalization to transform same range
MaxOrt=max(Ort); MinOrt=min(Ort);
MaxPop=max(Pop); MinPop=min(Pop);
for i=1:size(Pop,2)
    NOrt(1,i)=(Ort(1,i)-MinOrt)/(MaxOrt-MinOrt);
    NPop(1,i)=(Pop(1,i)-MinPop)/(MaxPop-MinPop);
end

%% Estimate BlockBuster Items
weights=[1 0.8 0.6 0.4 0.2 0];

for w=1:size(weights,2)
    for i=1:size(Pop,2)
        NBlock(1,i)=(1-(weights(1,w)))*NOrt(1,i)+(weights(1,w))*NPop(1,i);
    end
    
    [outPop,idxPop]=sort(NPop,'descend');
    [outNBlock,idxNBlock] = sort(NBlock,'descend');
    
    % Merging produced every ranked list
    topnItems=topn(1,:);
    for i=2:size(topn,1)
        topnItems = cat(2,topnItems,topn(i,:));
    end
    
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