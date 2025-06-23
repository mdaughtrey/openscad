ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>

$fn=96;

//module modname(anchor=CENTER,spin=0,orient=UP)
//{
//    module modname_()
//    {
//    }
//    attachable(anchor,spin,orient,size=)
//    {
//        modname_();
//        children();
//    }
//}


module arc(d)
{
    intersection()
    {
        tube(id=d, wall=100, h=200, anchor=BACK);
        cuboid([2530, 1000, 200],anchor=BACK);
    }
}

module case()
{
    rmtag="qc4134vA";
    diff(rmtag)
    cuboid([2530, 800, 850])
    {
        tag(rmtag) position(BACK) fwd(50) cuboid([2530-100,800,750], anchor=BACK);
        tag(rmtag) position(FRONT) back(200) tube(od=19000, wall=200, h=851, anchor=BACK);
        tag(rmtag) position(BACK) 
        intersection()
        {
            cyl(d=485, l=50, anchor=TOP, orient=BACK);
            cuboid([423+15, 50, 490], anchor=BACK);
        }
    }
}

module forViewing()
{
//    arc(19000);
    case();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
