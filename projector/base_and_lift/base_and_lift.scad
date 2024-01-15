ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>

$fn=96;

module model_base(anchor=CENTER,spin=0,orient=UP)
{
    attachable(anchor,spin,orient,size=[9875,9875,620]) {
        down(210)
        cuboid([7250,7250,200],rounding=300,edges="Z") {
            attach(BACK+TOP,norot=1) cuboid([6250,1070,420],rounding=300,edges="Z",anchor=FRONT+BOT);
            attach(FRONT+TOP,norot=1) cuboid([6250,1070,420],rounding=300,edges="Z",anchor=BACK+BOT);
            attach(LEFT+TOP,norot=1) cuboid([1070,6250,420],rounding=300,edges="Z",anchor=RIGHT+BOT);
            attach(RIGHT+TOP,norot=1) cuboid([1070,6250,420],rounding=300,edges="Z",anchor=LEFT+BOT);
        }
        children();
    }
}

module model_lift(anchor=CENTER,spin=0,orient=UP)
{
    cuboid([7875,7875,200],rounding=200,edges="Z",anchor=anchor);
}

module corners0(anchor=CENTER,spin=0,orient=UP)
{
    diff()
    cuboid([1710,1710,420+200],rounding=200,edges="Z",anchor=anchor) {
        tag("remove") attach(TOP+BACK+RIGHT,norot=1) cuboid([730,730,200],anchor=TOP+RIGHT+BACK);
        attach(RIGHT+FRONT+BOT,norot=1) back(160) rect_tube(h=420,isize=[1050,1050],irounding=300,wall=100,anchor=LEFT+FRONT+BOT)
            tag("remove") attach(RIGHT,norot=1) cuboid([400,1250,420],anchor=RIGHT);
        attach(BACK+LEFT+BOT,norot=1) right(160) rect_tube(h=420,isize=[1050,1050],irounding=300,wall=100,anchor=LEFT+FRONT+BOT)
            tag("remove") attach(BACK,norot=1) cuboid([1250,400,420],anchor=BACK);
    }
}

module corners(anchor=CENTER,spin=0,orient=UP)
{
    diff()
//    right(1710/2) back(1710/2)
    cuboid([1300,1300,420+200],anchor=anchor) {
        tag("remove") cuboid([600,600,621],rounding=100,edges="Z");
        tag("remove") attach(TOP+BACK+RIGHT,norot=1) cuboid([730,730,200],anchor=TOP+RIGHT+BACK);
        attach(BACK+BOT+RIGHT,norot=1) cuboid([470,1000,420],anchor=FRONT+RIGHT+BOT);
        attach(BACK+BOT+RIGHT,norot=1) cuboid([1000,470,420],anchor=BACK+LEFT+BOT);
        *attach(RIGHT+BACK+BOT,norot=1) fwd(1710/2+50) left(50) rect_tube(h=420,isize=[1090,1090],wall=150,anchor=LEFT+BOT)
            tag("remove") attach(RIGHT,norot=1) cuboid([400,1450,420],anchor=RIGHT);
        *attach(BACK+RIGHT+BOT,norot=1) left(1710/2+50) fwd(50) rect_tube(h=420,isize=[1090,1090],wall=150,anchor=FRONT+BOT)
            tag("remove") attach(BACK,norot=1) cuboid([1450,400,420],anchor=BACK);
    }
}

module forViewing()
{
    recolor("dimgray")
    model_base()
    attach(TOP) {
        *recolor("cornflowerblue") model_lift(anchor=BOT);
        recolor("aquamarine") attach(LEFT+FRONT,norot=1) down(100) right(1800) back(1800) corners(anchor=RIGHT+BACK);
        *recolor("aquamarine") attach(RIGHT+FRONT,norot=1) down(420) zrot(90) corners(anchor=FRONT+LEFT+BOT);
    }
    *up(330) ruler(10000,anchor=CENTER);
}

module forPrinting()
{
    corners();
}

scale(ViewScale)
{
//    forViewing();
    forPrinting();
}
