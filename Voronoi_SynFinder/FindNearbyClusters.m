function [Centroids_ref, Centroids_test, dist_closesttest] = FindNearbyClusters(Y_all, ref, varargin);

% This function helps find clusters of other colors near all clusters of a
% specific cluster. For example, find all clusters of colors 2, 3, 4, and 5
% that are near clusters of color 1. 
% Y_all is the clustering struct that comes out of VoronoiN()
% dist is the max Euclidean distance between clusters
% ref is the number of the channel to use as reference
% varargin are the numbers of the channels to test if they are near color ref
Centroids_ref = [Y_all{1,ref}.xcenter Y_all{1,ref}.ycenter Y_all{1,ref}.zcenter];


for i=1:length(varargin);
    n=varargin{i};
    Centroids_test = [Y_all{1,n}.xcenter Y_all{1,n}.ycenter Y_all{1,n}.zcenter];
    distances = pdist2(Centroids_ref, Centroids_test);
    %distances = sqrt(sum(bsxfun(@minus, Centroids_test, Centroids_ref).^2,2));
    for x=1:size(Centroids_ref, 1);
        loc_closesttest(x,:) = Centroids_test(find(distances(x,:)==min(distances(x,:))),:);
        x1 = Centroids_ref(x, 1);
        y1 = Centroids_ref(x, 2);
        z1 = Centroids_ref(x, 3);
        x2 = loc_closesttest(x, 1);
        y2 = loc_closesttest(x, 2);
        z2 = loc_closesttest(x, 3);
        dist_temp = sqrt((x2-x1)^2 + (y2-y1)^2 + (z2-z1)^2);
        dist_closesttest(x,1) = dist_temp;
    end
    
end
end