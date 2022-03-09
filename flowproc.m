function [] = flowproc(vid,im1,im2,outloc)
%%
%
%   Usage: flowproc(vid,im1,im2,outloc)
%          
%          vid: video structure 
%
%          im1: first image for comparison
%
%          im2: second image for comparison
%
%          outloc: file location for output
%          
%          
%          
%   Author: David Ross, Los Alamos National Lab
%   Contact: dross@lanl.gov
%   $Date: 6-15-2021$
%   $Revision: 1.0$
%
%
tic



[u,v] = goflow(vid(im1).cdata,vid(im2).cdata);

writematrix(u,append(outloc,num2str(im1),'u.txt'));
writematrix(v,append(outloc,num2str(im1),'v.txt'));


toc


