ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>
$fn=96;

module ductmold(anchor=CENTER,spin=0,orient=UP)
{
    module ductmold_()
    {
        rmtag="rvcq45axc";
        diff(rmtag)
        cuboid([15000, 15000, 300], rounding=500, edges="Z")
        {
            tag(rmtag)
            position(BOT) down(1)
            cyl(d=11400,h=302,anchor=BOT);
            position(TOP) tube(od=12000,wall=300,l=5000,anchor=BOT);
            tag(rmtag)
            position(BACK+LEFT+BOT) down(1)
            fwd(500) right(500) cyl(d=200, h=302, anchor=BOT)
            {
                right(2000) cyl(d=200, h=302)
                right(2000) cyl(d=200, h=302)
                right(2000) cyl(d=200, h=302);

                fwd(2000) cyl(d=200, h=302)
                fwd(2000) cyl(d=200, h=302)
                fwd(2000) cyl(d=200, h=302);
            }
        }
    }
    attachable(anchor,spin,orient,size=[15000,14000,300])
    {
        left_half(s=24000)
        back_half(s=24000)
        ductmold_();
        children();
    }
}


module forViewing()
{
    rect_tube(isize=[12000,12000], l=3500, wall=1500)
    position(TOP)
    recolor("cornflowerblue")
    ductmold(anchor=BOT);

//    tube(id=12000,wall=100,l=6000,anchor=BOT);
}

module forPrinting()
{
    ductmold();
}

scale(ViewScale)
{
//    forViewing();
    forPrinting();
}
