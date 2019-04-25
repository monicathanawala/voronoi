function [nlist] = neighborsList(index, neighbors, neighbors_counts, visited); 
nlist = [];   
for i=1:neighbors_counts(index)-1; %for each of i neighbors of the localization at index
       
    loc_index = neighbors(index,i); 
    if visited(loc_index)==0; % if neighbor has not been visited yet
       nlist=[nlist neighbors(index,i)]; % add it to the list called nlist
       visited(loc_index) = 1; % mark that neighbor as visited
    end
end
end
            

