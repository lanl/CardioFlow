function [F] = flowvid(vid,trace,u,v)
%%
%
%   Usage:  flowvid(vid,trace,u,v)
%          
%          vid: Video structure of intended video file
%
%          trace: Resulting waveform from PCA analysis
%
%          u/v: Flow vector matrices
%          
%          
%          
%   Author: David Ross, Los Alamos National Lab
%   Contact: dross@lanl.gov
%   $Date: 6-15-2021$
%   $Revision: 1.0$
%
%
clf
close all
sz = size(u);
fh = figure('Renderer','painters','Position',[10 10 980 772]) ;
%F(sz(2)) = struct('cdata',[]);
write = VideoWriter('test.avi');
write.FrameRate = 60;
open(write)
for i = 1:sz(2)
   ushape(:,:) = reshape(u(:,i), 480, 752);
   vshape(:,:) = reshape(v(:,i), 480, 752);
   uv(:,:,1) = ushape;
   uv(:,:,2) = vshape;
   

   
   sfh1 = subplot(3,1,1);

   image(vid(i).cdata)
    
   set(gca,'visible','off')
   set(gca,'xtick',[])
   set(gca,'ytick',[])
  
   sfh2 = subplot(3,1,2);
   
   plotflow(uv)
   set(gca,'visible','off')
   set(gca,'xtick',[])
   set(gca,'ytick',[])
 
   sfh3 = subplot(3,1,3);
   
   plot(trace(1:i))
   set(gca,'yticklabel',[])
   set(gca,'xticklabel',[])
   axis([0 610 -.1 .3])
   sfh1.Position = [0.21 .55 .55 .45];
   sfh2.Position = [0.013    0.1   0.95    0.45]; 
   sfh3.Position = [0.21 0.0 0.55 .1];
  
   Fcur = getframe(gcf);
   writeVideo(write,Fcur);
   
   %F(i).cdata = im2frame(Fcur.cdata);
   %saveas(gcf,append('C:\Users\350762\Documents\Data\Heart Beating Vids\practice\practice',num2str(i),'.jpg'))
   clf
  
   
end
close(fh)
close(write)
