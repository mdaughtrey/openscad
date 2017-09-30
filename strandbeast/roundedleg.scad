include <defs.scad>
include <arc.scad>
//ViewScale=[.02,.02,.02];
LayerUnit = 300;
StrutWidth = 400;
rrectR = 100;

// https://www.thingiverse.com/thing:9347
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
    translate([0, rrectR+x/2, 0]) // rrectR/2+y/2])
    rotate([0, 90, 0]) 
    linear_extrude(z)
    rectHull(rrectR/2, x, y);
}

module arcStrut(sweep, radius, height, width)
{
    intersection() {
        linear_extrude(1000)
        hull(){
            polygon([[0, 0], [0, radius*1.5], [radius*1.5*sin(sweep), radius*1.5*cos(sweep)]]);
        }
        translate([0, 0, height/2])
        rotate_extrude($fn=96) 
        {
            echo("r ",radius," h ",height," w ",width);
            translate([radius, 0,0 ])
            rectHull(rrectR,width*3/4, height/2);
            //rectHull(250,height, width/2);
            //rrect(height, width);
        }
    }
}

module cap(height, radius)
{
    translate([0, 0, height/2])
    rotate_extrude($fn=96) 
    {
        corner = 100;
        translate([height/2, 0, 0]) //rrect(radius, height);
        hull()
        {
            translate([(-radius/2)+(corner/2), (-height/2)+(corner/2), 0])
                square(corner);

            translate([(radius/2)-(corner/2), (-height/2)+(corner/2), 0])
                square(corner);

            translate([(-radius/2)+(corner/2), (height/2)-(corner/2), 0])
                square(corner);

            translate([(radius/2)-(corner/2), (height/2)-(corner/2), 0])
                circle(r=corner);
        }
    }
}

// Outer joint plus half the rod
// rodwidth, rodlength, layers
module strutA(rodw, rodl, layers) {
    layerSpace = SpacedLayer*layers+JointVertSpace;
    echo("layerSpace ",layerSpace);
    difference() {
        union() {
            cylinder((LayerUnit * 2)+layerSpace,r=JointR,$fn=96);
            // Strut
            translate([0,-rodw/2,LayerUnit/2]) rrect(rodl,rodw,LayerUnit);
//            translate([0,-rodw/2,0]) cube([rodl,rodw,LayerUnit]);
        }
        // Cutout
        translate([0,0,LayerUnit]) cylinder(layerSpace,r=440,$fn=96);
    }
    // Shaft
    translate([0,0,0])
        cylinder((LayerUnit * 2)+layerSpace, r=ShaftR,$fn=96);
}

// Inner Joint
module jointB()
{
    difference() {
        // Inner joint
        cylinder(LayerUnit, r=400,$fn=96);
        // Shaft hole
        translate([0,0,-1]) cylinder(LayerUnit + 2, r=ShaftHole,$fn=96);
    }
}

// Inner joint plus half the rod
module strutB(rodw, rodl)
{
    translate([260,-rodw/2,LayerUnit/2]) rrect(rodl-260,rodw,LayerUnit);
    //translate([260,-rodw/2,0]) cube([rodl-260,rodw,LayerUnit]);
    jointB();
}

module strutAA(rodw, rodl, layers) {
    strutA(rodw, rodl/2, layers);
    translate([rodl, 0, 0]) rotate([0, 0, 180]) strutA(rodw, rodl/2, layers);
}

module strutBB(rodw, rodl) {
    strutB(rodw, rodl/2, 0);
    translate([rodl, 0, 0]) rotate([0, 0, 180]) strutB(rodw, rodl/2);
}

module strutBC(rodw, rodl) 
{
    translate([260,-rodw/2,100])
    {
        translate([0, 100, 0]) cylinder(300, r=100,$fn=96);
        cube([rodl/2,rodw,LayerUnit]);
        translate([2*LayerUnit+ rodl/2, rodw, 0])
        rotate([-90,-90,180])
        linear_extrude(StrutWidth)
        polygon(points = [[0, 0], [0, 2*LayerUnit], [LayerUnit, 2*LayerUnit]], convexity = 0);
    }
    translate([rodl, 0, 0]) rotate([0, 0, 180]) strutB(rodw, rodl/2);
    translate([rodl/2-(2*LayerUnit), rodw/2, LayerUnit])
    rotate([0,90,-90])
    linear_extrude(StrutWidth)
    polygon(points = [[0, 0], [0, 2*LayerUnit], [LayerUnit, 2*LayerUnit]], convexity = 0);
}

