ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>

$fn=96;

models=0;

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

module model_motor(anchor=CENTER,spin=0,orient=UP)
{
    module model_motor_()
    {
        rmtag="qcqrads";
        recolor("gray")
        diff(rmtag)
        cyl(d=1245, h=690)
        {
            position(BOT) cuboid([1245, 115, 115], anchor=TOP, rounding=50, edges="Z");
            position(BOT) cuboid([311, 1240, 115], anchor=TOP, rounding=100, edges="Z")
            position(BOT) cyl(d=285, h=130, anchor=TOP);
            position(TOP) cyl(d=1450, h=912, anchor=BOT)
            {
                position(TOP) tube(id=950, od=1450, h=35, anchor=BOT)
                {
                    tag(rmtag) position(TOP) rot_copies(n=6,sa=30)
                        right(610) up(1) cyl(d=100,h=200,anchor=TOP);
                }
                position(TOP+LEFT) right(220) cyl(d=471, h=240+35, anchor=BOT+LEFT)
                {
                    position(BOT) cyl(d=700,h=35,anchor=BOT);
                    position(TOP) cyl(d=235,h=590,anchor=BOT)
                    tag(rmtag) position(TOP+LEFT) up(1) cuboid([25,235,591],anchor=TOP+LEFT);
                }
            }
        }
    }

    height=690+115+912+35+590+130;
    attachable(anchor,spin,orient,d=1450, h=height)
    {
        up(130+115+690/2)
        down(height/2)
        model_motor_();
        children();
    }
}

module motor_mount(anchor=CENTER,spin=0,orient=UP)
{
    module motor_mount_()
    {
        rmtag="vwre84";
        diff(rmtag)
        cyl(d=1450+200+40,h=200)
        {
            tag(rmtag) position(BOT) rot_copies(n=6,sa=30)
                right(610) down(1) cyl(d=120,h=200,anchor=BOT);
            tag(rmtag) position(BOT) rot_copies(n=6,sa=30)
                right(610) up(40) cyl(d=250,h=500,anchor=BOT);
            position(BOT) tube(od=1450+240,id=1450+40,h=400,anchor=TOP);
            tag(rmtag) position(BOT+LEFT) down(1)
                 right(330) cyl(d=491, h=602, anchor=BOT+LEFT);
            position(TOP) down(1) left(270) 
                cuboid([2500,1000,320],rounding=500,edges="Z",anchor=BOT)
            {
                position(TOP) down(150) cuboid([2700,1200,100],rounding=600,edges="Z");
//                position(RIGHT) cuboid([100,100,1000],anchor=LEFT);
            }
        }
        if (models)
        {
            down(700)
            model_motor();
        }
        
    }
    attachable(anchor,spin,orient,size=[2500,1690,920])
    {
        right(1690/2) left(610)
        down(420)
        up(920/2)
        motor_mount_();
        children();
    }
}

module active_shaft(anchor=CENTER,spin=0,orient=UP)
{
    module active_shaft_()
    {
        rmtag="qcf451324";
        diff(rmtag)
        cyl(d=400,h=590)
        {
            tag(rmtag) position(TOP) up(1) cyl(d=239,h=592,anchor=TOP)
            tag("keep") position(TOP+LEFT) up(1) cuboid([22,235,450],anchor=TOP+LEFT);
            //position(TOP) cyl(d=750,h=50,anchor=BOT)
            position(TOP) cyl(d=400,h=70,anchor=BOT)
            position(TOP) cyl(d=238,h=250,anchor=BOT)
            position(TOP) cyl(d=238,h=200,anchor=BOT,$fn=6);
            
        }
    }
    attachable(anchor,spin,orient,d=400,h=500)
    {
        active_shaft_();
        children();
    }
}

