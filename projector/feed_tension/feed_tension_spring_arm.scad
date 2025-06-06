ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>

$fn=96;
model=0;

//  module modname(anchor=CENTER,spin=0,orient=UP)
//  {
//      module modname_()
//      {
//      }
//      attachable(anchor,spin,orient,size=)
//      {
//          modname_();
//          children();
//      }
//  }

module model_wheel(anchor=CENTER,spin=0,orient=UP)
{
    module model_wheel_()
    {
        recolor("black")
        tube(id=100, od=505, h=250)
        {
            recolor("white")
            attach(TOP, norot=1) tube(id=100, od=342, h=40, anchor=BOT);
            recolor("white")
            attach(BOT, norot=1) tube(id=100, od=342, h=40, anchor=TOP);
        }

    }

    attachable(anchor,spin,orient,r=505/2,h=250+80)
    {
        model_wheel_();
        children();
    }
}

module models(anchor=CENTER,spin=0,orient=UP, boltlen, boltw, headw, headl)
{
    module models_()
    {
        model_wheel()
        // Bolt
        recolor("grey")
        {
            down(80)
            attach(BOT, norot=1) cyl(d=headw,l=headl, anchor=TOP)
            attach(TOP, norot=1) cyl(d=boltw,l=boltlen,anchor=BOT);
            // Lower washer
            attach(BOT, norot=1) recolor("silver") cyl(d=280,l=20, anchor=TOP);

            // Spring washer
            attach(TOP, norot=1) recolor("silver") #cyl(d=280,l=20, anchor=BOT)
            // Spring
            attach(TOP, norot=1) recolor("cyan") cyl(d=155, l=300, anchor=BOT)
            // Spring washer
            attach(TOP, norot=1) recolor("silver") cyl(d=280,l=20, anchor=BOT)
            // Nut
            attach(TOP, norot=1) recolor("grey") cyl(d=240,l=100, anchor=BOT);
        }
    }

    attachable(anchor,spin,orient,r=505/2,h=250+80)
    {
        models_();
        children();
    }
}

module wheel_contact0(anchor=CENTER,spin=0,orient=UP)
{
    module wheel_contact_()
    {
        cyl(d=500,h=50,anchor=TOP)
        {
        attach(TOP, norot=1) cyl(d=90,h=50, anchor=BOT);
        attach(BOT, norot=1) front_half(s=1200) cyl(d=600,h=50, anchor=BOT)
        attach(BOT, norot=1) front_half(s=1200) tube(id=599, od=699, h=330, anchor=BOT);
        }
    }
    attachable(anchor,spin,orient,d=500,h=100)
    {
        wheel_contact_();
        children();
    }
}

module shield0(anchor=CENTER,spin=0,orient=UP)
{
    h=450;
    d=600;
    module shield_()
    {
        rmtag = "v2412";
        front_half(s=1600)
        diff(rmtag)
        cyl(d=d, h=50)
        {
            tag(rmtag) attach(BOT, norot=1) cyl(d=100, h=50, anchor=BOT);
            attach(BOT, norot=1) tube(id=599, od=699, h=h, anchor=BOT)
            attach(TOP, norot=1) cyl(d=d, h=50, anchor=TOP)
            {
                tag(rmtag) attach(BOT, norot=1) cyl(d=100, h=50, anchor=BOT);
                attach(TOP, norot=1) tube(id=599, od=699, h=h, anchor=BOT)
                attach(TOP, norot=1) cyl(d=d, h=50, anchor=TOP)
                tag(rmtag) attach(BOT, norot=1) cyl(d=130, h=50, anchor=BOT);
            }
//            attach(TOP, norot=1) cyl(d=d, h=50, anchor=TOP)
//            tag(rmtag) attach(BOT, norot=1) cyl(d=100, h=50, anchor=BOT);
        }
    }
    attachable(anchor,spin,orient,d=699,h=h)
    {
        up(25)
        down(h/2)
        shield_();
        children();
    }
}

