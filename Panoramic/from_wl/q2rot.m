function r = q2rot(q)
% rmat3_3 = q2rot(q)
% R =q2rot([cos(th/2),sin(th/2)*vec(1),sin(th/2)*vec(2),sin(th/2)*vec(3)]);

w=q(1);
x=q(2);
y=q(3);
z=q(4);
r = [1-2*y*y-2*z*z,2*x*y-2*w*z,2*x*z+2*w*y;
     2*x*y+2*w*z  ,1-2*x*x-2*z*z,2*y*z-2*w*x;
     2*x*z-2*w*y  ,2*z*y+2*w*x,1-2*x*x-2*y*y] ;
return

