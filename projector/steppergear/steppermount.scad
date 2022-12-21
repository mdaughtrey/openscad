include <model_steppergear.scad>
include <model_projmount.scad>
include <model_vexplate.scad>
include <vexmount.scad>
include <adjuster.scad>
include <../../libs/MCAD/2Dshapes.scad>

ViewScale = [0.0254, 0.0254, 0.0254];

//model = 1;
model = 0;
supports = 1;

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
    linear_extrude(300)
    difference()
    {
        translate([-200, 0, 0])
        square([1200, 650], center=true);
        translate([100, 20, 0])
        circle(180/2, $fn=96);
        translate([-500, 20, 0])
        square([1200, 180], center = true);
    }
}

module frontStepperMount()
{
    {
        linear_extrude(385)
        {
            difference()
            {
                roundedSquare(pos=[2060, 2060],r=200);
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
        }
    }

    // Brace
    translate([-600, -3250, 185])
    brace();
}

module brace()
{
    linear_extrude(200)
    polygon([[0, 0], [1500, 2400], [1200, 2400], [0, 350]]);
}

module rearStepperMount()
{
    linear_extrude(385)
    difference()
    {
        roundedSquare(pos=[2060, 2060],r=200);
        square([1680, 1680], center=true);
        square([2100, 50], center=true);
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
            roundedSquare(pos=[2060, 2060],r=200);
            square([1680, 1680], center=true);
        }
    }


    translate([-1865/2+250, -1860/2-499, 0])
    rotate([0, 0, 90])
    linear_extrude(385)
    axleTab();

    for (ii=[-20,125])
    {
        translate([-1860/2-350, ii, 385/2])
        rotate([90, 0, 0])
        linear_extrude(100)
        captureTab();
    }

    for (ii=[-20,125])
    {
        translate([1860/2+350, ii-100, 385/2])
        rotate([90, 0, 180])
        linear_extrude(100)
        captureTab();
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
    }
    // Adjuster capture
    translate([-832, -3200, 700])
    rotate([90, 0, 90])
    adjusterCapture();

    translate([-832, -3200, 1250])
    rotate([90, 0, 90])
    adjusterCapture();

    // Brace
    translate([-600, -3250, 0])
    brace();
}

module supportArm()
{
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

module supports()
{
    for (ii=[-1860/2-550, 1860/2+150])
    {
        translate([ii, -150, 0])
        linear_extrude(1530)
        square([400, 300]);
    }

    translate([520, -4000, 0])
    linear_extrude(330)
    square([220, 700]);
}

module forPrinting()
{
    translate([0, 0, 1925])
    rotate([0, 180, 0])
    stepperMount();
    if (supports) {
        supports();
    }
}

scale(ViewScale)
{
//    scale([1, -1, 1])
    forPrinting();
//    forViewing();
}


