include <defs.scad>
include <model_squareinsert.scad>

//scale(ViewScale)
module driver_insert()
{
    // shaft surround
    translate([0, 0, 300])
    linear_extrude(250)
    difference() {
        circle(ShaftR, $fn=96);
        intersection() {
            circle(205/2, $fn=96);
            square([135, 400], center=true);
        }
    }
    translate([0, 0, 40])
    linear_extrude(260)
    intersection() {
    square([140, 520], center=true);
    circle(ShaftR, $fn=96);
    }
}
