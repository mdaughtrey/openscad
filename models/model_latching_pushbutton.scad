ViewScale = [0.0254, 0.0254, 0.0254];
include <../BOSL2-master/std.scad>

$fn=96;
module case(anchor=CENTER,spin=0,orient=UP,bentpins=false)
{
    // Body
    recolor("slategrey")
    intersect()
    cyl(d=472,h=169) {
        tag("intersect") cuboid([472,315,169]);
        tag("keep") attach(TOP,norot=1) cyl(d=272,h=78,anchor=BOT)
        attach(TOP,norot=1) cyl(d=173,h=75,anchor=BOT);
    }
    // Legs
    recolor("silver") {
        if (bentpins)
        {
            cuboid([500,169,5]) {
                attach(RIGHT+TOP,norot=1) cuboid([5,78,433/2],anchor=TOP,
                    rounding=78/2,edges=[FRONT+BOT,BACK+BOT]);
                attach(LEFT+TOP,norot=1) cuboid([5,78,433/2],anchor=TOP,
                    rounding=78/2,edges=[FRONT+BOT,BACK+BOT]);
            }
        }
        else
        {
            cuboid([500,169,5]);
            cuboid([1055,78,5],rounding=25,edges="Z");
        }
    }
}

module forViewing()
{
    case(bentpins=false);
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
