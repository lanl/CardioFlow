function [] = flowconfigrun(config)
%%
%
%   Usage: flowconfigrun(config) 
%          
%          config: structure containing videoname(video path),
%          outfolder(out path folder), and outlocation(full path with file
%          naming structure) in addition to the "stop" frame number
%          for each video file that needs to be processed.
%          
%   Author: David Ross, Los Alamos National Lab
%   Contact: dross@lanl.gov
%   $Date: 6-15-2021$
%   $Revision: 1.0$
%
%

% Loop through the config file and run parflowrun for each video
for i= 1:length(config)
    vid = importdata(config(i).videoname);
    
    if length(vid) < 721
        stop = length(vid)-1;
    else
        stop = 720;
    end
    
    if ~exist(config(i).outfolder, 'dir')
        mkdir(config(i).outfolder)
    end
    
    parflowrun(vid,1,stop,config(i).outlocation);
    
end
end
    