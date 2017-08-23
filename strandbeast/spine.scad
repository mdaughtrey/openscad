include <defs.scad>
ViewScale=[.02,.02,.02];
//ViewScale=[1,1,1];
spineLength = sqrt(pow(MagicA, 2) + pow(MagicL,2));


module halfSpine(layers)
{
    layerSpace = SpacedLayer*layers;
    baseHeight = JointVertSpace + LayerUnit * 2;
    shaftHeight = 2*SpacedLayer+150;
    difference() {
        union() {
            // shaft + base
                difference(){ union() {
                    cylinder(baseHeight, r=JointR,$fn=96); // base
                    translate([0, 0, baseHeight])
                        cylinder(shaftHeight, r=ShaftR,$fn=96); // shaft
                    // strut
                    translate([0,-200,0]) cube([spineLength, 400, LayerUnit]);
                }
                union() {
                // hole in shaft
                translate([0, 0, -2]) cylinder(baseHeight + shaftHeight + 20,r=50,$fn=4);
                // insertion hole
                translate([0, 0, -5]) cylinder(165, r=ShaftTight, $fn=96);
                }}
            // central joint
            translate([spineLength,0,0]) cylinder(LayerUnit, r=JointR, $fn=96);
        }
        // shaft hole
        translate([spineLength,0,-10]) cylinder(220, r=ShaftHole, $fn=96);
//        translate([0,0,100]) cylinder(layerSpace,r=440,$fn=96);
    }
}

module cam()
{
    shaftHeight = SpacedLayer * 4 + LayerUnit;
    // Cam
    translate([0, -1000, 0]) { difference() {
        union() {
            // shaft
            translate([0, 0, 0]) cylinder(shaftHeight, r=ShaftR, $fn=96);
            // strut
            translate([0, -200, 0]) cube([MagicM, 400, LayerUnit]);
            // central shaft
            translate([MagicM,0,0]) cylinder(LayerUnit, r=JointR, $fn=96);
        }
        // hex cutout
        translate([MagicM,0,-10]) cylinder(220, r=ShaftHole, $fn=6);
        }
    }
}

module cam2()
{
    shaftHeight = SpacedLayer * 2 + LayerUnit;
    // Cam
    translate([0, -1000, 0]) { difference() {
        union() {
            // shaft
            translate([0, 0, 0]) cylinder(shaftHeight, r=ShaftR, $fn=6);
            // strut
            translate([0, -200, 0]) cube([MagicM, 400, LayerUnit]);
            // central shaft
            translate([MagicM,0,0]) cylinder(LayerUnit, r=JointR, $fn=96);
        }
        // hex cutout
        translate([MagicM,0,-10]) cylinder(220, r=ShaftTight, $fn=96);
        }
    }
}

// Outer joint plus half the rod
module spine(layers) {
    halfSpine(layers);
    translate([spineLength, 0, 0]) rotate([0, 0, 180-33.32]) 
    translate([-spineLength, 0, 0]) halfSpine(layers);

}

// Inner joint plus half the rod
module strutB(rodw, rodl)
{
    // Inner joint
//    translate([0, 0, 100+JointVertSpace]) 
        difference() {
            // Inner joint
            cylinder(100, r=400,$fn=96);
            // Shaft hole
            translate([0,0,-10]) cylinder(120, r=ShaftHole,$fn=96);
        }
      translate([260,-rodw/2,0]) cube([rodl-260,rodw,100]);
}

module strutAA(rodw, rodl, layers) {
    strutA(rodw, rodl/2, layers);
    translate([rodl, 0, 0]) rotate([0, 0, 180]) strutA(rodw, rodl/2, layers);
}

module strutBB(rodw, rodl) {
    strutB(rodw, rodl/2, 0);
    translate([rodl, 0, 0]) rotate([0, 0, 180]) strutB(rodw, rodl/2);
}

module strutAB(rodw, rodl, layers) {
    strutA(rodw, rodl/2, layers);
    translate([rodl, 0, 0]) rotate([0, 0, 180]) strutB(rodw, rodl/2);
}

module strutBA(rodw, rodl, layers) {
    strutB(rodw, rodl/2);
    translate([rodl, 0, 0]) rotate([0, 0, 180]) strutA(rodw, rodl/2, layers);
}


function loCosA(lenA, lenB, lenC) =
    acos(((lenB * lenB) + (lenC * lenC) - (lenA * lenA)) / (2 * lenB * lenC));

function loCosB(lenA, lenB, lenC) =
     acos(((lenA * lenA) + (lenC * lenC) - (lenB * lenB)) / (2 * lenA * lenC));

function loCosC(lenA, lenB, lenC) =
     acos(((lenA * lenA) + (lenB * lenB) - (lenC * lenC)) / (2 * lenA * lenB));

module triangle(rodw, lenA, lenB, lenC) {
    strutBB(rodw, lenC);
    rotate([0, 0, loCosA(lenA, lenB, lenC)]) strutBB(rodw, lenB);
    translate([lenC, 0, 0]) rotate([0, 0, 180-loCosB(lenA, lenB, lenC)]) strutBB(rodw, lenA);
}

module collar() {
    // Collar
    difference() {
        cylinder(LayerUnit+2, r=JointR, $fn=96);
        translate([0, 0, -2]) cylinder(LayerUnit+5, r=ShaftTight, $fn=96);
    }
}

scale(ViewScale) {
    spine(5);
    cam();
    translate([1700, -300, 0]) cam2();
    translate([0, -2000, 0]) collar();
    translate([1500, -2000, 0]) collar();

    // Drill driver
    *translate([0, -2000, 0]) cylinder(1000, r=220, $fn=6);
}

