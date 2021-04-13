function plot_minbbox_2d(cornerpts, col)

if nargin == 1,col = 'b';end

hx = cornerpts(:,1);hy = cornerpts(:,2);

x=[hx(1);hx(2)];y=[hy(1);hy(2)];plot(x,y,col);hold on;
x=[hx(2);hx(3)];y=[hy(2);hy(3)];plot(x,y,col);hold on;
x=[hx(3);hx(4)];y=[hy(3);hy(4)];plot(x,y,col);hold on;
x=[hx(4);hx(1)];y=[hy(4);hy(1)];plot(x,y,col);hold off;

end