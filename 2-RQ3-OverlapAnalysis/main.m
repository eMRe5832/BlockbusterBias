function [result]=main(Dataset)

%% Blocbuster score estimation for each item (stored in BlockScores) and determination of long-tail items
a=Dataset;
a(a==0)=NaN;
% Item'ların ortalaması ve popülerliği
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

%% Find items in the long-tail
% UnItems=unique(topnItems);
% [outPop,idxPop]=sort(Pop,'descend');
itemSize=size(Dataset,2);
index=round(itemSize*20/100);

%% Find Popular head items
SortedPop=[];
for i=1:size(NPop,1)
    [outPop,idxSortedPop] = sort(Pop(i,:),'descend');
    SortedPop=[SortedPop; outPop];
end
LongTailItemsPop=[];HeadItemsPop=[];
top=0;
for i=1:size(idxSortedPop,2)
    if(top<index)
        ItemID=idxSortedPop(1,i);
        top=top+1;
        HeadItemsPop=[HeadItemsPop idxSortedPop(1,i)];
    else
        LongTailItemsPop=[LongTailItemsPop idxSortedPop(1,i)];
    end
end

weights=[1 0.8 0.6 0.4 0.2 0];
for w=1:size(weights,2)
    for i=1:size(Pop,2)
        BlockScores(1,i)=(1-(weights(1,w)))*NOrt(1,i)+(weights(1,w))*NPop(1,i);
    end


    % Sorting blockbuster scores
    SortedBlock=[];
    for i=1:size(BlockScores,1)
        [outNBlock,idxSortedBlock] = sort(BlockScores(i,:),'descend');
        SortedBlock=[SortedBlock; outNBlock];
    end

    % Head-Tail items blockbuster
    LongTailItemsBlock=[];HeadItemsBlock=[];
    top=0;
    for i=1:size(idxSortedPop,2)
        if(top<index)
            ItemID=idxSortedBlock(1,i);
            top=top+1;
            HeadItemsBlock=[HeadItemsBlock idxSortedBlock(1,i)];
        else
            LongTailItemsBlock=[LongTailItemsBlock idxSortedBlock(1,i)];
        end
    end


    % overlap all head items
    boyut=size(HeadItemsPop,2);
    count=0;
    for i=1:boyut
        ItemID=HeadItemsPop(1,i);
        if (any(HeadItemsBlock==ItemID))
            count=count+1;
        end
    end

    result(w,1)=count/size(HeadItemsBlock,2);

%     %overlap specific k item list
%     k=[5,10,20,30,40,50,60,70,80,90,100];
%     for j=1:size(k,2)
%         boyut=k(1,j);
%         BlockItems=idxSortedBlock(1:boyut);
%         PopItems=idxSortedPop(1:boyut);
%         count=0;
%         for i=1:boyut
%             ItemID=PopItems(1,i);
%             if (any(BlockItems==ItemID))
%                 count=count+1;
%             end
%         end
%         result(1,j)=count/boyut;
% 
%     end

end

return
end
