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

module frontStepperMount()
{
    translate([0, 0, 3000-390])
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
                circle(1420/2, $fn=96);
            }
        }
        linear_extrude(385)
        translate([-1865/2+250, -1860/2-499, 0])
        rotate([0, 0, 90])
        difference()
        {
            union()
            {
                circle(500/2, $fn=96);
                translate([250, 0, 0])
                square([500, 500], center = true);
            }
            circle(150/2, $fn=96);
        }
    }
}

module rearStepperMount()
{
    translate([0, 0, 1000-390])
    {
        linear_extrude(385)
        difference()
        {
            square([1860, 1860], center=true);
            square([1660, 1660], center=true);
        }

        linear_extrude(385)
        translate([-1865/2+250, -1860/2-499, 0])
        rotate([0, 0, 90])
        difference()
        {
            union()
            {
                circle(500/2, $fn=96);
                translate([250, 0, 0])
                square([500, 500], center = true);
            }
            circle(150/2, $fn=96);
        }
    }


}

module supportArm()
{
//    translate([0, 0, 4500])
    linear_extrude(385)
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
        circle(150/2, $fn=96);
        translate([0, -2500, 0])
        circle(945/2, $fn=96);
    }
}

module forViewing()
{
    color("lightblue")
    translate([-1650/2, -1650/2, 0])
    model_steppergear();
    color("lightblue")
    translate([-2850, -600, 1720])
    model_projmount();
    color("lightblue")
    translate([430, -4000, 2250])
    rotate([0, 90, 0])
    model_vexplate(5, 10);

    *color("lightblue")
    translate([0, -2500, 4000])
    model_cog();

    translate([0, -2500, 1000])
    vexmount();
    translate([0, -2500, 3000])
    vexmount();
    frontStepperMount();
    rearStepperMount();

    
    translate([0, 0, 1000])
    supportArm();
    translate([0, 0, 3000])
    supportArm();

}

scale(ViewScale)
{
    forViewing();
}