module strutABArc(rodw, rodl,layers)
{
    layerSpace = SpacedLayer*layers+JointVertSpace;
    arcR = 3000;
    difference() {
        union() {
            cylinder((LayerUnit * 2)+layerSpace,r=JointR,$fn=96);
            // Strut
            translate([sin(30) * arcR,
                -cos(30) * arcR + JointR / 2,
                0]) 
            rotate([0, 0, 30])
            arcStrut(59, arcR, LayerUnit, rodw);
               // 3D_arc(w=rodw,r=arcR,deg=57,h=LayerUnit,fn=96);
        }
        // Cutout
        translate([0,0,LayerUnit]) cylinder(layerSpace,r=440,$fn=96);
    }
    // Shaft
    translate([0,0,0])
        cylinder((LayerUnit * 2)+layerSpace, r=ShaftR,$fn=96);
    translate([rodl, 0, 0]) jointB();
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

module foot()
{
    //rotate([-90,-90,180])
    //linear_extrude(200)
    //polygon(points = [[0, 0], [0, LayerUnit], [LayerUnit, LayerUnit]], convexity = 0);
    strutBC(StrutWidth, MagicH);
    rotate([0, 0, loCosA(MagicG, MagicI, MagicH)]) strutBC(StrutWidth, MagicI);
    translate([MagicH, 0, 0]) rotate([0, 0, 180-loCosB(MagicG, MagicI, MagicH)]) strutBB(StrutWidth, MagicG);
}

scale(ViewScale) {
    legLen = MagicG;
    driverLen = MagicD;

    lenX = sqrt(pow(FsLen, 2) + pow(driverLen, 2));
    angA1 = acos(FsLen/lenX);
    angC1 = acos(driverLen/lenX);
    angD1 = 180.0 - angA1 - angC1;

    lenY = sqrt(pow(FsLen, 2) + pow(legLen, 2));
    angB2 = acos(BsLen/lenY);
    angC2 = acos(BsLen/lenX);
    angA2 = 180.0 - angB2 - angC2;
    angA = angA1 + angA2;
    angB = angB2;
    angC = angC1 + angC2;
    angD = angD1;

    translate([0, 0, LayerUnit + JointVertSpace]) {
        // leg triangle
        translate([MagicH, 0, 0]) rotate([0, 0, 180]) foot();
        //dtA = loCosA(MagicB, MagicD, MagicE);
        //translate([0, 0, 0]) rotate([0, 0, 0]) triangle(200, MagicB, MagicD, MagicE);
        rotate([0, 0, angB-0.5]) {
            // driver triangle
            translate([-MagicC, 0, 0]) rotate([0, 0, -angA])
            {
                // Upper Driver Strut
                translate([MagicE, 0, (LayerUnit * 2) + JointVertSpace]) rotate([180, 0, 115])
                    strutAB(StrutWidth, MagicJ, 1);
                triangle(StrutWidth, MagicB, MagicD, MagicE);
            }
            // front strut
            //translate([-MagicC, 0, 100 + JointVertSpace/2]) strutBB(200, FsLen);
            translate([-MagicC, 0, (LayerUnit * 2) + JointVertSpace])
                rotate([180, 0, 0]) strutAA(StrutWidth, FsLen, 1);
        }
        // back strut
        fsA = MagicG * cos(loCosB(MagicG, MagicI, MagicH));
        fsB = MagicG * sin(loCosB(MagicG, MagicI, MagicH));
        translate([-MagicF+fsA+FsLen, -fsB, LayerUnit + JointVertSpace])
            rotate([0, 0, -angC-angB+0.5])  strutBB(StrutWidth, MagicF);
    }
    // Lower Driver Strut
    lsA = MagicG * cos(loCosB(MagicG, MagicI, MagicH));
    lsB = MagicG * sin(loCosB(MagicG, MagicI, MagicH));
    translate([lsA, -lsB, 0]) rotate([0, 0, 235]) strutABArc(StrutWidth, MagicK, 2);
}

