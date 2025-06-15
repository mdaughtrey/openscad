ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>

$fn=96;

module molding(anchor=CENTER,spin=0,orient=UP)
{
    d = 5250;
    module molding_()
    {
        rmtag="45q2cr";
        diff(rmtag)
        tube(od=d, wall=150, l=400)
        {
            tag(rmtag) attach(RIGHT+BOT, norot=1) cyl(d=800, h=200, anchor=TOP, orient=RIGHT);
            attach(TOP, norot=1) cyl(d=d, h=150, rounding2=150, anchor=BOT)
            attach(TOP, norot=1)
            {
                back(3285/2)
                {
                    tag(rmtag) cyl(d=300, l=150, anchor=TOP);
                    tube(id=300, wall=100, l=550, anchor=TOP)
                    attach(BOT, norot=1) tube(od=500, id=180, l=100, anchor=BOT);
                }
                fwd(3285/2)
                {
                    tag(rmtag) cyl(d=300, l=150, anchor=TOP);
                    tube(id=300, wall=100, l=550, anchor=TOP)
                    attach(BOT, norot=1) tube(od=500, id=180, l=100, anchor=BOT);
                }
            }
        }
    }
    attachable(anchor,spin,orient,d=d, h=500)
    {
        molding_();
        children();
    }
}

module forPrinting()
{
    molding();
}

scale(ViewScale)
{
    forPrinting();
}
