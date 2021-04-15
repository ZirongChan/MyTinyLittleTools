clear all
close all
%% 重采样全景图序列
%
%定义水平FOV
fov = pi/3;
% 定义旋转
Rot{1} = v2rot([0,0,1],0 );
Rot{2} = v2rot([0,0,1],-fov );
Rot{3} = v2rot([0,0,1],fov);
Rot{4} = v2rot([0,0,1],-2*fov);
Rot{5} = v2rot([0,0,1],2*fov);
%Rot{6} = v2rot([0,1,0],pi/2);

%%
path = 'room\';
ls = dir([path,'*.JPG']);
pnum = length(ls);
pathout = 'roomout\';

for i=1:pnum
    name = ls(i).name;
    im = imread([path,name]);
    if(i==1)
        [nh,nw,~] = size(im);
        % 焦距为赤道半径
        fol = nw/(2*pi);
        imw = ceil(2*fol*tan(fov/2));
        imh = ceil(4*imw/3);
        % 画面朝向X
        [xmap,ymap,zmap] = im_to_sphere_patch(imw,imh,fol);
    end
        
    im = single(im);    
    prename=name(1:strfind(name,'.')-1);
    for k = 1:length(Rot)   
        boxim{k} =  im_resample_from_pano( im,xmap,ymap,zmap, Rot{k} );                
        nameout = sprintf('%s_%d.png', prename,k);
        imwrite(boxim{k},[pathout,nameout]);
    end    
end

Kc=[fol,0,(imw-1)/2;
    0,fol,(imh-1)/2;
    0,0,1];
fileID = fopen('Kc.dat','w');
fprintf(fileID,'%6.2f %6.2f %6.2f\n',Kc');
fclose(fileID);
