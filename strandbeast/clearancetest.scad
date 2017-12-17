include <defs.scad>

scale(ViewScale)
{
    linear_extrude(LayerUnit/2)
    circle(JointR, $fn=96);
    translate([0, 0, LayerUnit/2]) linear_extrude(LayerUnit/2) circle(ShaftR, $fn=96);

    translate([0, 0, LayerUnit/2+JointVertSpace])
    linear_extrude(LayerUnit/2)
    difference() {
    circle(JointR, $fn=96);
    circle(ShaftHole, $fn=96);
    }
}

