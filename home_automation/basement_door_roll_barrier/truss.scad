ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>
include <../../BOSL2-master/cubetruss.scad>
include <../../BOSL2-master/gears.scad>

$fn=96;
model=0;

module onetruss(anchor=CENTER,spin=0,orient=UP)
{
    cubesize = 1800;
    extents = 3;
    module onetruss_()
    {
        strut = 200;
        cubetruss(extents=extents,
            bracing=false,
            size=cubesize,
            strut=strut)
        {
            // End angle and tape holder
            position(FRONT)
               cubetruss_support(
                    size=cubesize,
                    strut=strut,
                    orient=BOTTOM,
                anchor=BACK)
            {
                // Axle holders
                position(RIGHT+TOP+FRONT) tube(id=90, wall=100,l=200,orient=LEFT,anchor=RIGHT+BOT);
                position(LEFT+TOP+FRONT) tube(id=90, wall=100,l=200,orient=LEFT,anchor=RIGHT+TOP);
                if (model) down(140)
                position(TOP+FRONT) model_axle();

                // Tape holder
                position(BACK) down(200) tape_holder_bottom(length=cubesize,orient=FRONT,anchor=FRONT+TOP);
                position(BACK+TOP) cuboid([200,cubesize-100,200],anchor=FRONT+TOP);

                // Racks
                position(BACK+BOT+RIGHT) rack(pitch=150, teeth=33, thickness=200, backing=120,orient=DOWN,spin=90,anchor=LEFT+BACK+BOT);
                position(BACK+BOT+LEFT) rack(pitch=150, teeth=33, thickness=200, backing=120,orient=DOWN,spin=90,anchor=LEFT+FRONT+BOT);
            }
           
            // End angle and tape holder
            position(BACK)
                zrot(180)
                cubetruss_support(
                    size=cubesize,
                    strut=strut,
                    orient=BOTTOM,
                anchor=BACK)
            {
                // Axle holders
                position(RIGHT+TOP+FRONT) left(220) tube(id=90, wall=100,l=200,orient=LEFT,anchor=RIGHT+BOT);
                position(LEFT+TOP+FRONT) right(220) tube(id=90, wall=100,l=200,orient=LEFT,anchor=RIGHT+TOP);

                // Tape holder
                position(BACK) down(200) tape_holder_bottom(length=cubesize,orient=FRONT,anchor=FRONT+TOP);
                position(BACK+TOP) cuboid([200,cubesize-100,200],anchor=FRONT+TOP);
            }

        }
    }
    attachable(anchor,spin,orient,size=[cubesize, cubesize * (2 + extents) + 200, cubesize+320])
    {
        down(320/2)
        onetruss_();
        children();
    }
}

module tape_holder()
{
    tube(id=1100,od=1200,l=500);
    tube(id=950,od=1050,l=500);
    left(450) cuboid([100,600,500],anchor=RIGHT);
    right(450) cuboid([100,600,500],anchor=LEFT);
}

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

module tape_holder_bottom(anchor=CENTER,spin=0,orient=UP,length=500)
{
    module tape_holder_bottom_()
    {
        intersect("mask")
        tube(id=1200,od=1300,l=length)
        tag("mask")  back(80) cuboid([1000,600,length],anchor=FRONT)
        tag("keep")
        {
            position(LEFT+BOT) right(20) cyl(d=150,l=length, anchor=BOT+RIGHT);
            position(RIGHT+BOT) left(20) cyl(d=150,l=length, anchor=BOT+LEFT);
        }
    }
    attachable(anchor,spin,orient,size=[1000+130,600,length])
    {
        tape_holder_bottom_();
        children();
    }
}

module tape_holder_top(anchor=CENTER,spin=0,orient=UP,length=500)
{
    module center(anchor=CENTER,spin=0,orient=UP)
    {
        itag="412qc14";
        module center_()
        {
            intersect(itag)
            tube(id=1050,od=1150,l=length)
            {
                tag(itag) cuboid([950,650,length],anchor=FRONT);
            }
        }
        attachable(anchor,spin,orient,size=[800,275,length])
        {
            fwd(310)
            center_();
            children();
        }
    }

    module clip(anchor=CENTER,spin=0,orient=UP)
    {
        itag="aev4F23";
        module clip_()
        {
            intersect(itag)
            tube(id=160,wall=50,l=length)
            {
                tag(itag) position(BOT) pie_slice(ang=210,l=length,r=300,anchor=BOT);
            }
        }
        attachable(anchor,spin,orient,d=200,l=length)
        {
            clip_();
            children();
        }
    }
    center()
    {
        position(BOT+LEFT) left(155) back(55) clip(anchor=BOT,spin=120);
        position(BOT+RIGHT) right(155) back(55) clip(anchor=BOT,spin=210);
    }
}

module clip_pin(anchor=CENTER,spin=0,orient=UP)
{
    module clip_pin_()
    {
        rmtag="2c5q2";
        diff(rmtag)
        cyl(d=300, l=100)
        {
            position(TOP) cyl(d=170, l=500, anchor=BOT)
            {
                template = path2d([[0, 0], [100,0], [100,50], [50,100], [0,100]]);
                position(TOP) rotate_sweep(template);
                tag(rmtag) position(BOT) up(100) cuboid([30, 270, 500], anchor=BOT);
            }
        }
    }
    attachable(anchor,spin,orient,d=3000,h=500)
    {
        clip_pin_();
        children();
    }
}

module model_axle(anchor=CENTER,spin=0,orient=UP)
{
    module model_axle_()
    {
        recolor("silver")
        cyl(d=79, l=2600, orient=LEFT)
        {
            recolor("black")
            position(TOP) cyl(d=1181, l=315, anchor=TOP);
            recolor("black")
            position(BOT) cyl(d=1181, l=315, anchor=BOT);
        }
    }
    attachable(anchor,spin,orient,size=[3937, 1181, 1181])
    {
        model_axle_();
        children();
    }
}

module forViewing()
{
//    tape_holder_bottom();
//    back(325)
//    tape_holder_top();
    onetruss();
//    clip_pin();
//    model_axle();
}

module forPrinting()
{
    tape_holder_top(length=1000);
//    tape_holder_bottom();
}

scale(ViewScale)
{
    forViewing();
//    forPrinting();
}
