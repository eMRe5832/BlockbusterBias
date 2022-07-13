function []=CreateNonPersonalized()

%% Creating Random Predictions
userNumber=3278;
ItemNumber=1351;
RatingNumber=userNumber*ItemNumber;
Random=zeros(RatingNumber,3);
row=1;
for i=1:userNumber
    fprintf('%d \n',i);
    for k=1:ItemNumber
        Random(row,1)=i;
        Random(row,2)=k;
        Random(row,3)=rand()*5;
        row=row+1;
    end
end

%% Creating MostPop Predictions
userNumber=3278;
ItemNumber=1351;
RatingNumber=userNumber*ItemNumber;
MostPop=zeros(RatingNumber,3);
row=1;
for i=1:ItemNumber
    fprintf('%d \n',i);
    index=find(LastCiao(:,2)==i);
    Rating=size(a,1);
    for k=1:userNumber
        MostPop(row,1)=k;
        MostPop(row,2)=i;
        MostPop(row,3)=Rating;
        row=row+1;
    end
end

%% Creating ItemAVG Predictions
userNumber=3278;
ItemNumber=1351;
RatingNumber=userNumber*ItemNumber;
ItemAVG=zeros(RatingNumber,3);
row=1;
for i=1:ItemNumber
    allRatings=[];
    fprintf('%d \n',i);
    index=find(LastCiao(:,2)==i);
    for item=1:size(index,1)
        allRatings=[allRatings; LastCiao(index,:)];
    end
    Rating=mean(allRatings(:,3));
    for k=1:userNumber
        ItemAVG(row,1)=k;
        ItemAVG(row,2)=i;
        ItemAVG(row,3)=Rating;
        row=row+1;
    end
end

return
end
