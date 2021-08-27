if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
defaultfilename="cone-over-hyperbola-1";
if(settings.render < 0) settings.render=4;
settings.outformat="";
settings.inlineimage=true;
settings.embed=true;
settings.toolbar=false;
viewportmargin=(2,2);

import three;
import graph3;
size(16cm, 0);
currentprojection = perspective(3,-1,3);

draw((0,0,0) -- (1,0,0), blue+2pt);
//x-axis
draw((0,0,0) -- (0,1,0), green+2pt);
//y-axis
draw((0,0,0) -- (0,0,1), red+2pt); //z-axis

// Draw out a cubic curve in space.
triple f(real t) {
return (t, 1/t, 1);
}

path3 spiral = graph(f, 1/2, 2, operator ..);
triple vertex = (0,0, 0);
surface cyl = extrude(spiral, vertex -- cycle);
draw(cyl, material(gray,emissivepen=gray));
draw(spiral,gray+2pt);

path3 spiral = graph(f, -2, -1/2, operator ..);
surface cyl = extrude(spiral, vertex -- cycle);
draw(cyl, material(gray,emissivepen=gray));
draw(spiral,gray+2pt);

// Draw plane x=1.
// draw(shift(X)*rotate(-90,Y)*unitplane,white);


// Draw plane x+y=1.
draw(shift(.5X+.5Y)*rotate(45,Z)*rotate(90,Y)*scale(2,2,2)*shift(-.5*X-.5*Y)*unitplane,lightgray+opacity(.35));

// ellipse on x+y=1
triple h(real t) {
return (.5+.5*cos(t),.5-.5*cos(t),.5*sin(t));
}
path3 ellips = graph(h, 0, 2pi, operator ..);
draw(ellips,lightgray+2pt);



//triple g(real t) {
//return (1,t^2,t);
//}
//path3 parabol = graph(g, 0, 1, operator ..);
//draw(parabol,lightgray+2pt);

// Draw plane z=1.
//draw(shift(Z)*scale(4,4,4)*shift(-.5*X-.5*Y)*unitplane,white+opacity(.25));
