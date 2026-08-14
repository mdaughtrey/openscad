ViewScale = [0.0254, 0.0254, 0.0254];
include <../BOSL2-master/std.scad>
include <../models/ssmicro.scad>

$fn=96;

module usb(anchor=CENTER,spin=0,orient=UP)
{
    module usb_()
    {
        recolor("silver")
        rect_tube(isize=[490,200], wall=36, h=825)
        {
            recolor("blue") back(40)
            position(TOP+FRONT) cuboid([430, 90, 350], anchor=TOP+FRONT);
            recolor("black")
            position(BOT) cuboid([490,200,100], anchor=BOT)
            recolor("silver")
            position(BOT)
            cuboid([325,92,330], edges="Z", rounding=40, anchor=TOP);
        }
        
    }
    attachable(anchor,spin,orient,size=[490+72,200+72,825+330])
    {
        down(825)
        up(825/2) up(330/2)
        usb_();
        children();
    }
}


module case(anchor=CENTER,spin=0,orient=UP)
{
    module case_()
    {
        rmtag="r51c5rq";
        diff(rmtag)
        rect_tube(isize=[582,282], wall=50, h=880, rounding=100, irounding=0)
        {
            position(BOT) cuboid([592,292,30], anchor=BOT)
            tag(rmtag) position(BOT) down(1) cuboid([405, 185, 32], anchor=BOT, edges="Z", rounding=50); 
            position(TOP+LEFT) translate([50, 0, 0])
            cuboid([150, 392, 1000], edges=[FRONT+LEFT,BACK+LEFT], rounding=100, anchor=BOT+RIGHT) back(45) up(30)
            tag(rmtag) position(RIGHT+BOT) cuboid([120, 100, 970], anchor=BOT+RIGHT);

            position(TOP+RIGHT) translate([-50, 0, 0])
            cuboid([150, 392, 1000], edges=[FRONT+RIGHT,BACK+RIGHT], rounding=100, anchor=BOT+LEFT) back(45) up(30)
            tag(rmtag) position(LEFT+BOT) cuboid([120, 100, 970], anchor=BOT+LEFT);

            position(TOP+FRONT) cuboid([682, 36, 1000], anchor=BOT+FRONT);
            position(TOP+BACK) cuboid([682, 36, 1000], anchor=BOT+BACK);
        }
    }
    attachable(anchor,spin,orient,size=[582,292,910])
    {
        case_();
        children();
    }
}

module lid(anchor=CENTER,spin=0,orient=UP)
{
    module lid_()
    {
        cuboid([872, 372, 100], edges="Z", rounding=100)
        position(BOT)
        rect_tube(size=[582, 290], h=220, wall=50, anchor=TOP);
    }
    attachable(anchor,spin,orient,size=[100,100,100])
    {
        lid_();
        children();
    }
}

module forViewing()
{
    *usb(orient=LEFT)
    {
        position(TOP) down(120) back(20)
        ssmicro(orient=BACK,spin=180,anchor=FRONT);
        position(BOT) down(120) 
        case(anchor=BOT);
    }
    case();
    up(2000) lid(anchor=BOT);
}

module forPrinting()
{
//    case();
    lid();
}

scale(ViewScale)
{
//    forViewing();
    forPrinting();
}