module passive_shaft(anchor=CENTER,spin=0,orient=UP)
{
    module passive_shaft_()
    {
        rmtag="qcf451324";
        diff(rmtag)
        cyl(d=360,h=100)
        {
            *tag(rmtag) position(TOP) up(1) cyl(d=239,h=592,anchor=TOP)
            *tag("keep") position(TOP+LEFT) up(1) cuboid([22,235,450],anchor=TOP+LEFT);
            //position(TOP) cyl(d=750,h=50,anchor=BOT)
            //*position(TOP) cyl(d=400,h=70,anchor=BOT)
            position(TOP) cyl(d=238,h=250,anchor=BOT)
            position(TOP) cyl(d=238,h=200,anchor=BOT,$fn=6);
            
        }
    }
    attachable(anchor,spin,orient,d=360,h=550)
    {
        up(50)
        down(550/2)
        passive_shaft_();
        children();
    }
}


module shaft_mount(anchor=CENTER,spin=0,orient=UP)
{
    module shaft_mount_()
    {
        tube(h=250,id=750,od=850)
        {
            position(TOP) tube(id=360,od=850,h=50,anchor=BOT);
            position(BOT) tube(id=360,od=850,h=50,anchor=TOP);
        }
    }
    attachable(anchor,spin,orient,size=[100,100,100])
    {
        shaft_mount_();
        children();
    }
}

module reel0(anchor=CENTER,spin=0,orient=UP)
{
    module reel0_()
    {
        rmtag="caqer534qw4";
        diff(rmtag)
        cyl(d=2000,h=100)
        {
            position(BOT) tag(rmtag) down(1) cyl(d=240,h=1202,anchor=BOT,$fn=6);
            tag(rmtag) right(650) xrot(-45) cyl(d=100,h=350);
            position(TOP) tube(od=1005,wall=100,h=100,anchor=BOT);
        }
    }
    attachable(anchor,spin,orient,d=2000,h=1200)
    {
        up(50)
        down(600)
        reel0_();
        children();
    }
}

module reel1(anchor=CENTER,spin=0,orient=UP)
{
    module reel1_()
    {
        rmtag="caqer534qw4";
        diff(rmtag)
        cyl(d=2000,h=100)
        {
            position(BOT) tag(rmtag) down(1) cyl(d=240,h=1202,anchor=BOT,$fn=6);
            *tag(rmtag) right(650) xrot(-45) cyl(d=100,h=350);
            *position(TOP) tube(od=1005,wall=100,h=100,anchor=BOT);
            position(TOP) tube(id=1010,wall=100,h=1000,anchor=BOT)
            *position(TOP) cyl(d=2000,h=100,anchor=BOT);
        }
    }
    attachable(anchor,spin,orient,d=2000,h=1200)
    {
        up(50)
        down(600)
        reel1_();
        children();
    }
}

module shaft_spacer(anchor=CENTER,spin=0,orient=UP)
{
    module reel_()
    {
        rmtag="caqer5344";
        diff(rmtag)
        cyl(d=360,h=80)
        {
            position(BOT) tag(rmtag) down(1) cyl(d=240,h=102,anchor=BOT,$fn=6);
        }
        *right(400) cyl(d=238,h=100,$fn=6);

    }
    attachable(anchor,spin,orient,d=360,h=100)
    {
        reel_();
        children();
    }
}

module bearing_surround(anchor=CENTER,spin=0,orient=UP)
{
    module bearing_surround_()
    {
        rmtag="aqc4345";
        diff(rmtag)
        cuboid([2500,1000,300],rounding=500,edges="Z")
        {
            tag(rmtag) position(TOP) up(1)  cyl(d=760,h=241,anchor=TOP);
            tag(rmtag) position(BOT) down(1)  cyl(d=460,h=66,anchor=BOT);
            cuboid([2700,1200,100],rounding=600,edges="Z");
        }
    }
    attachable(anchor,spin,orient,size=[2000,1000,400])
    {
        bearing_surround_();
        children();
    }
}


module bearing_surround_holder(anchor=CENTER,spin=0,orient=UP)
{
    module bearing_surround_holder_()
    {
        rmtag="vq454adf";
        diff(rmtag)
        cuboid([2500,1500,340])
        {
            tag(rmtag)
            {
                position(LEFT) right(500)
                cuboid([2500,1010,342],rounding=500,edges="Z",anchor=LEFT)
                cuboid([2700,1210,110],rounding=600,edges="Z");
            }
        }
    }
    attachable(anchor,spin,orient,size=[2500,1500,300])
    {
        bearing_surround_holder_();
        children();
    }
}


