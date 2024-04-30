ViewScale = [0.0254, 0.0254, 0.0254];
include <../../../BOSL2-master/std.scad>

$fn=96;

module ms_clamp(anchor=CENTER,spin=0,orient=UP)
{
    module ms_clamp()
    {
        diff()
        tube(id=1560,od=1760,h=800) {
            tag("remove") attach(CENTER,norot=1) left(20) cuboid([1760/2+100,1760,802],anchor=LEFT);
            attach(LEFT+BOT,norot=1) right(100) tube(id=250,od=450,h=800,anchor=BOT+RIGHT);
            attach(FRONT,norot=1) left(70) back(20) cuboid([100,400,800],rounding=400,edges=[FRONT+TOP,FRONT+BOT],anchor=BACK)
                tag("remove") cyl(d=180,h=102,orient=LEFT);
            attach(BACK,norot=1) left(70) fwd(20) cuboid([100,400,800],rounding=400,edges=[BACK+TOP,BACK+BOT],anchor=FRONT)
                tag("remove") cyl(d=180,h=102,orient=LEFT);
        }
    }
    attachable(anchor,spin,orient,d=1740,l=1600)
    {
        ms_clamp();
        children();
    }
}

module forViewing()
{
    case();
}

module forPrinting()
{
    ms_clamp();
}

scale(ViewScale)
{
//    forViewing();
    forPrinting();
}
