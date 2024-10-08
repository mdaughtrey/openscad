ViewScale = [0.0254, 0.0254, 0.0254];

include <../../BOSL2-master/std.scad>
$fn=96;


// module modname(anchor=CENTER,spin=0,orient=UP)
// {
//     module modname_()
//     {
//     }
//     attachable(anchor,spin,orient,size=)
//     {
//         modname_();
//         children();
//     }
// }


module model_pole()
{
    cuboid([8500, 8500, 1000], anchor=BOT)
    attach(TOP, norot=1) cyl(h=1000,d=4774, anchor=BOT)
    attach(TOP, norot=1) cyl(h=3000, d=4100, anchor=BOT);
}

module molding(anchor=CENTER,spin=0,orient=UP)
{
    module molding_()
    {
        diff("m_remove")
        cuboid([9500, 9500, 1200], anchor=BOT, rounding=100, edges=[TOP,"Z"])
        {
            attach(TOP, norot=1) cyl(d=9300,h=1000, anchor=BOT, rounding2=1000)
            attach(TOP, norot=1) cyl(d=7500,h=500, anchor=BOT)
            attach(TOP, norot=1) cyl(d=4500,h=1500, anchor=BOT, rounding1=-1000);
            
            tag("m_remove")
            {
                attach(BOT, norot=1) cuboid([8000, 8000, 1001], anchor=BOT)
                attach(TOP,norot=1) cyl(h=1200,d=6900, anchor=BOT)
                attach(TOP,norot=1) cyl(h=3000,d=4200, anchor=BOT);
            }
        }
    }
    attachable(anchor,spin,orient,size=[9500, 9500, 1100])
    {
        molding_();
        children();
    }
}

module forViewing()
{
//    case();
    *model_pole();
    recolor("cornflowerblue")
    molding();
}

module forPrinting()
{
//    difference()
//    {
        right_half(s=10000)
        molding();
//        fwd(400) cuboid([4000,500,4500],anchor=BOT+LEFT);
//        fwd(1200) cuboid([4000,500,4500],anchor=BOT+LEFT);
//        fwd(2000) cuboid([4000,500,4500],anchor=BOT+LEFT);
//        fwd(2800) cuboid([4000,500,4500],anchor=BOT+LEFT);
//        fwd(3600) cuboid([4000,500,4500],anchor=BOT+LEFT);
//
//        back(400) cuboid([4000,500,4500],anchor=BOT+LEFT);
//        back(1200) cuboid([4000,500,4500],anchor=BOT+LEFT);
//        back(2000) cuboid([4000,500,4500],anchor=BOT+LEFT);
//        back(2800) cuboid([4000,500,4500],anchor=BOT+LEFT);
//        back(3600) cuboid([4000,500,4500],anchor=BOT+LEFT);
//    }
}

scale(ViewScale)
{
//    forViewing();
    forPrinting();
}