module winch_assembly_mount(anchor=CENTER,spin=0,orient=UP)
{
    module winch_assembly_mount_()
    {
        bearing_surround_holder()
        {
            position(LEFT) rect_tube(size=[1700,1500],wall=200,irounding=100,h=200,orient=LEFT,anchor=RIGHT+TOP)
            {
                position(BOT+FRONT) cuboid([1500,200,600],anchor=TOP+FRONT);
                position(BOT+BACK) cuboid([1500,200,600],anchor=TOP+BACK);
                position(LEFT+TOP) bearing_surround_holder(orient=RIGHT,anchor=LEFT)
                position(LEFT+BOT) cuboid([1000,1500,290],anchor=LEFT+TOP)
                position(LEFT+BOT) bearing_surround_holder(anchor=LEFT+TOP);
            }
        }
    }
    
    attachable(anchor,spin,orient,size=[2500,1500,1732])
    {
        down(150)
        up(1972/2)
        winch_assembly_mount_();
        children();
    }
}


module assembled()
{
    reel()
    {
        position(BOT) down(470) active_shaft(anchor=TOP)
        { 
            recolor("cyan") position(BOT) up(630) tube(od=748, id=240, h=237,anchor=BOT)
            {
                recolor("cornflowerblue") position(TOP) shaft_spacer(anchor=BOT);
                recolor("green") position(TOP) up(50) bearing_surround(anchor=TOP);
            }
            position(BOT) recolor("cyan") down(190) right(35) %motor_mount();
        }
        position(TOP) down(100) passive_shaft(anchor=TOP,orient=DOWN)
        { 
            recolor("cornflowerblue") position(TOP) down(100)  shaft_spacer(anchor=TOP)
            recolor("cyan") position(BOT) tube(od=748, id=240, h=237,anchor=TOP)
            recolor("green") position(TOP) up(50) bearing_surround(anchor=TOP);
        }
        recolor("red") left(500)
        winch_assembly_mount()
        recolor("purple")
        position(LEFT)
        right(250) fwd(60)
         xrot(90) zrot(90) bookshelf_mount(anchor=FRONT);
    }
}

module model_bookshelf(anchor=CENTER,spin=0,orient=UP)
{
    module model_bookshelf_()
    {
        cuboid([600,1200,2000])
        position(BOT+RIGHT+FRONT) cuboid([480,2000,1000],anchor=FRONT+BOT+LEFT)
        position(BOT+RIGHT+FRONT) cuboid([2000,480,1000],anchor=LEFT+FRONT+BOT);
    }
    attachable(anchor,spin,orient,size=[3080,2000,2000])
    {
        back(600) fwd(1000)
        right(300) left(3080/2)
        model_bookshelf_();
        children();
    }
}

module bookshelf_mount(anchor=CENTER,spin=0,orient=UP)
{
    module bookshelf_mount_()
    {
        cuboid([630,300,2000])
        {
            *position(RIGHT+BOT+FRONT) cuboid([800,300,1000], anchor=LEFT+BOT+FRONT);
            position(RIGHT+TOP+FRONT) cuboid([300,1530,1000], anchor=LEFT+TOP+FRONT,
                rounding=100, edges=[TOP+RIGHT])
            position(BOT+RIGHT+BACK) cuboid([500,1530,300], anchor=LEFT+BACK+BOT,
                rounding=100, edges=[BACK+RIGHT,TOP+RIGHT])
            position(BOT+RIGHT+BACK) cuboid([300,730,1000], anchor=TOP+RIGHT+BACK,
                rounding=100, edges=[BACK+RIGHT]);
            position(LEFT+TOP+FRONT) cuboid([300,1530,1000], anchor=RIGHT+TOP+FRONT,
                rounding=100, edges=[TOP+LEFT,BOT+LEFT]);
            position(LEFT+BACK+TOP) left(300) cuboid([3000,300,2130], anchor=BACK+LEFT+TOP,
                rounding=100, edges=[TOP+LEFT,TOP+RIGHT,BOT+LEFT,BOT+RIGHT])
            {
                position(TOP+FRONT) back(1) cuboid([3000,300,300], anchor=TOP+BACK, rounding=100,
                     edges=[TOP+FRONT,LEFT+FRONT,RIGHT+FRONT,TOP+LEFT,TOP+RIGHT]);
                position(BOT+FRONT) back(1) cuboid([3000,300,300], anchor=BOT+BACK, rounding=100,
                     edges=[BOT+FRONT,LEFT+FRONT,RIGHT+FRONT,BOT+LEFT,BOT+RIGHT]);
            }
        }
///        position(BACK+TOP+RIGHT) cuboid([930,300,1000], anchor=RIGHT+TOP+FRONT);
    }
    attachable(anchor,spin,orient,size=[3000,2130,2000])
    {
        right(615) left(3000/2)
        back(450) fwd(2130/2)
        bookshelf_mount_();
        children();
    }
}
 
