ViewScale = [0.0254, 0.0254, 0.0254];
include <../../../BOSL2-master/std.scad>
include <../../../BOSL2-master/joiners.scad>
include <../../../BOSL2-master/walls.scad>
$fn=96;

model=0;

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

module model_box(anchor=CENTER,spin=0,orient=UP)
{
    module model_box_()
    {
        rmtag="rv4315qq";
//        diff(rmtag)
        cuboid([4400,1850,4700]);
//        cyl(d=1800,l=5000)
//        {
//            tag(rmtag) position(TOP) yrot(90-66) down(0)
//            cyl(d=2810,l=800); 
//        }
    }
    attachable(anchor,spin,orient,d=1800,l=5000)
    {
        model_box_();
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

module pole_mount(anchor=CENTER,spin=0,orient=UP)
{
    module pole_mount_()
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
        pole_mount_();
        children();
    }
}

module box_mount(anchor=CENTER,spin=0,orient=UP)
{
    module box_mount_()
    {
        if (model)
        {
            up(2700)
            model_box();
        }
        rmtag="flad25";
        diff(rmtag)
        recolor("cornflowerblue")
        rect_tube(size=[5060,2310], rounding=200,irounding=100,wall=600,l=300)
        {
            position(TOP) sparse_cuboid([5060,2310,4900], "Y", strut=200, max_bridge=1000,rounding=200, edges="Z",anchor=BOT)
            {
                tag(rmtag) cuboid([5100,1600,4500],rounding=100,edges="X");
            }
            tag(rmtag) position(TOP) cuboid([4660,1930,5000],anchor=BOT);
            position(BACK+BOT) cuboid([1500,600,5200], anchor=FRONT+BOT)
            tag(rmtag) position(BACK+BOT) dovetail("female", orient=FRONT, anchor=BOT+FRONT, width=1000, height=600, slide=4000, taper=2);
        }

//        position(TOP) rect_tube(size=[5060,2310], rounding=200,,wall=200,l=4900)
//        tag(rmtag) cuboid([5100,1600,4500],rounding=100,edges="X");
//        cuboid([4400,1850,4700]);
    }
    attachable(anchor,spin,orient,size=[100,100,100])
    {
        box_mount_();
        children();
    }
}

module forViewing()
{
//    pole_mount();
    box_mount();
//    up(400) captop();
//    model_box();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
