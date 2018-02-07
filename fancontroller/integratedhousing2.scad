use <model_adps9660.scad>

ViewScale = [0.0254, 0.0254, 0.0254];

module fpEdge(r1, r2)
{
    hull() {
    // PIR detector
    translate([500, -400, 0])
    circle(r1, $fn=96);
    // Gesture sensor
    //translate([-900-710, -900+710, 0])
    translate([-1400, -900+510, 0])
    circle(r2, $fn=96);
    }
}


module faceplate()
{
    linear_extrude(862)
    translate([0, 0, 30])
    {
        difference(){
            fpEdge(710, 710);
            fpEdge(610, 610); 
            translate([-500, -1050, 0])
            square([490, 120], center=true);
        }
        //difference() {
        //translate([-250, -900, 0])
        //square([590, 200], center=true);
        //translate([-250, -950, 0])
        //square([490, 100], center=true);
        //}
    }
    linear_extrude(30)
    difference() {
    fpEdge(710, 710);
    translate([165, -410, 0])
    circle(460, $fn=96);
    translate([-1450, -390, 0])
    square([321, 255], center=true);
    }

    // clip rails
    //translate([795/2+175-50, 295]) square([100, 100], center=true);
    //translate([795/2+175-50, -295]) square([100, 100], center=true);
}

// ----------------------------------------------------------------
//
// PIR Detector Housing
//
// ----------------------------------------------------------------
module rectHull(r, x, y)
{
    hull()
    {
        translate([(-x/2)+r, (-y/2)+r, 0]) circle(r=r);
        translate([(x/2)-r, (-y/2)+r, 0]) circle(r=r);
        translate([(-x/2)+r, (y/2)-r, 0]) circle(r=r);
        translate([(x/2)-r, (y/2)-r, 0]) circle(r=r);
    }
}

module enclosure_pirDetector()
{
    // outside cover
    linear_extrude(872) 
    difference() {
       rectHull(100, 1183, 1510);
       square([983, 1310], center=true);
       square([600, 1600], center=true);
       square([1400, 1000], center=true);
    }

    // Right support
    translate([0, (1280-140)/2, 350+65+227+60])
    linear_extrude(120)
    square([1000, 170], center=true);

    // Left support
    translate([0, -(1280-140)/2, 350+65+227+60])
    linear_extrude(120)
    square([1000, 170], center=true);

    // Dome base
    translate([0, 0, 762+60])
    linear_extrude(50)
    difference() {
        rectHull(100, 1183, 1510);
        circle(460, $fn=96);
    }
}

// ----------------------------------------------------------------
//
// Gesture Sensor Housing
//
// ----------------------------------------------------------------
module side(l,d)
{
    rotate([90, 0, 0])
    translate([-d, 0, -l/2])
    linear_extrude(l)
    polygon(points=[[0, 0], [d, 0],[d, d]]);
}

module sides(w, h, d)
{
    union() {
   translate([h/2, 0, 0])  rotate([0, 0, 0]) side(w,d);
   translate([-h/2, 0, 0])  rotate([0, 0, 180]) side(w,d);

   translate([0, w/2, 0])  rotate([0, 0, 90]) side(h,d);
   translate([0, -w/2, 0])  rotate([0, 0, -90]) side(h,d);
    }
}

module enclosure_gestureSensor()
{
    // main pcb surround
    translate([0, 0, 93+70])
    linear_extrude(469-70)
    {
    difference() {
    translate([0, 0, 0])
    rectHull(100, 968, 935);
    square([828, 795], center=true);
    }
    }

    // right support
    translate([(788-100)/2+3, -(755-500)/2-15, 300+70])
    linear_extrude(132)
    square([126, 500], center=true);

    // left support
    translate([-(788-100)/2-3, -(755-500)/2-15, 300+70])
    linear_extrude(132)
    square([126, 500], center=true);

    // cover
    translate([0, 0, 462+40])
    linear_extrude(60)
    difference() {
    rectHull(100, 968, 935);
    translate([0, 50, 0])
    square([254, 320], center=true);
    }

    // mounting around sensor
    // w,h,d 
    translate([0, 50, 432+70])
    {
        sides(321, 255, 60);
    }

    // mounting support
    translate([0, 50, 383+70])
    linear_extrude(50)
    difference() {
        square([605, 421], center=true);
        square([135, 201], center=true);
    }

    // surround with cutout for usb
    translate([0, 0, -300])
    linear_extrude(403+70) {
    difference() {
        translate([0, 0, 0])
        rectHull(100, 968, 935);
        square([828, 795], center=true);
        translate([0, -(755)/2, 0])
        square([502, 200], center=true);
        square([1000, 500], center=true);
        translate([0, 400, 0])
        square([500, 200], center=true);
    }
    // clip rails
    //translate([795/2+175-50, 295]) square([100, 100], center=true);
    //translate([795/2+175-50, -295]) square([100, 100], center=true);
    }
}

scale(ViewScale)
{
//    linear_extrude(900)
    faceplate();
    translate([165, -410, 872])
    rotate([180, 0, 90])
    enclosure_pirDetector();

    //translate([-900-710, 0, 562])
    translate([-1400, -390, 562])
    rotate([180, 0, -90])
    enclosure_gestureSensor();
//    translate([-1400, -380, 560-70])
//    rotate([180, 0, -90])
//    ADPS9660Carrier();
}
