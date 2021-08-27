if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
settings.inlinetex=true;
deletepreamble();
defaultfilename="cylinder-on-curve-2-1";
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
real z(real u, real v){return v;};
//triple f(pair p){return (x(p.x,p.y),y(p.x,p.y),z(p.x,p.y));};
//draw(surface(f,(umin,0),(umax,1),nu=50,Spline),
//material(diffusepen=gray(0.5), emissivepen=gray(0.4), specularpen=black));
triple f(real t) {return (x(t,0), y(t,0), 0);}
path3 C = graph(f, umin, umax, operator ..);
surface cyl1 = extrude(C, axis=2Z);
//material surfacepen = material(diffusepen=color+opacity(0.5),emissivepen=0.2*color);
draw(cyl1,white+opacity(0.25));
// material(diffusepen=gray(0.5), emissivepen=gray(0.4), specularpen=black));
triple g(real t) {return (x(t,0), y(t,0), 0.75+abs(x(t,0)*y(t,0)));}
path3 D = graph(g, umin, umax, operator ..);
draw(D,gray);
triple gt(real t) {return (x(t,0), y(t,0), 0.75-abs(x(t,0)*y(t,0)));}
path3 Dt = graph(gt, umin, umax, operator ..);
draw(Dt,gray);
//triple gtt(real t) {return (x(t^2,0), -y(t^2,0), .5+t/(2*sqrt(umax)));}
//path3 Dtt = graph(gtt, -sqrt(umax), sqrt(umax), operator ..);
//draw(Dtt,black);
