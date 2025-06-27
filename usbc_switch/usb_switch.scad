ViewScale = [0.0254, 0.0254, 0.0254];
include <../BOSL2-master/std.scad>
include <../models/model_rpi_pico.scad>

$fn=96;

model_cables=0;
model_u_connectors=1;
model_usb_switch=0;
model_rpi_pico=0;

usb_switch_mount_x = 2190+100;
usb_switch_mount_y = 1808+80;

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


module model_usb_connector(anchor=CENTER,spin=0,orient=UP)
{
    module model_usb_connector_()
    {
        cuboid([353, 306, 125], rounding=50, except=[FRONT, BACK]);
    }
    attachable(anchor,spin,orient,size=[353, 306, 125])
    {
        model_usb_connector_();
        children();
    }
}

module model_usb_u_connector(anchor=CENTER,spin=0,orient=UP)
{
    module model_usb_connector_()
    {
        recolor("black")
        cuboid([1112, 573, 253], rounding=50)
        {
            position(TOP+RIGHT) left(129) cuboid([234, 430, 284], rounding=100, edges="Z", anchor=BOT+RIGHT);
            position(TOP+LEFT) right(116) cuboid([205, 430, 50], rounding=100, edges="Z", anchor=BOT+LEFT)
            recolor("silver")
            position(BOT) model_usb_connector(anchor=BACK, spin=90, orient=LEFT);
        }
    }
    attachable(anchor,spin,orient,size=[1112, 573, 253+284])
    {
        up(253/2) down((253+284)/2)
        model_usb_connector_();
        children();
    }
}

module model_usb_switch(anchor=CENTER,spin=0,orient=UP)
{
    module model_usb_switch_()
    {
        rmtag="qw4vq2w4";
        recolor("green")
        diff(rmtag)
        cuboid([2190, 1808, 48])
        {
            // Connectors
            recolor("silver")
            {
                position(LEFT+BACK+TOP) right(387) back(40) model_usb_connector(anchor=LEFT+BACK+BOT);
//                if (model_cables)
//                {
//                    position(BACK) fwd(306) model_usb_cable(anchor=FRONT);
//                }
                position(RIGHT+BACK+TOP) left(387) back(40) model_usb_connector(anchor=RIGHT+BACK+BOT);
//                if (model_cables)
//                {
//                    position(BACK) fwd(306) model_usb_cable(anchor=FRONT);
//                }
                position(LEFT+FRONT+TOP) right(387) fwd(40) model_usb_connector(anchor=LEFT+FRONT+BOT);
                position(RIGHT+FRONT+TOP) left(387) fwd(40) model_usb_connector(anchor=RIGHT+FRONT+BOT);
            }
            // Chips
            recolor("black")
            {
                // USBC Adjacent
                position(LEFT+BACK+TOP) right(115) fwd(252) cuboid([100, 169, 85], anchor=LEFT+BACK+BOT)
                position(RIGHT+BOT) right(20) cuboid([113, 125, 55], anchor=LEFT+BOT);
                position(RIGHT+BACK+TOP) left(115) fwd(252) cuboid([100, 169, 85], anchor=RIGHT+BACK+BOT)
                position(LEFT+BOT) left(20) cuboid([113, 125, 55], anchor=RIGHT+BOT);

                // Centerline
                position(BACK+TOP) fwd(125) cuboid([120, 120, 30], anchor=BACK+BOT);
                position(BACK+TOP+LEFT) fwd(560) right(885) cuboid([180, 100, 50], anchor=BACK+BOT+LEFT);
                position(BACK+TOP+RIGHT) fwd(560) left(885) cuboid([180, 100, 50], anchor=BACK+BOT+RIGHT);
                position(BACK+TOP) fwd(940) cuboid([176, 139, 40], anchor=BACK+BOT);

                // Right
                position(RIGHT+BACK+TOP) left(367) fwd(785) cuboid([290, 250, 73], anchor=BOT+BACK+RIGHT);

                // Left
                position(LEFT+BACK+TOP) right(77) fwd(800) cuboid([120, 52, 45], anchor=LEFT+BACK+BOT)
                position(RIGHT+BACK+BOT) right(137) cuboid([170, 202, 55], anchor=LEFT+BACK+BOT);
                position(LEFT+BACK+TOP) right(77) fwd(1050) cuboid([120, 52, 45], anchor=LEFT+BACK+BOT)
                position(RIGHT+BACK+BOT) right(137) cuboid([170, 202, 55], anchor=LEFT+BACK+BOT);
                position(LEFT+FRONT+TOP) right(115) back(227) cuboid([200, 187, 60], anchor=LEFT+FRONT+BOT);

                // Button
                position(FRONT+TOP) back(143) recolor("silver") cuboid([237, 237, 167], anchor=BOT+FRONT)
                position(TOP) recolor("black") cyl(d=135, h=150, anchor=BOT);

                // Holes
                tag(rmtag) position(RIGHT+FRONT+TOP)
                ycopies(spacing=100, n=8) left(170) back(390+350) cyl(d=35, h=48, anchor=TOP);
            }
        
        }
    }
    
