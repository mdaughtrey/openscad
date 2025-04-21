ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>
include <../../models/model_ld2410_presence_sensor.scad>
include <../../models/model_5v_3v3_buck.scad>
include <../../models/model_esp32_s3_wroom.scad>
include <../../models/model_esp32_c3.scad>

$fn=96;
screwhole = 80;
model=0;

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

module buck_retainer(anchor=CENTER,spin=0,orient=UP)
{
    l = model_5v_3v3_buck_length;
    w = model_5v_3v3_buck_width;
    h = model_5v_3v3_buck_height;
    rmtag = "av4341_remove";

    module buck_retainer_()
    {

        diff(rmtag)
        conv_hull(rmtag)
        cyl(h=90, d=200)
        {
            tag(rmtag)
            attach(BOT, norot=1) cyl(h=50, d=screwhole,anchor=BOT)
            attach(TOP, norot=1) cyl(h=40, d=150,anchor=BOT);
            back(w+240)
            cyl(h=90, d=200)
            tag(rmtag)
            attach(BOT, norot=1) cyl(h=50, d=screwhole,anchor=BOT)
            attach(TOP, norot=1) cyl(h=40, d=150,anchor=BOT);
        }
    }
    attachable(anchor,spin,orient,size=[w+600, 200, 90])
    {
        buck_retainer_();
        children();
    }
}

module buck_mount(anchor=CENTER,spin=0,orient=UP,rmtag="bm_remove")
{
    l = model_5v_3v3_buck_length;
    w = model_5v_3v3_buck_width;
    h = model_5v_3v3_buck_height;
    module buck_mount_()
    {
        diff(rmtag)
        cuboid([300, 300, 50])
        {
            attach(BOT, norot=1)
            {
                fwd(w/2) cuboid([600, 100, 100], anchor=BOT)
                attach(BOT+FRONT+RIGHT, norot=1) tube(h=230, id=screwhole, od=200, anchor=BOT+BACK+RIGHT);
                back(w/2) cuboid([600, 100, 100], anchor=BOT)
                attach(BOT+BACK+RIGHT, norot=1) tube(h=230, id=screwhole, od=200, anchor=BOT+FRONT+RIGHT);

                left(l/2) cuboid([100, 200, 100], anchor=BOT);
                right(l/2) cuboid([100, 200, 100], anchor=BOT);
            }

            tag(rmtag)
            attach(TOP, norot=1) cuboid([l+20, w+20, 70], anchor=BOT);
            if (model)
            {
                tag("keep")
                attach(TOP, norot=1)
                model_5v_3v3_buck(anchor=BOT);
            }
        }
    }
    attachable(anchor,spin,orient,size=[l+100, w+100+460, 230])
    {
        up(25) down(115)
        buck_mount_();
        children();
    }
}

module lid(basex, basey, anchor=CENTER,spin=0,orient=UP)
{
    module lid_()
    {
        diff("lid_remove")
        cuboid([basex + 150, basey + 150, 100])
        {
            attach(LEFT+BOT, norot=1) cuboid([60, basey + 150, 120], anchor=TOP+LEFT)
            attach(BOT+RIGHT, norot=1) cuboid([60, basey + 150, 50], anchor=BOT+LEFT);
            attach(RIGHT+BOT, norot=1) cuboid([60, basey + 150, 120], anchor=TOP+RIGHT)
            attach(BOT+LEFT, norot=1) cuboid([60, basey + 150, 50], anchor=BOT+RIGHT);
            attach(FRONT+BOT, norot=1) cuboid([basex + 150, 60, 120], anchor=TOP+FRONT)
            attach(BOT+BACK, norot=1) cuboid([basex + 150, 60, 50], anchor=BOT+FRONT);
        }
    }
    attachable(anchor,spin,orient,size=[basex + 150, basey + 150, 100])
    {
        lid_();
        children();
    }
}

