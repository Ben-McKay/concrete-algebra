settings.outformat="pdf";
settings.prc=false;
settings.render=16;
import graph;
size(1cm,0);
pair F(real t) {
return (1-t^2,t*(1-t^2));
}
path G=graph(F, -1, 1);
draw(G,gray);
fill(circle((0,0), 0.1), white);
draw(circle((0,0), 0.1), gray);

for (int n = 3; n <= 7; ++n) {

shipout(scale(4.0)*currentpicture.fit());

