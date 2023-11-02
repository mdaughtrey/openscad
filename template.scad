ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>


module case()
{
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
