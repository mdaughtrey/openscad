ViewScale = [0.0254, 0.0254, 0.0254];
include <../BOSL2-master/std.scad>
include <../models/model_rpi_pico.scad>
include <../models/model_esp_wroom_32.scad>
include <cableloop.scad>

$fn=96;

model_cables=0;
model_u_connectors=0;
model_usb_switch=0;
model_rpi_pico=0;
model_esp32=-1;
development_jig=0;

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
        // rect_tube(isize=[2190-150,1808-150], size=[usb_switch_mount_x,usb_switch_mount_y], h=50, anchor=TOP);
        cuboid([usb_switch_mount_x,usb_switch_mount_y, 50], anchor=TOP);
    }
    attachable(anchor,spin,orient,size=[usb_switch_mount_x, usb_switch_mount_y, 350])
    {
        up(50)
        down(350/2)
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
            if (!development_jig)
            {
                position(BOT+LEFT) back(50)
                cuboid([100,usb_switch_mount_y+100,1200], anchor=BOT+RIGHT, rounding=100, edges=[LEFT+FRONT, LEFT+BACK])
                {
                    position(RIGHT+BACK) cuboid([250, 100, 1200], anchor=LEFT+BACK);
                    position(FRONT+RIGHT) cuboid([100, 30, 1200], anchor=LEFT+FRONT);
                }
            }

            if (!development_jig)
            {
                rmtag = "q24v9r";
                diff(rmtag)
                position(BOT+BACK+RIGHT) right(100) cuboid([1450, 100, 1200], rounding=100, edges=[BACK+RIGHT], anchor=RIGHT+BOT+FRONT)
                {
                    position(FRONT+RIGHT+TOP) cuboid([100, 110, 1200], anchor=BACK+RIGHT+TOP);
                    tag(rmtag) position(BACK+RIGHT+BOT) back(1) left(350) up(100) cuboid([700, 102, 300],
                        rounding=50, except=[FRONT, BACK], anchor=BACK+RIGHT+BOT);
                }
            }

            if (model_u_connectors)
            {
                position(LEFT+BOT+BACK) move([280, 90+300, 50])
                model_usb_u_connector(orient=FRONT, spin=90, anchor=BACK+LEFT);
            }
            if (!development_jig)
            {
                position(LEFT+BOT+BACK) right(200) cuboid([50, 720, 1200], anchor=FRONT+LEFT+BOT, rounding=50, edges=[BACK+LEFT])
                position(RIGHT+BACK) cuboid([650, 50, 1200], anchor=LEFT+BACK)
                position(RIGHT+BACK) cuboid([50, 720, 1200], anchor=LEFT+BACK, rounding=50, edges=[BACK+RIGHT]);
            }
        }
    }

    attachable(anchor,spin,orient,size=[usb_switch_mount_x+200, usb_switch_mount_y+720, 1200])
    {
        fwd(360)
        up(350/2)
        down(600)
        
        usb_switch_mount_a_();
        children();
    }
}

module mount_a_cage(anchor=CENTER,spin=0,orient=UP)
{
    module mount_a_cage_()
    {
        rmtag="54qv4r";
        diff(rmtag)
        rect_tube(size=[usb_switch_mount_x-20, usb_switch_mount_y-110], wall=100, h=100)
        {
            position(LEFT+BACK+BOT) cuboid([200,100,900],anchor=TOP+LEFT+BACK);
            position(RIGHT+BACK+BOT) cuboid([200,100,900],anchor=TOP+RIGHT+BACK);
            position(LEFT+FRONT+BOT) cuboid([150,200,900],anchor=TOP+LEFT+FRONT);
            position(RIGHT+FRONT+BOT) cuboid([100,200,900],anchor=TOP+RIGHT+FRONT)
            position(FRONT+LEFT+TOP) cuboid([300,40,830],anchor=TOP+FRONT+RIGHT);
            position(FRONT+TOP+LEFT) right(100)  cuboid([1889,40,930],anchor=BACK+TOP+LEFT)
            tag(rmtag) 
            {
                position(BOT+LEFT+FRONT) right(310) cuboid([363, 41, 145], rounding=50, edges="Y", anchor=FRONT+LEFT)
                position(RIGHT) right(700) cuboid([363, 41, 145], rounding=50, edges="Y", anchor=LEFT);
            }
        }
    }
    
    attachable(anchor,spin,orient,size=[
        usb_switch_mount_x-20,
        usb_switch_mount_y-20,
        1000])
    {
        down(100)
        up(500)
        back(20)
        mount_a_cage_();
        children();
    }
}