    attachable(anchor,spin,orient,size=[2190, 1808, 48])
    {
        up(24)
        model_usb_switch_();
        children();
    }
}

module model_usb_cable(anchor=CENTER,spin=0,orient=UP)
{
    module model_usb_cable_()
    {
        recolor("silver)")
        model_usb_connector()
        recolor("grey")
        position(BACK)
        cuboid([487, 715, 256], rounding=50, except=[FRONT, BACK], anchor=FRONT)
        recolor("black")
        position(BACK)
        cuboid([487, 390, 256], rounding=50, except=[FRONT, BACK], anchor=FRONT)
        recolor("grey")
        position(BACK) cyl(d=175, l=1000, orient=FRONT,anchor=TOP);
    }
    
    attachable(anchor,spin,orient,size=[487, 1411, 256])
    {
        back(306/2)
        fwd(1411/2)
        model_usb_cable_();
        children();
    }
}


module models()
{
    down(300) recolor("blue") cuboid([4500,4500,200], rounding=300, edges="Z");
    model_rpi_pico(spin=-90)
    {
        position(FRONT+LEFT) fwd(200) model_usb_switch(anchor=RIGHT+BACK,spin=90)
        {
            position(RIGHT+FRONT) down(110) fwd(90) left(280) model_usb_u_connector(spin=-90,orient=BACK,anchor=LEFT+BACK);
            position(LEFT+BACK) fwd(250) up(111) right(320) model_usb_cable(anchor=FRONT+LEFT);
            position(RIGHT+BACK) fwd(250) up(111) left(320) model_usb_cable(anchor=FRONT+RIGHT);
        }
        position(LEFT+BACK) back(200) model_usb_switch(anchor=LEFT+BACK,spin=90)
        {
            position(RIGHT+BACK) down(110) back(90) left(280) model_usb_u_connector(spin=90,orient=FRONT,anchor=LEFT+FRONT);
            position(LEFT+BACK) fwd(250) up(111) right(320) model_usb_cable(anchor=FRONT+LEFT);
            position(LEFT+FRONT) down(110) fwd(90) right(280) model_usb_u_connector(spin=-90,orient=BACK,anchor=LEFT+FRONT);
            position(RIGHT+FRONT) back(250) up(111) left(320) model_usb_cable(anchor=FRONT+LEFT,spin=180);
        }
    }
}


