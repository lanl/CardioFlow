function [u,v] = pargoflow(im1,im2)
%%
%
%   Usage: pargoflow(im1,im2)
%          im1: Matrix representing the first image of the image pair
%          
%          im2: Matrix representing the second image of the image pair
%          
%  
%   Author: David Ross, Los Alamos National Lab
%   Contact: dross@lanl.gov
%   $Date: 6-15-2021$
%   $Revision: 1.0$
%

% Input images into the optical flow code
uv = estimate_flow_interface(im1, im2, 'classic+nl-fastp');

% Matrices representing the U and V components of the flow vectors
u = uv(:,:,1);
v = uv(:,:,2);



