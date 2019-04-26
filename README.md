# voronoi
Using Voronoi diagrams to cluster single-molecule localization microscopy data to identify and extract important features.
Written by Monica Thanawala, 2016

This is based on the clustering algorithm described as the SR_Tesseler method (Levet et al., Nat Methods 2015).
It is organized to work on multicolor single-molecule localization microscopy (SMLM) data sets.


Getting Started
This version requires two- or three-dimensional data imported into MATLAB. It also requires the function Centroid written by David Legland (https://www.mathworks.com/matlabcentral/profile/authors/127343-david-legland). 
There's an example dataset in : .

Run clustering on the sample dataset by entering:
[mList_clust_all, mList_clust, ClusterNum_clust, Y_all] = VoronoiN(d);

You will get the following plots:
1. the raw data, 
2. pseudo-colored clusters displayed with unclustered points in black, 
3. cleaned-up data showing only clusters, and
4. a silhouette plot and 2D plot of clusters pseudo-colored with silhouette value*

Example plots:


as well as a data structure containing key characteristics of the identified clusters, such as volume, centroid in xyz dimensions, and density. 


*silhouette plots are not the best way to evaluate goodness of clusters that are not expected to be gaussian. For many biological structures, the silhouette values will be poor. However, for other spherical/amorphous clusters, the silhouette plots can be helpful, so I've left them in!

Last updated: April 2019
