ViewScale = [0.0254, 0.0254, 0.0254];
include <../../../BOSL2-master/std.scad>

$fn=96;

mm = function(tomill) tomill/25.4*1000;
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

module model_rpi_hq_camera(anchor=CENTER,spin=0,orient=UP)
{
    module model_rpi_hq_camera_()
    {
        recolor("green")
        diff()
        cuboid([mm(38),mm(38),mm(1.4)],rounding=100,edges="Z")
        {
            tag("remove") grid_copies(spacing=[mm(38)-mm(8),mm(38)-mm(8)],n=[2,2])
            cyl(d=mm(2.5),h=mm(1.5));
            recolor("darkgreen")
            attach(TOP,norot=1) cuboid([mm(8.5),mm(8.5),mm(1)],anchor=BOT);
        }
    }
    attachable(anchor,spin,orient,size=[mm(38),mm(38),mm(1.4)])
    {
        model_rpi_hq_camera_();
        children();
    }
}

module model_mountto(anchor=CENTER,spin=0,orient=UP)
{
    module model_mountto_()
    {
        linear_extrude(240)
        difference() {
            union() {
                intersection() {
                translate([0, -205, 0])
                circle(2276, $fn=96);
                translate([0, 1320, 0])
                square([3346, 3346], center=true);
              }
              translate([0, -500, 0])
              square([3346, 3346-1000], center=true);
            }
            circle(1500/2, $fn=96);
        }
    }
    attachable(anchor,spin,orient,size=[3346,3346,240])
    {
        down(120)
        model_mountto_();
        children();
    }
}

module pcb_to_mountto(anchor=CENTER,spin=0,orient=UP)
{
    module pcb_to_mountto_()
    {
        diff()
        tube(od=1490,h=500,wall=50,anchor=BOT)
        {
            attach(TOP,norot=1) cuboid([mm(38),mm(38),50],rounding=100,edges="Z",anchor=BOT)
            {
                grid_copies(spacing=[mm(38)-mm(8),mm(38)-mm(8)],n=[2,2])
                {
                    attach(BOT,norot=1) tube(id=mm(5),od=mm(7),h=100,anchor=TOP);
                    tag("remove") cyl(d=mm(2.5),h=mm(1.5));
                }
                tag("remove") cyl(d=1390,h=mm(1.5));
            }
        }

    }
    attachable(anchor,spin,orient,size=[mm(38),mm(38),500+mm(1.4)])
    {
        down(250+mm(0.7))
        pcb_to_mountto_();
        children();
    }
}

module pcb_back(anchor=CENTER,spin=0,orient=UP)
{
    module pcb_back_()
    {
        diff()
        cuboid([mm(38),mm(38),100],rounding=100,edges="Z")
        {
            *tag("remove") grid_copies(spacing=[mm(38)-mm(8),mm(38)-mm(8)],n=[2,2])
            cyl(d=mm(2.5),h=mm(1.5));
            attach(TOP,norot=1) left(305) cuboid([200,mm(38),300],anchor=BOT+RIGHT);
            attach(TOP,norot=1) right(305) cuboid([200,mm(38),300],anchor=BOT+LEFT);
            attach(BOT,norot=1)
            grid_copies(spacing=[mm(38)-mm(8),mm(38)-mm(8)],n=[2,2])
            tube(id=mm(1),od=200,h=150,anchor=TOP);
//            attach(TOP,norot=1) left(310) cuboid([100,mm(38),300],anchor=BOT+RIGHT);

        }
    }
    attachable(anchor,spin,orient,size=[mm(38),mm(38),550])
    {
        down(175)
        pcb_back_();
        children();
    }
}

module pcb_back_lid()
{
    cuboid([610+200+20,mm(38),50])
    {
        attach(LEFT+TOP,norot=1) cuboid([50,mm(38),100],anchor=RIGHT+TOP);
        attach(RIGHT+TOP,norot=1) cuboid([50,mm(38),100],anchor=LEFT+TOP);
    }
}

module arm(anchor=CENTER,spin=0,orient=UP)
{
    z=440+155+290;
    y=3000;
    module arm_()
    {
        diff()
        cuboid([1000,400,440],rounding=100,edges=[FRONT])
        {
            tag("remove") attach(BACK,norot=1) cuboid([1000,200,250],anchor=BACK);
            attach(TOP,norot=1) down(90) cuboid([300,400,365+90],anchor=BOT)
            {
                tag("remove") attach(FRONT,norot=1) cuboid([301,150,150],rounding=50,edges=[BACK+TOP,BACK+BOT],anchor=FRONT);
                attach(TOP+FRONT,norot=1) cuboid([300,3000,290],anchor=BOT+FRONT,rounding=100,edges=[FRONT+TOP]);
            }
        }
    }
    attachable(anchor,spin,orient,size=[2000,y,z])
    {
        down((z-220)/2)
        fwd((y-200)/2)
        arm_();
        children();
    }
}

module withModels()
{
    recolor("grey")
    model_mountto(spin=90) 
    {
        recolor("cornflowerblue")
        attach(TOP,norot=1) up(100) up(mm(1.5))pcb_to_mountto(anchor=TOP)
        recolor("green")
        attach(TOP,norot=1) model_rpi_hq_camera(orient=DOWN,anchor=TOP)
        recolor("cornflowerblue")
        attach(BOT,norot=1) down(125) pcb_back(spin=90,orient=DOWN,anchor=BOT)
        attach(TOP,norot=1) down(95) pcb_back_lid();
        recolor("yellow")
        attach(LEFT,norot=1) left(150) up(330) back(150) arm(spin=-90,anchor=FRONT);
        recolor("yellow")
        attach(RIGHT,norot=1) right(150) up(330) fwd(150) arm(spin=90,anchor=FRONT);
    }

//
//    down(40)
//    model_rpi_hq_camera()
//    {
//        attach(TOP,norot=1) pcb_to_mountto(orient=DOWN,anchor=TOP);
//        attach(BOT,norot=1) down(150) pcb_back(orient=DOWN,anchor=BOT)
//        attach(TOP,norot=1) pcb_back_lid();
//    }
//    recolor("cornflowerblue")
//    attach(LEFT,norot=1) down(200) xrot(180) arm(anchor=FRONT,spin=-90);
}

module forViewing()
{
//    model_mountto()
//    attach(LEFT,norot=1) up(460) arm(anchor=FRONT,spin=-90);
    withModels();
//arm();
}

module forPrinting()
{
    *arm();
    *pcb_to_mountto();
    *pcb_back();
    pcb_back_lid();
}

scale(ViewScale)
{
    forViewing();
//    forPrinting();
}
