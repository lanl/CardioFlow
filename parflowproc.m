function [] = parflowproc(im1,im2,i,outloc)
%%
%
%   Usage: parflowproc(im1,im2,i,outloc)
%          im1: The initial image for comparison. In the form of a matlab
%          image structure. example--> yourimage.cdata
%          
%          im2: The second image for comparison. In the form of a matlab
%          image structure. example--> yourimage.cdata
% 
%          i: number carried over from parflowrun used to name the output
%          file.
%
%          outloc: path to desired location
%  
%   Author: David Ross, Los Alamos National Lab
%   Contact: dross@lanl.gov
%   $Date: 6-15-2021$
%   $Revision: 1.0$




[u,v] = pargoflow(im1,im2);

writematrix(u,append(outloc,num2str(i),'u.txt'));
writematrix(v,append(outloc,num2str(i),'v.txt'));


