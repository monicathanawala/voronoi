[mList_1, mList_2, mList_1_sub, mList_2_sub, mList_1_sub2, mList_2_sub2] = GetXYZC_2d(d{1,1}, d{1,4});
x=.025 %smaller values give larger/more permissive clustering, find a default value with good rationale
V_thresh=1600/(x*length(d{1,1}.xc));
[mList_xy_1, area, DT_1, neighbors, neighbors_counts, visited, ClusterNum_1, ClusterSize_1] = VoronoiClusters(mList_1_sub2, V_thresh); %only running on subset in one color
[mList_xy_2, area, DT_2, neighbors, neighbors_counts, visited, ClusterNum_2, ClusterSize_2] = VoronoiClusters(mList_2_sub2, V_thresh); %only running on subset in one color
[Y1, temp_cl] = V_ClusterNumLocs_Test(mList_1_sub2, ClusterSize_1, ClusterNum_1); %new on 6/20/17
[Y2, temp_cl] = V_ClusterNumLocs_Test(mList_2_sub2, ClusterSize_2, ClusterNum_2); %new on 6/20/17
[ClusterNum_1, ClNum_unique_1] = RandomColorToCluster(mList_xy_1, ClusterNum_1, Y1, 10); %This chooses final clusters over a minimum # of locs and assigns them a random color
[ClusterNum_2, ClNum_unique_2] = RandomColorToCluster(mList_xy_2, ClusterNum_2, Y2, 10); %This chooses final clusters over a minimum # of locs and assigns them a random color 
%originally I ran this function without a minimum # of locs--just assigned all clusters a color no matter what the size.

figure();
scatter(mList_xy_1(:,1), mList_xy_1(:,2), [], ClusterNum_1(:,2:4), '.'); %This will show clusters each in a color (with repeats), and non-included locs in white.
whitebg('white');
set(gcf, 'Color', 'white');
daspect([1 1 1]);
title('\color{white}2D Voronoi Clusters c1')
xlabel('nm x 10^4')
ylabel('nm x 10^4')

figure();
scatter(mList_xy_2(:,1), mList_xy_2(:,2), [], ClusterNum_2(:,2:4), '.'); %This will show clusters each in a color (with repeats), and non-included locs in white.
whitebg('white');
set(gcf, 'Color', 'white');
daspect([1 1 1]);
title('\color{white}2D Voronoi Clusters c1')
xlabel('nm x 10^4')
ylabel('nm x 10^4')

%figure();
%scatter(mList_xy_2(:,1), mList_xy_2(:,2), [], ClusterNum_2(:,2:4), '.'); %This will show clusters each in a color (with repeats), and non-included locs in white.
%whitebg('white');
%set(gcf, 'Color', 'white');
%daspect([1 1 1]);
%title('\color{white}2D Voronoi Clusters c2')
%xlabel('nm x 10^4')
%ylabel('nm x 10^4')

[mList_1_clust, ClusterNum_1_clust] = ClustOnly(mList_xy_1, ClusterNum_1);
[mList_2_clust, ClusterNum_2_clust] = ClustOnly(mList_xy_2, ClusterNum_2);

figure();
scatter(mList_1_clust(:,1), mList_1_clust(:,2), 'm.'); hold on
scatter(mList_2_clust(:,1), mList_2_clust(:,2), 'c.'); 
daspect([1 1 1]);

%next thing to write--regrouping this data with its associated other mList
%parameters so that it can be written into a .bin file and viewed in
%Insight3.

