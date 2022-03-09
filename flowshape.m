function [xu,xv] = flowshape(label,start,finish,size)
%%
%
%   Usage: flowshape(label,start,finish,size) 
%          
%          label: path to files with file name base included
%          
%          start: Frame to start on, usually 1
%          
%          finish: Frame to finish on
%
%          size: size for matrices
%          
%   Author: David Ross, Los Alamos National Lab
%   Contact: dross@lanl.gov
%   $Date: 6-15-2021$
%   $Revision: 1.0$
%
%

% Initialize matrices
xu = zeros((size(1)*size(2)),length(start:finish));
xv = zeros((size(1)*size(2)),length(start:finish));

% Reshape Matrices
for i = start:finish
    xu(:,i-(start-1)) = reshape(readmatrix(append(label,num2str(i),'u','.txt')),[],1);
    xv(:,i-(start-1)) = reshape(readmatrix(append(label,num2str(i),'v','.txt')),[],1);
end
end

