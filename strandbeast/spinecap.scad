include <defs.scad>

StrutWidth = 400;
rrectR = 100;
//LayerUnit = 300;
JointVertSpace=20;
//ShaftHole=220;
ShaftSleeve = 200;

shaftHeight = SpacedLayer + JointVertSpace;

//module rectHull(r, x, y)
//{
//    hull()
//    {
//        // place 4 circles in the corners, with the given r
//        translate([(-x/2)+(r/2), (-y/2)+(r/2), 0])
//            circle(r=r);
//
//        translate([(x/2)-(r/2), (-y/2)+(r/2), 0])
//            circle(r=r);
//
//        translate([(-x/2)+(r/2), (y/2)-(r/2), 0])
//            circle(r=r);
//
//        translate([(x/2)-(r/2), (y/2)-(r/2), 0])
//            circle(r=r);
//    }
//}
//
//// rounded rectangle
//module rrect(z, y, x)
//{
//    y = y - rrectR;
//    x = x - rrectR;
//    //translate([0, rrectR+x/2, y/2]) // rrectR/2+y/2])
//    translate([0, rrectR+x/2, x/2+rrectR/4]) // rrectR/2+y/2])
//    rotate([0, 90, 0]) 
//    linear_extrude(z)
//    rectHull(rrectR/2, x, y);
//}
//
//}

// lower
module cam2()
{
    shaftHeight = SpacedLayer + JointVertSpace;
    // Cam
    linear_extrude(LayerUnit) {
    translate([0, 0, 0]) { difference() {
         circle(JointR, $fn=96);
        translate([MagicM,0,-1]) circle(ShaftTight, $fn=96);
        }
    }}
    translate([0, 0, LayerUnit])
    linear_extrude(shaftHeight)
    circle(ShaftR, $fn=96);
    
    translate([0, 0, LayerUnit+shaftHeight])
    linear_extrude(LayerUnit)
    circle(ShaftR/3*2, $fn=6);
}

module cap2()
{
    hull() { 
        polygon(points = [[0, 0],[JointR,LayerUnit],[0,LayerUnit]]);
        translate([JointR-50, 50]) circle(50, $fn=96);
    }
    translate([0, LayerUnit])
    square([ShaftR, shaftHeight]);
}

scale(ViewScale) {
    rotate_extrude($fn=96) { cap2(); }
//    translate([0, 0, LayerUnit+shaftHeight])
//    linear_extrude(LayerUnit)
//    circle(ShaftR/3*2, $fn=6);
}

