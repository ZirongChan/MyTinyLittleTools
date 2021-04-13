clc
clear all

%%
img_pano = imread('office_freewalk\00000.png');
[height, width, dim] = size(img_pano);

%% default parameters
% outCube{1} = % Front
% outCube{2} = % Right
% outCube{3} = % Back
% outCube{4} = % Left
% outCube{5} = % Top
% outCube{6} = % Bottom
out = equi2cubic(img_pano);
output_size = size(out{1});
cube_size = output_size(1);

% extend the output imgs as 
%        -----
%       | top |
% ---------------------------
%| left |front| right | back |
% ---------------------------
%       | bot |
%        -----
cube_map = uint8(zeros([3,4,1].*output_size));
% top
cube_map(1:cube_size, cube_size+1:2*cube_size,:) = out{5};
% bot
cube_map(2*cube_size+1:end, cube_size+1:2*cube_size,:) = out{6};
% left
cube_map(cube_size+1:2*cube_size, 1:cube_size,:) = out{4};
% front
cube_map(cube_size+1:2*cube_size, cube_size+1:2*cube_size,:) = out{1};
% right
cube_map(cube_size+1:2*cube_size, 2*cube_size+1:3*cube_size,:) = out{2};
% back
cube_map(cube_size+1:2*cube_size, 3*cube_size+1:end,:) = out{3};
figure; imshow(cube_map);

% convert back to pano img
% [out] = cubic2equi(top, bottom, left, right, front, back)
all_pano = cubic2equi(out{5}, out{6}, out{4}, out{2}, out{1}, out{3});
figure; imshow(all_pano);

% preserve certain angle of view
empty_cube = uint8(zeros(output_size));
partial_pano = cubic2equi(empty_cube, empty_cube, out{4}, out{2}, out{1}, out{3});
figure; imshow(partial_pano);



