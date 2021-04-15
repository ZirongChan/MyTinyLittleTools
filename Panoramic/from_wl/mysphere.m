function [x,y,z,thmap,phmap] = mysphere(nw,nh)
%5 maps on a unit sphere
%[x,y,z,thmap,phmap] = mysphere(nw,nh)

% -pi <= theta <= pi is a row vector.
% -pi/2 <= phi <= pi/2 is a column vector.
cen = [(1+nw)/2,(1+nh)/2];
theta = 2*pi/(nw)*((1:nw)-cen(1));
phi = pi/(nh)*((1:nh)'-cen(2));

%theta=[theta(end)-2*pi,theta,theta(1)+2*pi];
%phi=[-pi/2;phi;pi/2];

thmap = single(repmat(theta,nh,1));
phmap = single(repmat( phi,1,nw ));
%r=10;
x = single(cos(phmap).*cos(thmap));
y = single(cos(phmap).*sin(thmap));
%rr=sqrt(x.^2+y.^2); %纬线半径
z = single(sin(phmap)); %纬线距离赤道高度

end