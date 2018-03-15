include <../defs.scad>
include <model-geared2.scad>
include <../driver_vertebrae.scad>
include <../driverinsert.scad>
include <../drivercam.scad>

module tab() {
    difference()
    {
        union() {
            circle(277/2, $fn=96);
            translate([-75, 0, 0])
            square([150, 300], center=true);
        }
        circle(116/2, $fn=96);
    }
}

module segments()
{
    segs = 6;
    outer = 1290/2;
    inner = 990/2;
    hub = 300/2;
    difference() {
        circle(outer, $fn=96);
    circle(hub, $fn=96);
    difference() {
    circle(outer, $fn=96);
    circle(inner, $fn=96);
    }
    for (isegs = [0: segs])
    {
        rotate([0, 0, isegs*(360/segs)])
        square([10+2*inner, 200], center=true);
    }
    }
}


module armShapeOuter()
{
    difference() {
        square([spineLength, StrutWidth*2], center = true);
        // bite of of center
        //circle(1080/2, $fn=96);
        //circle(1290/2, $fn=96);
        // bite out of base end
        translate([-spineLength/2+20, 0,0])
        circle(JointR+15, $fn=96);
    }
}

module shroudShapeOuter()
{
    translate([-spineLength/2, 0, 0])
    armShapeOuter();
    circle(JointR, $fn=96);
    rotate([0, 0, -33.32]) 
    translate([spineLength/2, 0, 0])
    {
        rotate([0, 0, 180])
        armShapeOuter();
        translate([-spineLength/2, 0, 0])
        translate([(1100-363-63)/2, 0, 0])
        circle(1590/2, $fn=96);
        square([600, 850], center=true);
    }
}

module armShapeInner()
{
    difference() {
        square([spineLength, StrutWidth*2-200], center = true);
        // bite out of base end
        translate([-spineLength/2+100, 0,0])
        circle(JointR+15, $fn=96);
    }
}

module shroudShapeInner()
{
    translate([-spineLength/2, 0, 0])
    armShapeInner();
    circle(JointR-100, $fn=96);
    rotate([0, 0, -33.32]) 
    translate([spineLength/2, 0, 0])
    {
        rotate([0, 0, 180])
        armShapeInner();
        translate([-spineLength/2, 0, 0])
        translate([(1100-363-63)/2, 0, 0])
        circle(1460/2, $fn=96);
        square([600, 720], center=true);
    }
}

module tabHoleCutout()
{ 
    rotate([0, 0, -33.32]) 
    translate([(1100-363-63)/2, 0, 0])
    {
        rotate([0, 0, 90])
        translate([1290/2+50, 0, 0])
        circle(116/2, $fn=96);
        rotate([0, 0, -90])
        translate([1290/2+50, 0, 0])
        circle(116/2, $fn=96);
    }
}

module wireCutout()
{
    rotate([0, 0, -33.32]) 
    translate([(1100-363-63)/2, 0, 0])
    translate([spineLength/2+180, 0, 0])
    square([200, 360], center=true);
//    circle(180, $fn=96);
}

module circleSegs()
{ 
    rotate([0, 0, -33.32]) 
    translate([(1100-363-63)/2, 0, 0])
    {
//        rotate([0, 0, 90])
//        translate([1290/2, 0, 0])
        segments();
//        circle(116/2, $fn=96);
//        rotate([0, 0, -90])
//        translate([1290/2, 0, 0])
//        circle(116/2, $fn=96);
    }
}

module tabs()
{
    rotate([0, 0, -33.32]) 
    translate([(1100-363-63)/2, 0, 0])
    {
        rotate([0, 0, 90])
        translate([1290/2+50, 0, 0])
        tab();
        rotate([0, 0, -90])
        translate([1290/2+50, 0, 0])
        tab();
    }
}

module shroud()
{
    // Cover
//    linear_extrude(50)
//    difference() {
//        union() {
//            shroudShapeOuter();
//            tabs();
//        }
//        tabHoleCutout();
//        circleSegs();
//        wireCutout();
//    }

    // Body 1
//    translate([0, 0, 50])
//    linear_extrude(710)
//    difference() {
//        union() {
//            shroudShapeOuter();
//            tabs();
//        }
//        tabHoleCutout();
//        shroudShapeInner();
//        wireCutout();
//    }

    // Body 2
//    translate([0, 0, 460])
//    linear_extrude(300)
//    difference() {
//        union() {
//            shroudShapeOuter();
//            tabs();
//        }
//        tabHoleCutout();
//        shroudShapeInner();
//    //    wireCutout();
//    }

    // Tab cutouts
//    translate([0, 0, 760])
//    linear_extrude(50)
    difference() {
        shroudShapeOuter();
        shroudShapeInner();
 //       tabs();
 //       tabHoleCutout();
        wireCutout();
 //       circle(JointR+20, $fn=96);
    }
}


scale(ViewScale)
{
//    translate([0, 0, 1640])
//    *rotate([0, 0,90]) 
//    translate([0, (1100-363-63)/2, 0])
//    {
//        translate([0, 0, 1650])
//        rotate([180, 0, 0])
//        color("CornflowerBlue") stepper();
//    }
    translate([-spineLength, 0, 0])
    color("LightSeaGreen") driver_vertebrae();

    !translate([0, 0, 1700])
    rotate([180, 0, 180-33.32])
    shroud();

    *#translate([0, 0, 260])
    driver_insert();

    *translate([0, 0, 300])
    driver_cam();
}

