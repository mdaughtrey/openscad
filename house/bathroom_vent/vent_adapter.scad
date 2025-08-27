ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>
$fn=96;

module adapter(anchor=CENTER,spin=0,orient=UP)
{
    module adapter_()
    {
        tube(id=4000,od=4200,h=1000)
        position(TOP)
        tube(id1=4000,od1=4200,id2=3050,od2=3250,shift=[0,1330],h=4000,anchor=BOT)
        position(TOP) back(1330) tube(id=3050,od=3250,h=1000,anchor=BOT);
    
    }
    attachable(anchor,spin,orient,size=[100,100,100])
    {
        adapter_();
        children();
    }
}

module extender(anchor=CENTER,spin=0,orient=UP)
{
    module extender_()
    {
        tube(id=3300,od=3550,h=1000)
        position(TOP)
        tube(id=3050,od=3550,h=100,anchor=BOT)
        position(TOP)
        tube(id=3050,od=3250,h=3000,anchor=BOT);
    
    }
    attachable(anchor,spin,orient,size=[100,100,100])
    {
        extender_();
        children();
    }
}

module case()
{
}

module forViewing()
{
//    adapter();
//    up(6000)
//    back(1330)
    extender();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
