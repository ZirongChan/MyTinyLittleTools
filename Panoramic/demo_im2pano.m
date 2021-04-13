%lenovo video
close all
clear all
K = [ 1876.908324, 0, 968.3659812;
       0, 1881.978391, 531.7827403;
       0, 0, 1.0];
R = diag([1,1,1]);

hei_pano=960;
v = VideoReader('e.mp4');
w=v.Width;
h=v.Height;
[x2,y2] = im2pano_cord(h,w,K,R,hei_pano);

vout = VideoWriter('newfile.avi');
open(vout)
while hasFrame(v)
    im = readFrame(v);
    %imshow(im)    
    impano = im2pano_interp(im,x2,y2);
    imshow(impano)         
    writeVideo(vout,impano);
end
close(vout)


%% ���������ֵ���
function [x2d,y2d] = im2pano_cord(imh,imw,K,R,panoh)
panow=2*panoh;
[tx,ty] = meshgrid(0:panow-1,0:panoh-1);
tx=(tx/panow-1/2)*2*pi;
ty=(ty/panoh-1/2)*pi;
% sphere points
y = sin(ty);
x = cos(ty).*sin(tx);
z = cos(ty).*cos(tx);
%figure,plot3(x(:),y(:),z(:),'.');axis equal
%figure,imshow([x,y],[]);figure,imshow(z,[]);

p2d = [x(:),y(:),z(:)]*R'*K';
p2z = p2d(:,3);
x2d = p2d(:,1)./p2z; 
y2d = p2d(:,2)./p2z; 
x2d=reshape(x2d,panoh,panow);
y2d=reshape(y2d,panoh,panow);
p2z=reshape(p2z,panoh,panow);
mask= p2z>0 & x2d>0 & y2d>0 & x2d<imw & y2d<imh;

%figure,imshow(mask);
x2d(~mask)=NaN;
y2d(~mask)=NaN;
%figure,imshow(x2d,[])
end

%% 3-ͼ���ֵ
function imo = im2pano_interp(im,x2d,y2d)
for c=1:3
    imo(:,:,c) = interp2(single(im(:,:,c)),x2d,y2d,'bicubic');
end
imo=uint8(imo);
%figure,imshow(impano,[])
end

