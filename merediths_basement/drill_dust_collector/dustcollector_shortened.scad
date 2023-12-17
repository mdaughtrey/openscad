ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>

model=0;
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

module model_hose(anchor=CENTER)
{
    tube(od=1800,id=1600,h=2000,anchor=anchor);
}


module drillmount()
{
    tube(id=2400,od=2600,h=4800,anchor=BOT)
    attach(TOP) hoodside(anchor=BOT)
    // attach(TOP) tube(id=2400,od=6000,h=200,anchor=BOT);
    attach(TOP) tube(id=5800,od=6000,h=1000,anchor=BOT)
    attach(TOP) hoodside(anchor=BOT);

}

module hood(anchor=CENTER,spin=0,orient=UP)
{
    delta=300;
    attachable(anchor=anchor,spin=spin,orient=orient,size=[5600,6000,5400-delta])
    {
        up(800+2100-delta/2)
        diff() 
        rotate_sweep(angle=180,spin=90,shape=rect([3000,2600],anchor=LEFT))  {
            attach(BOT+CENTER+FRONT,norot=1) tube(id=2400,od=2600,h=3800-delta,anchor=TOP);
            attach(LEFT+FRONT,norot=1) cuboid([6000,1300,2600],anchor=LEFT+BACK);
            tag("remove") attach(CENTER) cyl(d=5600,h=2200) attach(FRONT,norot=1) cuboid([5600,3000,2200],anchor=FRONT);
            tag("remove") attach(FRONT+CENTER+BOT,norot=1) down(1) cyl(d=2400,h=202,anchor=BOT);
            tag("remove") attach(RIGHT+BACK,overlap=200) cyl(d=1600,h=500); // hose cutout
            attach(RIGHT+BACK,overlap=150) model_hose(anchor=BOT);
        }
        children();
    }
}

module coupling()
{
    tube(id=1750,od=2150,h=3000);
}

module forViewing()
{
    if (model) {
        model_drill();
        up(4300) model_wheel();
    }
//    *recolor("cornflowerblue")
//    drillmount();
//front_half(s=20000)
    hood(anchor=BOT);
//    halfcyl(anchor=BOT);
//    model_hose();
//    coupling();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
