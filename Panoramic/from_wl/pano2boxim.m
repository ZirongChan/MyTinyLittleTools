function boxim = pano2boxim(im,mode)
if( nargin<2 )
    mode=1;
end
[nh,nw,clr] = size(im); 

%% 
imw = ceil(nw/4);
imh = imw;
fov = pi/2;
%fol是内接立方体边长一半
fol = (imw/2)/tan(fov/2);
[xmap,ymap,zmap] = im_to_sphere_patch(imw,imh,fol);
im = single(im);

%% 旋转
Rot{1} = v2rot([0,0,-1],pi/2);
Rot{2} = eye(3);
Rot{3} = v2rot([0,0,-1],-pi/2);
Rot{4} = v2rot([0,0,-1],-pi);
Rot{5} = v2rot([0,1,0],pi/2);
Rot{6} = v2rot([0,1,0],-pi/2);

boxim = [];
for j=1:6    
    imview = im_resample_from_pano( im,xmap,ymap,zmap,Rot{j} );    
    boxim = [boxim,imview];
end

if ( mode==2 )
    padim = 255*ones(imh,imh,clr);
    boxim = [padim,boxim(:,imh*4+1:imh*5,:),padim,padim; ...
             boxim(:,1:imh*4,:); ...
             padim,boxim(:,imh*5+1:end,:),padim,padim];
end

return
