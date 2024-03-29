//ViewScale = [0.0254, 0.0254, 0.0254];
include <../BOSL2-master/std.scad>

$fn=96;
module model_latching_pushbutton(anchor=CENTER,spin=0,orient=UP,bentpins=false)
{
    module model_latching_pushbutton_(bentpins) {
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
            up(20)
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
    attachable(anchor,spin,orient,size=[472,315,169]) {
        model_latching_pushbutton_(bentpins);
        children();
    }
}

//module forViewing()
//{
//    model_latching_pushbutton(bentpins=false);
//}
//
//module forPrinting()
//{
//}
//
//scale(ViewScale)
//{
//    forViewing();
//}
