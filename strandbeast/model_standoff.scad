include <defs.scad>

scale(ViewScale)
{
    // insert
    //linear_extrude(600)
    //circle(90, $fn=6);

    translate([0, 0, 50])
    linear_extrude(320)
    difference() {
    square([400, 400], center=true);
    circle(100, $fn=6);
    }

    linear_extrude(50)
    difference() {
    square([400, 400], center=true);
    circle(18, $fn=96);
    }


}