module mount_b_cage(anchor=CENTER,spin=0,orient=UP)
{
    module mount_b_cage_()
    {
        rmtag="54qv4s";
        diff(rmtag)
        rect_tube(size=[usb_switch_mount_x-20, usb_switch_mount_y-100], wall=100, h=100)
        {
            position(LEFT+BACK+BOT) cuboid([200,100,900],anchor=TOP+LEFT+BACK);
            position(RIGHT+BACK+BOT) cuboid([200,100,900],anchor=TOP+RIGHT+BACK);
            position(LEFT+FRONT+BOT) cuboid([150,200,900],anchor=TOP+LEFT+FRONT);
            position(RIGHT+FRONT+BOT) cuboid([100,200,900],anchor=TOP+RIGHT+FRONT);
            //position(FRONT+LEFT+TOP) cuboid([300,40,830],anchor=TOP+FRONT+RIGHT);
            position(FRONT+TOP+LEFT) right(310)  cuboid([860,40,930],anchor=BACK+TOP+LEFT)
            tag(rmtag) 
            {
                position(BOT+LEFT+FRONT) right(120) fwd(1) cuboid([363, 42, 145], rounding=50, edges="Y", anchor=FRONT+LEFT);
//                position(RIGHT) right(700) cuboid([363, 41, 145], rounding=50, edges="Y", anchor=LEFT);
            }
        }
    }
    
    attachable(anchor,spin,orient,size=[
        usb_switch_mount_x-20,
        usb_switch_mount_y-20,
        1000])
    {
        down(100)
        up(500)
        back(20)
        mount_b_cage_();
        children();
    }
}

module usb_switch_mount_b(anchor=CENTER,spin=0,orient=UP)
{
    module usb_switch_mount_b_()
    {
        usb_switch_mount()
        {
            if (!development_jig) 
            {
                rmtag = "q27v9r";
                diff(rmtag)
                position(BOT+BACK) cuboid([usb_switch_mount_x+200, 100, 1200], rounding=100, edges=[LEFT+BACK,RIGHT+BACK], anchor=FRONT+BOT)
                {
                    position(FRONT+LEFT+TOP) cuboid([100, 150, 1200], anchor=BACK+LEFT+TOP);
                    position(FRONT+RIGHT+TOP) cuboid([100, usb_switch_mount_y+100, 1200], anchor=BACK+RIGHT+TOP,rounding=100,edges=[FRONT+RIGHT])
                    position(FRONT+LEFT) cuboid([200, 100, 1200], anchor=RIGHT+FRONT)
                    position(LEFT+BOT+BACK) cuboid([50, 720, 1200], anchor=BACK+RIGHT+BOT, rounding=50, edges=[RIGHT+FRONT])
                    position(LEFT+FRONT) cuboid([650, 50, 1200], anchor=RIGHT+FRONT)
                    position(LEFT+FRONT) cuboid([50, 720, 1200], anchor=RIGHT+FRONT,rounding=50,edges=[FRONT+LEFT])
                    position(RIGHT+BACK) cuboid([200,30,1200], anchor=FRONT+RIGHT);

                    tag(rmtag) position(BACK+RIGHT+BOT) back(1) left(350) up(100) cuboid([700, 102, 300],
                        rounding=50, except=[FRONT, BACK], anchor=BACK+RIGHT+BOT);
                    tag(rmtag) position(BACK+RIGHT+BOT) back(1) left(1400) up(100) cuboid([700, 102, 300],
                        rounding=50, except=[FRONT, BACK], anchor=BACK+RIGHT+BOT);
                }
            }

            if (model_u_connectors)
            {
                position(RIGHT+BOT+FRONT) move([-280, -90-300, 50])
                model_usb_u_connector(orient=BACK, spin=-90, anchor=BACK+LEFT);
            }
        }
    }
    attachable(anchor,spin,orient,size=[usb_switch_mount_x+200, 1808+720, 1200])
    {
        fwd(360)
        up(350/2)
        down(600)
        usb_switch_mount_b_();
        children();
    }
}

