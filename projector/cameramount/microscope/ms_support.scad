ViewScale = [0.0254, 0.0254, 0.0254];
include <../../../BOSL2-master/std.scad>

$fn=96;

//        tube(id=1560,od=1760,h=1350)
module ms_support(anchor=CENTER,spin=0,orient=UP)
{
    module modname_()
    {
        front_half(s=2000)
        tube(id=1560,od=1760,h=200)
        attach(LEFT,norot=1) cuboid([100,2000,200],anchor=LEFT+BACK)
        attach(FRONT+BOT,norot=1) yrot(90) rect_tube(isize=[1000,180], size=[1200,380],irounding=90,h=100,anchor=RIGHT+FRONT,spin=90);
    }
    attachable(anchor,spin,orient,d=1760,l=200)
    {
        modname_();
        children();
    }
}

module forViewing()
{
    ms_support();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
