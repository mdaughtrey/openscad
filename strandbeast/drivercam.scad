include <defs.scad>
include <model_squareinsert.scad>

//ViewScale=[1,1,1];

StrutWidth = 400;
rrectR = 100;
//LayerUnit = 300;
JointVertSpace=20;
//ShaftHole=220;
ShaftSleeve = 200;
//InsertR = 150;
//InsertX = 400;
//InsertY = 150;
//InsertH = 600;

// lower
module driver_cam()
{
    shaftHeight = SpacedLayer + JointVertSpace;
    // two sections of the shaft base
    // lower section without circle cutout
    union() {
        linear_extrude(LayerUnit-50)
        difference() {
            circle(JointR, $fn=96);
            intersection() {
            square([160, 540], center=true);
            circle(ShaftHole+10, $fn=96);
            }
        }
    }
    // upper section with circle cutout
    translate([0, 0, LayerUnit-50]) {
        linear_extrude(50)
        difference() {
            circle(JointR, $fn=96);
            circle(ShaftHole+10, $fn=96);
        }
    }
// Cam
    linear_extrude(LayerUnit) {
    translate([0, 0, 0]) { difference() {
        union() {
//            #circle(JointR, $fn=96);
            // strut
            translate([JointR, 0, 0]) square([300, 400], center=true);
            // central shaft
            translate([MagicM,0,0]) circle(JointR, $fn=96);
        }
        translate([MagicM,0,-1]) circle(ShaftTight, $fn=96);
        }
    }}
    shaftLower = shaftHeight-5+LayerUnit-320;
    shaftUpper = 320;
    echo("ShaftLower ",shaftLower," LayerUnit ",LayerUnit);
    // shaft upper section
    *translate([0, 0, LayerUnit])
    linear_extrude(shaftLower)
    difference() {
        circle(ShaftR, $fn=96);
        square([InsertE+30, InsertCapX+60], center=true);
    }
}

//scale(ViewScale) {
//        driver_cam();
//}

