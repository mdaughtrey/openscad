ViewScale = [0.0254, 0.0254, 0.0254];
include <../BOSL2-master/std.scad>
include <../BOSL2-master/rounding.scad>

include <../models/model_ssd1306.scad>
include <../models/model_5v_3v3_buck.scad>
include <../models/model_rpi_pico.scad>
$fn=96;

group1 = 1;

module top_display(anchor=CENTER,
    spin=0,
    orient=UP,
    l = ssd1306_128_32_length,
    w = ssd1306_128_32_width
)
{
    attachable(anchor,spin,orient, size=[l + 20, w + 20, 120])
    {
        up(50)
        cuboid([l - 430, w, 20])
        attach(BOT, norot=1)
        cuboid([l + 60, w + 20, 100], anchor=TOP);
//         attach(TOP,norot=1)
//                cuboid([l-440,w-40,20],anchor=TOP);
//            }
//        }
        children();
    }
}

module top_sensor(anchor=CENTER,spin=0,orient=UP,
    l = ssd1306_128_32_length,
    w = ssd1306_128_32_width)
{
    module top_sensor_()
    {
        diff("cs_remove")
        cuboid([l+270,1200,120], rounding=200, edges=[FRONT+LEFT, FRONT+RIGHT])
        {
            attach(TOP, norot=1) up(1)
            tag("cs_remove")
            {
                cyl(d=846, h=50, anchor=TOP) 
                {
                    attach(BOT, norot=1) cyl(d=768, h=1300, anchor=TOP) 
                    {
                        zrot(-45) attach(LEFT, norot=1) cyl(d=100,h=1300);
                        zrot(45) attach(LEFT, norot=1) cyl(d=100,h=1300);
                        zrot(180) attach(LEFT, norot=1) cyl(d=100,h=1300);
                        //attach(BOT, norot=1) cyl(d=600, h=526 - 175, anchor=TOP)
                        // attach(BOT, norot=1) cyl(d=1100, h=526-50, anchor=TOP);
                    }
                }
            }
            //attach(BOT, norot=1) tube(id=920, wall=100, h=526-50, anchor=TOP);
            attach(RIGHT+BACK+BOT, norot=1) left(50) buck_mount(spin=-90, anchor=TOP+BACK+LEFT);
        }
    }
    attachable(anchor,spin,orient,size=[l+220,1200,120])
    {
        top_sensor_();
        children();
    }
}

module rounded_surface(anchor=CENTER,spin=0,orient=UP, dl=0, dw=0)
{
    l = ssd1306_128_32_length + dw;
    w = ssd1306_128_32_width + dl;
    module rounded_surface_()
    {
        diff("rs_remove")
        cuboid([l + 270 + 200, 1870 + w, 200], rounding=200, edges=TOP)
        {
            tag("rs_remove")
            {
                attach(LEFT+TOP+FRONT, norot=1) rounding_corner_mask(r=201, orient=DOWN, spin=90);
                attach(RIGHT+TOP+FRONT, norot=1) rounding_corner_mask(r=201, orient=DOWN, spin=0);
                attach(RIGHT+TOP+BACK, norot=1) rounding_corner_mask(r=201, orient=DOWN, spin=-90);
                attach(LEFT+TOP+BACK, norot=1) rounding_corner_mask(r=201, orient=DOWN, spin=180);
            }
        }
    }
    attachable(anchor,spin,orient,size=[l + 270, 1870 + w, 200])
    {
        rounded_surface_();
        children();
    }
}

module fingerprint_sensor_cutout(anchor=CENTER,spin=0,orient=UP)
{
    h=300;
    attachable(anchor,spin,orient,d=846+100, h=h+100)
    {
        down(100)
        up(100+h/2)
        cyl(d=876, h=100) 
        attach(BOT, norot=1) cyl(d=768, h=h, anchor=TOP) 
        {
            zrot(-45) attach(LEFT, norot=1) cyl(d=100,h=h);
            zrot(45) attach(LEFT, norot=1) cyl(d=100,h=h);
            zrot(180) attach(LEFT, norot=1) cyl(d=100,h=h);
        }
        children();
    }
}

module fingerprint_sensor_mount(anchor=CENTER,spin=0,orient=UP)
{
    attachable(anchor,spin,orient,d=926, h=250)
    {
        diff("sm_remove")
        cyl(d=926, h=150)
        {
            tag("sm_remove")  down(0)
            attach(TOP, norot=1) fingerprint_sensor_cutout(anchor=TOP);
        }
       children();
    }
}


module rpi_support(anchor=CENTER,spin=0,orient=UP)
{
    module rpi_support_()
    {
        diff("rs_remove")
        cuboid([rpi_pico_pcb_width + 170, 200, 100])
        {
            attach(TOP, norot=1) cuboid([600, 200, 50], anchor=BOT)
            tag("rs_remove") attach(TOP, norot=1)
            {
                left(225) cyl(d=120, h=150, anchor=TOP);
                right(225) cyl(d=120, h=150, anchor=TOP);
            }
            attach(TOP+LEFT, norot=1) cuboid([75, 200, 100], anchor=BOT+LEFT);
            attach(TOP+RIGHT, norot=1) cuboid([75, 200, 100], anchor=BOT+RIGHT);
        }
    }
    attachable(anchor,spin,orient,size=[rpi_pico_pcb_width + 220, 200, 300])
    {
        up(100)
        down(150)
        rpi_support_();
        children();
    }
}