module rpi_pico_mount(anchor=CENTER,spin=0,orient=UP)
{
    rpi_l = rpi_pico_pcb_length;
    rpi_w = rpi_pico_pcb_width;
    module rpi_pico_mount_()
    {
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
                if (!development_jig)
                {
                    position(LEFT+BOT) cuboid([30, rpi_w+80, 1150], anchor=LEFT+BOT)
                    {
                        tag(rmtag) position(LEFT+BOT) left(1) up(200) cuboid([363, 32, 145],
                            rounding=50, except=[FRONT, BACK], anchor=BACK, spin=90);
                        tag(rmtag) position(BOT) left(1) up(700) cyl(d=200,h=32,orient=LEFT);
//                        rounding=50, except=[FRONT, BACK], anchor=BACK, spin=90);
                        *tag(rmtag) position(BACK+RIGHT) back(1) left(430) up(37) cuboid([363, 32, 145],
                            rounding=50, except=[FRONT, BACK], anchor=BACK+RIGHT);
                    }
                }

                // Front wall
                *position(FRONT+BOT) cuboid([usb_switch_mount_x, 30, 220], anchor=FRONT+BOT)
                {
                    tag(rmtag) position(BACK+LEFT+BOT) back(1) right(430) up(137) cuboid([363, 32, 145],
                        rounding=50, except=[FRONT, BACK], anchor=BACK+LEFT+BOT);
                    tag(rmtag) position(BACK+RIGHT+BOT) back(1) left(430) up(137) cuboid([363, 32, 145],
                        rounding=50, except=[FRONT, BACK], anchor=BACK+RIGHT+BOT);
                }

                // Back wall
                if (!development_jig)
                {
                    tag("keep") position(RIGHT+BOT) down(50) cuboid([30, rpi_w+80, 1200], anchor=LEFT+BOT)
                    {
                        position(RIGHT+FRONT) cuboid([382,30,1200], anchor=RIGHT+BACK)
                        position(LEFT+BACK) cuboid([30,300,1200], anchor=RIGHT+BACK);

                        position(RIGHT+BACK) cuboid([402,30,1200], anchor=RIGHT+FRONT)
                        position(LEFT+FRONT) cuboid([30,300,1200], anchor=RIGHT+FRONT);
                    }
                }
                
                position(TOP) rect_tube(isize=[rpi_l+10,rpi_w+20], size=[rpi_l+140, rpi_w+80], h=40, anchor=BOT);
                tag(masktag)
                {
                    position(BOT+LEFT+BACK) move([-10,0,0]) cuboid([370, rpi_w+80, 1200], anchor=BOT+LEFT+BACK);
                    position(BOT+RIGHT+BACK) move([10,0,0]) cuboid([370, rpi_w+80, 350], anchor=BOT+RIGHT+BACK);
//                    position(BOT+LEFT+FRONT) move([-10,0,0]) cuboid([usb_switch_mount_x, 370, 350], anchor=BOT+LEFT+FRONT);
//#grid_copies(n=2, spacing=[2190-300, 1808-300]) cuboid([370, 370, 149], anchor=TOP);
                }
            }
        }
        // Base
        //rect_tube(isize=[rpi_l-150,rpi_w-150], size=[rpi_l+140,rpi_w+80], h=50, anchor=TOP);
        cuboid([rpi_l+140,rpi_w+80, 50], anchor=TOP);
    }
    attachable(anchor,spin,orient,size=[rpi_l+140, rpi_w+80, 300])
    {
        up(50)
        down(300/2)
        rpi_pico_mount_();
        children();
    }
}


module higher()
{
    thickness=100;
    rmtag="bmn234";
    diff(rmtag)
    cuboid([4300, 6200, thickness], rounding=400, edges="Z")
    {
        tag(rmtag)
        {
            // Screw #8 x 3/4
            position(LEFT+BACK+BOT) right(300) fwd(300) cyl(d=100, h=thickness,anchor=BOT);
            position(LEFT+FRONT+BOT) right(300) back(300) cyl(d=100, h=thickness,anchor=BOT);
            position(RIGHT+FRONT+BOT) left(300) back(300) cyl(d=100, h=thickness,anchor=BOT);
            position(RIGHT+BACK+BOT) left(300) fwd(1400) cyl(d=100, h=thickness,anchor=BOT);
        }

        position(TOP) right(5050/2) cuboid([100, 1000, 600], anchor=BOT+LEFT)
        position(BOT+RIGHT) cuboid([1000, 1000, thickness], anchor=TOP+RIGHT);

        position(TOP) left(5050/2) cuboid([100, 1000, 600], anchor=BOT+RIGHT)
        position(BOT+LEFT) cuboid([1000, 1000, thickness], anchor=TOP+LEFT);

        position(BOT) back(4350/2)  cuboid([1000, 100, 600], anchor=BOT+FRONT);
        position(BOT) fwd(4350/2)  cuboid([1000, 100, 600], anchor=BOT+BACK);

        tag(rmtag)
        position(TOP) xcopies(spacing=300, n=6) 
        cuboid([100,3000,thickness],anchor=TOP)
        {
            position(TOP+BACK) cyl(d=100,h=thickness,anchor=TOP);
            position(TOP+FRONT) cyl(d=100,h=thickness,anchor=TOP);
        }
    }
}

