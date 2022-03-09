function [windowedtraces,crosscormatrix,lagmatrix,crosscorstd,lagstd,crosscormean,lagmean] = windowedtrace(uf,vf,windowsize,trace)
%%
%
%   Usage:  windowedtrace(uf,vf,windowsize,trace)
%          
%          uf/vf: Reshaped flow vector matrices 
%
%          windowsize: Dimension of windows used for video segmenting (16)
%
%          trace: Resulting waveform from PCA analysis
%          
%          
%          
%   Author: David Ross, Los Alamos National Lab
%   Contact: dross@lanl.gov
%   $Date: 6-15-2021$
%   $Revision: 1.0$
%
%

% Generate windows for segmenting
zeroframe = zeros(480,752);
onesframe = ones(windowsize,windowsize);
uvwindowed = zeros(480/windowsize, 752/windowsize, size(uf,2));
uframed = zeros(windowsize*windowsize,size(uf,2));
vframed = zeros(windowsize*windowsize,size(uf,2));
uvframed = [uframed;vframed];
windowedtraces = zeros(30,47,size(uf,2));

% Create video segments based on video size and perform PCA on each
for i = (1:30)
    for j = (1:47)
        oneswindow = zeroframe;
        oneswindow((i*16)-15:(i*16),(j*16)-15:(j*16))=onesframe(:,:);
        for k = (1:size(uf,2))
            uframed(:,k) = nonzeros(uf(:,k).*reshape(oneswindow,[],1));
            vframed(:,k) = nonzeros(vf(:,k).*reshape(oneswindow,[],1));
            
            

        end
 
        uvframed = [uframed; vframed];
        [V, E] = PCA(uvframed);
        [mrow , mcol] = find(ismember(E, max(E(:))));
        windowedtraces(i,j,:) = V(:,mcol);
% Create crosscorrelation and lag values      
        [crosscor, lag] = xcorr(squeeze(abs(windowedtraces(i,j,:))),abs(trace),'normalized');
        [M, I] = max(crosscor);
        crosscormatrix(i,j) = M;
        lagmatrix(i,j) = lag(I);
        
        
        
    end
disp(i)
end

% Generate lag and cross-correlation matrices from the individual values
crosscorstd = std(crosscormatrix,0,[1 2]);
lagstd = std(lagmatrix,0,[1 2]);
crosscormean = mean(crosscormatrix,'all');
lagmean = mean(lagmatrix,'all');




end