module usb_switch_mount(anchor=CENTER,spin=0,orient=UP)
{
    module usb_switch_mount_()
    {
        if (model_usb_switch)
        {
            up(100)
            model_usb_switch();
        }
        masktag="cvc5";
        rmtag="vti5a";
        diff(rmtag)
        intersect(masktag)
        {
            rect_tube(isize=[2190-100,1808-100], size=[usb_switch_mount_x, usb_switch_mount_y], h=100)
            {
                // Back wall
                position(BACK+BOT) cuboid([usb_switch_mount_x, 30, 350], anchor=BACK+BOT)
                {
                    tag(rmtag) position(BACK+LEFT) back(1) right(430) up(37) cuboid([363, 32, 145],
                        rounding=50, except=[FRONT, BACK], anchor=BACK+LEFT);
                    tag(rmtag) position(BACK+RIGHT) back(1) left(430) up(37) cuboid([363, 32, 145],
                        rounding=50, except=[FRONT, BACK], anchor=BACK+RIGHT);
                }

                // Front wall
                position(FRONT+BOT) cuboid([usb_switch_mount_x, 30, 220], anchor=FRONT+BOT)
                {
                    tag(rmtag) position(BACK+LEFT+BOT) back(1) right(430) up(137) cuboid([363, 32, 145],
                        rounding=50, except=[FRONT, BACK], anchor=BACK+LEFT+BOT);
                    tag(rmtag) position(BACK+RIGHT+BOT) back(1) left(430) up(137) cuboid([363, 32, 145],
                        rounding=50, except=[FRONT, BACK], anchor=BACK+RIGHT+BOT);
                }
                
                position(TOP) rect_tube(isize=[2190+20,1808], size=[usb_switch_mount_x,1808+100], h=48,anchor=BOT);
                tag(masktag)
                {
                    position(BOT+LEFT+BACK) move([-10,0,0]) cuboid([usb_switch_mount_x, 370, 350], anchor=BOT+LEFT+BACK);
                    position(BOT+LEFT+FRONT) move([-10,0,0]) cuboid([usb_switch_mount_x, 370, 350], anchor=BOT+LEFT+FRONT);
//#grid_copies(n=2, spacing=[2190-300, 1808-300]) cuboid([370, 370, 149], anchor=TOP);
                }
            }
        }
        // Base
        rect_tube(isize=[2190-150,1808-150], size=[usb_switch_mount_x,usb_switch_mount_y], h=50, anchor=TOP);
    }
    attachable(anchor,spin,orient,size=[usb_switch_mount_x, usb_switch_mount_y, 225])
    {
        up(50)
        down(225/2)
        usb_switch_mount_();
        children();
    }
}

module usb_switch_mount_a(anchor=CENTER,spin=0,orient=UP)
{
    module usb_switch_mount_a_()
    {
        usb_switch_mount()
        {
            position(BOT+LEFT) back(50) cuboid([100,usb_switch_mount_y+100,1200], anchor=BOT+RIGHT, rounding=100, edges=[LEFT+FRONT, LEFT+BACK])
                position(RIGHT+BACK) cuboid([250, 100, 1200] ,anchor=LEFT+BACK);

            rmtag = "q24v9r";
            diff(rmtag)
            position(BOT+BACK+RIGHT) right(100) cuboid([1400, 100, 1200], rounding=100, edges=[BACK+RIGHT], anchor=RIGHT+BOT)
            {
                position(FRONT+RIGHT+TOP) cuboid([100, 400, 1200], anchor=BACK+RIGHT+TOP);
                tag(rmtag) position(BACK+RIGHT+BOT) back(1) left(350) up(100) cuboid([700, 102, 300],
                    rounding=50, except=[FRONT, BACK], anchor=BACK+RIGHT+BOT);
            }

            if (model_u_connectors)
            {
                position(LEFT+BOT+BACK) move([280, 90+300, 50])
                model_usb_u_connector(orient=FRONT, spin=90, anchor=BACK+LEFT);
            }
        }
        position(LEFT+BOT+BACK) right(200) cuboid([50, 720, 1200], anchor=FRONT+LEFT+BOT)
        position(LEFT+BACK) cuboid([750, 50, 1200], anchor=LEFT+BACK)
        position(RIGHT+BACK) cuboid([50, 720, 1200], anchor=RIGHT+BACK);
    }
    attachable(anchor,spin,orient,size=[2190, 1808, 48+125])
    {
        usb_switch_mount_a_();
        children();
    }
}

module usb_switch_mount_b(anchor=CENTER,spin=0,orient=UP)
{
    module usb_switch_mount_b_()
    {
        usb_switch_mount()
        {
            rmtag = "q27v9r";
            diff(rmtag)
            position(BOT+BACK) cuboid([usb_switch_mount_x+200, 100, 1200], rounding=100, edges=[LEFT+BACK,RIGHT+BACK], anchor=FRONT+BOT)
            {
                position(FRONT+LEFT+TOP) cuboid([100, 400, 1200], anchor=BACK+LEFT+TOP);
                position(FRONT+RIGHT+TOP) cuboid([100, usb_switch_mount_y+100, 1200], anchor=BACK+RIGHT+TOP,rounding=100,edges=[FRONT+RIGHT])
                position(FRONT+LEFT) cuboid([300, 100, 1200], anchor=RIGHT+FRONT);
                *tag(rmtag) position(BACK+RIGHT+BOT) back(1) left(350) up(100) cuboid([700, 102, 300],
                    rounding=50, except=[FRONT, BACK], anchor=BACK+RIGHT+BOT);
            }

            if (model_u_connectors)
            {
                position(RIGHT+BOT+FRONT) move([-280, -90-300, 50])
                model_usb_u_connector(orient=BACK, spin=-90, anchor=BACK+LEFT);
            }
        }
        position(RIGHT+BOT+FRONT) left(200) cuboid([50, 720, 1200], anchor=BACK+RIGHT+BOT)
        position(RIGHT+FRONT) cuboid([750, 50, 1200], anchor=RIGHT+FRONT)
        position(LEFT+FRONT) cuboid([50, 720, 1200], anchor=LEFT+FRONT);
    }
    attachable(anchor,spin,orient,size=[2190, 1808, 48+125])
    {
        usb_switch_mount_b_();
        children();
    }
}

