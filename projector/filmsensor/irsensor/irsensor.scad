ViewScale = [0.0254, 0.0254, 0.0254];
include <../../../BOSL2-master/std.scad>

include <../../../models/model_film.scad>
include <../../../models/model_ir_reflective_sensor.scad>


module case()
{
}

module forViewing()
{
    model_ir_reflective_sensor();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
