function PlotDistYM(Dataset)

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

% For all weights
weights=[1 0.8 0.6 0.4 0.2 0];
for w=1:size(weights,2)
    for i=1:size(Pop,2)
        NBlock(w,i)=(1-(weights(1,w)))*NOrt(1,i)+(weights(1,w))*NPop(1,i);
    end
end

SortedNBlock=[];
for i=1:size(NBlock,1)
    [outNBlock,idxNBlock] = sort(NBlock(i,:),'descend');
    SortedNBlock=[SortedNBlock; outNBlock];
end


a1=plot(SortedNBlock(1,:),'DisplayName','w=1');
hold on
a2=plot(SortedNBlock(2,:),'DisplayName','w=0.8');
hold on
a3=plot(SortedNBlock(3,:),'DisplayName','w=0.6');
hold on
a4=plot(SortedNBlock(4,:),'DisplayName','w=0.4');
hold on
a5=plot(SortedNBlock(5,:),'DisplayName','w=0.2');
hold on
a6=plot(SortedNBlock(6,:),'DisplayName','w=0');
legend
title('YM')


return
end
