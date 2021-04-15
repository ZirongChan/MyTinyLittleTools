clear all
close all
%% ��ת����ǶȲ�����ͼƬ
 
im = imread('pics\R0010378.JPG');
%im = imresize(im,1/2,'bicubic');
%im = createpanopattern(1024);
figure,imshow(im)
[nh,nw,~] = size(im);
 
%% one shot
fol = nw/(2*pi)/1.4;
fov = 1.0*pi/2;
imw = ceil(2*fol*tan(fov/2));
imh = ceil(imw*1.5);

%���泯��X
[xmap,ymap,zmap] = im_to_sphere_patch(imw,imh,fol);

im = single(im);
%% ����Ƕ���ת
Rot{1}=v2rot([0,0,1],-fov-0.3);
Rot{2}=v2rot([0,0,1],0-0.3);
Rot{3}=v2rot([0,0,1],fov-0.3);

for k=1:3    
    boxim{k} =  im_resample_from_pano( im,xmap,ymap,zmap, Rot{k} );    
    imwrite(boxim{k},sprintf('imview%d.jpg',k));
end

impad = uint8(255*ones(imh,10,3));
imcav = [boxim{1},impad,boxim{2},impad,boxim{3}];
figure,  imshow(imcav);
