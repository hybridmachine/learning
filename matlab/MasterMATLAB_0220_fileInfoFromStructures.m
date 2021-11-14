%% 
%     COURSE: Master MATLAB through guided problem-solving
%    SECTION: Vectors and variables
%      VIDEO: File/folder information using structures
% Instructor: mikexcohen.com
%
%%

% get information about all files/folders
everything = dir;

% names of all folders
foldernames = {everything([everything.isdir]).name};

% filename lengths
cellfun(@length,foldernames)


% use selective query to extract filenames with *variable*
somethings = dir('*Test*');

%%
