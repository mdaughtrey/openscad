include <../../../models/model_pcb_pushbuttons.scad>
joystick_outer_shaft_dia = 500;
joystick_outer_shaft_length = 1400;
joystick_inner_shaft_dia = joystick_outer_shaft_dia - 220;
joystick_sphere_dia = 1000;
joystick_sliding_plate_thickness = 100;

// Screws
heat_insert_dia = 120;
screw_head_cutout_dia = 200;
screw_shaft_dia = 110;

// heat_insert_dia = 25.4/2.75*1000;
// screw_head_cutout_dia = heat_insert_dia;
// screw_shaft_dia = head_insert_dia;

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

module button_mount_cutout(anchor=CENTER,spin=0,orient=UP)
{
    height = 210+214-214/2;
    module button_mount_cutout_()
    {
        cuboid([240,320,210])
        {
            position(FRONT) translate([146/2,-1,1]) cuboid([50,60,214], anchor=TOP);
            position(FRONT) translate([-146/2,-1,1]) cuboid([50,60,214], anchor=TOP);
            position(BACK) translate([146/2,1,1]) cuboid([50,60,214], anchor=TOP);
            position(BACK) translate([-146/2,1,1]) cuboid([50,60,214], anchor=TOP);
        }
    }
    attachable(anchor,spin,orient,size=[300,360,height])
    {
        down(210/2)
        up(height/2)
        button_mount_cutout_();
        children();
    }
}

module button_and_mount(anchor=CENTER,spin=0,orient=UP,height_mm=7,add_top=false)
{
    module button_and_mount_()
    {
        rmtag="r.liasd";
        diff(rmtag)
        recolor("cornflowerblue")
        cuboid([300, 360, 210])
        {
            tag(rmtag) position(TOP) up(1)
            {
                cuboid([245,245,150], anchor=TOP);
                position(FRONT+LEFT) translate([55,-1,1]) cuboid([50,60,214], anchor=TOP+FRONT);
                position(FRONT+RIGHT) translate([-55,-1,1]) cuboid([50,60,214], anchor=TOP+FRONT);
                position(BACK+LEFT) translate([55,1,1]) cuboid([50,60,214], anchor=TOP+BACK);
                position(BACK+RIGHT) translate([-55,1,1]) cuboid([50,60,214], anchor=TOP+BACK);
            }
            down(20)
            model_pushbutton_6_6(height_mm=height_mm,add_top=add_top);
            position(TOP) down(1) rect_tube(isize=[295,355], size=[400,440], l=210, anchor=TOP);
        }
    }
    attachable(anchor,spin,orient,size=[400,400,210])
    {
        button_and_mount_();
        children();
    }
}

module joystick_knob_top(anchor=CENTER,spin=0,orient=UP)
{
    module joystick_knob_top_()
    {
        rmtag="rc123134";
        diff(rmtag)
        {
            cyl(d=1300, rounding=200, l=500);
            tag(rmtag) position(BOT) cyl(d=1000, h=300, anchor=BOT)
                tag("keep") position(TOP) zrot_copies(n=2, r=300) tube(id=heat_insert_dia, wall=50, l=100, anchor=TOP);
            tag(rmtag) position(TOP) up(1) cyl(d=300, h=240, anchor=TOP);
        }
    }
    attachable(anchor,spin,orient,d=1000,l=500)
    {
        joystick_knob_top_();
        children();
    }
}

module joystick_inner_shaft(anchor=CENTER,spin=0,orient=UP)
{
    module joystick_inner_shaft_()
    {
        rmtag="rqm.nb";
//        itag="iqm.nb";
        diff(rmtag)
        cyl(d=joystick_inner_shaft_dia, l=joystick_outer_shaft_length+1000-300)
        {
            tag(rmtag) position(TOP) up(1) cyl(d=joystick_inner_shaft_dia-100, l=joystick_outer_shaft_length+1002, anchor=TOP);
            // Twist paddles
            position(BOT) 
            {
                mydia = 1600 + joystick_sphere_dia;
//                fwd(50)
//                intersect(itag)
//                {
                    fwd(100) position(FRONT) cuboid([700, 200, 200], anchor=FRONT+BOT,edges="Z", rounding=50);
                    *back((mydia-joystick_outer_shaft_dia)/2) cyl(d=mydia, l=200, anchor=BOT);
                    *tag(itag) position(FRONT) cuboid([mydia-1100, joystick_outer_shaft_dia/2, 200], 
                        edges=[BACK+TOP, BACK+BOT, BACK+LEFT, BACK+RIGHT], rounding=50, anchor=FRONT);
//                }
            }
        }
    }
    attachable(anchor,spin,orient,d=joystick_inner_shaft_dia, l=joystick_outer_shaft_length+1000)
    {
        joystick_inner_shaft_();
        children();
    }
}


