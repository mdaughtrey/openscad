include <defs.scad>

StrutWidth = 400;
rrectR = 100;
//LayerUnit = 300;
JointVertSpace=20;
//ShaftHole=220;
ShaftSleeve = 200;

module rectHull(r, x, y)
{
    hull()
    {
        // place 4 circles in the corners, with the given r
        translate([(-x/2)+(r/2), (-y/2)+(r/2), 0])
            circle(r=r);

        translate([(x/2)-(r/2), (-y/2)+(r/2), 0])
            circle(r=r);

        translate([(-x/2)+(r/2), (y/2)-(r/2), 0])
            circle(r=r);

        translate([(x/2)-(r/2), (y/2)-(r/2), 0])
            circle(r=r);
    }
}

// rounded rectangle
module rrect(z, y, x)
{
    y = y - rrectR;
    x = x - rrectR;
    //translate([0, rrectR+x/2, y/2]) // rrectR/2+y/2])
    translate([0, rrectR+x/2, x/2+rrectR/4]) // rrectR/2+y/2])
    rotate([0, 90, 0]) 
    linear_extrude(z)
    rectHull(rrectR/2, x, y);
}

module halfSpine2(layers)
{
    linkLength = 520;
    baseHeight = LayerUnit * 2 + JointVertSpace + (3 * SpacedLayer) - 20;
    shaftHeight = SpacedLayer * 2 + linkLength - 70;
    // insertion hole
    linear_extrude(5*SpacedLayer+100) 
    difference() {
        circle(JointR, $fn=96);
        circle(ShaftTight, $fn=96);
    }

    // base with cutout
    *translate([0, 0, 3*SpacedLayer])
   // linear_extrude(baseHeight - linkLength) 
    linear_extrude(750) 
    difference() {
        circle(JointR, $fn=96);
        circle(ShaftTight, $fn=96);
//        translate([250, 0, 0])
//        square([300, 350], center=true);
    }

    // base without cutout
    *translate([0, 0, 3*SpacedLayer+550])
    linear_extrude(200) 
    difference() {
        circle(JointR, $fn=96);
        circle(ShaftTight, $fn=96);
    }

    // shaft
    *translate([0, 0, baseHeight-1])
    linear_extrude(shaftHeight) 
    difference() {
        circle(ShaftR, $fn=96);
        circle(40, $fn=4);
    }

    // central hole
    translate([spineLength, 0, SpacedLayer * 2 -20])
    linear_extrude(LayerUnit) 
    difference() {
        circle(JointR, $fn=96);
        circle(ShaftHole, $fn=96);
    }
    translate([0,-200,2*SpacedLayer])
    difference() {
        rrect(spineLength, StrutWidth*2, LayerUnit);
        // bite out of central end
        translate([spineLength, StrutWidth/2, -1])
        linear_extrude(LayerUnit)
        circle(ShaftHole, $fn=96);
        // bit out of base end
        translate([0, StrutWidth/2, -1])
        linear_extrude(LayerUnit)
        circle(ShaftHole, $fn=96);
    }
}

//module halfSpine(layers)
//{
//    linkLength = 520;
//    layerSpace = SpacedLayer*layers;
//    baseHeight = LayerUnit * 2 + JointVertSpace + (3 * SpacedLayer) - 20;
//    shaftHeight = SpacedLayer * 2 + linkLength- 70;
//
//    difference() {
//        union() {
//            // shaft + base
//                difference(){
//                    union() {
//                    translate([0, 0, baseHeight])
//                        cylinder(shaftHeight, r=ShaftR,$fn=96); // shaft
//                    // strut
//// temp                    translate([0,-200,2*SpacedLayer]) rrect(spineLength, StrutWidth*2, LayerUnit);
//                }
//                union() {
//                // hole in shaft
//                translate([0, 0, -2]) cylinder(baseHeight + shaftHeight,r=40,$fn=4);
//                // insertion hole
//                translate([0, 0, -1]) cylinder(linkLength, r=ShaftTight, $fn=96);
//                }
//                }
//            // central joint
//// temp            translate([spineLength,0,SpacedLayer * 2-20]) cylinder(LayerUnit, r=JointR, $fn=96);
//        }
//        // shaft hole
//        translate([spineLength,0,SpacedLayer*1-1]) cylinder(LayerUnit*3, r=ShaftHole, $fn=96);
//    }
//}

