ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>

$fn=96;

module model_base(anchor=CENTER,spin=0,orient=UP,len)
{
    attachable(anchor,spin,orient,size=[9875,9875,620]) {
        down(210)
        cuboid([9875,9875,200],rounding=300,edges="Z") {
            attach(BACK+TOP,norot=1) fwd(270) cuboid([6250,1070,420],rounding=300,edges="Z",anchor=BACK+BOT);
            attach(LEFT+TOP,norot=1) right(270) cuboid([1070,6250,420],rounding=300,edges="Z",anchor=LEFT+BOT);
            attach(RIGHT+TOP,norot=1) left(270) cuboid([1070,6250,420],rounding=300,edges="Z",anchor=RIGHT+BOT);
            attach(LEFT+FRONT+TOP,norot=1) back(270) right(1820) cuboid([2790,1070,420],rounding=300,edges="Z",anchor=LEFT+FRONT+BOT);
            attach(RIGHT+FRONT+TOP,norot=1) back(270) left(1820) cuboid([2790,1070,420],rounding=300,edges="Z",anchor=RIGHT+FRONT+BOT);
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
    right(1710/2) back(1710/2)
    cuboid([1710/2,1710/2,420+200],rounding=200,edges="Z",anchor=anchor) {
        tag("remove") cuboid([600,600,620],rounding=100,edges="Z");
        tag("remove") attach(TOP+BACK+RIGHT,norot=1) cuboid([730,730,200],anchor=TOP+RIGHT+BACK);
        attach(RIGHT+BACK+BOT,norot=1) fwd(1710/2+50) left(50) rect_tube(h=420,isize=[1090,1090],wall=150,anchor=LEFT+BOT)
            tag("remove") attach(RIGHT,norot=1) cuboid([400,1450,420],anchor=RIGHT);
        attach(BACK+RIGHT+BOT,norot=1) left(1710/2+50) fwd(50) rect_tube(h=420,isize=[1090,1090],wall=150,anchor=FRONT+BOT)
            tag("remove") attach(BACK,norot=1) cuboid([1450,400,420],anchor=BACK);
    }
}

module forViewing()
{
    recolor("dimgray")
    model_base(len=2000)
    attach(TOP) {
        recolor("cornflowerblue") model_lift(anchor=BOT);
        recolor("aquamarine") attach(LEFT+FRONT,norot=1) down(420) corners(anchor=LEFT+FRONT+BOT);
        recolor("aquamarine") attach(RIGHT+FRONT,norot=1) down(420) zrot(90) corners(anchor=FRONT+LEFT+BOT);
    }
}

module forPrinting()
{
    corners();
}

scale(ViewScale)
{
    forViewing();
//    forPrinting();
}
