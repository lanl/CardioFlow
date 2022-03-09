function [] = parflowrun(vidin,start,finish,outloc)
%%
%
%   Usage: parflowrun(vidin,start,finish,outloc)
%          vidin: Path to video file.
%          
%          start: Number indicating the starting frame. Normally 1.
%          
%          finish: Number indicating the ending frame -1. Normally N-1
%          where N is the total number of frames.
%          
%          outloc: Path to output.
%   
%  
%   Author: David Ross, Los Alamos National Lab
%   Contact: dross@lanl.gov
%   $Date: 6-15-2021$
%   $Revision: 1.0$
%

%tic
% Desired number of cores
M = 12;

vidin2 = vidin;

%Systematically input video frame pairs into parflowproc
parfor (i = start:finish, M)
im1 = vidin(i).cdata;
im2 = vidin2(i+1).cdata;
parflowproc(im1, im2, i, outloc)

end
%toc


