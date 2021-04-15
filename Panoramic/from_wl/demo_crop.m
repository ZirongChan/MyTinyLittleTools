clear all
close all
%% 旋转任意角度采样成图片
im = imread('pics\earth-huge.jpg');
%im = imresize(im,1/2,'bicubic');
%im = createpanopattern(1024);
figure,imshow(im)
im = single(im);
[nh,nw,~] = size(im);

%% 4:3的合成相机
imw = ceil(nw/4);
imh = round(imw*3/4);
imcav = [];
%设置水平fov，竖直fov按比例
fov = pi/3; %fov=pi*65/180;
%fol是内接立方体边长一半
fol = (imw/2)/tan(fov/2);
% 2D图像生成球面上的采样点
[xmap,ymap,zmap] = im_to_sphere_patch(imw,imh,fol);

%% 绕y轴旋转90度，朝向北极
ang = pi*90/180;
vec = [0,1,0];
R = v2rot(vec,ang);
imview = im_resample_from_pano( im,xmap,ymap,zmap, R );
figure,imshow(imview)