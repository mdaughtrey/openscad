ViewScale = [0.0254, 0.0254, 0.0254];
include <../../../BOSL2-master/std.scad>
include <../../../BOSL2-master/gears.scad>
include <../../../BOSL2-master/ball_bearings.scad>

include <../../../models/model_film.scad>
//include <../../../models/model_ir_reflective_sensor.scad>

mm = function(tomill) tomill/25.4*1000;
$fn=96;

model=0;
mirrorsize2d = [600,622];
mirrorsize3d = concat(mirrorsize2d,113);

module model_mirror(anchor=CENTER,spin=0,orient=UP,lift=1)
{
    module model_mirror_()
    {
        cuboid(mirrorsize);
    }
    attachable(anchor,spin,orient,size=mirrorsize)
    {
        model_mirror_();
        children();
    }
}

module mirror_holder(anchor=CENTER,spin=0,orient=UP)
{
    module mirror_holder_()
    {
        h=mirrorsize3d[2];
        cuboid(concat(mirrorsize2d+[80,80],50))
        {
            a=mirrorsize2d[1]+h+50+80;
            attach(LEFT+BOT+BACK,norot=1) wedge([30,a,a],spin=180,anchor=RIGHT+FRONT+BOT);
            attach(RIGHT+BOT+BACK,norot=1) wedge([30,a,a],spin=180,anchor=LEFT+FRONT+BOT);
            attach(TOP,norot=1) rect_tube(isize=mirrorsize2d+[20,20],wall=30,h=h,anchor=BOT)
            attach(FRONT+TOP) wedge([mirrorsize2d[0]+80,h+50,h+50] ,orient=FRONT+TOP ,anchor=BOT+BACK);
//            recolor("cornflowerblue")
//            attach(BACK+BOT,norot=1) down(40)
//            cuboid([mirrorsize2d[1]+60+80,30,a+80],anchor=BOT+FRONT)
//            attach(FRONT)
//            rect_tube(size=[mirrorsize2d[1]+60+80,a+80],wall=30,h=200,anchor=BOT);
        }
    }
    attachable(anchor,spin,orient,size=mirrorsize3d)
    {
        mirror_holder_();
        children();
    }
}


module slotguide_with_mirror(anchor=CENTER,spin=0,orient=UP,lift=1)
{
    module slotguide_with_mirror_()
    {
        diff()
        cuboid(size=[890,795,210])
        {
            tag("remove") attach(LEFT,norot=1) cuboid([1020,655,211],anchor=LEFT);
            attach(LEFT+BACK+BOT,norot=1) cuboid([890,120,100],anchor=LEFT+BACK+TOP);
            attach(LEFT+FRONT+BOT,norot=1) cuboid([890,120,100],anchor=LEFT+FRONT+TOP);
            //
            attach(TOP+RIGHT,norot=1) cuboid(size=[890,795,lift],anchor=RIGHT+BOT)
            {
                tag("remove") attach(RIGHT,norot=1) left(100) cuboid([1020,455,lift+1],anchor=RIGHT);
                attach(TOP+RIGHT,norot=1) cuboid([100,795,20],anchor=BOT+RIGHT)

                attach(TOP+RIGHT,norot=1) cuboid(size=[890,795,50],anchor=RIGHT+BOT) 
                {
                    tag("remove") attach(RIGHT,norot=1) left(100) cuboid([1020,455,51],anchor=RIGHT);
                }
            }
        }
    }
    height=100+25+lift+120;
    attachable(anchor,spin,orient,size=[1020,655,height])
    {
        down(210/2-5)
        {
            slotguide_with_mirror_();
            up(635) right(60)
            mirror_holder(spin=-90,orient=BOT+LEFT);
        }
        children();
    }
}

module lid(anchor=CENTER,spin=0,orient=UP)
{
    h=mirrorsize3d[2];
    a=mirrorsize2d[1]+h+50+80;
    module lid_()
    {
        attach(BACK+BOT,norot=1) down(40)
        cuboid([mirrorsize2d[1]+60+70,30,a+70],anchor=BOT+FRONT)
        attach(FRONT)
        rect_tube(size=[mirrorsize2d[1]+60+70,a+70],wall=35,h=200,anchor=BOT);

    }
    attachable(anchor,spin,orient,size=mirrorsize3d)
    {
        lid_();
        children();
    }
}

module forPrinting()
{
    lid();
}

module forViewing()
{
//    mirror_holder();
    slotguide_with_mirror(lift=125);
// lid();
}

scale(ViewScale)
{
    forPrinting();
   // forViewing();
}
