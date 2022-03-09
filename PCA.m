function [V,E] = PCA(xuv)
%%
%
%   Usage: PCA(xuv)
%          
%          xuv: combined u and v flow matrices
%          
%          
%          
%   Author: David Ross, Los Alamos National Lab
%   Contact: dross@lanl.gov
%   $Date: 6-15-2021$
%   $Revision: 1.0$
%
%
C = cov(xuv);
[V,E] = eig(C);


end