module bookshelf_mount_v2(anchor=CENTER,spin=0,orient=UP)
{
    module bookshelf_mount_v2_()
    {
        cuboid([630,300,2000])
        {
            *position(RIGHT+BOT+FRONT) cuboid([800,300,1000], anchor=LEFT+BOT+FRONT);
            position(RIGHT+TOP+FRONT) cuboid([300,1530,1000], anchor=LEFT+TOP+FRONT,
                rounding=100, edges=[TOP+RIGHT])
            position(BOT+RIGHT+BACK) cuboid([500,1530,300], anchor=LEFT+BACK+BOT,
                rounding=100, edges=[BACK+RIGHT,TOP+RIGHT])
            position(BOT+RIGHT+BACK) cuboid([300,730,1000], anchor=TOP+RIGHT+BACK,
                rounding=100, edges=[BACK+RIGHT]);
            position(LEFT+TOP+FRONT) cuboid([300,1530,1000], anchor=RIGHT+TOP+FRONT,
                rounding=100, edges=[TOP+LEFT,BOT+LEFT]);
            position(LEFT+BACK+TOP) left(300) cuboid([3000,300,810], anchor=BACK+LEFT+TOP,
                rounding=100, edges=[TOP+LEFT,TOP+RIGHT])
            {
                position(BOT+BACK) cuboid([3000,1000,300],anchor=BACK+TOP,
                    rounding=100,edges=[BOT+LEFT,BOT+RIGHT,FRONT])
                *position(TOP+FRONT) cuboid([3000,300,300],anchor=BOT+FRONT,
                    rounding=100,edges=[TOP+FRONT,RIGHT+FRONT,LEFT+FRONT]);
                *position(TOP+FRONT) back(1) cuboid([3000,300,300], anchor=TOP+BACK, rounding=100,
                     edges=[TOP+FRONT,LEFT+FRONT,RIGHT+FRONT,TOP+LEFT,TOP+RIGHT]);
                *position(BOT+FRONT) back(1) cuboid([3000,300,300], anchor=BOT+BACK, rounding=100,
                     edges=[BOT+FRONT,LEFT+FRONT,RIGHT+FRONT,BOT+LEFT,BOT+RIGHT]);
            }
        }
///        position(BACK+TOP+RIGHT) cuboid([930,300,1000], anchor=RIGHT+TOP+FRONT);
    }
    attachable(anchor,spin,orient,size=[3000,2130,2000])
    {
        right(615) left(3000/2)
        back(450) fwd(2130/2)
        bookshelf_mount_v2_();
        children();
    }
}
 

module case()
{
}

module forViewing()
{
//    active_axle();
//    assembled();
///    winch_assembly_mount();
//    motor_mount();
//    shaft_spacer();
    reel1();
///    recolor("cyan")
 ///   model_bookshelf()
  //  recolor("green")
    //position(LEFT+FRONT+BOT) bookshelf_mount();
//    bookshelf_mount_v2();
}

module forPrinting()
{
//    winch_assembly_mount(anchor=LEFT+TOP+FRONT);
    bookshelf_mount();
}

scale(ViewScale)
{
    forViewing();
//   forPrinting();
}
