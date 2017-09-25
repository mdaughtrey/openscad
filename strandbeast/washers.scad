include <defs.scad>
RealityScale = 1.27;
RealityVec=[RealityScale, RealityScale, RealityScale]; 
ViewScale=[.02,.02,.02];

module washer(thickness)
{
    difference() {
    cylinder(thickness,r=JointR,$fn=96); 
    union() {
    translate([0, 0, -1]) cylinder(thickness+2,r=ShaftHole,$fn=96); 
    translate([0, -ShaftHole, -1]) cube(ShaftHole*2);
    }
    }
}

scale(ViewScale)
{
    washer(20);
}

