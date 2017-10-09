include <defs.scad>

scale(ViewScale) {
    difference() {
    cylinder(SpacedLayer, r=JointR, $fn=96);
    translate([0, 0, -1]) cylinder(SpacedLayer+2, r=ShaftR, $fn=96);
    }
}
