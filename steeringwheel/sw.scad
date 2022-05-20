ViewScale = [0.0254, 0.0254, 0.0254];

include <model_encoder.scad>
include <model_stepper.scad>

module case()
{
}

module forViewing()
{
    translate([1700, 0, 0])
    model_encoder();
    model_stepper();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
