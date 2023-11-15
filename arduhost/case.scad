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

model=0;

module panel_usb_ethernet(anchor=CENTER,spin=0,orient=UP)
{
    module panel_usb_ethernet_()
    {
        slop=20;
        diff()
        cuboid([100,3000,1500],rounding=200,edges="X") {
            tag("remove") {
                down(100) back(150)
                // Ethernet
                attach(FRONT,norot=1) back(680-slop) cuboid([838,626+slop*2,536+slop*2])
                    // USB 
                    attach(BACK+BOT+RIGHT,norot=1)
                    back(170-slop*2)
                    cuboid([680,520+slop*2,630+slop*2],anchor=BOT+FRONT+RIGHT)
                        attach(BACK+BOT+RIGHT,norot=1)
                        back(190-slop*2)
                        cuboid([680,520+slop*2,630+slop*2],anchor=BOT+FRONT+RIGHT);
                // Mini USB
                attach(TOP,norot=1) down(200) cuboid([100,300+180,90+160],rounding=50,edges="X",anchor=TOP);
            }
            // UPS Board support
            attach(TOP+LEFT,norot=1) down(200) cuboid([250,ups_width+200,165],rounding=50,edges="X",anchor=TOP+RIGHT)
                tag("remove") attach(LEFT,norot=1) cuboid([251,ups_width+30,85],anchor=LEFT)
                    attach(RIGHT,norot=1) cuboid([226+40,300+180,170],anchor=RIGHT);
        }
    }
    attachable(anchor,spin,orient,size=[100,3000,1500])
    {
        panel_usb_ethernet_();
        children();
    }
}

