ViewScale = [0.0254, 0.0254, 0.0254];
include <../../../BOSL2-master/std.scad>

module cup(anchor=CENTER,spin=0,orient=UP)
{
    module cup_()
    {
        cuboid([1500,1800,100],edges="Z",rounding=200);
        position(TOP) rect_tube(isize=[1300,1600],h=600,wall=100,rounding=200,anchor=BOT);
    }
    attachable(anchor,spin,orient,size=[1500,1300,100])
    {
        cup_();
        children();
    }
}

module forViewing()
{
    cup();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
