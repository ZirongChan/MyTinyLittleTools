clear all
close all
% 中心投影构造六面体纹理映射
% Wang Lin
% 2015.3.12

% im = createpanopattern(512);
% imwrite(im,'Pattern.jpg');
% boxim = pano2boxim(im,1);
% imwrite(boxim,'Pattern_box1.jpg');
% boxim = pano2boxim(im,2);
% imwrite(boxim,'Pattern_box2.jpg');
% 
% return

im = imread('pics\earth-huge.jpg');
%im = imresize(im,1/2,'bicubic');
%im = createpanopattern(1024);
%figure, imshow(im)

boxim = pano2boxim(im,1);
imwrite(boxim,'earth_box1.jpg');
%figure,imshow(boxim);
boxim = pano2boxim(im,2);
imwrite(boxim,'earth_box2.jpg');

return
