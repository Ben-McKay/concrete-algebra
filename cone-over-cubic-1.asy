if(!settings.multipleView) settings.batchView=false;
settings.tex="pdflatex";
defaultfilename="cone-over-cubic-1";
if(settings.render < 0) settings.render=4;
settings.outformat="";
settings.inlineimage=true;
settings.embed=true;
settings.toolbar=false;
viewportmargin=(2,2);

import three;
import graph3;
size(16cm, 0);
currentprojection =
perspective(22,6,15);
// Draw out a cubic curve in space.
triple f(real t) {
return (t^2-1, t*(t^2-1), 1);
}
path3 spiral = graph(f, -1.2, 1.2, operator ..);
triple vertex = (0,0, 0);
surface cyl = extrude(spiral, vertex -- cycle);
draw(cyl, material(gray,emissivepen=gray));
draw(spiral,gray+2pt);
