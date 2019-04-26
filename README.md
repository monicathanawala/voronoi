# voronoi
Using Voronoi diagrams to cluster single-molecule localization microscopy data to identify and extract important features.
Written by Monica Thanawala, 2016

This is based on the clustering algorithm described as the SR_Tesseler method (Levet et al., Nat Methods 2015).
It is organized to work on multicolor single-molecule localization microscopy (SMLM) data sets.


Getting Started
This version requires two- or three-dimensional data imported into MATLAB. It also requires the function Centroid written by David Legland (https://www.mathworks.com/matlabcentral/profile/authors/127343-david-legland). 
Run an example analysis on your data using the function VoronoiN:

[Y_out] = VoronoiN(data);

_______
You will get plots of the raw data, pseudo-colored clusters, cleaned-up data showing only clusters, and a data structure containing key characteristics of the identified clusters, such as volume, centroid in xyz dimensions, and density.
Here we use the density parameter 2x of the average density, based on optimization presented by Levet et al., and confirmed with my own dataset, but this parameter can be tweaked if necessary.

You will get the following plots:
1. the raw data, 
2. pseudo-colored clusters displayed with unclustered points in black, 
3. cleaned-up data showing only clusters, and
4. a silhouette plot and 2D plot of clusters pseudo-colored with silhouette value*

Example plots:


as well as a data structure containing key characteristics of the identified clusters, such as volume, centroid in xyz dimensions, and density. 


*silhouette plots are not the best way to evaluate goodness of clusters that are not expected to be gaussian. For many biological structures, the silhouette values will be poor. However, for other spherical/amorphous clusters, the silhouette plots can be helpful, so I've left them in!

Last updated: April 2019
