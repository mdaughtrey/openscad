ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>
include <../../BOSL2-master/threading.scad>

$fn=96;

// module top_plate(anchor=CENTER,spin=0,orient=UP)
// {
//     module top_plate_()
//     {
//     }
//     attachable(anchor,spin,orient,size=)
//     {
//         top_plate_();
//         children();
//     }
// }


module threaded_clamp(anchor=CENTER,spin=0,orient=UP)
{
    module threaded_clamp_()
    {
//        right_half(s=2020) cyl(d=300,h=1000,anchor=BOT);
        rmtag="v1rv2r2q";
        itag="vrq231fw";
        ktag="vrq23fw";
        diff(rmtag)
        cyl(d=900,h=120,anchor=BOT)
        {
            position(TOP)
            cyl(d=2100,h=50,anchor=BOT) 
//            intersect(itag, keep=ktag)
//            {
//                cyl(d=1200,h=50,anchor=BOT) 
//                tag(itag) position(BOT) cuboid([1500,800,50],anchor=BOT);
//            }
            position(TOP) threaded_rod(d=980,l=500,pitch=100,d2=930,anchor=BOT);
            tag(rmtag) position(BOT) left(20) right_half(s=1410) down(1) cyl(d=345,h=702,anchor=BOT);
            tag(rmtag) position(BOT) right(20) left_half(s=1410) down(1) cyl(d=345,h=702,anchor=BOT);
            tag(rmtag) position(BOT) down(1) cuboid([50,2120,720],anchor=BOT);
        }
    }
    attachable(anchor,spin,orient,d=1000,h=100)
    {
        down(670/2)
        threaded_clamp_();
        children();
    }
}

module clamp_nut(anchor=CENTER,spin=0,orient=UP)
{
    module clamp_nut_()
    {
        threaded_nut(nutwidth=1000,id=750,h=500,pitch=100);
    }
    attachable(anchor,spin,orient,d=1000,h=100)
    {
        clamp_nut_();
        children();
    }
}

module bottom_plate(anchor=CENTER,spin=0,orient=UP)
{
    module bottom_plate_()
    {
        rmtag="vlkwhi";
        itag="ivlkwhi";
        ktag="kvlkwhi";
        diff(rmtag)
        tube(id=920,od=2400,h=100)
        {
            position(BOT) tag(rmtag) down(1) cyl(d=920,h=102,anchor=BOT);
            position(TOP) tube(od=2400, wall=50, h=120, anchor=BOT);
//            tag(rmtag) position(BOT) down(1)
//            intersect(itag, keep=ktag)
//            {
//                cyl(d=1220,h=102,anchor=BOT) 
//                tag(itag) position(BOT) cuboid([1500,820,102],anchor=BOT);
//            }
        }
//        position(TOP)
//        {
//            tube(od=1000,wall=50,h=50,anchor=BOT);
//            tube(od=800,wall=50,h=50,anchor=BOT);
//            tube(od=600,wall=50,h=50,anchor=BOT);
//            tube(id=320,wall=50,h=250,anchor=BOT);
//        }
    }
    attachable(anchor,spin,orient,d=2400,h=222)
    {
        bottom_plate_();
        children();
    }
}

module bottom_plate_lid(anchor=CENTER,spin=0,orient=UP)
{
    module bottom_plate_lid_()
    {
        tube(id=2120,od=2290,h=120)
        position(TOP)
        tube(id=1100,od=2290,h=50,anchor=BOT);
    }
    attachable(anchor,spin,orient,d=2320,h=100)
    {
        bottom_plate_lid_();
        children();
    }
}

module forViewing()
{
//    up(300)
//    clamp_nut()
    threaded_clamp(anchor=BOT)
    position(BOT)  down(340)
    recolor("cyan")
    bottom_plate(anchor=BOT)
    position(TOP)
    recolor("green")
    bottom_plate_lid(anchor=TOP);
}

module forPrinting()
{
    threaded_clamp();
//    clamp_nut();
//    bottom_plate_lid();
//    bottom_plate();
}

scale(ViewScale)
{
//    forViewing();
    forPrinting();
}
