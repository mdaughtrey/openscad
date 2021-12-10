include <model_steppergear.scad>
include <model_projmount.scad>
include <model_vexplate.scad>
//include <model_bolt.scad>
//include <setscrew_bearing.scad>
include <vexmount.scad>
include <adjuster.scad>
include <steppergear.scad>

ViewScale = [0.0254, 0.0254, 0.0254];

model = 0;

module model_cog()
{
    linear_extrude(270)
    circle(3580/2, $fn=96);
}

module captureTab()
{
    difference()
    {
        union()
        {
            circle(385/2, $fn=96);
            translate([285/2-1, 0, 0])
            square([285, 385], center = true);
        }
        circle(180/2, $fn=96);
    }
}

module axleTab()
{
//    linear_extrude(385)
    difference()
    {
        union()
        {
            circle(500/2, $fn=96);
            translate([250, 0, 0])
            square([500, 500], center = true);
        }
        circle(180/2, $fn=96);
    }
}

module adjusterCapture()
{
    linear_extrude(200)
    difference()
    {
        hull()
        {
            translate([-450, -275, 0])
            square([100, 100], center = true);
            translate([-450, 275, 0])
            square([100, 100], center = true);

            translate([450, -275, 0])
            square([100, 100], center = true);
            translate([300, 125, 0])
            circle(400/2, $fn=96);
        }
//        square([1000, 650], center=true);
        translate([0, 20, 0])
        circle(180/2, $fn=96);
        translate([-500, 20, 0])
        square([1000, 180], center = true);
    }
}

module frontStepperMount()
{
//    translate([0, 0, 3000])
    {
        linear_extrude(385)
        {
            difference()
            {
                square([1860, 1860], center=true);
                square([1560, 1560], center=true);
            }
            difference()
            {
                //square([1860, 1860], center=true);
                //circle(1860/2, $fn=96);
                circle(1620/2, $fn=96);
                circle(1440/2, $fn=96);
            }
        }
        translate([-1865/2+250, -1860/2-499, 0])
        rotate([0, 0, 90])
        {
            linear_extrude(385)
            {
                axleTab();
                // extended arm
                difference()
                {
                    translate([-850, 0, 0])
                    square([2000, 300], center = true);
                    circle(180/2, $fn=96);
                }

            }
            // Adjuster capture
            translate([-2300, 150, 700])
            rotate([90, 0, 0])
            adjusterCapture();
        }
        translate([-1865/2+250-150, -1860/2-499-2190, 385/2])
        {
            rotate([0, 90, 0])
            linear_extrude(300)
            {
                translate([0, 100, 0])
                square([385, 700], center = true);
                intersection()
                {
                    square([385, 2000], center = true);
                    translate([-385/2, -418+385/2, 0])
                    circle(385, $fn=96);
                }
            }
        }

        *translate([1860/2+280, -730, 190])
        rotate([90, 180, 0])
        linear_extrude(200)
        captureTab();

        *translate([1400, 650, 0])
        rotate([0, 0, 180])
        linear_extrude(385)
        axleTab();
    }
}

module rearStepperMount()
{
    linear_extrude(385)
    difference()
    {
        square([1860, 1860], center=true);
        square([1670, 1670], center=true);
        //square([1650, 1650], center=true);
        square([2000, 50], center=true);
    }

    // Link between mounts
    translate([0, 0, 384])
    linear_extrude(1300)
    intersection()
    {
        union()
        {
            translate([-800, -800, 0])
            square([500, 500], center=true);
            translate([800, -800, 0])
            square([500, 500], center=true);
        }

        difference()
        {
            square([1860, 1860], center=true);
            square([1650, 1650], center=true);
//            square([2000, 50], center=true);
        }
    }


    translate([-1865/2+250, -1860/2-499, 0])
    rotate([0, 0, 90])
    linear_extrude(385)
    axleTab();

