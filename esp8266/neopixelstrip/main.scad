ViewScale = [0.0254, 0.0254, 0.0254];
include <pegs.scad>
include <convertermount.scad>
//include <neopixelmount.scad>

scale(ViewScale)
{
    convertermount();
    translate([0, 0, 380])
    pegs();
 //   translate([-1150/2, -1000, 60])
//    rotate([-90, 0, 0])
//    rotate([0, 90, 0])
//    neopixelmount();
}
