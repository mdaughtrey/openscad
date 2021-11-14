include <model_steppergear.scad>
include <model_projmount.scad>
//include <model_vexplate.scad>
include <setscrew_bearing.scad>

ViewScale = [0.0254, 0.0254, 0.0254];

module forViewing()
{
//    color("lightblue")
//    translate([-1650/2, -1650/2, 0])
//    model_steppergear();
//    translate([-2850, -600, 1720])
//    model_projmount();
//    model_vexplate(50, 10);
    model_setscrew_bearing();
}

scale(ViewScale)
{
    forViewing();
}


