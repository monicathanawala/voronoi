 function [mList_1, mList_2, mList_1_sub, mList_2_sub, mList_1_sub2, mList_2_sub2] = GetXYZC_2d(mListName, varargin)
%--------------------------------------------------------------------------
% 05/06/2016 Monica Thanawala, edited 8/21/17 MT to accept arrays OR structs
% This function takes one or more inputs (molecule list(s) which is/are Nx18) and
%    produces the following outputs:

% 
% mList_1 and mList_2: a molecule list that contains all 18 parameters for
%    2 channels 
% mList_1_sub and mList_2_sub: subsets of molecule lists defined by
% x and y ranges for 2 channels
%--------------------------------------------------------------------------

% Read in the molecule lists, determine if they are struct or numeric arrays, and if there 
% are one or two colors, and get 'single' numeric arrays of each molecule list as


if isstruct(mListName) & nargin==1;
    mList = single([[mListName.x] [mListName.y] [mListName.xc] [mListName.yc] [mListName.h] [mListName.a] ...
      [mListName.w] [mListName.phi] [mListName.ax] [mListName.bg] [mListName.i] single([mListName.c]) ...
        single([mListName.density]) single([mListName.frame]) single([mListName.length]) single([mListName.link]) [mListName.z] ...
         [mListName.zc]]);

    NumMolecules_c1 = sum(mListName.c(:) == 1);
    NumMolecules_c2 = sum(mListName.c(:) == 2);

    % Make numeric arrays corresponding to molecules in channel 1 and channel 2
    mList_1 = zeros(NumMolecules_c1, 19);
    mList_2 = zeros(NumMolecules_c2, 19);

    i1=1;
    i2=1;

        if NumMolecules_c2~=0;
            for i= 1:length(mListName.c);
                if mListName.c(i) == 1;
                    mList_1(i1, 1:18) = mList(i, 1:18);
                    %mList_1(i1, 19) = i;
                    i1=i1+1;
                elseif mListName.c(i) == 2;
                    mList_2(i2, 1:18) = mList(i, 1:18);
                    %mList_2(i1, 19) = i;
                    i2=i2+1;
                end
            end
        else
            mList_1 = mList(:,1:18);
        end
        
elseif isstruct(mListName) & nargin==2;
    mList_1 = single([[mListName.x] [mListName.y] [mListName.xc] [mListName.yc] [mListName.h] [mListName.a] ...
      [mListName.w] [mListName.phi] [mListName.ax] [mListName.bg] [mListName.i] single([mListName.c]) ...
        single([mListName.density]) single([mListName.frame]) single([mListName.length]) single([mListName.link]) [mListName.z] ...
         [mListName.zc]]);
     
    mList_2 = single([[varargin{1}.x] [varargin{1}.y] [varargin{1}.xc] [varargin{1}.yc] [varargin{1}.h] [varargin{1}.a] ...
      [varargin{1}.w] [varargin{1}.phi] [varargin{1}.ax] [varargin{1}.bg] [varargin{1}.i] single([varargin{1}.c]) ...
        single([varargin{1}.density]) single([varargin{1}.frame]) single([varargin{1}.length]) single([varargin{1}.link]) [varargin{1}.z] ...
         [varargin{1}.zc]]);
     
    NumMolecules_c1 = sum(mListName.c(:) == 1);
    NumMolecules_c2 = sum(varargin{1}.c(:) == 1);

elseif isnumeric(mListName) & nargin==1;
    mList = single(mListName);
    NumMolecules_c1 = sum(mList(:,12) == 1);
    NumMolecules_c2 = sum(mList(:,12) == 2);
    
    % Make numeric arrays corresponding to molecules in channel 1 and channel 2
    mList_1 = zeros(NumMolecules_c1, 19);
    mList_2 = zeros(NumMolecules_c2, 19);
    
elseif isnumeric(mListName) & nargin==2;
    mList_1 = single(mListName);
    mList_2 = single(varargin{1});
    NumMolecules_c1 = length(mList_1);
    NumMolecules_c2 = length(mList_2);
else
    error ('error');
end

%% Define the subregion for clustering analysis in pixels. Choose 0 and 256
% if you want full image

xmin=120;
xmax=200;
ymin=70;
ymax=130;

i3=1;


% can I do this faster with logical indexing? I think so
mList_1_sub = mList_1;

over_xmin = mList_1(:,1) >=xmin;
under_xmax = mList_1(:,1) <=xmax;
over_ymin = mList_1(:,2) >=ymin;
under_ymax = mList_1(:,2)<=ymax;
in_range = over_xmin & under_xmax & over_ymin & under_ymax;
mList_1_sub(~in_range,:) = []; 


mList_2_sub = mList_2;
over_xmin = mList_2(:,1) >=xmin;
under_xmax = mList_2(:,1) <=xmax;
over_ymin = mList_2(:,2) >=ymin;
under_ymax = mList_2(:,2)<=ymax;
in_range = over_xmin & under_xmax & over_ymin & under_ymax;
mList_2_sub(~in_range,:) = [];

%% commented out 4/18 to replace with logical indexing
% preallocate arrays
%mList_1_sub = zeros(NumMolecules_c1, 18);
%mList_2_sub = zeros(NumMolecules_c2, 18);

%for i= 1:length(mList_1);
%    if mList_1(i,1)>=xmin && mList_1(i,2)>=ymin;
%        if mList_1(i,1)<=xmax && mList_1(i,2)<=ymax;
%            mList_1_sub(i3, 1:18) = mList_1(i, 1:18);
%             i3=i3+1;
%        end
%    end
%end

%i3=1;
%for i= 1:length(mList_2);
%    if mList_2(i,1)>=xmin && mList_2(i,2)>=ymin;
%        if mList_2(i,1)<=xmax && mList_2(i,2)<=ymax;
%            mList_2_sub(i3, 1:18) = mList_2(i, 1:18);
%             i3=i3+1;
%        end
%    end
%end

%% added 10/9/2018 for a test of whether GetXYZC2d is slow because of subregion picking
%mList_1_sub=mList_1;
%mList_2_sub=mList_2;

% delete any rows from subregion arrays that are empty
mList_1_sub(~any(mList_1_sub,2), :) = [];  
mList_2_sub(~any(mList_2_sub,2), :) = [];  

% Scaling factor to convert values from bin list (pixels in x and y) to nm
sc = [167,167,167,167,1,1,1,1,1,1,1,1,1,1,1,1,1,1]; %changed for STORM1 6/19/17

% Scale x and y data from pixels to nm
%mList_1_sub = bsxfun(@times,mList_1_sub,sc);
%mList_2_sub = bsxfun(@times,mList_2_sub,sc);

% Make c1x3 and c2x3 matrices for clustering analysis
% the sub2 arrays have xc, yc, and zc information.
mList_1_sub2 = mList_1_sub(:,[3 4 18]);
mList_2_sub2 = mList_2_sub(:,[3,4,18]);

figure();
scatter(mList_1(:,1), mList_1(:,2), 'm.'); hold on
scatter(mList_2(:,1), mList_2(:,2), 'c.'); 
legend('mList 1','mList 2');
daspect([1 1 1]);

figure();
scatter(mList_1_sub2(:,1), mList_1_sub2(:,2), 'm.'); hold on
scatter(mList_2_sub2(:,1), mList_2_sub2(:,2), 'c.'); 
legend('mList1 ROI','mList2 ROI');
 daspect([1 1 1]);
