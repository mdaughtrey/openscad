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

// upper
module cam()
{
    shaftHeight = SpacedLayer * 5 - 20;
    // Cam
    union() {
        // shaft
        translate([0, 0, LayerUnit]) cylinder(shaftHeight, r=ShaftR, $fn=96);
        {
            // central shaft lower section with square cutout
            translate([MagicM,0,0])
            linear_extrude(250)
            difference() {
                circle(JointR, $fn=96);
                rotate([0, 0, 120])
                square([InsertE+30, InsertCapX+30], center=true);
                //circle(InsertR, $fn=6);
            }
            // central shaft upper section without square cutout
            translate([MagicM,0,250])
            linear_extrude(LayerUnit-250)
                circle(JointR, $fn=96);
            linear_extrude(LayerUnit)
            {
                translate([0, 0, 0]) circle(JointR, $fn=96);
                // strut
                translate([JointR, 0, 0]) square([200, 400], center=true);
                // central shaft
//                translate([MagicM,0,0])
//                difference() {
//                    circle(JointR, $fn=96);
//                    circle(ShaftR/3*2+16, $fn=6);
//                }
            }
        }
    }
}

//// lower
module cam2()
{
    shaftHeight = SpacedLayer + JointVertSpace;
    // two sections of the shaft base
    // lower section
    union() {
        linear_extrude(LayerUnit-100)
        circle(JointR, $fn=96);
        // upper section with square cutout
        translate([0, 0, LayerUnit-101])
        linear_extrude(101)
        difference() {
            circle(JointR, $fn=96);
            square([InsertE+30, InsertCapX+30], center=true);
            //circle(InsertR, $fn=6);
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
    // shaft lower section
    translate([0, 0, LayerUnit])
    linear_extrude(shaftLower)
    difference() {
        circle(ShaftR, $fn=96);
        square([InsertE+30, InsertCapX+60], center=true);
    }

    // shaft upper section
//    translate([0, 0, LayerUnit+shaftLower])
//    linear_extrude(shaftUpper)
//    difference() {
//    circle(ShaftR, $fn=96);
//    circle(InsertR, $fn=6);
//    }
    
//    #translate([0, 0, LayerUnit+shaftHeight-15])
//    linear_extrude(LayerUnit+10)
//    circle(ShaftR/3*2, $fn=6);
}

module cap2()
{
    polygon(points = [[0, 0],[1,0],[0,1]]);
}

// Outer joint plus half the rod
module spine(layers) {
    cam2();
    translate([0, 1000, 0])
    cam();
    translate([0, 2000, 0])
}

scale(ViewScale) {
    spine(5);
}

