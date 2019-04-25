function [ClusterNum, ClNum_unique] = RandomColorToCluster(mList_xy, ClusterNum, Y, vol);

colors = [1 1 0 ; 1 0 1 ; 0 1 1; 1 0 0; 0 0 1; 0 1 0];

ClNum_unique = zeros(length(unique(ClusterNum(:,1))), 4);
ClNum_unique(:,1) = (unique(ClusterNum(:,1))); 

%ClNum_unique(1,2:4) = [1 1 1]; %make unclustered locs white
ClNum_unique(1,2:4) = [0 0 0]; %make unclustered locs black

SVlog=false(max(length(ClNum_unique)));

if length(ClNum_unique)>2;
    for i=2:max(length(ClNum_unique)); %changed from 6 to 2 7/5/17
        if (sum(ClusterNum(:,1) == ClNum_unique(i))>1); 
            if Y.volume(i-1)>vol;
                SVlog(i)=1;
                ClNum_unique(i,2:4) = colors(randi(6),:);
            else
                %ClNum_unique(i,2:4) = [1 1 1]; % make locs white
                ClNum_unique(i,2:4) = [0 0 0]; % make locs black
                SVlog(i)=0;
            end
        else
            %ClNum_unique(i,2:4) = [1 1 1]; % make locs white
                ClNum_unique(i,2:4) = [0 0 0]; % make locs black
                SVlog(i)=0;
        end
    end
    
    % add three columns to ClNum;
    %Cl_Num_color = zeros(length(ClusterNum), 3);
    %ClusterNum = [ClusterNum Cl_Num_color];

    for i=1:length(ClusterNum);
        index = find(ClNum_unique(:,1)==ClusterNum(i,1));
        ClusterNum(i,2:4) = ClNum_unique(index, 2:4);
    end    

    TF1 = ClNum_unique(:,2)==1 ;
    TF2 = ClNum_unique(:,3)==1 ;
    TF3 = ClNum_unique(:,4)==1 ;
    % combine them
    TFall = TF1 & TF2 & TF3;
    display(['Unique clusters: ' num2str(length(ClNum_unique) - sum(TFall(:)==1))]); 

    TF4 = ClusterNum(:,2)==1 ;
    TF5 = ClusterNum(:,3)==1 ;
    TF6 = ClusterNum(:,4)==1 ;
    % combine them
    TFall2 = TF4 & TF5 & TF6;
    display(['Total molecules: ' num2str(length(ClusterNum) - sum(TFall2(:)==1))]);
    
  
else
    return
end

end
    
    
