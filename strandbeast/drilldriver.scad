include <defs.scad>
ViewScale=[.02,.02,.02];
//ViewScale=[1,1,1];
spineLength = sqrt(pow(MagicA, 2) + pow(MagicL,2));



module cam()
{
    shaftHeight = SpacedLayer * 5;
    // Cam
//    translate([0, 0, 0]) { difference() {
        union() {
            // shaft
            translate([0, 0, 0]) cylinder(shaftHeight, r=ShaftR, $fn=96);
            translate([0, 0, 0]) cylinder(LayerUnit, r=JointR, $fn=96);
            // strut
            translate([0, -200, 0]) cube([MagicM, 400, LayerUnit]);
            // central shaft
            translate([MagicM,0,0]) cylinder(LayerUnit, r=JointR, $fn=96);
        }
        // hex cutout
//        translate([MagicM,0,-10]) cylinder(220, r=ShaftTight, $fn=96);
//        }
//    }
}


// Outer joint plus half the rod
module wheel() {
    difference()
    {
        cylinder(SpacedLayer * 2, r=MagicM*1.5, $fn=96);
        translate([0, 0, -1]) scale([1.04, 1.04, 1.04]) translate([-MagicM, 0, 0]) cam();
    }
}

scale(ViewScale) {
    wheel();

    // Drill driver
    translate([0, 0, SpacedLayer *2]) cylinder(1000, r=ShaftR, $fn=6);
}

