ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>

$fn=96;

/// module modname(anchor=CENTER,spin=0,orient=UP)
/// {
///     module modname_()
///     {
///     }
///     attachable(anchor,spin,orient,size=)
///     {
///         modname_();
///         children();
///     }
/// }

// 7 3/8 = 7375
// 9/16 = 560

module model_vent(anchor=CENTER,spin=0,orient=UP)
{
    module model_vent_()
    { 
        rmtag="cqavqv45r";
        diff(rmtag)
        cyl(d=4370,h=40)
        {
            position(BOT) tube(od=4370,wall=110,h=110,anchor=BOT);
            position(TOP) cyl(d=3600,h=130,anchor=BOT)
            position(TOP) cyl(d=2700,h=1300,anchor=BOT);
            tag(rmtag)
            {
                position(BOT+RIGHT) left(170) cyl(d=150,h=100,anchor=BOT+RIGHT);
                position(BOT+LEFT) right(170) cyl(d=150,h=100,anchor=BOT+LEFT);
            }
        }
    }
    attachable(anchor,spin,orient,d=4370,h=110)
    {
        model_vent_();
        children();
    }
}

module siding_shim(anchor=CENTER,spin=0,orient=UP)
{
    module siding_shim_()
    {
        rmtag="cqr43"; 
        itag="avc4qr";
        intersect(itag)
        {
            diff(rmtag)
            wedge([6000, 7500, 560])
            {
                position(FRONT+BOT) cuboid([6000,6000,200],anchor=TOP+FRONT)
                {
                    tag(rmtag) position(BOT+FRONT) back(625)  down(1) cyl(d=3000,h=1000,anchor=BOT+FRONT)
                    tag("keep") position(BOT) up(200) tube(od=4730,wall=450,h=300,anchor=TOP)
                    {
                        tag(rmtag)
                        {
                            position(BOT+RIGHT) left(170) down(2)  cyl(d=150,h=804,anchor=BOT+RIGHT);
                            position(BOT+LEFT) right(170) down(2) cyl(d=150,h=804,anchor=BOT+LEFT);
                        }
                    }
                }
                tag(rmtag) position(BOT+BACK) down(1) cuboid([6000,1500,402], anchor=BOT+BACK);
            }
            tag(itag) cuboid([6000,6000,1000],rounding=400,edges="Z",anchor=LEFT+FRONT);
        }
    }
    attachable(anchor,spin,orient,size=[6000,6000,560])
    {
        fwd(3000) left(3000) up(300) down(760/2)
        siding_shim_();
        children();
    }
}

module flap_assembly0()
{
    rmtag="v15aqvcrw";
    diff(rmtag)
    tube(od=2990,id=2900,h=2000)
    {
        tag(rmtag) position(TOP+BACK) cuboid([750,200,1250],anchor=TOP);
    }
}

module flap_assembly()
{
    rmtag="v15aqvcrw";
    diff(rmtag)
    tube(od=2990,id=2900,h=2000-1400)
    {
        tag(rmtag) position(TOP+BACK) cuboid([750,200,1250],anchor=TOP);
        position(BOT+LEFT) right(40) up(1500-1400) cuboid([200,600,200],anchor=RIGHT+BOT)
        tag(rmtag) position(BACK+LEFT) fwd(100) cyl(d=80,h=250,orient=LEFT,anchor=TOP);
        position(BOT+RIGHT) left(40) up(1500-1400) cuboid([200,600,200],anchor=LEFT+BOT)
        tag(rmtag) position(BACK+RIGHT) fwd(100) cyl(d=80,h=250,orient=RIGHT,anchor=TOP);
    }
}

module curve()
{
    radius=49625;
    ang=5;
    for (x=[1:0.25:3])
    {
        itag="rc1q1r";
        left(47000*x)
        intersect(itag)
        tube(or=radius*x+100,ir=radius*x,h=200)
        {
            tag(itag) pie_slice(r=radius*x+100,ang=5-x/2,h=200,$fn=192);
            
        }
    }
}


module case()
{
}

module forViewing()
{
    flap_assembly();
///    siding_shim();
    *down(700) right(3000) back(2100)
    {
        recolor("cyan") model_vent();
        recolor("green") up(1000) flap_assembly();
    }
}

module forPrinting()
{
    flap_assembly();
}

scale(ViewScale)
{
    forViewing();
//    forPrinting();
}