module joystick_outer_shaft(anchor=CENTER,spin=0,orient=UP)
{
    module joystick_outer_shaft_()
    {
        rmtag="rvq4ea";
        itag="irvq4ea";
        ktag="krvq4ea";
        diff(rmtag)
        cyl(d=joystick_outer_shaft_dia, l=joystick_outer_shaft_length)
        {
            // Sliding plate insert
            *position(BOT) cuboid([joystick_outer_shaft_dia+10, joystick_outer_shaft_dia+10, 150], edges="Z", rounding=100, anchor=BOT);
            // Ball
            position(BOT) sphere(d=joystick_sphere_dia+10, anchor=BOT)
            // button push tabs
            zrot_copies(n=4, r=600) up(50)
                cuboid([400, 300, 200], edges="Z", rounding=100);
            // Shaft hole
            tag(rmtag) position(TOP) up(1) cyl(d=joystick_inner_shaft_dia+10, l=joystick_outer_shaft_length+20+400, anchor=TOP);

            // Upper tabs
            *position(TOP) down(200) 
            {
                position(RIGHT) left(50) cuboid([200, 100, 400], anchor=TOP+LEFT, edges=RIGHT, rounding=50);
                position(LEFT) right(50) cuboid([200, 100, 400], anchor=TOP+RIGHT, edges=LEFT, rounding=50);
            }

            // Lower block
            position(BOT) cuboid([450, 450, 150], rounding=100, edges="Z", anchor=TOP);
        }
    }
    attachable(anchor,spin,orient,size=[100,100,100])
    {
        joystick_outer_shaft_();
        children();
    }
}

module joystick_sliding_plate(anchor=CENTER,spin=0,orient=UP)
{
    module button_baffle(anchor=CENTER,spin=0,orient=UP)
    {
        module button_baffle_()
        {
            rmtag="rqwed";
            itag="iqwed";
            intersect(itag)
            {
                diff(rmtag)
                cuboid([1100, 500, 200], edges="Z", rounding=125)
                {
                   tag(rmtag) position(TOP) up(1) cuboid([1000-20, 400, 202], edges="Z", rounding=100, anchor=TOP);
                }
                tag(itag) position(TOP+BACK) back(100) cuboid([1100,380,200], anchor=TOP+BACK);
            }
        }
        attachable(anchor,spin,orient,size=[1100,300,200])
        {
            button_baffle_();
            children();
        }
    }
    module joystick_sliding_plate_()
    {
        rmtag="rvwqr3";
        diff(rmtag)
        cuboid([1500, 1500, joystick_sliding_plate_thickness], edges="Z", rounding=100)
        {
            // Center Cutout
            tag(rmtag) position(TOP) up(1) cuboid([450, 450, 300], anchor=TOP);
            // Center Surround
            position(TOP) rect_tube(isize=[450, 450], size=[550,550], l=50, anchor=BOT);
            position(BOT) rect_tube(isize=[350, 350], size=[550,550], l=50, anchor=TOP);
//             tag(rmtag) position(TOP) up(1) cuboid([joystick_outer_shaft_dia+5, joystick_outer_shaft_dia+25, 202], anchor=TOP);
            // Button supports
            *position(BOT) back(150)
            {
                recolor("green")
                position(BOT) move([225,250,-130]) button_and_mount(orient=FRONT,spin=90,height_mm=11.5);
                position(BOT) move([-225,250,-130]) button_and_mount(orient=FRONT,spin=90,height_mm=11.5);
                //right(500) cuboid([400, 200, 300], anchor=TOP);
                //left(500) cuboid([400, 200, 300], anchor=TOP);
            }
            position(BOT) back(400)
            {
                cuboid([900,260,400],anchor=TOP)
                {
                    tag(rmtag) position(LEFT+FRONT) move([250, -1, 0]) button_mount_cutout(orient=FRONT,spin=90,anchor=TOP);
                    tag(rmtag) position(RIGHT+FRONT) move([-250, -1, 0]) button_mount_cutout(orient=FRONT,spin=90,anchor=TOP);
                }
            }
            // Cutouts
            *tag(rmtag) position(BOT+FRONT) translate([20, -70, -1]) cuboid([1000-20, 400, 202], edges="Z", rounding=100, anchor=BOT+FRONT);
            *tag(rmtag) position(BOT+BACK) translate([-20, 70, -1]) cuboid([1000-20, 400, 202], edges="Z", rounding=100, anchor=BOT+BACK);
            // Baffles
            *position(BOT+FRONT) translate([20, -20, 0])  button_baffle(anchor=TOP+FRONT);
            *position(BOT+BACK) translate([-20, 20, 0])  button_baffle(anchor=TOP+FRONT,spin=180);
            
        }
    }
    attachable(anchor,spin,orient,size=[100,100,100])
    {
        joystick_sliding_plate_();
        children();
    }
}

