function [xmap,ymap,zmap] = im_to_sphere_patch(imw,imh,fol)
% [xmap,ymap,zmap] = im_to_sphere_patch(imw,imh,fol)
%    ����ͼ�񳤿�ͽ���,����ͶӰ����λ�����ϵ���ͨ������
%    ��Ϊ������С�׳�������������ڻ������ģ�����fol���

[ymap,zmap] = meshgrid(1:imw,1:imh);
% 2-pixel wide image, in matlab:[1,2] cx=(2+1/)2
% in c++:[0,1],cx=(2+1/)2-1
cx = (imw+1)/2;
cy = (imh+1)/2;
ymap = single(ymap - cx);
zmap = single(zmap - cy);

%ymap = single( repmat((1:imw) -cx,imh,1) );
%zmap = single( repmat((1:imh)'-cy,1,imw) );

%����Ϊx����
xmap = single( fol*ones(imh,imw) );
[xmap,ymap,zmap] = normlisexyz( xmap,ymap,zmap );

end

 
