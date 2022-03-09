function [uvf] = pixelvelocity(uf,vf)
%%
%
%   Usage: pixelvelocity(uf,vf)
%
%          uf/vf: flow vector matrices
%          
%          
%          
%   Author: David Ross, Los Alamos National Lab
%   Contact: dross@lanl.gov
%   $Date: 6-15-2021$
%   $Revision: 1.0$
%
%

uvf = sqrt((uf.^2)+(vf.^2));


end

