function [MListClust, ClusterNumClust] = ClustOnly(MList, ClusterNum);

%This function can be used to generate a shorter molecule list (MListClust)
%and ClusterNum array (ClusterNumClust) which correspond only to
%localizations that fall within clusters as definted by Voronoi or OPTICS
%analysis. This is useful for display purposes--otherwise the many
%unclustered localizations which display in black or white can obscure the
%clustered localizations that display in a different color.

ClusterNumClust = ClusterNum;
MListClust = MList;
TF = ClusterNumClust(:,1)==0;
ClusterNumClust(TF,:) = [];
MListClust(TF,:) = [];

figure();
[s, h]=silhouette(MListClust, ClusterNumClust(:,1), 'Euclidean');

figure();
scatter(MListClust(:,1), MListClust(:,2), 1, s);
daspect([1 1 1]);


end
    
    