module lower()
{
    //rpi_pico_mount()
    esp_wroom_32_mount()
    {
        if (development_jig)
        {
            position(FRONT+BOT) cuboid([1000, 100, 100], anchor=BOT+BACK);
            position(BACK+BOT) cuboid([1000, 100, 100], anchor=BOT+FRONT);
        }
        position(LEFT+BOT+FRONT) back(50) left(720) usb_switch_mount_a(spin=90,anchor=RIGHT+BACK+BOT);
        position(LEFT+BOT+BACK) fwd(50) left(680) usb_switch_mount_b(spin=90,anchor=LEFT+BACK+BOT);
//        position(BACK) left(200) fwd(600) up(250) cableloop(spin=90);
        *position(BOT) recolor("blue") left(500) cuboid([4300, 5000, 50], rounding=400, edges="Z", anchor=BOT);
        if (!development_jig)
        {
            position(BOT) left(500) cuboid([4300, 6200, 50], rounding=400, edges="Z", anchor=BOT)
            {
                // Screw #8 x 3/4
                position(LEFT+BACK+BOT) right(300) fwd(300) 
                    rect_tube(isize=[120,120], irounding=60, rounding=100, size=[400,400], h=1200, anchor=BOT);
                position(LEFT+FRONT+BOT) right(300) back(300)
                    rect_tube(isize=[120,120], irounding=60, rounding=100, size=[400,400], h=1200, anchor=BOT);
                position(RIGHT+FRONT+BOT) left(300) back(300)
                    rect_tube(isize=[120,120], irounding=60, rounding=100, size=[400,400], h=1200, anchor=BOT);
                position(RIGHT+BACK+BOT) left(300) fwd(1400)
                    rect_tube(isize=[120,120], irounding=60, rounding=100, size=[400,400], h=1200, anchor=BOT);
            }
        }
    }
    *position(RIGHT+BOT+BACK) left(1500) rpi_pico_mount(spin=-90,anchor=FRONT+LEFT+BOT)
    position(RIGHT+BOT+BACK) usb_switch_mount_b(anchor=LEFT+BACK);
}

module minipc_mount(anchor=CENTER,spin=0,orient=UP)
{
    module minipc_mount_()
    {
//        cuboid([5000, 4300, 2000], rounding=400, edges="Z");
        recolor("blue") position(BOT)
        cuboid([5050, 300, 100])
        {
            position(RIGHT+BOT) cuboid([100, 1000, 600], anchor=BOT+LEFT);
            position(LEFT+BOT) cuboid([100, 1000, 600], anchor=BOT+RIGHT);
        }
        recolor("blue") position(BOT)
        cuboid([4350, 300, 100],spin=90)
        {
            position(RIGHT+BOT) cuboid([100, 1000, 600], anchor=BOT+LEFT);
            position(LEFT+BOT) cuboid([100, 1000, 600], anchor=BOT+RIGHT);
        }
    }
    attachable(anchor,spin,orient,size=[5000, 4300, 2000])
    { 
        minipc_mount_();
        children();
    }
}

module model_usb_chassis_connector(anchor=CENTER,spin=0,orient=UP)
{
    module model_usb_chassis_connector_()
    {
        rmtag = "452qvq24";
        diff(rmtag)
        cuboid([793,273,65])
        {
            tag(rmtag) position(RIGHT+BOT) left(85) cyl(d=87, h=65, anchor=BOT);
            tag(rmtag) position(LEFT+BOT) right(85) cyl(d=87, h=65, anchor=BOT);
            tag(rmtag) position(BOT) cuboid([330, 102, 66], rounding=50, edges="Z",anchor=BOT);
            position(TOP) cuboid([356, 125, 335], rounding=50, edges="Z",anchor=BOT)
            position(TOP) cuboid([356, 30, 148], anchor=BOT);
        }
    }
    attachable(anchor,spin,orient,size=[793,273,548])
    {
        up(65/2)
        down(548/2)
        model_usb_chassis_connector_();
        children();
    }
}


