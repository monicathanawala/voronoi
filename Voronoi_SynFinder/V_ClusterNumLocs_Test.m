function [Y, temp_cl] = V_ClusterNumLocs_Test(mList_sub2, ClusterSize, ClusterNum);

Y = struct([]);

[Y(:).numlocs]=deal();
[Y(:).volume] = deal();
Y(1).numlocs = ClusterSize(1,2);

i=2; %need this? 
for i=1:length(ClusterSize);
   Y(1).numlocs(i,1) = ClusterSize(i,2);  
   %gets an error if there are no clusters
end

ClNum=1;
%[Y(1:max(size(ClusterSize))).volume] = deal([]);

for i=1:size(ClusterSize,1); % for each cluster
    temp_cl = zeros(Y.numlocs(i), 3); % preallocate an array to hold xc, yc, and zc values of the cluster's locs
    n=ClusterSize(i,1); %n is cluster ID
    i3=1;
    for i2=1:length(mList_sub2);
        if ClusterNum(i2,1)==n;
            temp_cl(i3,:) = mList_sub2(i2,:);
            i3=i3+1;
        end
    end

         
%        % delaunayTriangulation to determine faces of polygon
    DT_cl = delaunayTriangulation(temp_cl(:,1), temp_cl(:,2), temp_cl(:,3)); 
    if max(temp_cl(:,3))-min(temp_cl(:,3))>.001;
        [K_cl, V_cl] = convexHull(DT_cl);  % this gives us the volume, V_cl, in nm3
        Y.volume(i) = V_cl;
        Y.density(i) = Y.numlocs(i)/V_cl;
    
        center = Centroid(temp_cl); %new on 6/9/16
        Y.xcenter(i) = center(1);
        Y.ycenter(i) = center(2);
        Y.zcenter(i) = center(3);
    end
    
    
end
%Y.numlocs = transpose(Y.numlocs);
Y.volume = transpose(Y.volume);
Y.density = transpose(Y.density);
Y.xcenter = transpose(Y.xcenter);
Y.ycenter = transpose(Y.ycenter);
Y.zcenter = transpose(Y.zcenter);

