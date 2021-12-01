include <model_steppergear.scad>
include <model_projmount.scad>
include <model_vexplate.scad>
//include <setscrew_bearing.scad>
include <vexmount.scad>

ViewScale = [0.0254, 0.0254, 0.0254];

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
        linear_extrude(385)
        axleTab();
        translate([1860/2+280, -730, 190])
        rotate([90, 180, 0])
        linear_extrude(200)
        captureTab();

        translate([1400, 650, 0])
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
        square([1650, 1650], center=true);
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
//    translate([0, 0, 2250])
    rearStepperMount();
    translate([0, 0, 1540])
    frontStepperMount();
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

    *color("lightblue")
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
}

module testPrint1()
{
    translate([-1000, 0, 0])
    linear_extrude(200)
    {
        difference()
        {
            square([1860, 1860], center=true);
            square([1650, 1650], center=true);
        }
    }
    translate([1000, 0, 0])
    linear_extrude(200)
    difference()
    {
        //square([1860, 1860], center=true);
        //circle(1860/2, $fn=96);
        circle(1620/2, $fn=96);
        circle(1430/2, $fn=96);
    }
}

module forPrinting()
{
    stepperMount();
//    rearStepperMount();
}

scale(ViewScale)
{
//    scale([1, -1, 1])
    forPrinting();
//    forViewing();
//    testPrint1();
}


