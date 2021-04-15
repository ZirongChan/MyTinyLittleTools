clear all
close all
%% ��ת����ǶȲ�����ͼƬ
im = imread('pics\earth-huge.jpg');
%im = imresize(im,1/2,'bicubic');
%im = createpanopattern(1024);
figure,imshow(im)
im = single(im);
[nh,nw,~] = size(im);

%% 4:3�ĺϳ����
imw = ceil(nw/4);
imh = round(imw*3/4);
imcav = [];
%����ˮƽfov����ֱfov������
fov = pi/3; %fov=pi*65/180;
%fol���ڽ�������߳�һ��
fol = (imw/2)/tan(fov/2);
% 2Dͼ�����������ϵĲ�����
[xmap,ymap,zmap] = im_to_sphere_patch(imw,imh,fol);

%% ��y����ת90�ȣ����򱱼�
ang = pi*90/180;
vec = [0,1,0];
R = v2rot(vec,ang);
imview = im_resample_from_pano( im,xmap,ymap,zmap, R );
figure,imshow(imview)