module base(basex, basey, anchor=CENTER,spin=0,orient=UP)
{
    rmtag = "ar4v34_remove";
    module base_()
    {
        diff(rmtag)
        cuboid([basex, basey, 65], rounding=100, edges="Z", except=BACK)
        {
            tag(rmtag)
            attach(BOT, norot=1)
            {
                back(700) right(1700) cyl(d=150,h=170,anchor=BOT);
                back(700) left(900) cyl(d=150,h=170,anchor=BOT);
                fwd(900) right(0) cyl(d=150,h=170,anchor=BOT);
            }

            // Base rims
            attach(TOP+BACK, norot=1) cuboid([basex-140, basey-70, 70], anchor=BOT+BACK,
                rounding=100, edges="Z", except=BACK)
            {
                attach(TOP+BACK, norot=1) rect_tube(size=[basex, basey], h=65, 
                    wall=100, rounding=100, anchor=BOT+BACK)
                // Front plate
                // attach(BOT+BACK, norot=1) #cuboid([basex, 300, 600], anchor=BOT+BACK)
                attach(BOT+BACK+LEFT, norot=1) cuboid([1000, 300, 638], anchor=BOT+BACK+LEFT)
                {
                    // Radar Module
                    attach(RIGHT+BACK+BOT, norot=1) down(100) fwd(20) radar_holder(orient=BACK,anchor=LEFT+BACK+TOP)
                    attach(RIGHT+FRONT+TOP, norot=1) back(0) up(20) cuboid([1900, 575, 100], anchor=LEFT+FRONT+TOP);
                    // Laser cutouts
                    tag(rmtag)
                    {
                        attach(BACK+LEFT+TOP, norot=1)  back(1) right(200) down(200)
                            cyl(d=140,h=50, anchor=BOT+LEFT+BACK, orient=FRONT)
                        attach(TOP, norot=1) cyl(d=245,h=300,anchor=BOT);
                        attach(BACK+LEFT+TOP, norot=1)  back(1) right(600) down(150)
                            cyl(d=325,h=50, anchor=BOT+LEFT+BACK, orient=FRONT)
                        attach(TOP, norot=1) cyl(d=400,h=300,anchor=BOT);
                    }
                }
                // ESP32 Mount
                attach(TOP+RIGHT+FRONT, norot=1) 
                left(450) fwd(220)
                esp32_c3_holder(spin=90,anchor=BOT+LEFT+FRONT)
                // ESP32 Model
                if (model)
                {
                    attach(BOT, norot=1) 
                    up(170) right(100)
                    model_esp32_c3(anchor=BOT);
                }
                // Buck Mount
                attach(TOP, norot=1) left(350) fwd(200)
                buck_mount(anchor=BOT,spin=90)
                *if (model)
                {
                    attach(BOT, norot=1)
                    up(100)
                    model_5v_3v3_buck(anchor=BOT);
                }
                // Cable tie
                attach(TOP+FRONT+LEFT, norot=1) right(200) back(400) down(100)
                rect_tube(isize=[300,200], wall=100, h=100, orient=FRONT, anchor=FRONT+LEFT);
                
            }
        }
    }
    attachable(anchor,spin,orient,size=[basex, basey, 270])
    {
        base_();
        children();
    }
}

module screw()
{
    recolor("red")
    cyl(d=110,h=300)
    attach(TOP, norot=1) cyl(d=250,h=200);
}


module esp32_c3_holder(anchor=CENTER,spin=0,orient=UP)
{
    rmtag="qwv54_remove";
    module esp32_c3_holder_()
    {
        diff(rmtag)
        rect_tube(isize=[esp32_c3_ai_pcb_X+30, esp32_c3_ai_Y+30], wall=50, h=200)
        {
            // USB Connector Cutout
            tag(rmtag)
            attach(TOP+LEFT, norot=1) left(1) up(1) cuboid([100, esp32_c3_ai_Y-200, 150], 
                rounding=100, edges=[BACK+BOT, FRONT+BOT], anchor=TOP+LEFT);
            // Inner board support
            attach(BOT, norot=1) rect_tube(isize=[esp32_c3_ai_pcb_X-30, esp32_c3_ai_Y-30], wall=60, h=150, anchor=BOT);

            // Screw mounts
            attach(LEFT+FRONT+BOT, norot=1) tube(h=200, id=screwhole, od=200, anchor=BOT+FRONT+RIGHT);
            attach(LEFT+BACK+BOT, norot=1) tube(h=200, id=screwhole, od=200, anchor=BOT+BACK+RIGHT);

            attach(RIGHT+FRONT+BOT, norot=1) tube(h=200, id=screwhole, od=200, anchor=BOT+FRONT+LEFT);
            attach(RIGHT+BACK+BOT, norot=1) tube(h=200, id=screwhole, od=200, anchor=BOT+BACK+LEFT);
        }
    }
    attachable(anchor,spin,orient,size=[esp32_c3_ai_pcb_X+1030, esp32_c3_ai_Y+30, 200])
    {
        down(100)
        esp32_c3_holder_();
        children();
    }
}

