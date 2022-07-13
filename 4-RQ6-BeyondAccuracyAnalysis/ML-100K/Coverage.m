function [LC,APLT,Novelty]=Coverage(Dataset,Predictions)
% LC --> Long-tail Coverage
% APLT --> Average Percentage Long-Tail
% Novelty --> Novelty for Long-tail items
a=Dataset;
a(a==0)=NaN;
%% Popularity-Mean of the items
Ort=nanmean(a);
Ort(isnan(Ort))=0;
Pop=sum(Dataset~=0,1);

%% Recommendations for individuals
for i=1:size(a,1)
    [val,idx]=maxk(Predictions(i,:),10);
    topn(i,:)=idx;
end

%% All recommended items
topnItems=topn(1,:);
for i=2:size(topn,1)
    topnItems = cat(2,topnItems,topn(i,:));
end

%% Min-Max Normalization to transform same range
MaxOrt=max(Ort); MinOrt=min(Ort);
MaxPop=max(Pop); MinPop=min(Pop);
for i=1:size(Pop,2)
    NOrt(1,i)=(Ort(1,i)-MinOrt)/(MaxOrt-MinOrt);
    NPop(1,i)=(Pop(1,i)-MinPop)/(MaxPop-MinPop);
end

%% Find items in the long-tail
UnItems=unique(topnItems);
[outPop,idxPop]=sort(Pop,'descend');
itemSize=size(idxPop,2);
index=round(itemSize*20/100);

%% Average Percentage of Long Tail Items (APLT)and Long-tail Coverage (LC)
weights=[1 0.8 0.6 0.4 0.2 0];
for w=1:size(weights,2)
    countLC=0;
    for i=1:size(Pop,2)
        NBlock(1,i)=(1-(weights(1,w)))*NOrt(1,i)+(weights(1,w))*NPop(1,i);
    end
    [outNBlock,idxNBlock] = sort(NBlock,'descend');
    LongTailItemsPNBlock=idxNBlock(:,index:end);
    
    for i=1:size(UnItems,2)
        if (any(LongTailItemsPNBlock==UnItems(1,i)))
            countLC=countLC+1;
        end
    end
    % LC
    LC(w,1)=countLC/size(LongTailItemsPNBlock,2);
    
    for i=1:size(topn,1)
        countAPLT=0; countNovelty=0;
        for k=1:size(topn,2)
            if (any(LongTailItemsPNBlock==topn(i,k)))
                countAPLT=countAPLT+1;
            end
            %Novelty
            if (any(LongTailItemsPNBlock==topn(i,k)) && Dataset(i,topn(i,k))==0)
                countNovelty=countNovelty+1;
            end
        end
        % APLT
        APLTUser(i,1)=countAPLT/size(topn,2);
        NoveltyUser(i,1)=countNovelty/size(topn,2);
    end
    APLT(w,1)=mean(APLTUser);
    Novelty(w,1)=mean(NoveltyUser);
end




return
end
