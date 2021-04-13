clc
clear all
close all

%%
img_pano = imread('./Headquarter/pano/20210204_083638_bMS3D_Image_000000.jpg');

imw = 1920;
imh = 1080;

hFov = 128;
vFov = 72;

out_imgs = equi2monos_fov(img_pano, imw, imh, hFov, vFov);

%%
K = [ 1876.908324, 0, 968.3659812;
       0, 1881.978391, 531.7827403;
       0, 0, 1.0];

out_imgs_2 = equi2monos_intrinsic(img_pano, imw, imh, K);
