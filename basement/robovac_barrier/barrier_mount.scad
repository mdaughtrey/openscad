ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>

$fn=96;

module rod_support(anchor=CENTER,spin=0,orient=UP)
{
    module rod_support_()
    {
        rmtag="aqc4345";
        diff(rmtag)
        cuboid([2500,1000,400],rounding=500,edges="Z")
        {
            tag(rmtag) position(BOT) up(100)  cyl(d=240,h=302,anchor=BOT);
            *tag(rmtag) position(BOT) down(1)  cyl(d=460,h=66,anchor=BOT);
            cuboid([2700,1200,100],rounding=600,edges="Z");
            position(TOP) tube(id=240, od=3500, h=130, anchor=BOT)
            position(TOP) tube(id=240, od=700, h=160, anchor=BOT)
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
        cuboid([2700,3000,340],rounding=100,edges=["X","Y","Z"],except=[LEFT,FRONT])
        {
            position(BACK) fwd(1010)
            tag(rmtag)
            {
                position(RIGHT) right(500)
                cuboid([2500,1010,342],rounding=500,edges="Z",anchor=RIGHT)
                cuboid([2700,1210,110],rounding=600,edges="Z");
            }
        }
    }
    attachable(anchor,spin,orient,size=[2700,3000,340])
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
            position(LEFT+BOT+BACK) cuboid([200, 3000, 1740],anchor=BOT+RIGHT+BACK,rounding=100,edges=[BACK+TOP,BACK+BOT])
            position(TOP+RIGHT+BACK) rod_support_holder(anchor=LEFT+TOP+BACK);
            position(RIGHT+BOT+FRONT) cuboid([2900,200,1740],anchor=BACK+RIGHT+BOT,rounding=100,edges=[TOP+RIGHT,BOT+RIGHT])
            position(LEFT+FRONT) right(1000) base_socket(orient=RIGHT,spin=180,anchor=BOT+FRONT);
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

module base_back(anchor=CENTER,spin=0,orient=UP)
{
    height = 1000;
    module base_back_()
    {
        cuboid([1240,300,height],rounding=100,edges=[BACK+LEFT,BACK+RIGHT])
        {
            position(LEFT+FRONT) cuboid([300,1830,height],anchor=BACK+LEFT)
            {
                position(LEFT+FRONT) cuboid([100,400,height],anchor=RIGHT+FRONT);
                position(RIGHT+TOP+FRONT) cuboid([400,400,1000],anchor=RIGHT+BOT+FRONT);
            }
            position(RIGHT+FRONT) cuboid([300,1830,height],anchor=BACK+RIGHT)
            {
                position(RIGHT+FRONT) cuboid([100,400,height],anchor=LEFT+FRONT);
                position(LEFT+TOP+FRONT) cuboid([400,400,1000],anchor=LEFT+BOT+FRONT);
            }
        }
    }
    attachable(anchor,spin,orient,size=[1440,1300,height])
    {
        fwd(150)
        back(1300/2)
        base_back_();
        children();
    }
}

module base_socket(anchor=CENTER,spin=0,orient=UP)
{
    height = 1000;
    module base_socket_()
    {
        rmtag="vr2qrde";
        diff(rmtag)
        cuboid([1800,800,height])
        {
            tag(rmtag)
            {
                position(BACK) left(470) up(1) cuboid([330,620,height+2],anchor=BACK)
                position(FRONT+LEFT) cuboid([100,420,height+2], anchor=FRONT+RIGHT);
                position(BACK) right(470) up(1) cuboid([330,620,height+2],anchor=BACK)
                position(FRONT+RIGHT) cuboid([100,420,height+2], anchor=FRONT+LEFT);
            }
//            position(LEFT+FRONT) cuboid([100,400,height],anchor=RIGHT+FRONT);
//            position(RIGHT+FRONT) cuboid([300,1000,height],anchor=BACK+RIGHT)
//            position(RIGHT+FRONT) cuboid([100,400,height],anchor=LEFT+FRONT);
        }
    }
    attachable(anchor,spin,orient,size=[1800,800,height])
    {
        base_socket_();
        children();
    }
}

module all()
{
    base();
    down(480) right(600) back(500)
    assembled();
    fwd(3400)
    recolor("cyan")
    base_back(spin=180,orient=RIGHT);
    recolor("green")
    right(600) back(500)
    tube(id=500,od=3500,h=750);
}


module forViewing()
{
    all();
///    assembled();
//    base_back();
}

module forPrinting()
{
//    base_back();
///    base();
    rod_support();
}

scale(ViewScale)
{
///    forViewing();
    forPrinting();
}
