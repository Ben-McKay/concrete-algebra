if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
settings.inlinetex=true;
deletepreamble();
defaultfilename="blow-up-cubic-1";
if(settings.render < 0) settings.render=4;
settings.outformat="";
settings.inlineimage=true;
settings.embed=true;
settings.toolbar=false;
viewportmargin=(2,2);

import graph3;
import three;
currentprojection = perspective(2,1,3);
real umin=-1.1;
real umax=1.1;
size(4cm,IgnoreAspect);
size3(4cm,IgnoreAspect);
real x(real u, real v){return u^2-1;};
real y(real u, real v){return u*(u^2-1);};
real z(real u, real v){return 0;};
triple f(real t) {return (x(t,0), y(t,0), 0);}
path3 C = graph(f, umin, umax, operator ..);
surface cyl1 = extrude(C, axis=2Z);
draw(cyl1,white+opacity(0.25));
real h(pair z) {return z.x*z.y;}
draw(rotate(90,X)*surface(h,(-1,-1),(1,1),nx=10,Spline),white+opacity(0.25),render(merge=true));
