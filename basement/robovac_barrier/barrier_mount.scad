ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>

$fn=96;

module rod_support(anchor=CENTER,spin=0,orient=UP)
{
    module rod_support_()
    {
        rmtag="aqc4345";
        diff(rmtag)
        cuboid([2500,1000,300],rounding=500,edges="Z")
        {
            tag(rmtag) position(BOT) up(100)  cyl(d=240,h=302,anchor=BOT);
            *tag(rmtag) position(BOT) down(1)  cyl(d=460,h=66,anchor=BOT);
            cuboid([2700,1200,100],rounding=600,edges="Z");
            position(TOP) tube(id=240, od=900, h=100, anchor=BOT)
            position(TOP) tube(id=240, od=700, h=300, anchor=BOT);
        }
    }
    attachable(anchor,spin,orient,size=[2700,1200,700])
    {
        up(150)
        down(700/2)
        rod_support_();
        children();
    }
}


module rod_support_holder(anchor=CENTER,spin=0,orient=UP)
{
    module rod_support_holder_()
    {
        rmtag="vq454adf";
        diff(rmtag)
        cuboid([2500,1500,340])
        {
            tag(rmtag)
            {
                position(LEFT) right(500)
                cuboid([2500,1010,342],rounding=500,edges="Z",anchor=LEFT)
                cuboid([2700,1210,110],rounding=600,edges="Z");
            }
        }
    }
    attachable(anchor,spin,orient,size=[2500,1500,340])
    {
        rod_support_holder_();
        children();
    }
}

module barrier_mount(anchor=CENTER,spin=0,orient=UP)
{
    module barrier_mount_()
    {
    }
    attachable(anchor,spin,orient,size=[100,100,100])
    {
        barrier_mount_();
        children();
    }
}

module assembled()
{
    recolor("cornflowerblue")
    rod_support()
    recolor("silver")
    position(TOP) tube(id=250,od=750,h=237,anchor=BOT)
    recolor("cornflowerblue")
    position(TOP) rod_support(orient=BOT, anchor=TOP);
}
    

module case()
{
}

module forViewing()
{
    assembled();
    left(500) down(200) 
    rod_support_holder()
    position(LEFT+BOT) cuboid([200, 1500, 1680],anchor=BOT+RIGHT)
    position(TOP+RIGHT) rod_support_holder(anchor=LEFT+TOP);
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
