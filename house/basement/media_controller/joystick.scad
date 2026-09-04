joystick_outer_shaft_dia = 500;
joystick_outer_shaft_length = 3000;
joystick_inner_shaft_dia = joystick_outer_shaft_dia - 220;
joystick_sphere_dia = 1000;
joystick_switch_base_thickness = 100;

// module joystick(anchor=CENTER,spin=0,orient=UP)
// {
//     module joystick_()
//     {
//     }
//     attachable(anchor,spin,orient,size=[100,100,100])
//     {
//         joystick_();
//         children();
//     }
// }

module joystick_inner_shaft(anchor=CENTER,spin=0,orient=UP)
{
    module joystick_inner_shaft_()
    {
        rmtag="rqm.nb";
        diff(rmtag)
        cyl(d=joystick_inner_shaft_dia, l=joystick_outer_shaft_length+1000)
        {
            tag(rmtag) position(TOP) up(1) cyl(d=joystick_inner_shaft_dia-100, l=joystick_outer_shaft_length+1002, anchor=TOP);
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
        cyl(d=joystick_outer_shaft_dia,  l=joystick_outer_shaft_length)
        {
            // Twist paddles
            *position(BOT) up(500)
            {
                mydia = 1600 + joystick_sphere_dia;
                intersect(itag)
                {
                    back((mydia-joystick_outer_shaft_dia)/2) cyl(d=mydia, l=200, anchor=BOT)
                    tag(itag) position(FRONT) cuboid([mydia-1100, joystick_outer_shaft_dia/2, 200], 
                        edges=[BACK+TOP, BACK+BOT, BACK+LEFT, BACK+RIGHT], rounding=50, anchor=FRONT);
                }
            }
            // Sliding plate insert
            position(BOT) up(300) cuboid([joystick_outer_shaft_dia, joystick_outer_shaft_dia, 200], edges="Z", rounding=100, anchor=BOT);
            // Ball
            position(BOT) up(500+joystick_sphere_dia) sphere(d=joystick_sphere_dia);
            // Shaft hole
            tag(rmtag) position(BOT) down(1) cyl(d=joystick_outer_shaft_dia-200, l=joystick_outer_shaft_length+2, anchor=BOT);
            // Upper tabs
            position(TOP) down(200) 
            {
                position(RIGHT) left(50) cuboid([200, 100, 400], anchor=TOP+LEFT, edges=RIGHT, rounding=50);
                position(LEFT) right(50) cuboid([200, 100, 400], anchor=TOP+RIGHT, edges=LEFT, rounding=50);
            }
        }
    }
    attachable(anchor,spin,orient,size=[100,100,100])
    {
        joystick_outer_shaft_();
        children();
    }
}

module joystick_switch_base(anchor=CENTER,spin=0,orient=UP)
{
    module joystick_switch_base_()
    {
        rmtag="rvwqr3";
        diff(rmtag)
        cuboid([1500, 1500, joystick_switch_base_thickness], edges="Z", rounding=100)
        {
             tag(rmtag) position(TOP) up(1) cuboid([joystick_outer_shaft_dia+50, joystick_outer_shaft_dia+50, 202],
                 edges="Z", rounding=125, anchor=TOP);
            // Button supports
            *position(TOP) back(150)
            {
                right(500) cuboid([400, 200, 300], anchor=BOT);
                left(500) cuboid([400, 200, 300], anchor=BOT);
            }
        }
    }
    attachable(anchor,spin,orient,size=[100,100,100])
    {
        joystick_switch_base_();
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

module joystick_switch_upper(anchor=CENTER,spin=0,orient=UP)
{
    module joystick_switch_upper_()
    {
        rmtag="rvclkfiqw";
        diff(rmtag)
        cuboid([2000, 1500, 200], edges="Z", rounding=100)
        {
            sphere_r = joystick_sphere_dia/2;
            sphere_outer_d = joystick_sphere_dia + 100;
            sphere_inner_d = joystick_sphere_dia + 30;
            tag(rmtag) position(BOT) down(1) cyl(d=joystick_outer_shaft_dia+100, l=502, anchor=BOT);
            // Ball Holder
            position(TOP) down(100) joystick_halfball(inner_d=sphere_inner_d, outer_d=sphere_outer_d, anchor=BOT);
            // Ball Holder screw mounts
            position(TOP)
            {
               right(sphere_outer_d/2-30) tube(id=100, od=250, l=sphere_outer_d/2-100, anchor=BOT+LEFT);
               left(sphere_outer_d/2-30) tube(id=100, od=250, l=sphere_outer_d/2-100, anchor=BOT+RIGHT);
            }
            
            
            //tag(rmtag) position(TOP) up(1) cuboid([600, 600, 202], anchor=TOP, edges="Z", rounding=100);
        }
    }
    attachable(anchor,spin,orient,size=[100,100,100])
    {
        joystick_switch_upper_();
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

