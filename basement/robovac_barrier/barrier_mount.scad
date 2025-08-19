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
            position(TOP) tube(id=240, od=700, h=300, anchor=BOT)
            position(TOP) tube(id=240, od=360, h=30, anchor=BOT);
        }
    }
    attachable(anchor,spin,orient,size=[2700,1200,730])
    {
        up(150)
        down(730/2)
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
        cuboid([2700,2000,340],rounding=100,edges=["X","Y","Z"],except=[LEFT,FRONT])
        {
            tag(rmtag)
            {
                position(RIGHT) right(500)
                cuboid([2500,1010,342],rounding=500,edges="Z",anchor=RIGHT)
                cuboid([2700,1210,110],rounding=600,edges="Z");
            }
        }
    }
    attachable(anchor,spin,orient,size=[2700,2000,340])
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
    

module base(anchor=CENTER,spin=0,orient=UP)
{
    module base_()
    {
        rod_support_holder()
        {
            position(LEFT+BOT) cuboid([200, 2000, 1740],anchor=BOT+RIGHT,rounding=100,edges=[BACK+TOP,BACK+BOT])
            position(TOP+RIGHT+BACK) rod_support_holder(anchor=LEFT+TOP+BACK)
            position(FRONT+RIGHT) cuboid([2700,1000,340],anchor=BACK+RIGHT);
            position(FRONT+RIGHT+BOT) cuboid([2700,1000,340],anchor=BACK+RIGHT+BOT);
        }
    }
    attachable(anchor,spin,orient,size=[2500+200,2000,1740])
    {
        up(340/2)
        down(1740/2)
        base_();
        children();
    }
}

module forViewing()
{
    assembled();
    left(600) up(500)
    base();
    up(500)
    tube(od=3690,h=960,id=750);
}

module forPrinting()
{
    rod_support();
}

scale(ViewScale)
{
    forViewing();
//    forPrinting();
}
