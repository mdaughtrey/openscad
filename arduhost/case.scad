ViewScale = [0.0254, 0.0254, 0.0254];
include <../BOSL2-master/std.scad>
include <../models/model_rpi3.scad>
include <../models/model_ups_board.scad>
include <../models/model_lionpack.scad>
include <../models/model_fan_caizhu_1inch.scad>
include <../models/model_ssd1306.scad>
include <../models/model_slideswitch.scad>
include <../models/model_pushbuttons.scad>
include <../models/veroboard.scad>

model=1;

module panel_usb_ethernet()
{
    slop=20;
    diff()
    cuboid([100,3000,1500]) {
        tag("remove") {
            // Ethernet
            attach(FRONT,norot=1) back(700-slop) cuboid([838,626+slop*2,536+slop*2])
                // USB 
                attach(BACK+BOT+RIGHT,norot=1)
                back(170-slop*2)
                cuboid([680,520+slop*2,630+slop*2],anchor=BOT+FRONT+RIGHT)
                    attach(BACK+BOT+RIGHT,norot=1)
                    back(190-slop*2)
                    cuboid([680,520+slop*2,630+slop*2],anchor=BOT+FRONT+RIGHT);
        }
    }
}

module panel_power_hdmi_audio()
{
    slop=20;
    diff()
    cuboid([4000,100,1500]) {
        tag("remove") {
        // Power Connector
        attach(FRONT, norot=1) fwd(10) left(1000-slop) cuboid([300+slop*2,220,100+slop*2],anchor=FRONT)
            // HDMI
            attach(FRONT+BOT+RIGHT,norot=1)
            right(410-slop*2)
            cuboid([590+slop*2,450,250+slop*2], anchor=BOT+LEFT+FRONT)

                // Audio Connector
                attach(FRONT+BOT+RIGHT,norot=1) 
                right(700-275-slop*2)
                fwd(50)
                cuboid([275+slop*2,580,230+slop*2], anchor=BOT+FRONT+LEFT);
        }
    }
}

module panel_fan_powerswitch_reset()
{
    $fn=96;
    recolor("dimgray")
    model_fan_caizhu_1inch() {
        attach(LEFT,norot=1) left(300) zrot(90) model_slideswitch(anchor=RIGHT);
        attach(RIGHT,norot=1) right(400)  model_pushbutton_base(shaftl=100,anchor=LEFT) {
            attach(TOP) up(150) recolor("red") model_buttontop();
            attach(CENTER) down(100) model_veroboard(holesX=5,holesY=5);
        }
    }

    *diff()
    cuboid([1100,1100,510], rounding=100,edges="Z") {
        tag("remove") {
            attach(BOT) cuboid([1020,1020,410], rounding=100,edges="Z")
            attach(TOP) cylinder(d=940,h=150);
        }
        tag("keep") {
            attach(TOP) cylinder(d=640,h=100,anchor=TOP);
        }
     }
}

module case()
{
}

module forViewing0()
{
    if (model) {
        zrot(180) model_ups_board();
        up(900) xrot(180) model_rpi3();
        up(200) back(500) model_lionpack_120mah();
        up(500) left(2200) yrot(90) model_fan_caizhu_1inch();
        up(1200) right(1000) back(300) zrot(180)  model_ssd1306_128_64();
        left(1800) fwd(700) up(400) yrot(-90)  model_slideswitch();
        left(1800) back(800) up(400) yrot(-90) model_pushbutton_base(shaftl=200)
        attach(TOP) up(200) recolor("red") model_buttontop();
    }
}

module forViewing()
{
    panel_fan_powerswitch_reset();
//    right(1700) up(300) back(130) panel_usb_ethernet();
//    left(290) up(80)  fwd(1100) panel_power_hdmi_audio();
//    if (model) {
//        model_rpi3();
//    }
//    attach(BACK+TOP,norot=1)  model_ups_board(anchor=BACK+BOT);
//    attach(TOP+FRONT+RIGHT,norot=1) model_ups_board(anchor=RIGHT+BACK+TOP);
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
