ViewScale = [0.0254, 0.0254, 0.0254];
include <../../../BOSL2-master/std.scad>
include <../../../BOSL2-master/joiners.scad>
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


module model_pole(anchor=CENTER,spin=0,orient=UP)
{
    module model_pole_()
    {
        rmtag="rv215qq";
        diff(rmtag)
        cyl(d=1800,l=5000)
        {
            tag(rmtag) position(TOP) yrot(90-66) down(0)
            cyl(d=2810,l=800); 
        }
    }
    attachable(anchor,spin,orient,d=1800,l=5000)
    {
        model_pole_();
        children();
    }
}

module captop(anchor=CENTER,spin=0,orient=UP)
{
    module captop_()
    {
        itag="iv21wcd";
        intersect(itag)
        cyl(l=2000,d=2200)
        {
            tag(itag)
            yrot(90-66) cyl(d=2600,l=300);
        }
    }
    attachable(anchor,spin,orient,d=2600,l=1000)
    {
        captop_();
        children();
    }
}

module cap(anchor=CENTER,spin=0,orient=UP)
{
    module cap_()
    {
        rmtag="rc5q233";
        diff(rmtag)
        tube(id=1840,l=1500,od=2200)
        {
            tag(rmtag) position(TOP) yrot(90-66) cyl(d=3010,l=1000); 
            position(BOT) tube(id=1840,od=2200,l=4000,anchor=TOP)
            {
                tag(rmtag) right(400) position(TOP+LEFT) cuboid([400,2200,4002],anchor=TOP+RIGHT);
                tag("keep") position(BOT+RIGHT) left(80) dovetail("male", orient=RIGHT, spin=90, anchor=BOT+FRONT, width=1000, height=600, slide=4000, taper=2);
            }
        }
        down(140) captop(anchor=BOT);
    }
    attachable(anchor,spin,orient,d=2200,l=1000)
    {
        cap_();
        children();
    }
}

module forViewing()
{
    cap();
//    up(400) captop();
        
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
