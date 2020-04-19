ViewScale = [0.0254, 0.0254, 0.0254];

use <model_smallcog.scad>
use <model_bigcog.scad>
use <model_arm.scad>
use <model_motor.scad>

module models()
{
    rotate([0, 90, 0])
    color("SteelBlue")
    model_motor();

    translate([750, 0, 0])
    rotate([0, 90, 0])
    color("Aqua")
    model_smallcog();

    translate([760, -1250/2-530/2+50, 0])
    rotate([0, 90, 0])
    color("PaleGreen")
    model_bigcog();

    translate([1760, -1250/2-530/2+50, 0])
    //rotate([90, 0, 0])
    rotate([0, -90, 0])
    color("SpringGreen")
    model_arm();
}

module wall1() 
{
    linear_extrude(100)
    difference() {
        translate([0, -550, 0])
        square([1500, 2000], center=true);
        translate([492, 0, 0])
        circle(130/2, $fn=96);
        translate([-492, 0, 0])
        circle(130/2, $fn=96);
        circle(520/2, $fn=96);
    }
    translate([0, 0, 99])
    linear_extrude(92)
    difference() {
        circle(620/2, $fn=96);
        circle(520/2, $fn=96);
    }
}

module wall2()
{
    linear_extrude(86)
    difference() {
        translate([0, -550, 0])
        square([1500, 2000], center=true);

        translate([0, -1250/2-530/2+50, 0])
        circle(510, $fn=96);
        translate([492, 0, 0])
        circle(180/2, $fn=96);
        translate([-492, 0, 0])
        circle(180/2, $fn=96);
    }
}

module w3_section(dia)
{
    difference() {
        circle(dia/2+50, $fn=96);
        difference() {
            circle(dia/2, $fn=96);
            translate([560/2+30, 0, 0])
            square([180, 117], center=true);
            translate([-560/2-30, 0, 0])
            square([180, 117], center=true);
        }
    }
}

module wall3()
{
    linear_extrude(101) {
    translate([0, -1250/2-530/2+50, 0]) {
    difference() {
        square([1500, 1420], center=true);
        circle(580/2, $fn=96);
    }
    w3_section(580);
    }}
}

module armshaft()
{
    linear_extrude(255)
    translate([0, -1250/2-530/2+50, 0]) 
    w3_section(580);
}

module endwalls()
{
    linear_extrude(1185) {
        translate([0, -1600, 0])
        square([1500, 100], center=true);
        translate([0, 400, 0])
        square([1500, 100], center=true);
    }
}

module truss()
{
    translate([-750, -960, 0])
    rotate([90, 0, 0])
    linear_extrude(150)
    difference() {
        polygon(points=[[0,0],[1500,0],[1500,-2500]]);
        translate([900, -400, 0])
        circle(400, $fn=96);
    }
}

module vexmount()
{
    linear_extrude(100)
    difference() {
        hull() {
            circle(170, $fn=96);
            translate([2500, 0, 0])
            circle(170, $fn=96);
        }
        hull() {
            circle(90, $fn=96);
            translate([2500, 0, 0])
            circle(90, $fn=96);
        }
    }

    linear_extrude(200)
    difference() {
        hull() {
            circle(260, $fn=96);
            translate([2500, 0, 0])
            circle(260, $fn=96);
        }
        hull() {
            circle(160, $fn=96);
            translate([2500, 0, 0])
            circle(160, $fn=96);
        }
    }
}

module base() 
{
    linear_extrude(100)
    difference() {
        square([2000, 1170], center=true);
        circle(1200/2, $fn=96);
    }
}

module feedmount()
{
    *translate([0, 0, -500])
    rotate([0, -90, 0])
    models();
    wall1();

    translate([0, 0, 1100])
    wall2();

    translate([0, 0, 1000])
    wall3();

    translate([0, 0, 750])
    armshaft();

    endwalls();

    truss();

    translate([750, -1300, -2650])
    rotate([0, -90, 0])
    vexmount();

    translate([750, -800, -2650])
    rotate([0, -90, 0])
    vexmount();

    translate([650, -550, 600])
    rotate([90, 0, 0])
    rotate([0, 90, 0])
    base();
}

scale(ViewScale)
{
    feedmount();
}
