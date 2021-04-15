function [thx,thy]=sphere2angmap(xmap,ymap,zmap)

%-pi/2<thy<pi/2
%0<thx<2*pi
%y = cos(phmap).*sin(thmap);
%rr=sqrt(x.^2+y.^2); %γ�߰뾶

thy = asin(zmap);
costhx = xmap./cos(thy);
sinthx = ymap./cos(thy);
%2*pi-acos(costhx): -pi~0=pi~2pi
% thx = (sinthx>=0).*acos(costhx)+(sinthx<0).*(2*pi-acos(costhx));
thx = atan2(sinthx,costhx);
%thx = (thx>=0).*(thx)+(thx<0).*( 2*pi+thx);

return