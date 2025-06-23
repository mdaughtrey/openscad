ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>

$fn=96;


hole_spacing=3000;

module model_screw(anchor=CENTER,spin=0,orient=UP)
{
    module model_screw_()
    {
        cyl(d=370, l=120)
        position(TOP) cyl(d=193, l=2366, anchor=BOT);
    }
    attachable(anchor,spin,orient,d=370, l=2366+120)
    {
        up(60) down(2486/2)
        model_screw_();
        children();
    }
}

module model_door(anchor=CENTER,spin=0,orient=UP)
{
    module model_door_()
    {
        rmtag="1q2qv45";
        diff(rmtag)
        cuboid([3000, 1375, 6000])
        {
            tag(rmtag) position(FRONT) up(hole_spacing/2) cyl(d=200, l=1375, anchor=TOP, orient=FRONT);
            tag(rmtag) position(FRONT) down(hole_spacing/2) cyl(d=200, l=1375, anchor=TOP, orient=FRONT);
        }
    }
    attachable(anchor,spin,orient,size=[3000,1375,6000])
    {
        model_door_();
        children();
    }
}


module doorknob(anchor=CENTER,spin=0,orient=UP,front=1)
{
    x=4000;
    
    module doorknob_()
    {
        rmtag="c2c145";
        diff(rmtag)
        cuboid([x,1000,8000], rounding=400)
        {
            position(BACK) cuboid([2000,1000,4000], anchor=FRONT, rounding=400, edges=[TOP+LEFT,TOP+RIGHT,BOT+LEFT,BOT+RIGHT])
            if (front)
            {
                tag(rmtag) position(BACK) up(hole_spacing/2) cyl(d=180, l=1000, anchor=TOP, orient=BACK);
                tag(rmtag) position(BACK) down(hole_spacing/2) cyl(d=180, l=1000, anchor=TOP, orient=BACK);
            }
            else
            {
                tag(rmtag) position(BACK) up(hole_spacing/2) cyl(d=190, l=400, anchor=TOP, orient=BACK)
                    position(BOT) cyl(d=400, l=1600, anchor=TOP);
                tag(rmtag) position(BACK) down(hole_spacing/2) cyl(d=190, l=400, anchor=TOP, orient=BACK)
                    position(BOT) cyl(d=400, l=1600, anchor=TOP);
            }
        }

    }
    attachable(anchor,spin,orient,size=[x,1000,8000])
    {
        doorknob_();
        children();
    }
}

module screwtest()
{
    rmtag="134vd";
    diff(rmtag)
    cuboid([1000, 1000, 400])
    {
        tag(rmtag) left(200) position(TOP) cyl(d=180, l=400, anchor=TOP);
        tag(rmtag) right(200) position(TOP) cyl(d=220, l=400, anchor=TOP);
    }
}


module template()
{
    rmtag="av5v";
    diff(rmtag)
    cuboid([300, hole_spacing+500, 50])
    {
        position(CENTER) cuboid([3000,200,50],anchor=LEFT)
        position(RIGHT+BOT) cuboid([50,1000,1000],anchor=LEFT+BOT);
        tag(rmtag) position(TOP) back(hole_spacing/2) cyl(d=80, l=50, anchor=TOP);
        tag(rmtag) position(TOP) fwd(hole_spacing/2) cyl(d=80, l=50, anchor=TOP);

    }

}



module case()
{
}

module forViewing()
{
//    model_screw();
//    model_door();
//    doorknob(front=0);
//    screwtest();
    template();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
