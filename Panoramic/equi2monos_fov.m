function out_imgs = equi2monos_fov(img_pano, imw, imh, hFov, vFov)
% Convert a panoramic image to 8 monocular images based on given resulotion
% and FoVs.
% Input: 
%   img_pano: the panoramic image whose height is half of its width
%   imw: the width of output monocular image
%   imh: the height of output monocular image
%   hFov: the horizontal FoV of output monocular image
%   vFov: the vertical FoV of output monocular image
% Output:
%   out_imgs: 8x1 cells contain output images
%%
[height, width, dim] = size(img_pano);

% [x_coo, y_coo] = meshgrid(0:width-1, 0:height-1);
% phi_coo = (x_coo / width - 0.5) * 2 * pi;
% theta_coo = (y_coo / height - 0.5) * pi;

img_pano_padding = zeros(height, width+2,dim);
img_pano_padding(:,2:end-1,:) = img_pano;
img_pano_padding(:,1,:) = img_pano(:,end,:);
img_pano_padding(:,end,:) = img_pano(:,1,:);

%% Projection using customized FOV
% imw = 1920;
% imh = 1080;
% 
% hFov = 128;
% vFov = 72;

hRes = hFov / (imw-1);
vRes = vFov / (imh-1);

[phis_coo, thetas_coo] = meshgrid(-hFov/2:hRes:hFov/2, -vFov/2:vRes:vFov/2);

%% Method 1
% just take the coo accordingly
% this one is more reasonable when it comes to FOV alone
out_imgs = cell(8,1);
for i = -3:4
    
    ycoo = (thetas_coo / 180 + 0.5)*height;
    phis = phis_coo + 45 * i;
    phis(phis<180) = phis(phis<180)+360;
    phis(phis>180) = phis(phis>180)-360;
    xcoo = (phis / 360 + 0.5)*width;
    
%     xcoo(xcoo>width) = width;
%     xcoo(xcoo<0) = 0;
%     ycoo(ycoo>height) = height;
%     ycoo(ycoo<0) = 0;
    
    im = zeros(imh, imw, 3);
    for c = 1:3
        im(:,:,c) = interp2(double(img_pano_padding(:,:,c)), xcoo+1, ycoo);
    end
    
    out_imgs{i+4} = im / 255;
%     figure; imshow(im / 255);
end

%% Method 2

% % CounterClockWise
% views = [0 0 0; % Front
%          45 0 0;
%          90 0 0; % Right
%          135 0 0;
%          180 0 0; % Back
%          -135 0 0;
%          -90 0 0; % Left
%          -45 0 0]; % Bottom
% num_views = size(views,1);
% 
% Rs = zeros(3,3,num_views);
% for idx = 1:num_views
%      % Get yaw, pitch and roll of a particular view
%      yaw = views(idx,1);
%      pitch = views(idx,2);
%      roll = views(idx,3);
%      
%      % Get transformation matrix
%      Rs(:,:,idx) = roty(yaw)*rotx(pitch)*rotz(roll);
% end
% 
% ptx = tan(phis_coo /180 *pi);
% pty = tan(thetas_coo /180*pi);
% ptz = ones(imh,imw);
% 
% norm = sqrt(ptx.^2 + pty.^2 + ptz.^2);
% ptx = ptx ./ norm;
% pty = pty ./ norm;
% ptz = ptz ./ norm;
% 
% % figure; pcshow([ptx(:),pty(:),ptz(:)]);
% 
% for i = 1:num_views    
%     p3d = [ptx(:),pty(:),ptz(:)]*Rs(:,:,i);
%     
%     figure; grid on; axis equal; hold on;
%     pcshow(p3d); hold on;
%     xlabel('X'); hold on;
%     ylabel('Y'); hold on;
%     zlabel('Z'); hold on;
%     
%     p3dx = reshape(p3d(:,1), imh, imw);
%     p3dy = reshape(p3d(:,2), imh, imw);
%     p3dz = reshape(p3d(:,3), imh, imw);
% 
%     thetas = asin(p3dy);
%     ycoo = (thetas / pi + 0.5)*height;
%     
%     xznorm = sqrt(p3dx.^2 + p3dz.^2);
%     phis = acos(p3dz ./ xznorm);
%     phis(p3dx<0) = - phis(p3dx<0);
%     xcoo = (phis / pi / 2 + 0.5)*width;
%     
% %     xcoo(xcoo>width) = width;
% %     xcoo(xcoo<0) = 0;
% %     ycoo(ycoo>height) = height;
% %     ycoo(ycoo<0) = 0;
%     
%     im = zeros(imh, imw, 3);
%     for c = 1:3
%         im(:,:,c) = interp2(double(img_pano_padding(:,:,c)), xcoo+1, ycoo);
%     end
%     
%     
%     figure; imshow(im / 255);
% end
% 
% %%
% % Rotation matrix - x axis
% % Angle in degrees
% function [mat] = rotx(ang)
% mat = [1 0 0;
%     0 cosd(ang) -sind(ang);
%     0 sind(ang) cosd(ang)];
% end
% 
% % Rotation matrix - y axis
% % Angle in degrees
% function [mat] = roty(ang)
% mat = [cosd(ang) 0 sind(ang);
%     0 1 0;
%     -sind(ang) 0 cosd(ang)];
% end
% 
% % Rotation matrix - z axis
% % Angle in degrees
% function [mat] = rotz(ang)
% mat = [cosd(ang) -sind(ang) 0;
%     sind(ang) cosd(ang) 0;
%     0 0 1];
% end
end