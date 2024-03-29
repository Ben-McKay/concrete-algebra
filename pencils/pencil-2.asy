settings.outformat="pdf";
settings.prc=false;
settings.render = 16;

import contour;
import graph;
import palette;


size(800);

// We want to draw the pencil of two polynomials in (x,y) called g(x,y) and h(x,y), inside the square with corners a and b.

pair a=(-1,-1);
pair b=(1,1);

real g(real x, real y) 
// {return x^2-y^2; }
{return x^3-x-y^2;}

real h(real x, real y) 
// {return x^2+y^2-1; }
{return x*y^2;}

real tolerance=.001;

real f(real x, real y) {
	real gg=g(x,y);
	real hh=h(x,y);
	if (gg^2+hh^2<tolerance)
		return 0;
	else
		return atan2(gg,hh)^2;
}

//int n=10;
//real[] c=new real[n];
//for(int i=0; i < n; ++i) c[i]=(i-n/2)/n;

//pen[] p=sequence(new pen(int i) {
//    return (c[i] >= 0 ? solid : solid)+gray+fontsize(120pt)+2pt;
//  },c.length);

//Label[] Labels=sequence(new Label(int i) {
//    return Label(c[i] != 0 ? (string) c[i] : "",Relative(unitrand()),(0,0),
//                 UnFill(1bp));
//  },c.length);

// draw(Labels,contour(f,(-1,-1),(1,1),c),p);
// draw(contour(f,(-1,-1),(1,1),c),p);




int nn=512;
real[][] u=new real[nn][nn];
pen[][] v=new pen[nn][nn];

real xx(int i)
{
	return (b.x-a.x)*i/nn+a.x;
}

real yy(int j)
{
	return (b.y-a.y)*j/nn+a.y;
}

real maxf=-1000000;
real minf=1000000;

int numcolors=12;

pen clr(real z)
{
	real t=(z-minf)/(maxf-minf);
	t=round(numcolors*t)/numcolors;
	return rgb(t,t,t)+opacity(.35);
}



void drawcontour()
{
	for(int i=0; i < nn; ++i)
		for(int j=0; j < nn; ++j)
		{
			u[i][j]=f(xx(i),yy(j));
			if (u[i][j]>maxf)
			{
				maxf=u[i][j];
			}
			if (u[i][j]<minf)
			{
				minf=u[i][j];
			}
		}
	for(int i=0; i < nn; ++i)
	  for(int j=0; j < nn; ++j)
	    v[i][j]=clr(u[i][j]);
	image(v,a,b);
}



drawcontour();


shipout(scale(4.0)*currentpicture.fit());



