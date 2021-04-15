function [x,y,z]=rotmap(xmap,ymap,zmap,R)
% [xmapout,ymapout,zmapout]=rotmap(xmap,ymap,zmap,R)
%

x=R(1,1)*xmap+R(1,2)*ymap+R(1,3)*zmap;
y=R(2,1)*xmap+R(2,2)*ymap+R(2,3)*zmap;
z=R(3,1)*xmap+R(3,2)*ymap+R(3,3)*zmap;

return
