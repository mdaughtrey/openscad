include <defs.scad>
ViewScale=[.02,.02,.02];
include <arc.scad>

scale(ViewScale)
{
    length = 2000;
    height = 100;
    3D_arc(w=100, r=1000,deg=60,fn=96,h=100);
//    arc(length, height);
   translate([-length/2, 0, 0]) #cube([length, 100, 100]);
}
