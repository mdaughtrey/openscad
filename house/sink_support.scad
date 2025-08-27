ViewScale = [0.0254, 0.0254, 0.0254];
include <../BOSL2-master/std.scad>

$fn=96;

module support(anchor=CENTER,spin=0,orient=UP,height=500)
{
    module support_()
    {
        rmtag = "vr32qr";
        diff(rmtag)
        cuboid([1000,1000,height], rounding=500,edges=[FRONT+LEFT,FRONT+RIGHT])
        tag(rmtag) position(BOT) down(1) cyl(d=170,h=height+2,anchor=BOT)
            position(TOP) cyl(d=350,h=150,anchor=TOP);
        
    }
    attachable(anchor,spin,orient,size=[1000,1000,height])
    {
        support_();
        children();
    }
}

module support_template(anchor=CENTER,spin=0,orient=UP,height=500)
{
    module support_()
    {
        rmtag = "vr32r";
        diff(rmtag)
        cuboid([1000,1000,height], rounding=500,edges=[FRONT+LEFT,FRONT+RIGHT])
        tag(rmtag) position(BOT) down(1) cyl(d=170,h=height+2,anchor=BOT)
            position(TOP) cyl(d=700,h=450,anchor=TOP);
        
    }
    attachable(anchor,spin,orient,size=[1000,1000,height])
    {
        support_();
        children();
    }
}


module case()
{
}

module forViewing()
{
//    support(height=200);
    support_template();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
