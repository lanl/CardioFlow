function [] = flowrun(vid,start,finish,outloc)
%%
%
%   Usage: flowrun(vid,start,finish,outloc)
%          
%          vid: video structure 
%
%          start: start frame number
%
%          finish: end frame number
%
%          outloc: output file location
%          
%          
%          
%   Author: David Ross, Los Alamos National Lab
%   Contact: dross@lanl.gov
%   $Date: 6-15-2021$
%   $Revision: 1.0$
%
%
for i = start:finish
flowproc(vid,i,i+1,outloc)
end