module panel_power_hdmi_audio(anchor=CENTER,spin=0,orient=UP)
{
    module panel_power_hdmi_audio_()
    {
        slop=20;
        diff()
        cuboid([4000,100,1500]) {
            tag("remove") {
            // Power Connector
            attach(FRONT, norot=1) down(500) fwd(10) left(1000-slop) cuboid([300+slop*2,220,100+slop*2],anchor=FRONT)
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
    attachable(anchor,spin,orient,size=[4000,100,1500])
    {
        panel_power_hdmi_audio_();
        children();
    }
}

module fanmount(anchor=CENTER,spin=0,orient=UP)
{
    $fn=96;
    module fanmount_()
    {
        if (model) { 
            down(50)
            recolor("dimgray")
            model_fan_caizhu_1inch(); // {
        }

        diff()
        cuboid([1100,1100,510], rounding=100,edges="Z") {
            tag("remove") {
                attach(BOT,norot=1) cuboid([1020,1020,410], rounding=100,edges="Z",anchor=BOT)
                attach(TOP,norot=1,overlap=1) cylinder(d=940,h=150);
            }
            tag("keep") {
                attach(TOP,norot=1) cylinder(d=640,h=100,anchor=TOP);
                attach(TOP) zrot_copies(n=3,d=790) cuboid([200,80,100],anchor=TOP);
            }
         }
    }
     attachable(anchor,spin,orient,size=[1100,1100,510])
     {
         fanmount_();
         children();
     }
}

module reset_button_backstop(anchor=CENTER,spin=0,orient=UP)
{
    attachable(anchor,spin,orient,size=[750,620,170]) {
        diff()
        cuboid([740,620,170]) {
            tag("remove") attach(BACK+BOT,norot=1)
                 fwd(90) down(1) cuboid([350,350,103],anchor=BOT+BACK)
                 attach(TOP+BACK,norot=1) cuboid([540,540,70],anchor=BOT+BACK);
//             tag("remove") attach(BACK+BOT,norot=1) cuboid([540,540,70],anchor=BOT+BACK);
//            attach(BOT,norot=1) cuboid([740,620,100],anchor=TOP)
//                tag("remove") attach(BOT+BACK,norot=1) fwd(90) down(1) cuboid([350,350,103],anchor=BOT+BACK);
        }
        children();
    }
}

module reset_button(anchor=CENTER,spin=0,orient=UP)
{
    $fn=96;
    module reset_button_() {
        diff()
        cuboid([740,620,100],anchor=BOT) {
            tag("remove") {
                //cuboid([270,270,101]);
                attach(TOP+BACK,norot=1) fwd(230/2) cuboid([270,270,101],anchor=TOP+BACK);
            }
            if (model) {
                tag("keep") {
                    attach(TOP+BACK,norot=1) down(50) fwd(230/2+20) model_pushbutton_base(shaftl=100,anchor=BACK)  {
                     attach(TOP,norot=1) up(150) recolor("red") model_buttontop();
                    attach(CENTER,norot=1) down(85) model_veroboard(holesX=5,holesY=5);
                    }
                }
            }
            tag("keep") {
                attach(TOP,norot=1) back(52) tube(id=350,wall=50,h=350,anchor=BOT);
            }
            *attach(BOT, norot=1) cuboid([740,620,70],anchor=TOP) {
                 tag("remove") attach(BACK+BOT,norot=1) cuboid([540,540,70],anchor=BOT+BACK);
                attach(BOT,norot=1) cuboid([740,620,100],anchor=TOP)
                    tag("remove") attach(BOT+BACK,norot=1) fwd(90) down(1) cuboid([350,350,103],anchor=BOT+BACK);
            }
        }
    }
    attachable(anchor,spin,orient,size=[740,620,450])
    {
        reset_button_();
        children();
    }
}

module powerswitch(anchor=CENTER,spin=0,orient=UP)
{
    module powerswitch_()
    {
        diff()
        cuboid([455,237,150]) {
            tag("remove") {
                attach(BOT,norot=1) cuboid([375,157,100], anchor=BOT)
                attach(TOP,norot=1) cuboid([160,75,51],anchor=BOT);
            }
        }

    //            square([355, 137], center = true);
    //            square([150, 65], center = true);
        if (model) { down(120) model_slideswitch(); }
    }
    attachable(anchor,spin,orient,size=[455,237,150])
    {
        powerswitch_();
        children();
    }
}


module panel_fan_powerswitch_reset()
{
    $fn=96;
    diff() 
    cuboid([3000,1500,100],rounding=200,edges="Z") {
        tag("remove") cuboid([1020,1020,410], rounding=100,edges="Z");
        attach(TOP,norot=1)
        cuboid([1100,1100,510], rounding=100,edges="Z",anchor=BOT) {
            tag("remove") {
                attach(BOT,norot=1) cuboid([1020,1020,410], rounding=100,edges="Z",anchor=BOT)
                attach(TOP,norot=1,overlap=1) cylinder(d=940,h=150);
            }
            tag("keep") {
                attach(TOP,norot=1) cylinder(d=640,h=100,anchor=TOP);
                attach(TOP) zrot_copies(n=3,d=790) cuboid([200,80,100],anchor=TOP);
            }
         }
         // Cutout for power switch
         tag("remove") attach(TOP+RIGHT,norot=1) left(400) cuboid([75,160,50],anchor=TOP)
            attach(BOT,norot=1) cuboid([157,375,100], anchor=TOP);

//          attach(RIGHT,norot=1) left(300) cuboid([237,455,100],anchor=RIGHT)
//          attach(TOP,norot=1) #cuboid([237,455,150],anchor=TOP) {
//              tag("remove") {
//                 attach(BOT,norot=1) cuboid([157,375,100], anchor=BOT)
//                 attach(TOP,norot=1) cuboid([75,160,51],anchor=BOT);
//              }
//          }
    }


    *fanmount() {
        attach(LEFT+BOT,norot=1) powerswitch(spin=90,anchor=FRONT+BOT);
        attach(RIGHT+BOT,norot=1) reset_button(anchor=LEFT);
    }
    
}

module panel_oled_display()
{
    diff()
    cuboid([ssd1306_128_64_length+100,ssd1306_128_64_width+100,150])  {
        tag("remove") {
            attach(BOT,norot=1) cuboid([ssd1306_128_64_length+30,ssd1306_128_64_width+30,101],anchor=BOT);
            attach(FRONT+TOP,norot=1) back(220) up(1) cuboid([1050+30,757+30,62], anchor=TOP+FRONT);
        }
    }

//    model_ssd1306_128_64();
}


module case()
{
}

module forViewing0()
{
    *model_ups_board() {
        attach(LEFT,norot=1) down(280) panel_usb_ethernet(anchor=TOP+LEFT,orient=DOWN)
        attach(BOT+LEFT, norot=1) up(350) model_rpi3(anchor=RIGHT);
        attach(RIGHT,norot=1) down(280) cuboid([100,3000,1500],rounding=200,edges="X",anchor=BOT+LEFT);
    }
    panel_fan_powerswitch_reset();
//        panel_usb_ethernet();

//        up(900) xrot(180) model_rpi3();
//        up(200) back(500) model_lionpack_120mah();
//        up(500) left(2200) yrot(90) model_fan_caizhu_1inch();
//        up(1200) right(1000) back(300) zrot(180)  model_ssd1306_128_64();
//        left(1800) fwd(700) up(400) yrot(-90)  model_slideswitch();
//        left(1800) back(800) up(400) yrot(-90) model_pushbutton_base(shaftl=200)
//        attach(TOP) up(200) recolor("red") model_buttontop();
//    }
}

module forViewing()
{
    forViewing0();
//    up(1100/2) left(2500) yrot(-90) zrot(-90) panel_fan_powerswitch_reset();
//    right(1750) up(500) xrot(180) panel_usb_ethernet();
//    left(300) down(450) back(1150) xrot(180) panel_power_hdmi_audio(anchor=TOP);
//    back(400) right(800) up(1200) panel_oled_display();
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
