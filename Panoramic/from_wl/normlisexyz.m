function [xmap,ymap,zmap]=normlisexyz(xmap,ymap,zmap)
%[xmap,ymap,zmap]=normlisexyz(xmap,ymap,zmap)

rr = sqrt(xmap.*xmap+ymap.*ymap+zmap.*zmap);
xmap = xmap./rr;
ymap = ymap./rr;
zmap = zmap./rr;
return
