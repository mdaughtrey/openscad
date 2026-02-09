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

module rounder(anchor=CENTER,spin=0,orient=UP,id=1000,l=1000)
{
    module rounder_()
    {
        rmtag="rv1r5323";
        diff(rmtag)
        right_half(s=12000)
        cuboid([id,l,id])
        {
            tag(rmtag) fwd(1) cyl(d=id,l=l+4,orient=FRONT);
        }
    }
    attachable(anchor,spin,orient,size=[id/2,l,id/2])
    {
        left(id/4)
        rounder_();
        children();
    }
}

module curve(anchor=CENTER,spin=0,orient=UP,w=1000,thickness=300,d=1000)
{
    module curve_()
    {
        left_half(s=d*2)
        tube(od=d,wall=thickness,l=w);
    }
    attachable(anchor,spin,orient,d=d,h=w)
    {
        curve_();
        children();
    }
}

module clip(anchor=CENTER,spin=0,orient=UP)
{
    width=1000;
    thickness=400;
    module clip_()
    {
        rmtag="c1q24ed";
        itag="ivc1q5r";
        diff(rmtag)
        left_half(s=10000) rect_tube(isize=[8000,5000],wall=thickness,l=width,rounding=300,irounding=100)
        {
            tag(rmtag)
            {
                position(FRONT) rounder(anchor=RIGHT+FRONT,l=thickness+2);
                position(BACK) rounder(anchor=RIGHT+BACK,l=thickness+2);
            }
            position(FRONT) tag("keep")  cyl(d=width, l=1000, orient=FRONT, anchor=BOT+RIGHT)
            position(TOP+RIGHT) cuboid([3000,width,thickness], rounding=width/2, edges="Z", anchor=BOT+RIGHT);
        }
//        cuboid([width,5000,thickness],rounding=100)
//        {
//            position(BACK+TOP) cuboid([width, thickness, 3000], anchor=TOP+FRONT, rounding=100);
//            position(FRONT+TOP) cuboid([width, thickness, 3000], anchor=TOP+BACK,edges=[BOT+LEFT,BOT+RIGHT],rounding=width/2)
//            {
//                position(BOT+FRONT)
//                cyl(d=width, l=2000, orient=FRONT, anchor=BOT+FRONT)
//                position(TOP)
//                down(1700) zrot(90) yrot(90)
//                curve(thickness=thickness, w=1000, d=4000);
////                #cuboid([width*4,1000,thickness],rounding=500,edges="Z",anchor=BOT);
//            }
//        }
    }
    attachable(anchor,spin,orient,size=[1000,1000,1000])
    {
        clip_();
        children();
    }
}


module forViewing()
{
    clip();
//    rounder();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
