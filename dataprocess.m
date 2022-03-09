function [] = dataprocess(filenamein,filenameout,fps,start,finish)
%%
%
%   Usage: dataprocess(filenamein,filenameout,fps,start,finish)
%          filenamein: Path to input file
%          
%          filenameout: Desired path for output file location
%
%          fps: Video frames per second
%          
%          start: Frame to start on, usually 1
%          
%          finish: Frame to finish on
%          
%   Author: David Ross, Los Alamos National Lab
%   Contact: dross@lanl.gov
%   $Date: 6-15-2021$
%   $Revision: 1.0$
%
%

% Send U and V matrices to flowshape to reshape each frame into a column
[uf, vf] = flowshape(filenamein,start,finish, [480 752]);

% Combine U and V matrices
uvf = [uf;vf];

% Perform PCA on combined matrix
[V, E] = PCA(uvf);

[mrow , mcol] = find(ismember(E, max(E(:))));

trace = V(:,mcol);

% Attempts to infer contraction vs relaxation based on the strength +/-
maxval = islocalmax(trace,'MinProminence',.7*max(trace));
minval = islocalmin(trace,'MinProminence',abs(.7*min(trace)));
if abs(mean(trace(maxval).')) < abs(mean(trace(minval).'))
    trace = -trace;
end

% Saves intermediate data in case of crash/failure
save(append(filenameout,'.mat'),'trace','uf','vf','-v7.3')

% Sends trace to flowdata
[contractionintervals,relaxationintervals,intervals, ... 
    validintervals,maxindex,minindex,p2ptime,avgcontractiont, ...
    avgrelaxationt, avgmax, avgmin, avgbase2max,avgbase2min, ...
    avgmax2base, avgmin2base, avgtotalt] = flowdata(trace,fps);

% Saves outputs from flowdata
save(append(filenameout,'data.mat'), 'contractionintervals','relaxationintervals','intervals', ...
'validintervals','maxindex','minindex','p2ptime','avgcontractiont', ...
'avgrelaxationt', 'avgmax', 'avgmin', 'avgbase2max','avgbase2min', ...
'avgmax2base', 'avgmin2base', 'avgtotalt','trace');