module joystick_halfball(anchor=CENTER, spin=0, orient=UP, inner_d, outer_d)
{
    module joystick_halfball_()
    {
        rmtag="rvr1vqwfde";
        itag="ivr1vqwfde";
        rotate_extrude(angle=360)
        intersection(itag)
        {
            diff(rmtag)
            circle(r=outer_d/2)
            {
                tag(rmtag) circle(r=inner_d/2);
            }
            square([outer_d,outer_d], anchor=BACK+LEFT);
        }
    }
    attachable(anchor,spin,orient,r=outer_d/2,h=outer_d/2)
    {
        up(outer_d/4)
        joystick_halfball_();
        children();
    }

}

module joystick_upper_trap(anchor=CENTER,spin=0,orient=UP)
{
    sphere_r = joystick_sphere_dia/2;
    sphere_outer_d = joystick_sphere_dia + 200;
    sphere_inner_d = joystick_sphere_dia + 30;
    module joystick_upper_trap_()
    {
        rmtag="rawer";
        itag="iawer";
        diff(rmtag)
//        intersect(itag)
        joystick_halfball(inner_d=sphere_inner_d, outer_d=sphere_outer_d)
        {
            // Push button cutouts
            tag(rmtag) zrot_copies(n=4, r=600) position(TOP) up(2)  cuboid([200, 350, 250],anchor=TOP+RIGHT);
            offset=50;
            // Upper cutout
            tag(rmtag) position(BOT) 
            {
                cyl(d=joystick_outer_shaft_dia+500, l=200, anchor=BOT);
            }
            // Screw mounts for base
            zrot_copies(n=4, r=700,sa=45)
            position(TOP) cyl(d=250,l=170,anchor=TOP)
                tag(rmtag) position(TOP) up(1) cyl(d=screw_shaft_dia, l=172, anchor=TOP);

        }
    }
    attachable(anchor,spin,orient,size=[100,100,100])
    {
        joystick_upper_trap_();
        children();
    }
}

