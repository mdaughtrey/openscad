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
endcap_height = 1800;
endcap_width = 3000;
endcap_depth = 350;
case_length=3500;

module panel_usb_ethernet(anchor=CENTER,spin=0,orient=UP)
{
    module panel_usb_ethernet_()
    {
        slop=20;
        diff()
        cuboid([100,endcap_width,endcap_height],rounding=200,edges="X") {
            // case body screw holes
            tag("remove") attach(RIGHT) 
            grid_copies(n=2,size=[endcap_width-490,endcap_height-490])
            cyl(h=120,d=100,anchor=TOP);
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
                attach(TOP,norot=1) left(1) down(350) cuboid([105,480,250],rounding=50,edges="X",anchor=TOP);
            }
            // Skirt
            attach(LEFT,norot=1) rect_tube(h=endcap_depth-100,size=[endcap_width,endcap_height],wall=100,orient=RIGHT,spin=90,rounding=200,anchor=TOP);
            // UPS Board support
            attach(LEFT+TOP,norot=1) down(350) 
                cuboid([250,ups_width+200,165],rounding=50,edges="X",anchor=RIGHT+TOP)
                tag("remove") attach(LEFT,norot=1) left(2) cuboid([252,ups_width+30,85],anchor=LEFT)
                    attach(RIGHT,norot=1) cuboid([266,480,170],anchor=RIGHT);
        }
    }
    attachable(anchor,spin,orient,size=[100,endcap_width,endcap_height])
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
        cuboid([rpi3_length,rpi3_height,50]) {
            tag("remove") {
            // Power Connector
            attach(BOT+LEFT,norot=1,overlap=1)
            right(250-slop/2)
            fwd(55)
            cuboid([300+slop*2,100+slop*2,50], anchor=BOT+LEFT)
                // HDMI
                attach(BACK+BOT+RIGHT,norot=1)
                right(360)
                cuboid([590+slop*2,250+slop*2,50], anchor=BOT+LEFT+BACK)

                    // Audio Connector
                    attach(BACK+BOT+RIGHT,norot=1,overlap=1) 
                    right(380)
                    cuboid([275+slop*2,230+slop*2,100], anchor=BOT+BACK+LEFT);
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


module panel_fan_powerswitch_reset(anchor=CENTER,spin=0,orient=UP)
{
    $fn=96;
    module panel_fan_powerswitch_reset_()
    {
        diff() 
        cuboid([endcap_width,endcap_height,100],rounding=200,edges="Z") {
            tag("remove") cuboid([1020,1020,510], rounding=100,edges="Z");
            // case body screw holes
            tag("remove") attach(TOP,norot=1) 
            grid_copies(n=2,size=[endcap_width-490,endcap_height-490])
            cyl(h=120,d=100,anchor=TOP);

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
             left(700) {
                 tag("remove") attach(TOP+RIGHT,norot=1) cuboid([75,160,50],anchor=TOP)
                    attach(BOT,norot=1) cuboid([157,375,100], anchor=TOP);
                 attach(BOT+RIGHT,norot=1) cuboid([237,455,50], anchor=TOP);
                 attach(TOP+RIGHT,norot=1) rect_tube(h=100,isize=[237,455],wall=50,anchor=BOT);
             }

             // Reset Button
             tag("remove") attach(TOP+LEFT,norot=1) right(450)
                cuboid([270,270,101],anchor=TOP);
             tag("keep") attach(TOP+LEFT,norot=1) right(450) tube(id=380,wall=50,h=450,anchor=BOT);
             attach(BOT+LEFT,norot=1) right(450) rect_tube(h=100,isize=[370,520],wall=30,anchor=TOP);
             *attach(BOT+LEFT,norot=1) right(450) #cuboid([700,700,100],anchor=TOP,rounding=50,edges="Z")
                tag("remove") cuboid([520,520,100]);

            // Skirt
            attach(BOT,norot=1) rect_tube(h=endcap_depth-100,size=[endcap_width,endcap_height],wall=100,rounding=200,anchor=TOP);

            // UPS Board support
            attach(BOT,norot=1)  back(470)
                cuboid([ups_width+200,250,165],rounding=50,edges="Z",anchor=TOP)
                 tag("remove") attach(CENTER,norot=1) left(2) cuboid([ups_width+30,85,252])
                   attach(CENTER,norot=1) cuboid([1200,266,170]);

            // RPI Board support
            attach(BOT,norot=1)  fwd(400)
                cuboid([rpi3_width+200,250,350-100],rounding=50,edges="Z",anchor=TOP)
                 tag("remove") attach(CENTER,norot=1) down(200) left(2) cuboid([rpi3_width+30,85,452-100])
                   attach(CENTER,norot=1) up(100) cuboid([1700,266,370]);
        }
    }
    attachable(anchor,spin,orient,size=[endcap_width,endcap_height,1110])
    {
        panel_fan_powerswitch_reset_();
        children();
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
}

module case_body(anchor=CENTER,spin=0,orient=UP)
{
    $fn=96;
    module case_body_()
    {
        diff()
         rect_tube(h=case_length,size=[endcap_width-240,endcap_height-240],wall=100,rounding=100)  {
         tag("remove") {
             attach(RIGHT,norot=1,overlap=1) cuboid([200,1060,case_length+5],anchor=RIGHT);
             attach(BACK) cuboid([ssd1306_128_64_length+20,ssd1306_128_64_width+20,100], anchor=TOP);
         }
         // Display mount
         attach(BACK) cuboid([ssd1306_128_64_length+100,ssd1306_128_64_width+100,150], rounding=100,edges="Z",anchor=BOT)
             tag("remove") {
                attach(BOT,norot=1) cuboid([ssd1306_128_64_length+30,ssd1306_128_64_width+30,101],anchor=BOT);
                attach(FRONT+TOP,norot=1) back(220) up(1) cuboid([1050+30,757+30,62], anchor=TOP+FRONT);
            }
         }
         // Screw mounts
         attach(TOP,norot=1) 
         grid_copies(n=2,size=[endcap_width-490,endcap_height-490])
         tube(h=case_length,id=30,od=150);

    }
    attachable(anchor,spin,orient,size=[2760,1260,case_length])
    {
        down(case_length/2)
        case_body_();
        children();
    }
}

module body_indent(anchor=CENTER,spin=0,orient=UP)
{
    slop=20;
    depth=220;
    diff()
    cuboid([case_length,1040,depth]) {
        tag("remove") {
        attach(TOP+BACK+RIGHT,norot=1) fwd(70) up(1) left(300)
        cuboid([2400,400,depth-50],rounding=100,edges="Z",anchor=TOP+BACK+RIGHT);
        attach(BOT+BACK+RIGHT,norot=1) fwd(70) down(1) right(1)
        cuboid([250,500,depth-50],anchor=BOT+BACK+RIGHT);
        attach(BOT+FRONT,norot=1) back(50) down(1)
        cuboid([case_length+400,450,depth-50],rounding=100,edges="Z",anchor=BOT+FRONT);
        attach(BOT+BACK+LEFT,norot=1) fwd(70) down(1) left(50)
        cuboid([700,500,depth-50],anchor=BOT+BACK+LEFT);
        // Connector cutouts
        attach(BACK+RIGHT,norot=1) left(700) fwd(140) down(50)
        zrot(180)
        cuboid([300+slop,100+slop,220],anchor=RIGHT+FRONT)
            // HDMI
            attach(FRONT+BOT,norot=1)
            right(410+150+590/2)
            cuboid([590+slop,250+slop,450], anchor=BOT+FRONT)
                // Audio Connector
                attach(FRONT+BOT,norot=1) 
                right(700-275+590/2+275/2) 
                cuboid([275+slop,230+slop,580], anchor=BOT+FRONT);
        }
    }
}

module forViewing()
{
    model_ups_board() {
        attach(LEFT,norot=1) down(430) panel_usb_ethernet(anchor=TOP+LEFT,orient=DOWN)
        attach(BOT+LEFT, norot=1) up(500) model_rpi3(anchor=RIGHT);
        attach(RIGHT,norot=1) down(430) left(500) panel_fan_powerswitch_reset(anchor=BOT+BACK,spin=-90,orient=RIGHT)
        attach(BOT,norot=1) up(500) recolor("cornflowerblue") case_body(anchor=TOP)
        attach(RIGHT,norot=1) left(180) xrot(180) yrot(90) recolor("cyan") body_indent();
    }
    *recolor("cornflowerblue") case_body()
    attach(RIGHT,norot=1) left(70) xrot(180) yrot(90) recolor("cyan") body_indent();
}

module forPrinting()
{
//    panel_fan_powerswitch_reset();
//    panel_power_hdmi_audio();
//      panel_usb_ethernet();
//    case_body();
body_indent();
}

scale(ViewScale)
{
    forViewing();
//    forPrinting();
}
