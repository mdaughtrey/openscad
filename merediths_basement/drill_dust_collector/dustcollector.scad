ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>

$fn=96;

module model_drill()
{
    recolor("silver") cyl(d=2370,h=1500,anchor=BOT)
    attach(TOP) recolor("dimgray") cyl(d1=2370,d2=2000,h=1010,anchor=BOT)
    attach(TOP) cyl(d1=1800,d2=1700,h=200,anchor=BOT)
    attach(TOP) cyl(d=1700,h=1280,anchor=BOT)
    attach(TOP) cyl(d1=1700,d2=1000,h=850,anchor=BOT);
}

module model_wheel()
{
    recolor("silver")
    cyl(d=250,h=1500)
    attach(TOP) cyl(d=1000,h=50,anchor=BOT)
    attach(TOP) cyl(d=4000,h=500,anchor=BOT)
    attach(TOP) cyl(d=1000,h=50,anchor=BOT);
}

module model_hose()
{
    tube(od=1800,id=1600,h=2000);
}


module drillmount()
{
    tube(id=2400,od=2600,h=4800,anchor=BOT)
    attach(TOP) tube(id=2400,od=6000,h=200,anchor=BOT)
    attach(TOP) tube(id=5800,od=6000,h=1000,anchor=BOT)
    attach(TOP) cyl(d=6000,h=200,anchor=BOT);

}

module hoodside(anchor=CENTER,spin=0,orient=UP)
{
    module hoodside_()
    {
        diff() {
            cyl(d=6000,h=200) {
                attach(CENTER,norot=1) cuboid([3000,6000,200],anchor=LEFT)
                tag("remove") attach(RIGHT, norot=1) cuboid([500,6000,200],anchor=RIGHT);
                tag("remove") cyl(d=2400,h=200);
            }
        }
    }
    attachable(anchor=anchor,spin=spin,orient=orient,size=[5500,600,200])
    {
        hoodside_();
        children();
    }
}

module forViewing()
{
    *model_hose();
    *model_drill();
    *up(4300) model_wheel();
    *recolor("cornflowerblue")
    drillmount();
    hoodside();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