module joystick_switch_lower(anchor=CENTER,spin=0,orient=UP)
{
    module joystick_switch_lower_()
    {
        rmtag="rvclkfiqw";
        diff(rmtag)
        cuboid([2000, 2000, 200], edges="Z", rounding=100)
        {
            sphere_r = joystick_sphere_dia/2;
            sphere_outer_d = joystick_sphere_dia + 100;
            sphere_inner_d = joystick_sphere_dia + 30;
            tag(rmtag) position(BOT) down(1) cyl(d=joystick_outer_shaft_dia+800, l=502, anchor=BOT);
            // Ball Holder
            *position(TOP) down(100) joystick_halfball(inner_d=sphere_inner_d, outer_d=sphere_outer_d, anchor=BOT);
            // Ball Holder screw mounts
            *position(TOP)
            {
               right(sphere_outer_d/2-30) tube(id=100, od=250, l=sphere_outer_d/2-100, anchor=BOT+LEFT);
               left(sphere_outer_d/2-30) tube(id=100, od=250, l=sphere_outer_d/2-100, anchor=BOT+RIGHT);
            }

            screw_mount_length = 360;

            // Screw mounts for upper assembly
            zrot_copies(n=4, r=1250,sa=45)
            position(BOT) cyl(d=350,l=screw_mount_length+200,anchor=BOT)
                tag(rmtag) position(BOT) down(1) cyl(d=screw_head_cutout_dia, l=500, anchor=BOT)
                    position(TOP) down(1) cyl(d=screw_shaft_dia, l=90, anchor=BOT);

            // Sliding plate retainers
            position(TOP+LEFT+FRONT) cuboid([400,500,screw_mount_length], anchor=BOT+LEFT+FRONT,edges="Z", rounding=100);
            position(TOP+RIGHT+FRONT) cuboid([400,500,screw_mount_length], anchor=BOT+RIGHT+FRONT,edges="Z", rounding=100);
            position(TOP+LEFT+BACK) cuboid([400,500,screw_mount_length], anchor=BOT+LEFT+BACK,edges="Z", rounding=100);
            position(TOP+RIGHT+BACK) cuboid([400,500,screw_mount_length], anchor=BOT+RIGHT+BACK,edges="Z", rounding=100);
        }
    }
    attachable(anchor,spin,orient,size=[100,100,100])
    {
        joystick_switch_lower_();
        children();
    }
}

module joystick_switch_upper(anchor=CENTER,spin=0,orient=UP)
{
    module joystick_switch_upper_()
    {
        rmtag="rvclkfiqw";
        ktag="kvclkfiqw";
        diff(rmtag, ktag)
        cuboid([1800, 1800, 210], edges="Z", rounding=700)
        {
            sphere_r = joystick_sphere_dia/2;
            sphere_outer_d = joystick_sphere_dia + 100;
            sphere_inner_d = joystick_sphere_dia + 30;

            zrot_copies(n=4, r=joystick_sphere_dia-300) position(TOP)
                {
                    tag(rmtag) up(1) button_mount_cutout(anchor=TOP);
//                    tag(ktag) recolor("cornflowerblue") up(70) model_pushbutton_6_6(height_mm=7,anchor=TOP);
                }
            *tag(rmtag) position(BOT) down(1) 
                cyl(d=joystick_outer_shaft_dia+200, l=702, anchor=BOT)
                tag("keep") position(BOT) down(1) tube(id=joystick_outer_shaft_dia+200,wall=100,l=240,anchor=BOT);
//                position(BOT) cuboid([joystick_outer_shaft_dia+20, joystick_outer_shaft_dia+20, 502], edges="Z", rounding=100, anchor=BOT);
            // Ball Holder
            {
                position(BOT) tag(rmtag) down(100) sphere(d=sphere_inner_d, anchor=BOT);
                *position(BOT) down(100) joystick_halfball(inner_d=sphere_inner_d, outer_d=sphere_outer_d, anchor=BOT);
                *position(BOT) down(1) tag(rmtag) cyl(d=joystick_outer_shaft_dia+200, l=200, anchor=TOP);
//                    position(BOT) down(1) tag(rmtag) cyl(d=joystick_outer_shaft_dia+200, l=50, anchor=BOT);
//                position(BOT) tag(rmtag) down(1) cyl(d=joystick_sphere_dia-20, l=250, anchor=BOT);
            }

            
            *position(TOP) down(100) tube(od=sphere_outer_d, id=sphere_inner_d, l=sphere_outer_d/2, anchor=BOT);
            // Ball Holder screw mounts
            *position(TOP)
            {
               right(sphere_outer_d/2-30) tube(id=heat_insert_dia, od=250, l=sphere_outer_d/2-100, anchor=BOT+LEFT);
               left(sphere_outer_d/2-30) tube(id=heat_insert_dia, od=250, l=sphere_outer_d/2-100, anchor=BOT+RIGHT);
            }
            // Sliding plate retainers
            *position(BOT+LEFT+FRONT) retainer(anchor=TOP+LEFT+FRONT);
            *position(BOT+RIGHT+FRONT) retainer(anchor=TOP+LEFT+FRONT, spin=90);

            *position(BOT+LEFT+BACK) retainer(anchor=TOP+LEFT+FRONT, spin=270);
            *position(BOT+RIGHT+BACK) retainer(anchor=TOP+LEFT+FRONT, spin=180);

            // Screw mounts for lower assembly
            *zrot_copies(n=4, r=1250,sa=45)
            position(TOP) cyl(d=350,l=320,anchor=BOT)
                tag(rmtag) position(TOP) up(1) cyl(d=heat_insert_dia, l=322, anchor=TOP);

            // Screw mounts for upper trap
            zrot_copies(n=4, r=700,sa=45)
            position(TOP) cyl(d=250,l=210,anchor=BOT)
                tag(rmtag) position(TOP) up(1) cyl(d=heat_insert_dia, l=422, anchor=TOP);


            // Buttons
//            recolor("red")
//            position(FRONT+BOT) move([-250,340,-150]) button_and_mount(orient=BACK,spin=90);
//            position(FRONT+BOT) move([260,350,-190]) button_and_mount(orient=RIGHT,spin=90);
//            position(BACK+BOT) move([250,-340,-150]) button_and_mount(orient=FRONT,spin=90);
//            position(BACK+BOT) move([-260,-350,-190]) button_and_mount(orient=LEFT,spin=90);
           
            
        }
    }
    attachable(anchor,spin,orient,size=[100,100,100])
    {
        joystick_switch_upper_();
        children();
    }
}

