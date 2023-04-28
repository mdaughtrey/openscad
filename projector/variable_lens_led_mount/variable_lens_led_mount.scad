ViewScale = [0.0254, 0.0254, 0.0254];

include <model_1w_led.scad>
include <model_variable_lens.scad>
model=1;

module mount()
{
}

module forViewing()
{
    color("gray") {
        model_1w_led();
        translate([0, 0, 300])
        model_variable_lens();
    }
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
