ViewScale = [0.0254, 0.0254, 0.0254];

include <../../BOSL2-master/std.scad>
include <model_psu_12v.scad>

module forViewing()
{
    model_psu12v();
}


scale(ViewScale)
{
    forViewing();
}
