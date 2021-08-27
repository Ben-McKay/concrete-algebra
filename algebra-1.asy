if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
defaultfilename="algebra-1";
if(settings.render < 0) settings.render=4;
settings.outformat="";
settings.inlineimage=true;
settings.embed=true;
settings.toolbar=false;
viewportmargin=(2,2);

import graph3;
real umin=-1.1;
real umax=1.1;
size(800,IgnoreAspect);
size3(800,IgnoreAspect);
real x(real u, real v){return 1-u^2;};
real y(real u, real v){return u*(1-u^2);};
real z(real u, real v){return v;};
triple f(pair p){return (x(p.x,p.y),y(p.x,p.y),z(p.x,p.y));};
draw(surface(f,(umin,0),(umax,1),nu=25,Spline),
material(diffusepen=gray(0.5), emissivepen=gray(0.4), specularpen=black));
// lightgray);
// path3 g=(1,0,1)..(0,1,1)..(-1,0,1)..(0,-1,0)..cycle;
// draw(g,green+linewidth(1mm));
// path3 h=(1,0,-1)..(0,1,-1)..(-1,0,-1)..(0,-1,-1)..cycle;
// draw(h,blue+linewidth(1mm));
int N=15;
//real eps=.0;
//real stp(int i)
//{
// return umin+(umax-umin)*((1.0*i)/N);
//}
//for(int i=0; i < (N+1); ++i) { //draw((x(stp(i),0)+eps,y(stp(i),0)+eps,z(stp(i),0)+eps)--(x(stp(i),1)+eps,y(stp(i),1)+eps,z(stp(i),1)+eps),white+linewidth(.5mm));
//}
