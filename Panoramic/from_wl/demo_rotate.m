%% panorama image旋转任意角度
clear all
close all

im=imread('pics\R0010378.JPG');
im = imresize(im,1/2,'bicubic');
%im = createpanopattern(1024);
figure,imshow(im)
[nh,nw,nch] = size(im);

im = single(im);

[xmap,ymap,zmap,thmap,phmap] = mysphere(nw,nh); 

%% 任意角度旋转
ang = pi*0.3;
vec = [1,0,0];
R = v2rot(vec,ang);
imview = im_resample_from_pano( im,xmap,ymap,zmap,R );
figure, imshow(imview)
