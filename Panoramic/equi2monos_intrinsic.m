function out_imgs = equi2monos_intrinsic(img_pano, imw, imh, K, ang)
% Convert a panoramic image to 8 monocular images based on given resulotion
% and FoVs.
% Input: 
%   img_pano: the panoramic image whose height is half of its width
%   imw: the width of output monocular image
%   imh: the height of output monocular image
%   K: camera intrinsic simulated by the output monocular image
%   ang: the angle in degree indicts how much you look down 

% Output:
%   out_imgs: 8x1 cells contain output images
%%
[height, width, dim] = size(img_pano);

img_pano_padding = zeros(height, width+2,dim);
img_pano_padding(:,2:end-1,:) = img_pano;
img_pano_padding(:,1,:) = img_pano(:,end,:);
img_pano_padding(:,end,:) = img_pano(:,1,:);

% [x_coo, y_coo] = meshgrid(0:width-1, 0:height-1);
% phi_coo = (x_coo / width - 0.5) * 2 * pi;
% theta_coo = (y_coo / height - 0.5) * pi;
% 
% % sphere points
% y = sin(theta_coo);
% x = cos(theta_coo).*sin(phi_coo);
% z = cos(theta_coo).*cos(phi_coo);
% 
% pts = zeros(height*width, 3);
% pts(:,1) = x(:);
% pts(:,2) = y(:);
% pts(:,3) = z(:);
% clrs = reshape(img_pano, height*width, 3);
% 
% figure; pcshow(pts(1:50:end,:), clrs(1:50:end,:));

%% CounterClockWise
views = [-45 0 0;
         0 0 0; % Front
         45 0 0;
         90 0 0; % Right
         135 0 0;
         180 0 0; % Back
         -135 0 0;
         -90 0 0 % Left
         ];

views(1:4,2) = ang;
views(5:8,2) = -ang;

num_views = size(views,1);

Rs = zeros(3,3,num_views);
for idx = 1:num_views
     % Get yaw, pitch and roll of a particular view
     yaw = views(idx,1);
     pitch = views(idx,2);
     roll = views(idx,3);
     
     % Get transformation matrix
     Rs(:,:,idx) = roty(yaw)*rotx(pitch)*rotz(roll);
end

% imw = 1920;
% imh = 1080;

%% Projection using customized Pinhole Parameters
% K = [ 1876.908324, 0, 968.3659812;
%        0, 1881.978391, 531.7827403;
%        0, 0, 1.0];

[u, v] = meshgrid(0:imw-1, 0:imh-1);
ptx = (u-K(1,3))/K(1,1);
pty = (v-K(2,3))/K(2,2);
ptz = ones(imh,imw);

r = sqrt(ptx.^2 + pty.^2 + ptz.^2);
ptx = ptx ./ r;
pty = pty ./ r;
ptz = ptz ./ r;

% figure; pcshow([ptx(:),pty(:),ptz(:)]);
out_imgs = cell(num_views, 1);
for i = 1:num_views    
    p3d = [ptx(:),pty(:),ptz(:)]*Rs(:,:,i);
    
%     figure; grid on; axis equal; hold on;
%     pcshow(p3d); hold on;
%     xlabel('X'); hold on;
%     ylabel('Y'); hold on;
%     zlabel('Z'); hold on;
    
    p3dx = reshape(p3d(:,1), imh, imw);
    p3dy = reshape(p3d(:,2), imh, imw);
    p3dz = reshape(p3d(:,3), imh, imw);

    thetas = asin(p3dy);
    ycoo = (thetas / pi + 0.5)*height;
    
%     xznorm = sqrt(p3dx.^2 + p3dz.^2);
%     phis = acos(p3dz ./ xznorm);
%     phis(p3dx<0) = - phis(p3dx<0);
    sinphis = p3dx ./ cos(thetas);
    cosphis = p3dz ./ cos(thetas);
    phis = atan2(sinphis,cosphis);
    
    xcoo = (phis / pi / 2 + 0.5)*width;
        
%     xcoo(xcoo>width) = width;
%     xcoo(xcoo<0) = 0;
%     ycoo(ycoo>height) = height;
%     ycoo(ycoo<0) = 0;
    
    im = zeros(imh, imw, 3);
    for c = 1:3
        im(:,:,c) = interp2(double(img_pano_padding(:,:,c)), xcoo+1, ycoo, 'bicubic');
    end
    
    out_imgs{i} = im / 255;
%     figure; imshow(im / 255);
end

%%
% Rotation matrix - x axis
% Angle in degrees
function [mat] = rotx(ang)
mat = [1 0 0;
    0 cosd(ang) -sind(ang);
    0 sind(ang) cosd(ang)];
end

% Rotation matrix - y axis
% Angle in degrees
function [mat] = roty(ang)
mat = [cosd(ang) 0 sind(ang);
    0 1 0;
    -sind(ang) 0 cosd(ang)];
end

% Rotation matrix - z axis
% Angle in degrees
function [mat] = rotz(ang)
mat = [cosd(ang) -sind(ang) 0;
    sind(ang) cosd(ang) 0;
    0 0 1];
end
end