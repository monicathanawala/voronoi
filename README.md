# voronoi
Using Voronoi diagrams to cluster single-molecule localization microscopy data to identify and extract important features.
Written by Monica Thanawala, 2016

This is based on the clustering algorithm described as the SR_Tesseler method (Levet et al., Nat Methods 2015).
It is organized to work on multicolor single-molecule localization microscopy (SMLM) data sets saved as binary files.
It is currently written to use two scripts from ZhuangLab/matlab-storm to read in and write binary files that contain the molecule lists. https://github.com/ZhuangLab/matlab-storm


Getting Started
This version requires two- or three-dimensional data imported into MATLAB. There's an example dataset in : .
Run an example analysis by entering:
_______
You will get plots of the raw data, pseudo-colored clusters, cleaned-up data showing only clusters, and a data structure containing key characteristics of the identified clusters, such as volume, centroid in xyz dimensions, and density.
Here we use the density parameter 2x of the average density, based on optimization presented by Levet et al., and confirmed with my own dataset, but this parameter can be tweaked if necessary.


Last updated: April 2019
