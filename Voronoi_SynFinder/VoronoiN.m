function [Y_all] = VoronoiN(d);

for ROI=1:size(d, 1);
    for i=1:size(d, 2);
        [mList_sub, mList_sub2] = GetXYZC_N(d{ROI,i});
        [mList_xy, area, DT, neighbors, neighbors_counts, visited, ClusterNum, ClusterSize] = VoronoiClusters(mList_sub2); %only running on subset in one color
        [Y, temp_cl] = V_ClusterNumLocs_Test(mList_sub2, ClusterSize, ClusterNum); %new on 6/20/17
        [ClusterNum, ClNum_unique] = RandomColorToCluster(mList_xy, ClusterNum, Y, .00001); %This chooses final clusters over a minimum volume and number of locs and assigns them a random color
        [mList_clust, ClusterNum_clust] = ClustOnly(mList_xy, ClusterNum);
        mList_clust_all{ROI,i} = mList_clust;
        Y_all{ROI,i} = Y;
        
        display(['Processed ROI ' num2str(ROI) ', channel ' num2str(i)]);
        
        figure();
        scatter(mList_xy(:,1), mList_xy(:,2), [], ClusterNum(:,2:4), '.'); %This will show clusters each in a color (with repeats), and non-included locs in white.
        whitebg('white');
        set(gcf, 'Color', 'white');
        daspect([1 1 1]);
        title('\color{white}2D Voronoi Clusters c1');
        xlabel('nm x 10^4');
        ylabel('nm x 10^4');
    end
end

%next thing to write--regrouping this data with its associated other mList
%parameters so that it can be written into a .bin file and viewed in
%Insight3.

end

