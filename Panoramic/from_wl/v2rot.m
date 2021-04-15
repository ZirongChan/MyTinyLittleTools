function r = v2rot(axis,th)
% rmat3_3 = v2rot(axis,th)
% rotate rangle th, around axis 
% 
% R =q2rot([cos(th/2),sin(th/2)*vec(1),sin(th/2)*vec(2),sin(th/2)*vec(3)]);

axis = axis./norm(axis);
w=cos(th/2);
x=sin(th/2)*axis(1);
y=sin(th/2)*axis(2);
z=sin(th/2)*axis(3);

r = [1-2*y*y-2*z*z,2*x*y-2*w*z,2*x*z+2*w*y;
     2*x*y+2*w*z  ,1-2*x*x-2*z*z,2*y*z-2*w*x;
     2*x*z-2*w*y  ,2*z*y+2*w*x,1-2*x*x-2*y*y] ;
return

