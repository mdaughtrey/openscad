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

module model_molding(anchor=CENTER,spin=0,orient=UP,length=1000)
{
    module model_molding_()
    {
        fwd(38)
        cuboid([length, 250, 250], anchor=BACK+BOT)
        position(FRONT+TOP) cuboid([length, 100, 30], anchor=BOT+FRONT);

        back(38)
        cuboid([length, 250, 250], anchor=FRONT+BOT)
        position(BACK+TOP) cuboid([length, 100, 30], anchor=BOT+BACK);

        cuboid([length, 1750, 125], anchor=TOP);
    }
    attachable(anchor,spin,orient,size=[length,1750,125+250+30])
    {
        model_molding_();
        children();
    }
}

module model_floor(anchor=CENTER,spin=0,orient=UP,length=1000)
{
    module model_floor_()
    {
        cuboid([length, 200, 1000+350])
        {
            position(BOT+FRONT)
            cuboid([length, 350, 350], anchor=BACK+BOT)
            position(FRONT+BOT)
            pie_slice(d=350*2, height=length, ang=90,orient=RIGHT,spin=180,anchor=CENTER);

            position(BACK+BOT)
            cuboid([length, 900+200, 100], anchor=TOP+BACK)
            position(FRONT+BOT)
            cuboid([length, 100, 625], anchor=BOT+FRONT);
        }
    }
    attachable(anchor,spin,orient,size=[length, 200, 1000])
    {
        model_floor_();
        children();
    }
}

module floor_cutout(anchor=CENTER,spin=0,orient=UP,length=1000)
{
    module floor_cutout_()
    {
        *cuboid([length, 200, 1000+350]);
        {
//            position(BOT+FRONT)
            cuboid([length, 350, 350])
            position(FRONT+BOT)
            pie_slice(d=350*2, height=length, ang=90,orient=RIGHT,spin=180,anchor=CENTER);

            *position(BACK+BOT)
            cuboid([length, 900+200, 100], anchor=TOP+BACK)
            *position(FRONT+BOT)
            cuboid([length, 100, 625], anchor=BOT+FRONT);
        }
    }
    attachable(anchor,spin,orient,size=[length, 700, 350])
    {
        back(175)
        floor_cutout_();
        children();
    }
}

module mount0(anchor=CENTER,spin=0,orient=UP,length=1000)
{
    module mount0_()
    {
        rmtag = "rmf1q5v324";
        diff(rmtag)
        {
            wedge([length, 1586, 740],center=true)
            position(FRONT+BOT)
            cuboid([length,1080,600], anchor=TOP+FRONT)
            tag(rmtag)
            position(BOT+FRONT)
            down(1)
            up(110)
            scale([1.0, 1.02, 1.02])
            floor_cutout(spin=180,anchor=BACK+BOT,length=length+50)
            position(BOT+BACK)
            cuboid(anchor=TOP+BACK, [length+50, 1100, 200]);
            tag(rmtag)
            {
                xrot(180-25)
                scale([1.0, 1.02, 1.02])
                model_molding(length=length+50);
            }
        }
    }
    attachable(anchor,spin,orient,size=[length,1586,740+600])
    {
        mount0_();
        children();
    }
}

module intermount(anchor=CENTER,spin=0,orient=UP,length=1000)
{
    module intermount_()
    {
        itag="iq51vf";
        ktag="kvaqtgf";
        rtag="rv35tfvq";
        intersect(itag, ktag)
        tube(id=700,wall=100,l=length)
        {
            tag(itag)
            cuboid(anchor=RIGHT+BACK, [700, 700, length]);
            tag(ktag)
            position(LEFT)
            diff(rtag)
            cuboid([100,360,length],anchor=FRONT+LEFT)
            {
                position(LEFT)
                cyl(d=350,h=100,anchor=BOT,orient=LEFT)
                position(TOP)
                tag(rtag)
                up(1)
                cyl(d=170,l=300,anchor=TOP);
            }
        }
    }
    attachable(anchor,spin,orient,size=[350,350+700,length])
    {
        intermount_();
        children();
    }
}

module forViewing()
{
    intermount(length=1000);
}

module forPrinting()
{
    mount0(spin=180,length=500);
    move([700,430,-850])
    rot([0, 90, 0])
    intermount(length=1000);
    right(1400)
    mount0(spin=180,length=500);
}

scale(ViewScale)
{
//    forViewing();
    forPrinting();
}
