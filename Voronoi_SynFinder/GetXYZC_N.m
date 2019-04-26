 function [mList_1_sub, mList_1_sub2] = GetXYZC_N(mListName, varargin)
%--------------------------------------------------------------------------
% 05/06/2016 Monica Thanawala, edited 8/21/17 MT to accept arrays OR structs
% This function takes one or more inputs (molecule list(s) which is/are Nx18) and
%    produces the following outputs:
%edited on 4/18/19 to not accept multiactivator molecule lists. Only
%single-color molecule lists. Intend to use this to run on oligoSTORM
%experiments by looping for each color.
%--------------------------------------------------------------------------

% Read in the molecule lists, determine if they are struct or numeric arrays

if isstruct(mListName) & nargin==1;
    mList = single([[mListName.x] [mListName.y] [mListName.xc] [mListName.yc] [mListName.h] [mListName.a] ...
      [mListName.w] [mListName.phi] [mListName.ax] [mListName.bg] [mListName.i] single([mListName.c]) ...
        single([mListName.density]) single([mListName.frame]) single([mListName.length]) single([mListName.link]) [mListName.z] ...
         [mListName.zc]]);

    NumMolecules = sum(mListName.c(:) == 1);

    % Make numeric arrays corresponding to molecules in channel 1
    mList_1 = mList(:,1:18);


elseif isnumeric(mListName) & nargin==1;
    mList = single(mListName);
    NumMolecules = sum(mList(:,12) == 1);
    
    % Make numeric arrays corresponding to molecules in channel 1 and channel 2
    mList_1 = mList
    
else
    error ('error');
end

%% Define the subregion for clustering analysis in pixels. Choose 0 and 256
% if you want full image

xmin=0;
xmax=256;
ymin=0;
ymax=256;

i3=1;


% can I do this faster with logical indexing? I think so
mList_1_sub = mList_1;

over_xmin = mList_1(:,1) >=xmin;
under_xmax = mList_1(:,1) <=xmax;
over_ymin = mList_1(:,2) >=ymin;
under_ymax = mList_1(:,2)<=ymax;
in_range = over_xmin & under_xmax & over_ymin & under_ymax;
mList_1_sub(~in_range,:) = []; 


%%

% delete any rows from subregion arrays that are empty
mList_1_sub(~any(mList_1_sub,2), :) = [];  

% Scaling factor to convert values from bin list (pixels in x and y) to
% micron
sc = [.167,.167,.167,.167,1,1,1,1,1,1,1,1,1,1,1,1,.001,.001]; %changed for STORM1 and to scale z 4/23/19

% Scale x and y data from pixels to nm
mList_1_sub = bsxfun(@times,mList_1_sub,sc);

% Make c1x3 and c2x3 matrices for clustering analysis
% the sub2 arrays have xc, yc, and zc information.
mList_1_sub2 = mList_1_sub(:,[3 4 18]);

figure();
scatter(mList_1(:,1), mList_1(:,2), 'm.'); hold on
legend('mList 1');
daspect([1 1 1]);

figure();
scatter(mList_1_sub2(:,1), mList_1_sub2(:,2), 'm.'); hold on
legend('mList1 ROI');
 daspect([1 1 1]);