module esp32_c3_holder_retainer()
{
    rmtag = "a4vq_remove";
    hide("hidden") tag("hidden")
    rect_tube(isize=[esp32_c3_ai_pcb_X+30, esp32_c3_ai_Y+30], wall=50, h=200)
    {
        // SW Screw mount
        attach(LEFT+FRONT+BOT, norot=1) tube(h=200, id=80, od=250, anchor=BOT+FRONT+RIGHT)
        tag("visible") 
        attach(TOP, norot=1) tube(h=70, id=100, od=250, anchor=BOT)
        attach(TOP, norot=1) tube(h=115, id=200, od=250, anchor=BOT);

        // NW Screw mount
        attach(LEFT+BACK+BOT, norot=1) tube(h=200, id=80, od=250, anchor=BOT+BACK+RIGHT)
        tag("visible") 
        attach(TOP, norot=1) tube(h=70, id=100, od=250, anchor=BOT)
        attach(TOP, norot=1) tube(h=115, id=200, od=250, anchor=BOT);

    }
    up(360) left(720+60)
    diff(rmtag)
    cuboid([500, esp32_c3_ai_Y+60+70, 50], rounding=200, edges=[RIGHT+BACK,RIGHT+FRONT])
    {
        tag(rmtag)
        {
            attach(BOT+LEFT+FRONT, norot=1) cyl(d=250, h=51, anchor=BOT+LEFT+FRONT);
            attach(BOT+LEFT+BACK, norot=1) cyl(d=250, h=51, anchor=BOT+LEFT+BACK);
            attach(LEFT+BOT, norot=1) down(1) cuboid([250, esp32_c3_ai_Y-200,52], anchor=LEFT+BOT, 
                rounding=100, edges=[RIGHT+BACK, RIGHT+FRONT]);
        }
            
    }
}

module radar_holder(anchor=CENTER,spin=0,orient=UP)
{
    rmtag="fqcq43_remove";
    x = model_ld2410_pcb_X;
    y = model_ld2410_pcb_Y;

    module radar_holder_()
    {
        diff(rmtag)
        cuboid([x+10, 100, 50])
        {
            attach(LEFT+BOT+BACK, norot=1) cuboid([100, 440, 50], anchor=BOT+LEFT+BACK);
            attach(RIGHT+BOT+BACK, norot=1) cuboid([100, 350, 50], anchor=BOT+RIGHT+BACK);
            attach(TOP+BACK, norot=1) cuboid([x+10, y+10, 30], anchor=BOT+BACK)
            tag(rmtag)
            {
                attach(BACK+TOP, norot=1) fwd(150) cuboid([670, 220, 30], anchor=BACK+TOP);
                attach(TOP+FRONT+LEFT, norot=1) move([80, 80, 0]) cuboid([80, 50, 30], anchor=TOP+FRONT+LEFT);
            }
            attach(TOP+BACK, norot=1) up(30) back(100) rect_tube(isize=[x+9,y+9-100],wall=100,h=250,anchor=TOP+BACK)
            {
                tag(rmtag) attach(BOT+FRONT, norot=1) cuboid([x+9,100,190],anchor=BOT+FRONT);
                attach(BOT+BACK+RIGHT, norot=1) left(99) cuboid([150, y+10, 30], anchor=BOT+BACK+RIGHT);
                attach(BOT+BACK+LEFT, norot=1) right(99) cuboid([100, y+10, 100], anchor=BOT+BACK+LEFT);
            }
        }
    }
    attachable(anchor,spin,orient,size=[x+209,y+109,250])
    {
        fwd(150)
        back((y+109)/2)
        down(55)
        up(125)
        radar_holder_();
        children();
    }
}

module forViewing()
{
//    radar_holder();
//    model_esp32_c3();
//    buck_mount();
    base(basex = 4000, basey = 2500);
//    down(40) fwd(300)
//    model_ld2410_presence_sensor();
}

module forPrinting()
{
    base(basex = 4000, basey = 2500);
}

scale(ViewScale)
{
    forViewing();
//    forPrinting();
}
