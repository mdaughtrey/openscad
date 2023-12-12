ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>

$fn=96;

module case()
{
}

module forViewing()
{
    case();
}

module forPrinting()
{
    tube(or=970/2,ir=830/2,h=100)
    position(TOP) tube(or=1100/2,ir=830/2,h=40,anchor=BOT);
}

scale(ViewScale)
{
//    forViewing();
    forPrinting();
}