    for (ii=[-20,125])
    {
        translate([-1860/2-250, ii, 385/2])
        rotate([90, 0, 0])
        linear_extrude(100)
        captureTab();
    }

    for (ii=[-20,125])
    {
        translate([1860/2+250, ii-100, 385/2])
        rotate([90, 0, 180])
        linear_extrude(100)
        captureTab();
    }
}

module supportArm()
{
//    translate([0, 0, 4500])
    linear_extrude(300)
    difference()
    {
        hull()
        {
            translate([-1865/2+250, -1860/2-499, 0])
            circle(250, $fn=96);
            translate([0, -2500, 0])
            circle(250, $fn=96);
        }
        translate([-1865/2+250, -1860/2-499, 0])
        circle(180/2, $fn=96);
        translate([0, -2500, 0])
        circle(945/2, $fn=96);
    }
}

module stepperMount()
{
    if (model == 1)
    {
        color("lightblue")
        translate([-1650/2, -1650/2, -800])
        model_steppergear();
    }
    rearStepperMount();
    // mattd
    translate([0, 0, 1540])
    frontStepperMount();
    *translate([0, 0, 3000])
    steppergear();
}

module forViewing()
{
    color("lightblue")
    translate([-1650/2, -1650/2, 0])
    model_steppergear();
    *color("lightblue")
    translate([-2850, -600, 1720])
    model_projmount();
    color("lightblue")
    translate([430, -4000, 2250])
    rotate([0, 90, 0])
    model_vexplate(5, 10);

    color("lightblue")
    translate([2500, -1450, 3000])
    rotate([0, 0, 90])
    rotate([0, 90, 0])
    model_vexplate(2, 8);

    color("lightblue")
    translate([0, -2500, 4000])
    model_cog();

    // Rear vexmount
    translate([0, -2500, 1550])
    vexmount2();
    translate([0, 0, 1550+400])
    supportArm();
    translate([0, 0, 1155])
    supportArm();

    // Front vexmount
    translate([0, -2500, 3450])
    rotate([180, 0, 0])
    vexmount();
    translate([0, 0, 3000-345])
    supportArm();

    translate([0, 0, 740])
    stepperMount();
//    frontStepperMount();
//    translate([0, 0, 740])
//    rearStepperMount();

    translate([2250, -1350, 3000])
    rotate([-90, 0, 0])
    model_adjuster();
}

module forViewing0()
{

    *color("lightblue")
    translate([-1650/2, -1650/2, 0])
    model_steppergear();
    *color("lightblue")
    translate([-2850, -600, 1720])
    model_projmount();
    color("lightblue")
    translate([430, -4000, 2250])
    rotate([0, 90, 0])
    model_vexplate(5, 10);

    color("lightblue")
    translate([2500, -1450, 3000])
    rotate([0, 0, 90])
    rotate([0, 90, 0])
    model_vexplate(2, 8);

    color("lightblue")
    translate([0, -2500, 4000])
    model_cog();

    // Rear vexmount
    translate([0, -2500, 1550])
    vexmount2();
    translate([0, 0, 1550+400])
    supportArm();
    translate([0, 0, 1155])
    supportArm();

    // Front vexmount
    translate([0, -2500, 3450])
    rotate([180, 0, 0])
    vexmount();
    translate([0, 0, 3000-345])
    supportArm();

    translate([0, 0, 740])
    translate([-1865/2+250, -1860/2-499, 0])
    rotate([0, 0, 144])
    translate([1865/2-250, 1860/2+499, 0])
    stepperMount();
//    frontStepperMount();
//    translate([0, 0, 740])
//    rearStepperMount();

    translate([2250, -1350, 3000])
    rotate([-90, 0, 0])
    model_adjuster();
}


module forPrinting()
{
    stepperMount();
}

scale(ViewScale)
{
//    scale([1, -1, 1])
    forPrinting();
    //forViewing();
//    forViewing0();
}


