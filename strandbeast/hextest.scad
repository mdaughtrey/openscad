include <defs.scad>


scale(ViewScale)
{
    linear_extrude(200)
    difference() {
    circle(JointR-100, $fn=96);
    circle(ShaftR/3*2+16, $fn=6);
    }

    translate([800, 0, 0])
    linear_extrude(400)
    circle(ShaftR/3*2, $fn=6);
}

