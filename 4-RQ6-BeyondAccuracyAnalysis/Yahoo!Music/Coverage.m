function [LC,APLT,Novelty]=Coverage(Dataset,Predictions)
% LC --> Long-tail Coverage
% APLT --> Average Percentage Long-Tail
% Novelty --> Novelty for Long-tail items

%% Producing top10 list of items for each member
UserNumber=size(unique(Dataset(:,1)),1);

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

%% All recommended items
topnItems=topn(1,:);
for i=2:size(topn,1)
    topnItems = cat(2,topnItems,topn(i,:));
end

%% 4) Find Popularity-Mean of the items
ItemNumber=max(Dataset(:,2));
Pop=zeros(1,ItemNumber);
Ort=zeros(1,ItemNumber);

for i=1:ItemNumber
    fprintf('%d\n',i);
    Rows=[];
    idx=find(Dataset(:,2)==i);
    if(isempty(idx))
        Ort(1,i)=0;
        Pop(1,i)=0;
    else
        for k=1:size(idx,1)
            Rows=[Rows;Dataset(idx(k,1),:)];
        end
        Ort(1,i)=mean(Rows(:,3));
        Pop(1,i)=size(Rows,1);
    end
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
            tmp=0;
            if (any(LongTailItemsPNBlock==topn(i,k)))
                countAPLT=countAPLT+1;
                %Novelty
                IDs=find(Dataset(:,1)==i);
                
                for t=1:size(IDs,1)
                    if(Dataset(IDs(t,1),2)~=topn(i,k))
                        tmp=tmp+1;
                    end
                end
                if(tmp==size(IDs,1))
                    countNovelty=countNovelty+1;
                end
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