module shield(anchor=CENTER,spin=0,orient=UP)
{
    h=450;
    module shield_()
    {
        intersect("mask")
        shield0()
        zrot(-135) attach(BOT, norot=1) tag("mask") pie_slice(ang=90,l=451,r=700/2,anchor=BOT)
        attach(TOP, norot=1) cyl(d=700,l=450,anchor=BOT);
        
    }
    attachable(anchor,spin,orient,d=700,h=h)
    {
        shield_();
        children();
    }
}

module arm0(anchor=CENTER,spin=0,orient=UP)
{
    module arm_()
    {
        wheel_contact()
        attach(BOT, norot=1) right(100)
        cuboid([800,100,100], anchor=RIGHT+TOP, rounding=100, edges=[BOT+RIGHT])
        attach(LEFT+BOT, norot=1) left(50)
        tube(id=100, od=200, h=315, anchor=BOT);
    }
    attachable(anchor,spin,orient,d=700,h=100)
    {
        up(25)
        arm_();
        children();
    }
}


module arm(anchor=CENTER,spin=0,orient=UP)
{
    module arm_()
    {
        rmtag = "d412iv";
        diff(rmtag)
        tube(id=180, od=300, h=315)
        {
            attach(BOT, norot=1) tube(id=180, od=500, h=50, anchor=BOT);
            attach(BOT, norot=1) fwd(90) cyl(d=200, h=610, anchor=BACK+BOT)
            {
                tag(rmtag) attach(TOP, norot=1) back(190) cyl(d=300, h=300, anchor=TOP);
                attach(RIGHT+TOP, norot=1) left(20) zrot(25) cuboid([900,100,100], anchor=LEFT+TOP, rounding=100, edges=[TOP+RIGHT]);
                attach(RIGHT+TOP, norot=1) left(20) cuboid([800,100,100], anchor=LEFT+TOP, rounding=100, edges=[TOP+RIGHT]);

                attach(RIGHT+BOT, norot=1) left(20) zrot(25) cuboid([900,100,100], anchor=LEFT+BOT, rounding=100, edges=[BOT+RIGHT]);
                attach(RIGHT+BOT, norot=1) left(20) cuboid([800,100,100], anchor=LEFT+BOT, rounding=100, edges=[BOT+RIGHT])
                attach(RIGHT+TOP, norot=1) back(200) zrot(20) cyl(d=450,h=50,anchor=BOT)
                {
                    if (model)
                        attach(TOP, norot=1) up(190) models(headw=210, headl=110, boltw=110, boltlen=1000);
                    tag(rmtag) attach(BOT, norot=1) cyl(d=120, h=50, anchor=BOT);
                    attach(BOT, norot=1) shield(anchor=BOT)
                    attach(TOP, norot=1) cyl(d=450,h=50,anchor=TOP)
                    tag(rmtag) attach(BOT, norot=1) cyl(d=290, h=50, anchor=BOT);
                }
                attach(LEFT+BOT, norot=1) right(30) zrot(20) cuboid([800,100,610], anchor=RIGHT+BOT, rounding=100, edges=[BOT+LEFT,TOP+LEFT])
                attach(LEFT+BACK, norot=1) cyl(h=100, d=400, orient=BACK,anchor=TOP+LEFT)
                {
                    attach(BOT, norot=1) tag(rmtag) cyl(d=350, h=100, anchor=BOT);
                    attach(BOT, norot=1) cyl(h=50, d=400, anchor=TOP);
                }
            }
        }
    }
    attachable(anchor,spin,orient,d=700,h=100)
    {
        up(25)
        arm_();
        children();
    }
}

