ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>

$fn=96;
model=0;

//  module modname(anchor=CENTER,spin=0,orient=UP)
//  {
//      module modname_()
//      {
//      }
//      attachable(anchor,spin,orient,size=)
//      {
//          modname_();
//          children();
//      }
//  }

module wheel(anchor=CENTER,spin=0,orient=UP)
{
    module wheel_()
    {
        recolor("black")
        tube(id=100, od=505, h=250)
        {
            recolor("white")
            attach(TOP, norot=1) tube(id=100, od=342, h=40, anchor=BOT);
            recolor("white")
            attach(BOT, norot=1) tube(id=100, od=342, h=40, anchor=TOP);
        }

    }

    attachable(anchor,spin,orient,r=505/2,h=250+80)
    {
        wheel_();
        children();
    }
}

module wheel_contact0(anchor=CENTER,spin=0,orient=UP)
{
    module wheel_contact_()
    {
        cyl(d=500,h=50,anchor=TOP)
        {
        attach(TOP, norot=1) cyl(d=90,h=50, anchor=BOT);
        attach(BOT, norot=1) front_half(s=1200) cyl(d=600,h=50, anchor=BOT)
        attach(BOT, norot=1) front_half(s=1200) tube(id=599, od=699, h=330, anchor=BOT);
        }
    }
    attachable(anchor,spin,orient,d=500,h=100)
    {
        wheel_contact_();
        children();
    }
}

module shield(anchor=CENTER,spin=0,orient=UP)
{
    module shield_()
    {
        rmtag="acq234";
        diff(rmtag)
        cyl(d=500,h=50,anchor=TOP)
        {
            tag("keep") attach(TOP, norot=1) cyl(d=90,h=50, anchor=BOT);
            attach(BOT, norot=1) tube(id=599, od=699, h=330, anchor=BOT)
            tag(rmtag) attach(BOT, norot=1) cuboid([600, 330, 330], anchor=FRONT+BOT);
//             attach(BOT, norot=1) cyl(d=600,h=50, anchor=BOT)
//        attach(TOP, norot=1) cyl(d=600,h=50, anchor=BOT);


        }
    }
    attachable(anchor,spin,orient,d=500,h=100)
    {
        shield_();
        children();
    }
}

module arm0(anchor=CENTER,spin=0,orient=UP)
{
    module arm_()
    {
        wheel_contact()
        attach(BOT, norot=1) right(100)
        cuboid([800,100,100], anchor=RIGHT+TOP, rounding=100, edges=[BOT+RIGHT])
        attach(LEFT+BOT, norot=1) left(50)
        tube(id=100, od=200, h=315, anchor=BOT);
    }
    attachable(anchor,spin,orient,d=700,h=100)
    {
        up(25)
        arm_();
        children();
    }
}


module arm(anchor=CENTER,spin=0,orient=UP)
{
    module arm_()
    {
        tube(id=100, od=200, h=315)
        attach(FRONT+BOT, norot=1) back(20) cyl(d=200, h=315, anchor=BACK+BOT)
        attach(RIGHT+BOT, norot=1) left(20) cuboid([800,100,100], anchor=LEFT+BOT, rounding=100, edges=[BOT+RIGHT])
        attach(RIGHT+TOP, norot=1)  wheel_contact(anchor=BOT);
//        attach(BOT, norot=1) right(100)
//        cuboid([800,100,100], anchor=RIGHT+TOP, rounding=100, edges=[BOT+RIGHT])
//        attach(LEFT+BOT, norot=1) left(50)
//        tube(id=100, od=200, h=315, anchor=BOT);
    }
    attachable(anchor,spin,orient,d=700,h=100)
    {
        up(25)
        arm_();
        children();
    }
}

module case()
{
}

module forViewing()
{
    shield();
//    wheel_contact();
//    arm();
//    up(200)
//    wheel();
//    attach(BOT, norot=1) wheel_contact();
}

module forPrinting()
{
    wheel_contact();
}

scale(ViewScale)
{
//    forPrinting();
    forViewing();
}

