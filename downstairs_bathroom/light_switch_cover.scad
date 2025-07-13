ViewScale = [0.0254, 0.0254, 0.0254];
include <../BOSL2-master/std.scad>
include <../BOSL2-master/screws.scad>

$fn=96;

module light_switch_cover(anchor=CENTER,spin=0,orient=UP)
{
    module light_switch_cover_()
    {
        depth=400;
        rmtag="q5q2332q";
        diff(rmtag)
        cuboid([4300,4800,depth],rounding=200,edges=TOP)
        {
            tag(rmtag) position(BOT) down(10) cuboid([4300-200,4800-200,depth-100],anchor=BOT);
            tag(rmtag) left(250) down(1) cuboid([1300+30,2600+30,depth+2],anchor=RIGHT)
            {
                position(BACK+TOP) back(600-15) scale(INCH) screw_hole("6-32,.5",head="flat",anchor=TOP);
                position(FRONT+TOP) fwd(600-15) scale(INCH) screw_hole("6-32,.5",head="flat",anchor=TOP);
            }
            tag(rmtag) right(250) down(1) cuboid([1300+30,2600+30,depth+2],anchor=LEFT)
            {
                position(BACK+TOP) back(600-15) scale(INCH) screw_hole("6-32,.5",head="flat",anchor=TOP);
                position(FRONT+TOP) fwd(600-15) scale(INCH) screw_hole("6-32,.5",head="flat",anchor=TOP);
            }
        }
    }
    attachable(anchor,spin,orient,size=[4000,4000,500])
    {
        light_switch_cover_();
        children();
    }
}


module case()
{
}

module forViewing()
{
    light_switch_cover();
    //scale([1000,1000,1000]) screw_hole("6-32",head="flat",length=.5,anchor=TOP);
}

module forPrinting()
{
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
