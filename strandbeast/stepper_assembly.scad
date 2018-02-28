include <defs.scad>
include <model_stepper.scad>
include <vertebrae.scad>

module tab() {
    difference()
    {
        union() {
            circle(277/2, $fn=96);
            translate([-75, 0, 0])
            square([150, 277], center=true);
        }
        circle(116/2, $fn=96);
    }
}

module shroud1(offset)
{
    //linear_extrude(710)
    difference()
    {
        union()
        {
            circle(1290/2, $fn=96);
            translate([0, offset, 0])
            square([850, 490], center=true);
        }
        union()
        {
            circle(1140/2, $fn=96);
            translate([0, -500, 0])
            square([700, 440], center=true);
        }
    }
}

module shroud2(offset)
{
    //linear_extrude(710)
    difference()
    {
        union()
        {
            circle(1290/2, $fn=96);
            translate([0, offset, 0])
            square([850, 490], center=true);
            translate([1100/2+277/2, 0, 710-32])
            tab();

            translate([-(1100+277)/2, 0, 710-32])
            rotate([0, 0, 180])
            tab();
        }
        union()
        {
            circle(1140/2, $fn=96);
            translate([0, -500, 0])
            square([700, 440], center=true);
        }
    }
}

module motorShroud()
{
    translate([0, 0, 718])
    linear_extrude(42)
    difference()
    {
        shroud1(-470);
        square([1500, 300], center=true);
    }

    translate([0, 0, 568])
    linear_extrude(150)
    {
        shroud2(-470);
    }

    translate([0, 0, 50])
    linear_extrude(560)
    shroud2(-550);
//
//    //translate([0, 0, 710])
    linear_extrude(50)
    union()
    {
        circle(1290/2, $fn=96);
        translate([0, -550, 0])
        square([850, 490], center=true);
    }
}

module shroudArm(x, y)
{
    // central hole
    *circle(y, $fn=96);
    difference() {
        translate([-spineLength/2, 0, 0])
        square([spineLength, StrutWidth*2-x], center = true);
        // bite of of center
        circle(1080/2, $fn=96);
        //circle(1290/2, $fn=96);
        // bite out of base end
        translate([-spineLength, 0,0])
        circle(y+15, $fn=96);
    }
}

module shroudArms()
{
//    linear_extrude(718)
//    {
//    difference() {
//      shroudArm(100, JointR);
//    shroudArm(300, JointR+100);
//    }
//    rotate([0, 0, 180-33.32]) 
//    difference() {
//    shroudArm(100, JointR);
//    shroudArm(300, JointR+100);
//    }
//    }
//    translate([0, 0, 718])
//    {
//    linear_extrude(42)
//    shroudArm(100, JointR);
//    rotate([0, 0, 180-33.32]) 
//    linear_extrude(42)
//    shroudArm(100, JointR);
//    }

    // Shroud top
//    linear_extrude(50)
//    {
//    shroudArm(100, JointR);
//    rotate([0, 0, 180-33.32]) 
//    shroudArm(100, JointR);
//    rotate([180, 0, 270-33.32]) 
//    union()
//    {
//        circle(1290/2, $fn=96);
//        translate([0, -550, 0])
//        square([850, 490], center=true);
//    }
//    }

    // Top cover
    linear_extrude(100)
    {
    difference() {
        union() {
        rotate([0, 0, 180-33.32]) 
        shroudArm(100, JointR);
        shroudArm(100, JointR);
        }
//        shroudArm(300, JointR+100);
//        rotate([0, 0, 180-33.32]) 
//        shroudArm(300, JointR+100);
    }

    rotate([180, 0, 270-33.32]) 
    difference()
    {
        union()
        {
            circle(1290/2, $fn=96);
            translate([0, -550, 0])
            square([850, 490], center=true);
        }
//        union()
//        {
//            circle(1090/2, $fn=96);
//            translate([0, -550, 0])
//            square([750, 490], center=true);
//        }
    }
    }
}

module shroudTopCover()
{
    rotate([0, 0, 180-33.32]) 
    shroudArm(100, JointR);
    shroudArm(100, JointR);

    rotate([180, 0, 270-33.32]) 
    difference()
    {
        union()
        {
            circle(1290/2, $fn=96);
            translate([0, -550, 0])
            square([850, 490], center=true);
        }
    }
}

module shroudBody()
{
    // one arm facing square part of motor body
    rotate([0, 0, 180-33.32]) 
    difference() {
        shroudArm(100, JointR);
        shroudArm(300, JointR+100);
        translate([-600, 0, 0])
        square([380, 700], center=true);
    }

    // one arm facing the other side
    difference() {
        shroudArm(100, JointR);
        shroudArm(300, JointR+100);
        circle(1090/2, $fn=96);
//        translate([-600, 0, 0])
//        square([400, 700], center=true);
    }

    // motor shroud body
    rotate([180, 0, 270-33.32]) 
    difference()
    {
        union()
        {
            circle(1290/2, $fn=96);
            translate([0, -650, 0])
            square([850, 600], center=true);
        }
        union()
        {
            circle(1090/2, $fn=96);
            translate([0, -690, 0])
            square([600, 520], center=true);
        }
    }




    
//        difference() {
//            union() {
//        rotate([0, 0, 180-33.32]) 
//        shroudArm(300, JointR+100);
//        shroudArm(300, JointR+100);
//        }
//        rotate([0, 0, 90-33.32]) 
//        translate([0, -600, 0])
//        square([700, 400], center=true);
//        }
//    }
//
//    rotate([180, 0, 270-33.32]) 
//    difference()
//    {
//        union()
//        {
//            circle(1290/2, $fn=96);
//            translate([0, -550, 0])
//            square([850, 490], center=true);
//        }
//        union()
//        {
//            circle(1090/2, $fn=96);
//            translate([0, -600, 0])
//            square([700, 400], center=true);
//        }
//    }
} 

scale(ViewScale)
{
    translate([0, 0, 1640])
    rotate([180, 0, 270-33.32]) 
    translate([0, -(1100-363-63)/2, 0])
    {
//        translate([0, 0, 50])
//        color("CornflowerBlue") stepper();
//        motorShroud();
    }
//    translate([-spineLength, 0, 0])
//    color("LightSeaGreen") vertebrae();
//    translate([0, 0, 900])
//    shroudArms();

//    linear_extrude(100)
//    shroudTopCover();
    linear_extrude(500)
    shroudBody();
}