module friction_arm(anchor=CENTER,spin=0,orient=UP)
{
    module friction_arm_()
    {
        rmtag = "d412iv";
        diff(rmtag)
        tube(id=180, od=300, h=315)
        {
            attach(BOT, norot=1) tube(id=180, od=500, h=50, anchor=BOT);
            attach(BOT, norot=1) fwd(90) cyl(d=200, h=610, anchor=BACK+BOT)
            {
                tag(rmtag) attach(TOP, norot=1) back(190) cyl(d=300, h=300, anchor=TOP);
                attach(RIGHT+TOP, norot=1) left(20) zrot(25) cuboid([900,100,100], anchor=LEFT+TOP, rounding=100, edges=[TOP+RIGHT]);
                attach(RIGHT+TOP, norot=1) left(20) cuboid([800,100,100], anchor=LEFT+TOP, rounding=100, edges=[TOP+RIGHT]);

                attach(RIGHT+BOT, norot=1) left(20) zrot(25) cuboid([900,100,100], anchor=LEFT+BOT, rounding=100, edges=[BOT+RIGHT]);
                attach(RIGHT+BOT, norot=1) left(20) cuboid([800,100,100], anchor=LEFT+BOT, rounding=100, edges=[BOT+RIGHT])
                attach(RIGHT+TOP, norot=1) back(200) zrot(20) cyl(d=450,h=50,anchor=BOT)
                {
                    tag(rmtag) attach(BOT, norot=1) cyl(d=100, h=50, anchor=BOT);
                    attach(BOT, norot=1) shield(anchor=BOT)
                    attach(TOP, norot=1) cyl(d=450,h=50,anchor=TOP)
                    tag(rmtag) attach(BOT, norot=1) cyl(d=100, h=50, anchor=BOT);
                }
                attach(LEFT+BOT, norot=1) right(30) zrot(20) cuboid([800,100,610], anchor=RIGHT+BOT, rounding=100, edges=[BOT+LEFT,TOP+LEFT])
                attach(LEFT+BACK, norot=1) cyl(h=100, d=400, orient=BACK,anchor=TOP+LEFT)
                {
                    attach(BOT, norot=1) tag(rmtag) cyl(d=350, h=100, anchor=BOT);
                    attach(BOT, norot=1) cyl(h=50, d=400, anchor=TOP);
                }
            }
        }
    }
    attachable(anchor,spin,orient,d=700,h=100)
    {
        up(25)
        friction_arm_();
        children();
    }
}

// 860 gap 1130 reach
module mount(anchor=CENTER,spin=0,orient=UP)
{
    h=860-630/2;
    module mount_()
    {
        rmtag="q2cc451";
        diff(rmtag)
        cuboid([500, 750, h], rounding=100, edges="Z")
        {
            // Alignment
            attach(BOT, norot=1) up(1) back(250) cuboid([180,180,30],rounding=10,edges="Z",anchor=TOP);
            attach(BOT, norot=1) up(1) fwd(250) cuboid([180,180,30],rounding=10,edges="Z",anchor=TOP);
            // Bolt Holes
            tag(rmtag)
            {
                screw_head_d = 340;
                attach(TOP, norot=1) back(250) cyl(d=180,h=h+40, anchor=TOP);
                attach(TOP, norot=1) fwd(250) cyl(d=180,h=h+40, anchor=TOP);
                attach(TOP, norot=1) back(250) cyl(d=screw_head_d,h=h-150, anchor=TOP);
                attach(TOP, norot=1) fwd(250) cyl(d=screw_head_d,h=h-150, anchor=TOP);
            }
            // Arm
            attach(TOP, norot=1) cuboid([1300, 300, 200], anchor=LEFT+TOP, rounding=20, edges=["X","Y","Z"])
            attach(TOP+RIGHT, norot=1) tag(rmtag) left(170) cyl(d=180,h=200,anchor=TOP);
        }
    }

    attachable(anchor,spin,orient,size=[750,750,h])
    {
        mount_();
        children();
    }
}

module forViewing()
{
    arm();
//    shield();

//    attach(TOP, norot=1) up(330) zrot(220)  arm(orient=BOTTOM);
//    mount();
}
    

module forPrinting()
{
    arm();
}

scale(ViewScale)
{
//    forPrinting();
    forViewing();
}

