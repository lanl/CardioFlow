function [contractionintervals,relaxationintervals,intervals, ... 
    validintervals,maxindex,minindex,p2ptime,avgcontractiont, ...
    avgrelaxationt, avgmax, avgmin, avgbase2max,avgbase2min, ...
    avgmax2base, avgmin2base, avgtotalt, initcutoff, neg2poscutoff, ...
    pos2negcutoff, maxindexcutoff, minindexcutoff] ...
    = flowdata(trace,fps)
%%
%
%   Usage: flowdata(trace,fps) 
%          
%          trace: Resulting waveform from PCA analysis
%          
%          fps: Frames per second of video input file
%          
%   Author: David Ross, Los Alamos National Lab
%   Contact: dross@lanl.gov
%   $Date: 6-15-2021$
%   $Revision: 1.0$
%
%

% Segregate trace signal into positive and negative values
postrace = max(trace,0);
negtrace = min(trace,0);

% Find peak values
maxval = islocalmax(postrace,'MinProminence',2*std(postrace));
maxindex = find(maxval);

% Find Minimum values
D = mean(diff(maxindex))/2;
minval = islocalmin(negtrace,'MinProminence',abs(.7*min(trace)),'MinSeparation',D);
%minval = islocalmin(negtrace,'MinProminence',abs(3*std(negtrace)),'MinSeparation',D);
minindex = find(minval);


% Isolate potential starts and stops of contraction/relaxation phases
pos2neg = find(trace(1:end-1)>0 & trace(2:end)<0);
neg2pos = find(trace(1:end-1)<0 & trace(2:end)>0);
initcutoff = 0;
finalcutoff = 0;

% Remove information for contractions/relaxations that are not complete
if neg2pos(1) < maxindex(1)
    initcutoff = neg2pos(find(neg2pos<maxindex(1),1,'last'));
else
    initcutoff = neg2pos(find(neg2pos<maxindex(2),1,'last'));
end


if neg2pos(end) > minindex(end)
    finalcutoff = neg2pos(find(neg2pos>minindex(end),1,'first'));
else  
    finalcutoff = neg2pos(find(neg2pos>minindex(end-1),1,'first'));
end

% Calculate relevent time points and values
neg2poscutoff = neg2pos.*(neg2pos>=initcutoff);
pos2negcutoff = pos2neg.*(pos2neg>=initcutoff);
maxindexcutoff = maxindex.*(maxindex>=initcutoff);
minindexcutoff = minindex.*(minindex>=initcutoff);
neg2poscutoff = neg2poscutoff.*(neg2pos<=finalcutoff);
pos2negcutoff = pos2negcutoff.*(pos2neg<=finalcutoff);
maxindexcutoff = maxindexcutoff.*(maxindex<=finalcutoff);
minindexcutoff = minindexcutoff.*(minindex<=finalcutoff);
neg2poscutoff = nonzeros(neg2poscutoff);
pos2negcutoff = nonzeros(pos2negcutoff);
maxindexcutoff = nonzeros(maxindexcutoff);
minindexcutoff = nonzeros(minindexcutoff);


% Create matrix for relevent data and populate them
contractionintervals = zeros(2, length(maxindexcutoff));
relaxationintervals = zeros(2, length(maxindexcutoff));
for i = 1:length(maxindexcutoff)
  if neg2poscutoff(find(neg2poscutoff<maxindexcutoff(i),1,'last'))==real(neg2poscutoff(find(neg2poscutoff<maxindexcutoff(i),1,'last')))
  contractionintervals(1,i) = neg2poscutoff(find(neg2poscutoff<maxindexcutoff(i),1,'last'));
  end
  
  contractionintervals(2,i) = pos2negcutoff(find(pos2negcutoff>maxindexcutoff(i),1,'first'));
  
  relaxationintervals(1,i) = pos2negcutoff(find(pos2negcutoff<minindexcutoff(i),1,'last'));
  
  if neg2poscutoff(find(neg2poscutoff>minindexcutoff(i),1,'first'))==real(neg2poscutoff(find(neg2poscutoff>minindexcutoff(i),1,'first')))
  relaxationintervals(2,i) = neg2poscutoff(find(neg2poscutoff>minindexcutoff(i),1,'first'));
  end
  



end

intervals = [contractionintervals; relaxationintervals; maxindexcutoff.'; ...
minindexcutoff.'; trace(maxindexcutoff).'; trace(minindexcutoff).'];
validintervals = standardizeMissing(intervals,0);
validintervals = rmmissing(validintervals,2);
  
for i = 1:size(validintervals,2)
  contractionframes(i) = validintervals(2,i)-validintervals(1,i);
  relaxationframes(i) = validintervals(4,i)-validintervals(3,i);
  beatduration(i) = validintervals(4,i)-validintervals(1,i);
  base2max(i) = validintervals(5,i)-validintervals(1,i);
  base2min(i) = validintervals(6,i)-validintervals(3,i);
  max2base(i) = validintervals(2,i)-validintervals(5,i);
  min2base(i) = validintervals(4,i)-validintervals(6,i);
  totalframes(i) = validintervals(4,i)-validintervals(1,i);
end
avgcontractiont = mean(contractionframes)/fps;
avgrelaxationt = mean(relaxationframes)/fps;
avgmax = mean(validintervals(7,:));
avgmin = mean(validintervals(8,:));
avgbase2max = mean(base2max)/fps;
avgbase2min = mean(base2min)/fps;
avgmax2base = mean(max2base)/fps;
avgmin2base = mean(min2base)/fps;
avgtotalt = mean(totalframes)/fps;
p2pframes = mean(diff(validintervals(5,:)));
p2ptime = p2pframes/fps;



  