module esp_wroom_32_mount(anchor=CENTER,spin=0,orient=UP)
{
    module esp_wroom_32_mount_()
    {
        if(model_esp32)
        {
            up(250)
            model_esp_wroom_32();
        }
        rmtag="f1re1c";
        diff(rmtag)
        rect_tube(isize=[1920,1120],wall=70,h=300)
        {
            // Rear Shroud
            position(TOP+RIGHT) cuboid([100,1260,300],anchor=TOP+LEFT)
            position(TOP+RIGHT) cuboid([40,1260,850],anchor=BOT+RIGHT)
            {
                position(FRONT+LEFT) cuboid([332,40,850],anchor=RIGHT+FRONT)
                position(LEFT+BACK+TOP) cuboid([40,400,1150],anchor=TOP+BACK+RIGHT);
                position(BACK+LEFT) cuboid([332,40,850],anchor=RIGHT+BACK)
                position(LEFT+FRONT+TOP) cuboid([40,400,1150],anchor=TOP+FRONT+RIGHT);
            }

            position(TOP+LEFT) cuboid([100,1260,300],anchor=TOP+RIGHT)
            position(LEFT+TOP) cuboid([29,1260,850],anchor=LEFT+BOT)
            tag(rmtag) position(BOT+LEFT) left(1) down(30) cuboid([32, 450, 300], rounding=50, edges="X",anchor=LEFT+BOT);

            position(BOT) cuboid([1920+340,1260,50],anchor=TOP);
            tag(rmtag)
            position(TOP+BACK) up(1) back(1) cuboid([1300,1262,300],anchor=TOP+BACK);
        }
    }
    attachable(anchor,spin,orient,size=[1920+340,1260,350])
    {
        up(50) down(175)
        esp_wroom_32_mount_();
        children();
    }
}

module esp_mount_cage(anchor=CENTER,spin=0,orient=UP)
{
    module esp_mount_cage_()
    {
        rmtag="5444v4s";
        height=760;
        diff(rmtag)
        rect_tube(osize=[1130, 2100], wall=100, h=100)
        {
            position(LEFT+BACK+BOT) cuboid([150,100,height-100],anchor=TOP+LEFT+BACK);
            position(RIGHT+BACK+BOT) cuboid([150,100,height-100],anchor=TOP+RIGHT+BACK);
            position(LEFT+FRONT+BOT) cuboid([150,100,height-100],anchor=TOP+LEFT+FRONT);
            position(RIGHT+FRONT+BOT) cuboid([150,100,height-100],anchor=TOP+RIGHT+FRONT);
            //position(FRONT+LEFT+TOP) cuboid([300,40,830],anchor=TOP+FRONT+RIGHT);
//            *position(FRONT+TOP+LEFT) right(320)  cuboid([1350,40,890],anchor=BACK+TOP+LEFT)
//            *tag(rmtag) 
//            {
//                position(BOT+LEFT+FRONT) right(90) fwd(1) cuboid([363, 42, 145], rounding=50, edges="Y", anchor=FRONT+LEFT);
////                position(RIGHT) right(700) cuboid([363, 41, 145], rounding=50, edges="Y", anchor=LEFT);
//            }
        }
    }
    
    attachable(anchor,spin,orient,size=[
        model_esp_wroom_32_x-20,
        model_esp_wroom_32_y-20,
        1000])
    {
        esp_mount_cage_();
        children();
    }
}

module forViewing()
{
//    esp_wroom_32_mount(anchor=BOT+LEFT+BACK);
//    esp_wroom_32_mount();
//    model_usb_chassis_connector();
//    minipc_mount();
//    cableloop();
    lower();
    up(1200)
    left(500)
    higher();
//    recolor("blue")
//    position(TOP+LEFT)
//    fwd(1820) left(160) up(30) zrot(90)
//    mount_a_cage(anchor=BOT);
//    recolor("red")
//    back(1820) left(160) up(30) zrot(90)
//    mount_b_cage(anchor=BOT);
//    model_usb_cable();
//    models();
//    model_usb_u_connector();
//    usb_switch_mount(anchor=BOT);
//    usb_switch_mount_b(anchor=BOT);
//    usb_switch_mount_b(anchor=BOT+LEFT+FRONT);
//   rpi_pico_mount(anchor=BOT);
}

module forPrinting()
{
//    mount_a_cage();
//    mount_b_cage();
//    esp_mount_cage();
    higher();
//    minipc_mount();
}

scale(ViewScale)
{
//    forViewing();
    forPrinting();
}
