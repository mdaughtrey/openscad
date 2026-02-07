ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>

$fn=96;

model = 0;
// model = 1;

shaftD = 308;
shaftL = 451;
magnetD = 315;
magnetH = 108;

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

module model_magnet(anchor=CENTER,spin=0,orient=UP)
{
    module model_magnet_()
    {
        cyl(d=magnetD, h=magnetH);
    }
    attachable(anchor,spin,orient,d=magnetD, h=magnetH)
    {
        model_magnet_();
        children();
    }
}

module model_proj_shaft(anchor=CENTER,spin=0,orient=UP)
{
    module model_proj_shaft_()
    {
        cyl(d=shaftD, h=shaftL);
    }
    attachable(anchor,spin,orient,d=shaftD, h=shaftL)
    {
        model_proj_shaft_();
        children();
    }
}

module clamp(anchor=CENTER,spin=0,orient=UP)
{
    clampOD = shaftD + 800;
    rodD = 125;
    gap = 40;
    module clamp_()
    {
        if (model)
        {
            recolor("cornflowerblue")
            model_proj_shaft();
        }
        rmtag = "v263w";
        right_half(s=clampOD*2)
        diff(rmtag)
        tube(id=shaftD+20, od=clampOD+200, l=50)
        {
            position(TOP) tube(id=shaftD+20, od=clampOD, l=shaftL-100,anchor=BOT)
            {
                tag(rmtag) right(350) up(50) teardrop(d=rodD, l=1500);
                // tag(rmtag) right(350) #cyl(d=rodD, l=1500, orient=FRONT);
                position(TOP) tube(id=shaftD+20, od=clampOD+200, l=50);
            }
            tag(rmtag)
            position(BOT) down(1) cuboid([gap, clampOD+200, shaftL+2], anchor=BOT);
            *tag(rmtag)
            {
                position(BACK) right(gap/2) right(20)
                    cyl(d=magnetD+20, h=500, orient=RIGHT,anchor=BOT+BACK)
                    position(BOT) up(1) cyl(d=100,h=22,anchor=TOP);
                *position(FRONT) right(gap/2) right(20)
                    cyl(d=magnetD+20, h=500, orient=RIGHT,anchor=BOT+FRONT)
                    position(BOT) up(1) cyl(d=100,h=22,anchor=TOP);
            }
        }
    }
    attachable(anchor,spin,orient,d=1000,h=1000)
    {
        clamp_();
        children();
    }
}


module forViewing()
{
    clamp();
}

module forPrinting()
{
    clamp();
}

scale(ViewScale)
{
    forViewing();
}
