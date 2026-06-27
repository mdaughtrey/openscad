ViewScale = [0.0254, 0.0254, 0.0254];
include <../../../BOSL2-master/std.scad>

$fn=96;

module adapter(anchor=CENTER,spin=0,orient=UP)
{
    module adapter_()
    {
        tube(id=6100, wall=100, length=620)
        position(TOP)
        tube(id1=6100, wall=100, od2=4000, h=6000, anchor=BOT)
        position(TOP)
        tube(od=4000, wall=100, length=2000,anchor=BOT);
        

           
    }
    attachable(anchor,spin,orient,r=6100/2,l=620)
    {
        adapter_();
        children();
    }
}

module forViewing()
{
    adapter();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
