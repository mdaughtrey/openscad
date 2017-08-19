ViewScale=[.02,.02,.02];
//ViewScale=[1,1,1];
JointVertSpace=30;
OneLayer=100+JointVertSpace;
JointR = 400;
ShaftR = 200;
ShaftHole=230;

MagicMult = 50;
// Leg Triangle
MagicG = MagicMult * 36.7; // a
MagicH = MagicMult * 65.7; // c
MagicI = MagicMult * 49;   // b

// Driver Triangle
MagicB = MagicMult * 41.5;
MagicD = MagicMult * 40.1;
MagicE = MagicMult * 55.8;

// Front Strut
MagicC = MagicMult * 39.3;
FsLen = MagicC;

// Back Strut
MagicF = MagicMult * 39.4;
BsLen = MagicF;

// Lower Driver Strut
MagicK = MagicMult * 81.9;

// Upper Driver Strut
MagicJ = MagicMult * 50;

// Outer joint plus half the rod
// rodwidth, rodlength, layers
module strutA(rodw, rodl, layers) {
    layerSpace = OneLayer*layers+JointVertSpace;
    echo("layerSpace ",layerSpace);
    difference() {
        union() {
            cylinder(200+layerSpace,r=JointR,$fn=96);
            // Strut
            translate([0,-rodw/2,0]) cube([rodl,rodw,100]);
            //translate([0,-rodw/2,0]) cube([rodl,rodw,300+JointVertSpace*2]);
        }
        // Cutout
        translate([0,0,100]) cylinder(layerSpace,r=440,$fn=96);
    }
    // Shaft
    translate([0,0,0])
        cylinder(200+layerSpace, r=ShaftR,$fn=96);
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


scale(ViewScale) {
//    lenA = MagicC;
    legLen = MagicG;
    //lenC = MagicF;
    driverLen = MagicD;

    lenX = sqrt(pow(FsLen, 2) + pow(driverLen, 2));
    echo("FsLen ",FsLen," legLen ",legLen," BsLen ",BsLen," driverLen ",driverLen);
    echo("lenX ",lenX);
    angA1 = acos(FsLen/lenX);
    angC1 = acos(driverLen/lenX);
    angD1 = 180.0 - angA1 - angC1;
    echo("angA1 ",angA1," angC1 ",angC1," angD1 ",angD1);

    lenY = sqrt(pow(FsLen, 2) + pow(legLen, 2));
    echo(" lenY ",lenY);
    angB2 = acos(BsLen/lenY);
    angC2 = acos(BsLen/lenX);
    angA2 = 180.0 - angB2 - angC2;
    echo("angA2 ",angA2," angB2 ",angB2," angC2 ",angC2);
    angA = angA1 + angA2;
    angB = angB2;
    angC = angC1 + angC2;
    angD = angD1;
    echo("angA ",angA," angB ",angB," angC ",angC," angD ",angD);


    //translate([0, 0, 100 + JointVertSpace/2]) {
    translate([0, 0, 100 + JointVertSpace]) {
        // leg triangle
        translate([MagicH, 0, 0]) rotate([0, 0, 180]) triangle(200, MagicG, MagicI, MagicH);
        //dtA = loCosA(MagicB, MagicD, MagicE);
        //translate([0, 0, 0]) rotate([0, 0, 0]) triangle(200, MagicB, MagicD, MagicE);
        rotate([0, 0, angB-0.5]) {
            // driver triangle
            translate([-MagicC, 0, 0]) rotate([0, 0, -angA])
            {
                // Upper Driver Strut
                translate([MagicE, 0, 200+JointVertSpace]) rotate([180, 0, 115])
                    strutAB(200, MagicJ, 1);
                    //strutBB(200, MagicJ);
                triangle(200, MagicB, MagicD, MagicE);
            }
            // front strut
            //translate([-MagicC, 0, 100 + JointVertSpace/2]) strutBB(200, FsLen);
            translate([-MagicC, 0, 200 + JointVertSpace])
                rotate([180, 0, 0]) strutAA(200, FsLen, 1);
        }
        // back strut
        fsA = MagicG * cos(loCosB(MagicG, MagicI, MagicH));
        fsB = MagicG * sin(loCosB(MagicG, MagicI, MagicH));
        echo("fsA ",fsA," fsB ",fsB);
        translate([-MagicF+fsA+FsLen, -fsB, 100 + JointVertSpace])
            rotate([0, 0, -angC-angB+0.5])  strutBB(200, MagicF);
    }
    // Lower Driver Strut
    lsA = MagicG * cos(loCosB(MagicG, MagicI, MagicH));
    lsB = MagicG * sin(loCosB(MagicG, MagicI, MagicH));
    //translate([lsA, -lsB, 0]) strutBB(200, MagicK);
    translate([lsA, -lsB, 0]) rotate([0, 0, 235]) strutAB(200, MagicK, 2);
}

//scale(ViewScale) { strutAA(400,2500,2); }
//scale(ViewScale) { strutBB(400,2500); }
//scale(ViewScale) { strutA(400, 2000, 2); 
//    translate([0, 0, OneLayer]) strutB(400,1500);
//    translate([0, 0, 2*OneLayer]) strutB(400,1000);
//    }
