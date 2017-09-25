include <defs.scad>
use <MCAD/involute_gears.scad>
RealityScale = 1.27;
RealityVec=[RealityScale, RealityScale, RealityScale]; 
ViewScale=[.02,.02,.02];

module spanSection(length, clip)
{
    difference() {
        cylinder(length, r=JointR,$fn=96); // base
        union() {
            translate([0, 0, -1]) cylinder(length + 2, r=ShaftTight, $fn=96); // base
            if (clip)
            {
                translate([100, -JointR*4/3, -1]) cube([JointR, 1000, length+2]);
                translate([-(JointR+100), -JointR*4/3, -1]) cube([JointR, 1000, length+2]);
            }
        }
    }
}

scale(ViewScale)
{
    union() 
    {
        spanSection(500, 0);
        translate([0, 0, 500]) spanSection(3000, 1);
        translate([0, 0, 3500]) spanSection(500, 0);
    }
}

