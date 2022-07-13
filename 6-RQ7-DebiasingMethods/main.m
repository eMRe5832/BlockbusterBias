function [RF,LC,APLT,Novelty,Precision,Recall,F1,nDCG]=main(Dataset,Pred)

%% Blocbuster score estimation for each item (stored in BlockScores) and determination of long-tail items
a=Dataset;
a(a==0)=NaN;
% Item'ların ortalaması ve popülerliği
Ort=nanmean(a);
Ort(isnan(Ort))=0;
Pop=sum(Dataset~=0,1);

% Min-Max Normalization to transform same range
MaxOrt=max(Ort); MinOrt=min(Ort);
MaxPop=max(Pop); MinPop=min(Pop);
for i=1:size(Pop,2)
    NOrt(1,i)=(Ort(1,i)-MinOrt)/(MaxOrt-MinOrt);
    NPop(1,i)=(Pop(1,i)-MinPop)/(MaxPop-MinPop);
end

% Blockbuster scores = Average of Pop and Mean
for i=1:size(Pop,2)
    BlockScores(1,i)=(NOrt(1,i)+NPop(1,i))/2;
end

% Sorting blockbuster scores
SortedBlock=[];
for i=1:size(BlockScores,1)
    [outNBlock,idxSortedBlock] = sort(BlockScores(i,:),'descend');
    SortedBlock=[SortedBlock; outNBlock];
end


% Determination of long-tail items based on BlockScores
% Head items are estimated based on pareto principle (Ratings of blockbuster items)
totalRatings=sum(Dataset~=0,1);
Limit=round((sum(Pop))*20/100);
LongTailItemsPNBlock=[];
top=0;
for i=1:size(idxSortedBlock,2)
    if(top<Limit)
        ItemID=idxSortedBlock(1,i);
        top=top+Pop(1,ItemID);
    else
        LongTailItemsPNBlock=[LongTailItemsPNBlock idxSortedBlock(1,i)];
    end
end


%% Value-aware Ranking (Var)
weightsForVaR=zeros(1,size(Pop,2));

for i=1:size(Pop,2)
    weightsForVaR(1,i)=1/log2(Pop(1,i)+2);
end

PredictionsVaR=zeros(size(Pred,1),size(Pred,2));
for u=1:size(Pred,1)
    for i=1:size(Pred,2)
        PredictionsVaR(u,i)=0.8*Pred(u,i)+0.2*weightsForVaR(1,i);
       
    end
end

% Recommendations for individuals
for i=1:size(a,1)
    [val,idx]=maxk(PredictionsVaR(i,:),10);
    topn(i,:)=idx;
end

% All recommended items
topnItems=topn(1,:);
for i=2:size(topn,1)
    topnItems = cat(2,topnItems,topn(i,:));
end
UnItems=unique(topnItems);

countLC=0;

% Calculation of LC
for i=1:size(UnItems,2)
    if (any(LongTailItemsPNBlock==UnItems(1,i)))
        countLC=countLC+1;
    end
end
Results(1,1)=countLC/size(LongTailItemsPNBlock,2);

% Calculation APLT and Novelty
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
Results(1,2)=mean(APLTUser);
Results(1,3)=mean(NoveltyUser);

% NDCG Calculation
for user=1:size(Pred,1)
    [pre(user,1),re(user,1),f1score(user,1)]=PreRecF1(Dataset(user,:), topn(user,:));
    nDCGs(user,1)=NDCG(Dataset(user,:), topn(user,:));
end

Results(1,4)=mean(pre);
Results(1,5)=mean(re);
Results(1,6)=mean(f1score);
Results(1,7)=mean(nDCGs);

%% Enhanced Re-ranking procedure - MUL (ERP,Mul)
weightsForERPMUL=zeros(1,size(Pop,2));

for i=1:size(Pop,2)
    weightsForERPMUL(1,i)=1-NPop(1,i);
end

PredNorm=Pred;
for i=1:size(Pred,1)
    MaxUser=max(Pred(i,:)); MinUser=min(Pred(i,:));
    for k=1:size(Pred,2)
        PredNorm(i,k)=(Pred(i,k)-MinUser)/(MaxUser-MinUser);
    end
end


PredictionsERPMUL=zeros(size(Pred,1),size(Pred,2));
for u=1:size(Pred,1)
    for i=1:size(Pred,2)
       PredictionsERPMUL(u,i)=PredNorm(u,i)*weightsForERPMUL(1,i);
    end
end

% Recommendations for individuals
for i=1:size(a,1)
    [val,idx]=maxk(PredictionsERPMUL(i,:),10);
    topn(i,:)=idx;
end

% All recommended items
topnItems=topn(1,:);
for i=2:size(topn,1)
    topnItems = cat(2,topnItems,topn(i,:));
end
UnItems=unique(topnItems);

countLC=0;

% Calculation of LC
for i=1:size(UnItems,2)
    if (any(LongTailItemsPNBlock==UnItems(1,i)))
        countLC=countLC+1;
    end
end
Results(2,1)=countLC/size(LongTailItemsPNBlock,2);

% Calculation APLT and Novelty
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
Results(2,2)=mean(APLTUser);
Results(2,3)=mean(NoveltyUser);

% NDCG Calculation
for user=1:size(Pred,1)
    [pre(user,1),re(user,1),f1score(user,1)]=PreRecF1(Dataset(user,:), topn(user,:));
    nDCGs(user,1)=NDCG(Dataset(user,:), topn(user,:));
end

Results(2,4)=mean(pre);
Results(2,5)=mean(re);
Results(2,6)=mean(f1score);
Results(2,7)=mean(nDCGs);

%% Enhanced Re-ranking procedure - Aug (ERP,Aug)
weightsForERPMUL=zeros(1,size(Pop,2));

for i=1:size(Pop,2)
    weightsForERPMUL(1,i)=1-NPop(1,i);
end

PredNorm=Pred;
for i=1:size(Pred,1)
    MaxUser=max(Pred(i,:)); MinUser=min(Pred(i,:));
    for k=1:size(Pred,2)
        PredNorm(i,k)=(Pred(i,k)-MinUser)/(MaxUser-MinUser);
    end
end

PredictionsERPAug=zeros(size(Pred,1),size(Pred,2));
for u=1:size(Pred,1)
    for i=1:size(Pred,2)
       PredictionsERPAug(u,i)=PredNorm(u,i)+ (PredNorm(u,i)*weightsForERPMUL(1,i));
    end
end

% Recommendations for individuals
for i=1:size(a,1)
    [val,idx]=maxk(PredictionsERPAug(i,:),10);
    topn(i,:)=idx;
end

% All recommended items
topnItems=topn(1,:);
for i=2:size(topn,1)
    topnItems = cat(2,topnItems,topn(i,:));
end
UnItems=unique(topnItems);

countLC=0;

% Calculation of LC
for i=1:size(UnItems,2)
    if (any(LongTailItemsPNBlock==UnItems(1,i)))
        countLC=countLC+1;
    end
end
Results(3,1)=countLC/size(LongTailItemsPNBlock,2);

% Calculation APLT and Novelty
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
Results(3,2)=mean(APLTUser);
Results(3,3)=mean(NoveltyUser);

% NDCG Calculation
for user=1:size(Pred,1)
    [pre(user,1),re(user,1),f1score(user,1)]=PreRecF1(Dataset(user,:), topn(user,:));
    nDCGs(user,1)=NDCG(Dataset(user,:), topn(user,:));
end

Results(3,4)=mean(pre);
Results(3,5)=mean(re);
Results(3,6)=mean(f1score);
Results(3,7)=mean(nDCGs);

return
end
