function [mList_xy, area, DT, neighbors, neighbors_counts, visited, ClusterNum, ClusterSize] = VoronoiClusters(mList_1_sub2);

% adapted from SR_Tesseler paper (Levet et al, Nat Methods 2015
% and Hazen Babcock's 2016 Python implementation

%[mList_1, a, mList_1_sub, b, mList_1_sub2, c] = GetXYZC_2(dirPath, binfile);
%mList = ReadMasterMoleculeList([dirPath,binfile]);

%use this block if input is sub2 array
mList_xy = zeros(length(mList_1_sub2),2);
mList_xy(:, 1) = mList_1_sub2(:,1);
mList_xy(:, 2) = mList_1_sub2(:,2);

%use this block if input is struct
%mList_xy = zeros(length(mList.x),2);
%mList_xy(:, 1) = mList.xc;
%mList_xy(:, 2) = mList.yc;

%use this line if input is Nx2 array
%mList_xy = P;

DT = delaunayTriangulation(mList_xy(:,1),mList_xy(:,2));
[vv,vc] = voronoiDiagram(DT);

d=zeros(length(vc), 1); % vector to hold densities of Voronoi polygons
area=zeros(length(vc), 1); % vector to hold areas of Voronoi polygons
ClusterSize = zeros(20000,2);
for i = 1:length(vc); % for all voronoi polygons 
    vxy = zeros(numel(vc{1,1}),2); 
    for i2 = 1:numel(vc{i,1}); % for each vertex of a polygon i
        vxy(i2, 1) = vv(vc{i,1}(i2), 1);
        vxy(i2, 2) = vv(vc{i,1}(i2), 2);    
    end
    area(i)=polyarea(vxy(:,1), vxy(:,2));
    d(i)=1/area(i);
end

max_neighbors = 40;
neighbors = NaN(length(mList_xy), max_neighbors, 'single');
neighbors_counts = ones(length(mList_xy), 1, 'int32');

% Calculate neighbors from DT
for i = 1:length(DT.ConnectivityList);
    p1 = DT.ConnectivityList(i,1);
    p2 = DT.ConnectivityList(i,2);
    p3 = DT.ConnectivityList(i,3);
   
    % Add p2 and p3 to the list for p1
    if ismember(p2, neighbors(p1,:))==0;
        neighbors(p1, neighbors_counts(p1)) = p2;
        neighbors_counts(p1)=neighbors_counts(p1)+1;
    end
    if ismember(p3, neighbors(p1,:))==0;
        neighbors(p1, neighbors_counts(p1)) = p3;
        neighbors_counts(p1)=neighbors_counts(p1)+1;
    end
    
    %Add p1 and p3 to the list for p2
    if ismember(p1, neighbors(p2,:))==0;
        neighbors(p2, neighbors_counts(p2)) = p1;
        neighbors_counts(p2)=neighbors_counts(p2)+1;
    end
    if ismember(p3, neighbors(p2,:))==0;
        neighbors(p2, neighbors_counts(p2)) = p3;
        neighbors_counts(p2)=neighbors_counts(p2)+1;
    end
        
    %Add p1 and p2 to the list for p3
    if ismember(p1, neighbors(p3,:))==0;
        neighbors(p3, neighbors_counts(p3)) = p1;
        neighbors_counts(p3)=neighbors_counts(p3)+1;
    end
    if ismember(p2, neighbors(p3,:))==0;
        neighbors(p3, neighbors_counts(p3)) = p2;
        neighbors_counts(p3)=neighbors_counts(p3)+1;
    end
    % added 12/20 to print the number of points processed to command window
    % so I know things are still running
    if mod(i,10000)==0;
        display(['Voronoi clustering: ' num2str(i) ' out of ' num2str(length(DT.ConnectivityList)) ' points processed ']);
    end
end

% Mark connected points that meet minimum density requirements
% mList_xy.lk = -1;
TF = ~isnan(area);
area_sub = area(TF);
max_area = 0.5*(median(area_sub)); %changed 4/24 to reflect 2x median density of image
%max_area = V_thresh;
visited = zeros(length(mList_xy), 1, 'int32');
min_size=10; % min number of points to be marked as a cluster

%% Second section

ClusterNum = zeros(length(mList_xy),1);
cluster_id = 2;
  for i=1:length(mList_xy); % for each localization
    if (visited(i)==0); %if you haven't visited it yet
       if area(i)<max_area; % and if its polygon is sufficiently small
           cluster_elt = i; % start a cluster
            c_size = 1; % cluster size is initially 1
            visited(i) = 1; % mark that localization as visisted
            % make a list of the neighbors of localization i, which comes
            % from "neighbors" and has a length "neighbors_counts - 1"
            [to_check] = neighborsList(i, neighbors, neighbors_counts, visited); 
            while(length(to_check)>1);  
                loc_index = to_check(end); % put the last loc in to_check as the loc_index
                to_check = to_check(1:end-1); % remove last localization from the list
                
                if area(loc_index)<max_area; % if the neighbor "loc_index" has a small associated polygon
                    % add all of loc_index's neighbors to the list to_check
                    to_check = [to_check neighborsList(loc_index, neighbors, neighbors_counts, visited)];
                    cluster_elt = [cluster_elt loc_index]; %add loc_index to the list
                    %c_size = c_size + 1; % increase the size of cluster by 1
                end
                
                visited(loc_index)=1; %Mark loc_index as visited
            end
                    
                % Mark the cluster if there are enough localizations in the
                % cluster.
            cluster_elt=unique(cluster_elt);
            c_size = length(cluster_elt);
            if (c_size > min_size);
                %cluster_id, c_size
                display(['Cluster ID: ' num2str(cluster_id) '; cluster size: ' num2str(c_size) ' points  ']);
                for i3 = 1:(length(cluster_elt));
                    ClusterNum(cluster_elt(i3)) = cluster_id;
                end
                ClusterSize(cluster_id, 1) = cluster_id;
                ClusterSize(cluster_id, 2) = c_size;
            end
            
            cluster_id=cluster_id+1;
            
       else
           visited(i) = 1;
          
       end 
        
    end
end
ClusterSize(all(ClusterSize==0,2),:)=[];        
                          
end
       