module case_top(anchor=CENTER,spin=0,orient=UP) {
    l = ssd1306_128_32_length;
    w = ssd1306_128_32_width;
    module case_top_()
    {
        diff("ct0_remove", "ct0_keep")
        rounded_surface()
        {
            tag("ct0_remove")
            {
                // Scoop
                down(100) rounded_surface(dl = -100, dw = -100);
                // Fingerprint sensor hole
                attach(TOP+FRONT, norot=1) back(200)  up(1)
                cyl(d=886, h=102, anchor=TOP+FRONT)
                tag("ct0_keep")
                attach(TOP, norot=1) down(20) fingerprintSensorFacia(d=886+100,rounding=50, anchor=BOT);

                *attach(TOP+FRONT, norot=1) back(200)
                fingerprint_sensor_cutout(anchor=TOP+FRONT);
                attach(TOP+FRONT, norot=1) back(1500) top_display(anchor=TOP);
            }
            tag("ct0_keep")
            {
                attach(TOP+FRONT, norot=1) back(181)  // down(99)
                fingerprint_sensor_mount(anchor=TOP+FRONT);
//                tube(id=746, wall=100, h=100, anchor=TOP+FRONT);
                attach(LEFT+BACK+TOP, norot=1) fwd(380) down(150) right(50)
                     buck_mount(anchor=LEFT+BOT+BACK, orient=DOWN, spin=-90);
                // RPI Pico Lifts
                attach(BOT+RIGHT+BACK, norot=1) right(50) fwd(200) rpi_support(orient=DOWN, anchor=LEFT);
                attach(BOT+RIGHT, norot=1) right(50) rpi_support(orient=DOWN, anchor=LEFT);
                *attach(BOT+RIGHT+FRONT, norot=1) right(50) back(180) rpi_support(orient=DOWN, anchor=LEFT);

                // Lid screw receivers
                attach(TOP+FRONT+LEFT, norot=1) down(100) right(70) back(160) tube(id=120, wall=70, h=200,anchor=TOP+FRONT+LEFT);
                attach(TOP+BACK+LEFT, norot=1) down(100) right(70) fwd(160) tube(id=120, wall=70, h=200,anchor=TOP+BACK+LEFT);

                // Display facia
                if (group1)
                {
                    attach(TOP+FRONT, norot=1) down(20) back(1500) display_facia(l - 330, w + 110, rounding=100, anchor=BOT);
//                    attach(TOP+FRONT, norot=1) down(20) back(200)  fingerprintSensorFacia(d=886+100,rounding=50, anchor=BOT+FRONT);
                }
            }
            // Walls
            attach(BOT+FRONT, norot=1) rect_tube(size=[l + 270 + 200, 1200 + 500 + w + 170],
                 wall=100, h=350, anchor=TOP+FRONT, rounding=200, irounding=0)
            {
                // USB Connector
                tag("ct0_remove") right(5)
                attach(BOT+BACK+RIGHT, norot=1) left(400) up(135-20) fwd(50) cuboid([340, 100, 150], anchor=BOT+RIGHT)
                attach(BACK, norot=1) cuboid([475, 50, 250], anchor=BACK, rounding=50, edges="Y");
                // RPI Pico front right
                //attach(TOP+BACK, norot=1) right(100) cuboid([100, 500, 300], anchor=TOP+BACK);
            }

        }
    }
    attachable(anchor,spin,orient,size=[1000,1000,550])
    {
        down(100)
        up(550/2)
        case_top_();
        children();
    }
}

module buck_mount(anchor=CENTER,spin=0,orient=UP)
{
    l = model_5v_3v3_buck_length;
    w = model_5v_3v3_buck_width;
    h = model_5v_3v3_buck_height;
    module buck_mount_()
    {
        diff("bm_remove")
        cuboid([l + 70, w + 100, 200])
        {
            attach(LEFT+TOP, norot=1) cuboid([100, 200, 200], anchor=TOP+RIGHT);
            attach(RIGHT+TOP, norot=1) cuboid([100, 200, 200], anchor=TOP+LEFT);
            tag("bm_remove") 
            {
                attach(TOP, norot=1) cuboid([l + 70, w + 40, 60], anchor=TOP);
                attach(TOP, norot=1) cuboid([l - 100, w + 120, 200], anchor=TOP);
                attach(TOP, norot=1) cuboid([l + 120, w - 300, 200], anchor=TOP);
            }
        }
    }
    attachable(anchor,spin,orient,size=[l, w, h+30])
    {
        down(h/2)
        buck_mount_();
        children();
    }
}

module display_facia(x, y, rounding=200, anchor=CENTER, spin=0, orient=UP)
{
    path = rect([x-rounding, y-rounding]);
    r = round_corners(path, r = rounding);
    attachable(anchor, spin, orient, size=[x+rounding/2, y+rounding/2, rounding/2])
    {
        down(rounding/4)
        top_half(s = max(x, y) + 200)
        path_sweep(circle(d = rounding),r,closed=true);
        children();
    }
}

module fingerprintSensorFacia(d, rounding=200, anchor=CENTER, spin=0, orient=UP)
{
    path = circle(d=d);
    attachable(anchor, spin, orient, d=d,l=rounding/2)
    {
        top_half(s = d + 200)
        path_sweep(circle(d = 2*rounding),path,closed=true);
        children();
    }
}


module test()
{
    cyl(d=886, h=100)
    attach(TOP, norot=1) fingerprintSensorFacia(d=886+100,rounding=50, anchor=BOT);
}

module forViewing()
{
    l = ssd1306_128_32_length;
    w = ssd1306_128_32_width;
//    test();
//    display_facia(l - 450, w - 20, rounding=100);

//    rpi_support();
    *up(100)
    *model_5v_3v3_buck();
//    buck_mount();
//    fingerprint_sensor_mount();
//    fingerprint_sensor_cutout();
    case_top();
//    recolor("cyan") down(45) right(415) back(60)
//    model_rpi_pico(orient=DOWN, spin=-90);
//    back(540) up(120)
//    model_ssd1306_128_32();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
