ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>
include <../../BOSL2-master/hinges.scad>


$fn=96;
module case()
{
}

module forViewing()
{
    snap_lock(thick=1.75,layerheight=0.15);
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
