function [xmap,ymap,zmap] = im_to_sphere_patch(imw,imh,fol)
% [xmap,ymap,zmap] = im_to_sphere_patch(imw,imh,fol)
%    根据图像长宽和焦距,生成投影到单位球面上的三通道坐标
%    因为是理想小孔成像相机，光心在画面中心，两个fol相等

[ymap,zmap] = meshgrid(1:imw,1:imh);
% 2-pixel wide image, in matlab:[1,2] cx=(2+1/)2
% in c++:[0,1],cx=(2+1/)2-1
cx = (imw+1)/2;
cy = (imh+1)/2;
ymap = single(ymap - cx);
zmap = single(zmap - cy);

%ymap = single( repmat((1:imw) -cx,imh,1) );
%zmap = single( repmat((1:imh)'-cy,1,imw) );

%正面为x方向
xmap = single( fol*ones(imh,imw) );
[xmap,ymap,zmap] = normlisexyz( xmap,ymap,zmap );

end

 