module joystick_knob_button_mount(anchor=CENTER,spin=0,orient=UP)
{
    module joystick_knob_button_mount_()
    {
        rmtag="rcqfe2w";
        diff(rmtag)
        cyl(d=970, l=210)
        {
            tag(rmtag) position(TOP)
            {
                zrot_copies(n=2, r=320) up(1) cyl(d=screw_shaft_dia, l=212, anchor=TOP);
                up(1) button_mount_cutout(anchor=TOP);
            }
            *tag("keep") button_and_mount(height_mm=11.5,add_top=true);
        }

        *button_and_mount()
        {
            position(LEFT+TOP) cuboid([100,400,200], anchor=TOP+RIGHT)
            {
                position(LEFT+BOT) right(75) cyl(d=220, l=100, anchor=RIGHT+BOT)
                tag(rmtag) position(BOT) down(1) cyl(d=120, l=210, anchor=BOT);
            }
            position(RIGHT+TOP) cuboid([100,400,200], anchor=TOP+LEFT)
            {
                position(RIGHT+BOT) left(75) cyl(d=220, l=100, anchor=LEFT+BOT)
                tag(rmtag) position(BOT) down(1) cyl(d=120, l=210, anchor=BOT);
            }
        }
    }
    attachable(anchor,spin,orient,size=[100,100,100])
    {
        joystick_knob_button_mount_();
        children();
    }
}

module joystick_knob_inner(anchor=CENTER,spin=0,orient=UP)
{
    dia=joystick_inner_shaft_dia;
    module joystick_knob_inner_()
    {
        rmtag="rqiqaser";
        diff(rmtag)
        {
            tube(id=dia-100,od=dia+200,l=50)
            {
                position(BOT) tube(id=dia,l=500,od=dia+200, anchor=TOP);
                zrot_copies(n=2, r=320)
                   position(TOP) up(300) cyl(d=300, l=500, anchor=TOP)
//                   tag(rmtag) position(TOP) up(1) cyl(d=screw_shaft_dia,l=150,anchor=TOP)
                    tag(rmtag) position(TOP)  up(1) cyl(d=screw_head_cutout_dia, l=870, anchor=TOP);
//cytube(id=heat_insert_dia, l=500, wall=100, anchor=TOP);
//                position(RIGHT+TOP) left(75) tube(id=heat_insert_dia, l=500, wall=100, anchor=LEFT+TOP);
            }
        }
    }
    attachable(anchor,spin,orient,size=[620,dia+200,480])
    {
        joystick_knob_inner_();
        children();
    }
}

module joystick_knob_outer(anchor=CENTER,spin=0,orient=UP)
{
    module joystick_knob_outer_()
    {
        rmtag="rqwqaser";
        diff(rmtag)
        {
            cyl(d=1000,l=1000,rounding=100);
        }
    }
    attachable(anchor,spin,orient,size=[100,100,100])
    {
        joystick_knob_outer_();
        children();
    }
}

module joystick(anchor=CENTER,spin=0,orient=UP)
{
    module joystick_()
    {
    }
    attachable(anchor,spin,orient,size=[100,100,100])
    {
        joystick_();
        children();
    }
}

