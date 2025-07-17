ViewScale = [0.0254, 0.0254, 0.0254];
include <../BOSL2-master/std.scad>

module shim(anchor=CENTER,spin=0,orient=UP)
{
    module shim_()
    {
        cuboid([2000,1000,100])
        position(LEFT+TOP) cuboid([1400,1000,50],anchor=BOT+LEFT)
        position(LEFT+TOP) cuboid([700,1000,50],anchor=BOT+LEFT);
    }
    attachable(anchor,spin,orient,size=[5000,1000,250])
    {
        shim_();
        children();
    }
}


module case()
{
}

module forViewing()
{
    shim();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
