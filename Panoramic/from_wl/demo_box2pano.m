clear all 
close all
%% 普通视角图像根据KRT映射到全景图上
 
im=imread('pics\20150212112453_im.jpg');
fac = 0.5;
im = imresize(im,fac,'bicubic');
im = single(im);
[nh,nw,~] = size(im);

Kcal = [3551.446458495, 0.0, 2037.861259299;
        0.0 3551.446458495 1215.612303973 ;
        0.0 0.0 1.0 ];
Kcal=Kcal*fac;
Kcal(3,3)=1;

%heipano = round(pi*Kcal(1,1));
heipano = 2048;

%% 生成球面的3D坐标和对应经纬度
[impano,msk1] = im_to_pano(im,Kcal, eye(3),heipano );

%im1,不旋转
figure,imshow(impano,[]) ;
imwrite(impano,'pano1.jpg');
figure,imshow(msk1,[])
 
%im2,绕着vec轴旋转ang度
ang = pi/2;
vec = [0,1,0];
%四元数转R
q = [cos(ang/2),sin(ang/2)*vec(1),sin(ang/2)*vec(2),sin(ang/2)*vec(3)];
R = q2rot(q);
 
[impano,msk2] = im_to_pano(im,Kcal,R,heipano );
figure,imshow(impano)
imwrite(impano,'pano2.jpg');

%%
function [impano,msk] = im_to_pano(im,Kcal, R,heipano )
    [nh,nw,nc]=size(im);
    [xmap,ymap,zmap] = mysphere( 2*heipano, heipano );
    [xt,yt,zt] = rotmap(xmap,ymap,zmap,R);

    x2d = (yt./xt)*Kcal(1,1) + Kcal(1,3);
    y2d = (zt./xt)*Kcal(2,2) + Kcal(2,3);
    msk = xt>0 & x2d>0 & x2d<nw & y2d>0 & y2d<nh;
    impano = zeros(heipano,2*heipano,nc,'uint8');
    
    for i = 1:nc
       imt = interp2(im(:,:,i),x2d,y2d,'linear' );
       impano(:,:,i) = uint8(imt.*msk);
    end
end
 

