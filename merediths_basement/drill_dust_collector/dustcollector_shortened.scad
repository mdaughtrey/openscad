ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>

model=0;
$fn=96;

module model_drill()
{
    diff()
    tube(id=2230,wall=100,h=700)
    {
        tag("remove") cuboid([1760,2500,701]);
        attach(TOP,norot=1) tube(id=2080,wall=180,h=200,anchor=BOT);
    }


//    recolor("silver") cyl(d=2370,h=1500,anchor=BOT)
//    attach(TOP) recolor("dimgray") cyl(d1=2370,d2=2000,h=1010,anchor=BOT)
//    attach(TOP) cyl(d1=1800,d2=1700,h=200,anchor=BOT)
//    attach(TOP) cyl(d=1700,h=1280,anchor=BOT)
//    attach(TOP) cyl(d1=1700,d2=1000,h=850,anchor=BOT);
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


module drillmount(anchor=CENTER,spin=0,orient=UP)
{
    module drillmount_()
    {
        diff()
        tube(id=2230,wall=200,h=700,anchor=BOT)
        {
            tag("remove") cuboid([1760,2700,701]);
            attach(TOP,norot=1) tube(id=2080,wall=280,h=200,anchor=BOT);
            attach(TOP,norot=1) tube(id=2080,wall=150,h=2780,anchor=BOT)
            {
                attach(TOP,norot=1) tube(id=2230,od=4990,h=200,anchor=TOP)
                tag("remove") attach(RIGHT,norot=1) cuboid([200+(5000-2230)/2,5000,201],anchor=RIGHT);
                tag("remove") attach(TOP,norot=1) down(500) cuboid([1760,2700,1000],anchor=TOP);
            }
        }
    }
    attachable(anchor,spin,orient,d=2430,h=3760)
    {
        down(3760/2)
        drillmount_();
        children();
    }
}

module hood(anchor=CENTER,spin=0,orient=UP)
{
    attachable(anchor,spin,orient,d=6000,h=2600)
    {
        diff() 
        cyl(d=5000,h=200)
        {
            tag("remove") attach(BOT+RIGHT,norot=1) cuboid([200+(5000-2230)/2,5000,2601],anchor=RIGHT+BOT);
            attach(TOP,norot=1) tube(od=5000,wall=200,h=2200,anchor=BOT)
            {
                // Hose cutouts
                attach(LEFT+BACK,overlap=150) model_hose(anchor=BOT);
                tag("remove") attach(LEFT+BACK,overlap=200) cyl(d=1600,h=500); // hose cutout
                attach(LEFT+FRONT,overlap=150) model_hose(anchor=BOT);
                tag("remove") attach(LEFT+FRONT,overlap=200) cyl(d=1600,h=500); // hose cutout

                // Lip
                intersect("mask")
                attach(TOP,norot=1) tube(id=5000,wall=50,h=200)
                tag("mask") cuboid([1000,5500,200]);
            }
        }
//        rotate_sweep(angle=180,spin=90,shape=rect([3000,2600],anchor=LEFT))  {
//            attach(LEFT+FRONT,norot=1) cuboid([6000,700,2600],anchor=LEFT+BACK);
//            tag("remove") attach(CENTER) cyl(d=5600,h=2200) attach(FRONT,norot=1) cuboid([5600,3000,2200],anchor=FRONT);
//            tag("remove") attach(FRONT+CENTER+BOT,norot=1) down(1) cyl(d=2300,h=202,anchor=BOT);
//            tag("remove") attach(RIGHT+BACK,overlap=200) cyl(d=1600,h=500); // hose cutout
//            attach(RIGHT+BACK,overlap=150) model_hose(anchor=BOT);
//        }
        children();
    }
}

module hood0(anchor=CENTER,spin=0,orient=UP)
{
    attachable(anchor,spin,orient,d=6000,h=2600)
    {
        diff() 
        rotate_sweep(angle=180,spin=90,shape=rect([3000,2600],anchor=LEFT))  {
            attach(LEFT+FRONT,norot=1) cuboid([6000,700,2600],anchor=LEFT+BACK);
            tag("remove") attach(CENTER) cyl(d=5600,h=2200) attach(FRONT,norot=1) cuboid([5600,3000,2200],anchor=FRONT);
            tag("remove") attach(FRONT+CENTER+BOT,norot=1) down(1) cyl(d=2300,h=202,anchor=BOT);
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
    drillmount()
    up(750)
    attach(TOP,norot=1) hood(orient=DOWN,spin=180,anchor=TOP);
//    hood();
}

module forPrinting()
{
//    hood();
    drillmount();
}

scale(ViewScale)
{
//    forViewing();
    forPrinting();
}