//// upper
//module cam()
//{
//    shaftHeight = SpacedLayer * 5;
//    // Cam
////    translate([0, 0, 0]) { difference() {
//        union() {
//            // shaft
//            translate([0, 0, LayerUnit]) cylinder(shaftHeight, r=ShaftR, $fn=96);
//            translate([0, 0, 0]) cylinder(LayerUnit, r=JointR, $fn=96);
//            // strut
//            translate([0, -200, 0]) cube([MagicM, 400, LayerUnit]);
//            // central shaft
//            translate([MagicM,0,0]) cylinder(LayerUnit, r=JointR, $fn=96);
//        }
//        // hex cutout
////        translate([MagicM,0,-10]) cylinder(220, r=ShaftTight, $fn=96);
////        }
////    }
//}
//
//// lower
//module cam2()
//{
//    shaftHeight = SpacedLayer * 2 + JointVertSpace;
//    // Cam
//    translate([0, 0, 0]) { difference() {
//        union() {
//            // shaft
//            translate([0, 0, 0]) cylinder(shaftHeight, r=ShaftR, $fn=96);
//            // shaft circle
//            translate([0, 0, 0]) cylinder(LayerUnit, r=JointR, $fn=96);
//            // strut
//            translate([0, -200, 0]) cube([MagicM, 400, LayerUnit]);
//            // central shaft
//            translate([MagicM,0,0]) cylinder(LayerUnit, r=JointR, $fn=96);
//        }
//        translate([MagicM,0,-1]) cylinder(LayerUnit+2, r=ShaftTight, $fn=96);
//        }
//    }
//}

// Outer joint plus half the rod
module spine(layers) {
    halfSpine2(layers);
    translate([spineLength, 0, 0]) rotate([0, 0, 180-33.32]) 
    translate([-spineLength, 0, 0]) halfSpine2(layers);
}

// Inner joint plus half the rod
//module strutB(rodw, rodl)
//{
//    // Inner joint
////    translate([0, 0, 100+JointVertSpace]) 
//        difference() {
//            // Inner joint
//            cylinder(100, r=400,$fn=96);
//            // Shaft hole
//            translate([0,0,-10]) cylinder(120, r=ShaftHole,$fn=96);
//        }
//      translate([260,-rodw/2,0]) cube([rodl-260,rodw,100]);
//}

//module strutAA(rodw, rodl, layers) {
//    strutA(rodw, rodl/2, layers);
//    translate([rodl, 0, 0]) rotate([0, 0, 180]) strutA(rodw, rodl/2, layers);
//}
//
//module strutBB(rodw, rodl) {
//    strutB(rodw, rodl/2, 0);
//    translate([rodl, 0, 0]) rotate([0, 0, 180]) strutB(rodw, rodl/2);
//}
//
//module strutAB(rodw, rodl, layers) {
//    strutA(rodw, rodl/2, layers);
//    translate([rodl, 0, 0]) rotate([0, 0, 180]) strutB(rodw, rodl/2);
//}
//
//module strutBA(rodw, rodl, layers) {
//    strutB(rodw, rodl/2);
//    translate([rodl, 0, 0]) rotate([0, 0, 180]) strutA(rodw, rodl/2, layers);
//}


//function loCosA(lenA, lenB, lenC) =
//    acos(((lenB * lenB) + (lenC * lenC) - (lenA * lenA)) / (2 * lenB * lenC));
//
//function loCosB(lenA, lenB, lenC) =
//     acos(((lenA * lenA) + (lenC * lenC) - (lenB * lenB)) / (2 * lenA * lenC));
//
//function loCosC(lenA, lenB, lenC) =
//     acos(((lenA * lenA) + (lenB * lenB) - (lenC * lenC)) / (2 * lenA * lenB));
//
//module triangle(rodw, lenA, lenB, lenC) {
//    strutBB(rodw, lenC);
//    rotate([0, 0, loCosA(lenA, lenB, lenC)]) strutBB(rodw, lenB);
//    translate([lenC, 0, 0]) rotate([0, 0, 180-loCosB(lenA, lenB, lenC)]) strutBB(rodw, lenA);
//}

//module collar() {
//    // Collar
//    difference() {
//        cylinder(150, r=JointR, $fn=96);
//        translate([0, 0, -2]) cylinder(SpacedLayer*3+5, r=ShaftTight, $fn=96);
//    }
//}

//scale(ViewScale) {
 module driver_vertebrae() {
    spine(5);
}

