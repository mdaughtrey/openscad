viewscale=[.02,.02,.02];
jointVertSpace=30;

// Outer joint plus half the rod
module strutA(rodw, rodl) {
    jointR = 400;
    shaftR = 200;
    difference() {
        union() {
            cylinder(300+jointVertSpace*2,r=jointR,$fn=96);
            // Strut
            translate([0,-rodw/2,0]) cube([rodl,rodw,300+jointVertSpace*2]);
        }
        // Cutout
        translate([0,0,100]) cylinder(100+jointVertSpace*2,r=440,$fn=96);
    }
    // Shaft
    translate([0,0,90]) cylinder(120+jointVertSpace*2,r=shaftR,$fn=96);
}

// Inner joint plus half the rod
module strutB(rodw, rodl)
{
    shaftHole=220;
    // Inner joint
    translate([0, 0, 100+jointVertSpace]) 
        difference() {
            // Inner joint
            cylinder(100, r=400,$fn=96);
            // Shaft hole
            translate([0,0,-10]) cylinder(120, r=shaftHole,$fn=96);
        }
    difference() {
        // Strut
        translate([60,-rodw/2,0]) cube([rodl-60,rodw,300+jointVertSpace*2]);
        union() {
            // Lower disc
            translate([0,0,-10]) cylinder(110+jointVertSpace, r=460,$fn=96);
            // Upper disc
            translate([0,0,200+jointVertSpace]) cylinder(100+jointVertSpace*2, r=460,$fn=96);
            // Shaft hole
            translate([0,0,90]) cylinder(110+jointVertSpace*2, r=shaftHole,$fn=96);
        }
    }
}

module strutAA(rodw, rodl) {
    strutA(rodw, rodl/2);
    translate([rodl, 0, 0]) rotate([0, 0, 180]) strutA(rodw, rodl/2);
}

module strutBB(rodw, rodl) {
    strutB(rodw, rodl/2);
    translate([rodl, 0, 0]) rotate([0, 0, 180]) strutB(rodw, rodl/2);
}

//scale(viewscale) { strutB(500, 2000); rotate([0, 0, 180]) strutAA(500, 2000); }
scale(viewscale) { strutBB(500, 2000); rotate([0, 0, 180]) strutAA(500, 2000); }
