ViewScale = [0.0254, 0.0254, 0.0254];
include <../BOSL2-master/std.scad>

$fn=96;
module case()
{
    intersect()
    cyl(d=472,h=169) {
    tag("intersect") cuboid([472,315,169]);
    tag("keep") attach(TOP,norot=1) cyl(d=272,h=78,anchor=BOT)
    attach(TOP,norot=1) cyl(d=173,h=75,anchor=BOT);
    }
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
