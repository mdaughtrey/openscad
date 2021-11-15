include <model_steppergear.scad>
include <model_projmount.scad>
//include <model_vexplate.scad>
//include <setscrew_bearing.scad>
include <vexmount.scad>

ViewScale = [0.0254, 0.0254, 0.0254];

module frontStepperMount()
{
    translate([0, 0, 3000])
    linear_extrude(385)
    difference()
    {
        circle(1620/2, $fn=96);
        circle(1420/2, $fn=96);
    }
    translate([0, -2000, 3000])
    vexmount();
}

module forViewing()
{
    color("lightblue")
    translate([-1650/2, -1650/2, 0])
    model_steppergear();
    translate([-2850, -600, 1720])
    model_projmount();
//    model_vexplate(50, 10);
//    model_setscrew_bearing();

    translate([0, -2000, 1000])
    vexmount();
    frontStepperMount();
}

scale(ViewScale)
{
    forViewing();
}


