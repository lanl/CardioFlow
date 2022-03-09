function [u,v] = goflow(im1,im2)
%%
%
%   Usage:  goflow(im1,im2)
%          
%          im1: the first image for flow comparison
%
%          im2: the second image for flow comparison
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

% Perfom optical flow analysis on im1 and im2
uv = estimate_flow_interface(im1, im2, 'classic+nl-fastp');
u = uv(:,:,1);
v = uv(:,:,2);
clear mex
toc