module rpi_pico_mount(anchor=CENTER,spin=0,orient=UP)
{
    module rpi_pico_mount_()
    {
        rpi_l = rpi_pico_pcb_length;
        rpi_w = rpi_pico_pcb_width;
        if (model_rpi_pico)
        {
            up(170)
            model_rpi_pico();
        }
        masktag="cvc5aa";
        rmtag="vti5aa";
        diff(rmtag)
        intersect(masktag)
        {
            rect_tube(isize=[rpi_l-100,rpi_w-100], size=[rpi_l+140, rpi_w+80], h=100)
            {
                // Connector wall
                position(LEFT+BOT) cuboid([30, rpi_w+80, 300], anchor=LEFT+BOT)
                {
                    tag(rmtag) position(LEFT+BOT) left(1) up(200) cuboid([363, 32, 145],
                        rounding=50, except=[FRONT, BACK], anchor=BACK, spin=90);
                    *tag(rmtag) position(BACK+RIGHT) back(1) left(430) up(37) cuboid([363, 32, 145],
                        rounding=50, except=[FRONT, BACK], anchor=BACK+RIGHT);
                }

                // Front wall
                *position(FRONT+BOT) cuboid([usb_switch_mount_x, 30, 220], anchor=FRONT+BOT)
                {
                    tag(rmtag) position(BACK+LEFT+BOT) back(1) right(430) up(137) cuboid([363, 32, 145],
                        rounding=50, except=[FRONT, BACK], anchor=BACK+LEFT+BOT);
                    tag(rmtag) position(BACK+RIGHT+BOT) back(1) left(430) up(137) cuboid([363, 32, 145],
                        rounding=50, except=[FRONT, BACK], anchor=BACK+RIGHT+BOT);
                }
                
                position(TOP) rect_tube(isize=[rpi_l+10,rpi_w+20], size=[rpi_l+140, rpi_w+80], h=40, anchor=BOT);
                tag(masktag)
                {
                    position(BOT+LEFT+BACK) move([-10,0,0]) cuboid([370, rpi_w+80, 350], anchor=BOT+LEFT+BACK);
                    position(BOT+RIGHT+BACK) move([10,0,0]) cuboid([370, rpi_w+80, 350], anchor=BOT+RIGHT+BACK);
//                    position(BOT+LEFT+FRONT) move([-10,0,0]) cuboid([usb_switch_mount_x, 370, 350], anchor=BOT+LEFT+FRONT);
//#grid_copies(n=2, spacing=[2190-300, 1808-300]) cuboid([370, 370, 149], anchor=TOP);
                }
            }
        }
        // Base
        rect_tube(isize=[rpi_l-150,rpi_w-150], size=[rpi_l+140,rpi_w+80], h=50, anchor=TOP);
    }
    attachable(anchor,spin,orient,size=[2190, 1808, 48+125])
    {
        rpi_pico_mount_();
        children();
    }
}

module lower()
{
    left(1700)
    usb_switch_mount_a();
    fwd(500)
    rpi_pico_mount(spin=-90);
    right(1700)
    usb_switch_mount_b();
}


module forViewing()
{
    lower();
//    model_usb_cable();
//    models();
//    model_usb_u_connector();
//    usb_switch_mount(anchor=LEFT);
//    usb_switch_mount_a();
//    usb_switch_mount_b();
//    rpi_pico_mount();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
//    forPrinting();
}
