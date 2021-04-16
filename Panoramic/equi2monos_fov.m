function out_imgs = equi2monos_fov(img_pano, imw, imh, fov, ang)
% Convert a panoramic image to 8 monocular images based on given resulotion
% and FoVs.
% Input: 
%   img_pano: the panoramic image whose height is half of its width
%   imw: the width of output monocular image
%   imh: the height of output monocular image
%   fov: the horizontal FoV of output monocular image
%   ang: the angle in degree indicts how much you look down 
% Output:
%   out_imgs: 8x1 cells contain output images

%% Projection using customized FOV
% imw = 1920;
% imh = 1080;
% 

focal_length = imw/2 / tand(fov/2);
K = [focal_length, 0, imw/2;
     0, focal_length, imh/2;
     0, 0, 1];
 
out_imgs = equi2monos_intrinsic(img_pano, imw, imh, K, ang);

end