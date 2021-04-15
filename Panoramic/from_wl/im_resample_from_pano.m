function imview = im_resample_from_pano( impano,xmap,ymap,zmap,R )
% imview = im_resample_from_pano( impano,xmap,ymap,zmap,R )
%   resample image view from pano image 
%   xmap,ymap,zmap 是图像image grid坐标 从图像上投影到单位球上
%   see also:  im_to_sphere_patch 

[nh,nw,nch] = size(impano);
%% 扩边 否则采样边界会出现黑线
%row
impano = [impano(1:2,end:-1:1,:);impano;impano(end-1:end,end:-1:1,:)];
%im = [im(1,1:end,:);im;im(end,1:end,:)];
impano = [impano(:,end-1:end,:),impano,impano(:,1:2,:)];  

[xt,yt,zt]=rotmap(xmap,ymap,zmap,R);
[thmap,phmap] = sphere2angmap(xt,yt,zt);
cen=[size(impano,2),size(impano,1)]/2;
idx = cen(1)+thmap*(nw+1)/(2*pi);
idy = cen(2)+phmap*(nh+1)/pi;
for i=1:nch
    imt = interp2(impano(:,:,i),idx,idy,'bicubic' );
    imview(:,:,i) = uint8(imt);
end
end
    