if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
settings.inlinetex=true;
deletepreamble();
defaultfilename="cylinder-on-curve-1";
if(settings.render < 0) settings.render=4;
settings.outformat="";
settings.inlineimage=true;
settings.embed=true;
settings.toolbar=false;
viewportmargin=(2,2);

import graph3;
currentprojection = perspective(2,1,3);
real umin=-1.1;
real umax=1.1;
size(800,IgnoreAspect);
size3(800,IgnoreAspect);
real x(real u, real v){return u^2-1;};
real y(real u, real v){return u*(u^2-1);};
real z(real u, real v){return v;};
//triple f(pair p){return (x(p.x,p.y),y(p.x,p.y),z(p.x,p.y));};
//draw(surface(f,(umin,0),(umax,1),nu=50,Spline),
//material(diffusepen=gray(0.5), emissivepen=gray(0.4), specularpen=black));
triple f(real t) {return (x(t,0), y(t,0), 0);}
path3 C = graph(f, umin, umax, operator ..);
surface cyl1 = extrude(C, axis=2Z);
draw(cyl1,material(diffusepen=gray(0.5), emissivepen=gray(0.4), specularpen=black));
