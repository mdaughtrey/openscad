ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>
include <../../BOSL2-master/walls.scad>

$fn=96;
magnetd = 8/25.4*1000;
magneth = 3/25.4*1000;

model=0;

module collar_inserter(anchor=CENTER,spin=0,orient=UP)
{
    attachable(anchor,spin,orient,size=[1500,1500,600]) {
        down(300)
        union() {
            rect_tube(h=500,size=1380,isize=1280,rounding=50)
            attach(TOP,overlap=1)
            rect_tube(h=100,size=1500,isize=1280,rounding=50,anchor=BOT);
        }
        children();
    }
}

module collar_acceptor(anchor=CENTER,spin=0,orient=UP,extend=0)
{
    attachable(anchor,spin,orient,size=[1500,1500,550+extend]) {
    down((550+extend)/2)
    rect_tube(h=50,size=1500,isize=1300,rounding=50)
    attach(TOP) 
    rect_tube(h=500+extend,size=1500,isize=1400,rounding=50,anchor=BOT);
    children();
    }
}

module model_magnet_8x3mm()
{
    cyl(h=magneth,d=magnetd);
}

module magnetic_collar_v1()
{

    module magnetholder(anchor=CENTER,spin=0,orient=UP) 
    {
        attachable(anchor,spin,orient,size=[1400,magnetd+100,magneth+30]) {
            diff() {
                cuboid([1400,magnetd+100,magneth+30],rounding=50,edges="Z")
                {
                    tag("remove") attach(TOP) left(400) cyl(h=magneth,d=magnetd+20,anchor=TOP);
                    tag("remove") attach(TOP) right(400) cyl(h=magneth,d=magnetd+20,anchor=TOP);
                }
            }
            children();
        }
    }
    rect_tube(h=200,isize=1520,size=1620,irounding=50,rounding=100)
    {
        attach(FRONT+BOT,norot=1) magnetholder(anchor=BACK+BOT);
        attach(BACK+BOT,norot=1) magnetholder(anchor=FRONT+BOT);
    }
}

module magnetic_collar_v2()
{

    module magnetholder(anchor=CENTER,spin=0,orient=UP) 
    {
        attachable(anchor,spin,orient,size=[magnetd+100,magnetd+100,magneth+30]) {
            diff() {
                cuboid([magnetd+100,magnetd+100,magneth+30],rounding=50,edges="Z")
                {
                    tag("remove") attach(TOP) cyl(h=magneth,d=magnetd+20,anchor=TOP);
                }
            }
            children();
        }
    }
    rect_tube(h=200,isize=1520,size=1620,irounding=50,rounding=100)
    {
        attach(FRONT+BOT,norot=1) magnetholder(anchor=BACK+BOT);
        attach(BACK+BOT,norot=1) magnetholder(anchor=FRONT+BOT);
        attach(LEFT+BOT,norot=1) magnetholder(anchor=RIGHT+BOT);
        attach(RIGHT+BOT,norot=1) magnetholder(anchor=LEFT+BOT);
    }
}

module forViewing()
{
    if (model) {
        recolor("peachpuff") {
            collar_acceptor();
//            model_magnet_8x3mm();
        }
    }
    recolor("cyan")
    magnetic_collar_v2();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
    // forPrinting();
}
