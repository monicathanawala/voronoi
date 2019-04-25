% Voronoi_SynFinder
%
%%
% Author: Monica Thanawala Sellon
% Research Group: Xiaowei Zhuang Group, Chemistry and Chemical Biology,
% Harvard University

%%
% This code identifies clusters in multi-color three-dimensional STORM
% images using Voronoi tesselation in 2 dimensions (x and y).
% The application here is to find synapses in mammalian neurons and brain
% tissue, but it has been applied to other biological problems effectively
% as well.


% Files
% -----

% GetXYZC_2d: 
% GetXYZC_N:
% neighborsList:
% VoronoiClusters:
% RandomColorToCluster:
% V_ClusterNumLocs_Test:
% RunVoronoi2: an early version I wrote to deal with 2-color multiactivator
%   (simultaneous multicolor) experiments as well as single-color and multi-color multireporter. 
% VoronoiN: a simplified version to run exclusively on single-color
%   experiments, either alone or taken in series with other color. Can run on N colors. 


% Last updated: April 2019