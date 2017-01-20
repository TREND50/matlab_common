function fun=fsin(p,xdata)
% Power law
%fun=p(1)*sin(2*pi*p(2)*xdata+p(3));
fun=p(1)*sin(2*pi*66e6*xdata+p(3));
