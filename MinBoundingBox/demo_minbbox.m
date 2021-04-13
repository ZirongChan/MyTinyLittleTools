clear all
clc

%% Randomly generated point cloud
n = 500;
pts = rand(n,3);

%% 2D on xy-plane projection
xys = pts(:, 1:2);
[rot2d, bb2d] = minboundbox_2d(double(xys));

figure; grid on; axis equal; hold on;
plot(xys(:,1), xys(:,2), 'b.'); hold on;
plot_minbbox_2d(bb2d);

theta = 90; % to rotate 90 counterclockwise
R = [cosd(theta) -sind(theta); sind(theta) cosd(theta)];
rot2d = R * rot2d';

rot_xy_2d = xys * rot2d';
rot_bb_2d = bb2d * rot2d';

figure; grid on; axis equal; hold on;
plot(rot_xy_2d(:,1), rot_xy_2d(:,2), 'b.'); hold on;
plot_minbbox_2d(rot_bb_2d);

%% 3D
[rot3d, bb_3d] = minboundbox_3d(pts(:,1), pts(:,2), pts(:,3));
figure; grid on; axis equal; hold on;
plot3(pts(:,1), pts(:,2), pts(:,3), 'b.'); hold on;
plot_minbbox_3d(bb_3d);

