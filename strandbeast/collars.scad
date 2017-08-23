include <defs.scad>
include <arc.scad>
ViewScale=[.02,.02,.02];

module Collar(hh,rr)
{
    translate([0, 0, 0]) difference() {
        cylinder(hh, r=rr, $fn=96);
        translate([0, 0, -2]) cylinder(hh+5, r=ShaftR+4, $fn=96);
    }
}

scale(ViewScale)
{
    Collar(100, JointR);
    translate([0, -1000, 0]) Collar(100, JointR);
    translate([0, -2000, 0]) Collar(100, JointR);
}
