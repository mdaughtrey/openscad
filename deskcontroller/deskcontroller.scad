ViewScale = [0.0254, 0.0254, 0.0254];

include <../models/apds9960.scad>
include <../models/vl53l0x.scad>

module case()
{
//    model_APDS9960();
//    translate([1000, 0, 0])
    model_VL53L0X();
}

module forViewing()
{
    case();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
