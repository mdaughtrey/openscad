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
include <../models/model_latching_pushbutton.scad>

$fn=96;

model=1;
endcap_height = 1800;
endcap_width = 3000;
endcap_depth = 350;
case_length=ups_length-50;
support_wall = 50;
board_diff_len = abs(rpi3_length-ups_length);

holespacing = [endcap_width-490,endcap_height-490];
skirtxy = [endcap_width,endcap_height];
casebodyxy = [endcap_width-220,endcap_height-220];
casebodytabxy = [endcap_width-440,endcap_height-440];


module panel_usb_ethernet(anchor=CENTER,spin=0,orient=UP)
{
    module panel_usb_ethernet_()
    {
        slop=20;
        diff()
        cuboid([100,endcap_width,endcap_height],rounding=200,edges="X") {
            // case body screw holes
            tag("remove") attach(RIGHT) 
            grid_copies(n=2,size=holespacing) {
                up(1) cyl(l=65,d2=150,d1=80,anchor=TOP)
                attach(BOT) cyl(d=80,l=100);
            }

            tag("remove") {
                down(100) back(130+slop)
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
                attach(TOP,norot=1) left(1) down(275) cuboid([105,480,250],rounding=50,edges="X",anchor=TOP);
            }
            // Skirt
            attach(LEFT,norot=1) rect_tube(h=endcap_depth-100,size=skirtxy,wall=100,orient=RIGHT,spin=90,rounding=200,anchor=TOP);
            // Inner
            attach(LEFT)
             rect_tube(h=100,size=casebodytabxy,wall=50,rounding=50,anchor=BOT)
             attach(BOT) {
                 tag("remove") 
                     grid_copies(n=2,size=[endcap_width-500,endcap_height-500])
                     cuboid([200,200,102],anchor=TOP);
                 tag("remove") 
                     attach(LEFT,norot=1)
                     cuboid([60,casebodytabxy[1],100],anchor=LEFT+TOP);
             }
             // Body indent barriers
             tag("keep") attach(LEFT+FRONT,norot=1) back(190) up(340)
             cuboid([endcap_depth-100,100,230],anchor=RIGHT+FRONT);

             tag("keep") attach(LEFT+FRONT,norot=1) back(190) down(200) 
             cuboid([endcap_depth-100,100,430],anchor=RIGHT+FRONT);
        }
        // UPS Board Support
        recolor("Cornsilk")
        up(580) left(49)
        pcb_support(ups_width,85,orient=LEFT,spin=90,anchor=BOT);
    }
    attachable(anchor,spin,orient,size=[100,endcap_width,endcap_height])
    {
        right(endcap_depth/2-50)
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
//        cuboid([740,620,100],anchor=BOT) {
//            tag("remove") {
//                //cuboid([270,270,101]);
//                attach(TOP+BACK,norot=1) fwd(230/2) cuboid([270,270,101],anchor=TOP+BACK);
//            }
            if (model) {
                tag("keep") {
                    attach(TOP+BACK,norot=1) down(50) fwd(230/2+20) model_pushbutton_base(shaftl=100,anchor=BACK)  {
                     attach(TOP,norot=1) up(150) recolor("red") model_buttontop();
                    attach(CENTER,norot=1) down(85) model_veroboard(holesX=5,holesY=5);
                    }
                }
            }
            *tag("keep") {
                attach(TOP,norot=1) back(52) tube(id=350,wall=50,h=350,anchor=BOT);
            }
            *attach(BOT, norot=1) cuboid([740,620,70],anchor=TOP) {
                 tag("remove") attach(BACK+BOT,norot=1) cuboid([540,540,70],anchor=BOT+BACK);
                attach(BOT,norot=1) cuboid([740,620,100],anchor=TOP)
                    tag("remove") attach(BOT+BACK,norot=1) fwd(90) down(1) cuboid([350,350,103],anchor=BOT+BACK);
            }
//        }
    }
    attachable(anchor,spin,orient,size=[740,620,450])
    {
        reset_button_();
        children();
    }
}

//module powerswitch(anchor=CENTER,spin=0,orient=UP)
//{
//    module powerswitch_()
//    {
//        diff()
//        cuboid([455,237,150]) {
//            tag("remove") {
//                attach(BOT,norot=1) cuboid([375,157,100], anchor=BOT)
//                attach(TOP,norot=1) cuboid([160,75,51],anchor=BOT);
//            }
//        }
//
//    //            square([355, 137], center = true);
//    //            square([150, 65], center = true);
//        if (model) { down(120) model_slideswitch(); }
//    }
//    attachable(anchor,spin,orient,size=[455,237,150])
//    {
//        powerswitch_();
//        children();
//    }
//}

module pcb_support(boardW,boardT,tabH=200,lift=1,anchor=CENTER,spin=0,orient=UP,wall=50)
{
    module pcb_support_()
    {
        diff()
        cuboid([boardW+wall*2+20,boardT+wall*2+20,lift],rounding=wall,edges="Z")  {
        attach(TOP,norot=1)
            rect_tube(h=tabH,isize=[boardW+20,boardT+20],wall=wall,rounding=wall,anchor=BOT);
        tag("remove") attach(BOT,norot=1)
            cuboid([boardW-400,boardT+20+wall*2,tabH+lift],anchor=BOT);
        }
    }
    attachable(anchor,spin,orient,size=[boardW+200,250,200+lift])
    {
        down(100)
        pcb_support_();
        children();
    }
}

module fan_housing(anchor=CENTER,spin=0,orient=UP)
{
    module fan_housing_(anchor,spin,orient)
    {
        diff()
        cuboid([1080,1080,50], rounding=100,edges="Z") {
            attach(TOP) cuboid([1100,1100,510], rounding=100,edges="Z",anchor=BOT)  {
                tag("keep") {
                    attach(TOP,norot=1) cylinder(d=640,h=50,anchor=TOP);
                    attach(TOP) zrot_copies(n=3,d=790) cuboid([200,80,50],anchor=TOP);
                }
            }
            tag("remove") attach(BOT,norot=1) cuboid([1020,1020,490], rounding=100,edges="Z",anchor=BOT)  {
                attach(TOP,norot=1) cuboid([1000,1000,20],rounding=100,edges="Z",anchor=BOT)
                attach(TOP,norot=1) cylinder(d=940,h=50,anchor=BOT);
            }
         }
    }
    attachable(anchor,spin,orient,size=[1100,100,560])
    {
        down(280-25)
        fan_housing_(anchor,spin,orient);
        children();
    }
}

module reset_button_surround(anchor=CENTER,spin=0,orient=UP)
{
    module reset_button_surround_(anchor,spin,orient)
    {
        tube(id=380,wall=30,h=50)
        attach(TOP,norot=1)
       tube(id=380,wall=50,h=300,anchor=BOT);
    }
    attachable(anchor,spin,orient,d=380,l=350)
    {
        down(175)
        reset_button_surround_();
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
            tag("remove") cuboid([1020,1020,480], rounding=100,edges="Z");
 //           attach(TOP,norot=1) fan_housing(anchor=BOT);

             // Cutout for SD card
             *tag("remove") fwd(625) attach(TOP,norot=1) cuboid([500,100,100],anchor=TOP);
             // case body screw holes
             tag("remove") attach(TOP,norot=1) 
             grid_copies(n=2,size=holespacing) {
                 up(1) cyl(l=65,d2=150,d1=80,anchor=TOP)
                 attach(BOT) cyl(d=80,l=100);
             }
             // Cutout for power switch
             right(800) 
                tag("remove") attach(TOP,norot=1) cyl(d=282,h=100,anchor=TOP);

             // Reset Button
             tag("remove") attach(TOP+LEFT,norot=1) right(450)
                cuboid([270,270,101],anchor=TOP);
                // Reset button surround
//                tag("remove") attach(TOP+LEFT,norot=1) right(45) cyl(d=420,h=100,anchor=TOP);
//             tag("keep") attach(TOP+LEFT,norot=1) reset_button_surround(anchor=BOT);
//             tag("keep") attach(TOP+LEFT,norot=1) right(450) tube(id=380,wall=50,h=350,anchor=BOT);
             *attach(BOT+LEFT,norot=1) right(450) rect_tube(h=100,isize=[370,520],wall=30,anchor=TOP);

            // Skirt
            attach(BOT,norot=1) rect_tube(h=endcap_depth-100,size=skirtxy,wall=100,rounding=200,anchor=TOP);

            // Inner
            attach(BOT,norot=1)
             rect_tube(h=100,size=casebodytabxy,wall=50,rounding=50,anchor=TOP)
             attach(BOT) {
                 tag("remove") {
                     grid_copies(n=2,size=[endcap_width-500,endcap_height-500])
                     cuboid([200,200,102],anchor=TOP);
                     cuboid([casebodytabxy[0]-800,casebodytabxy[1],100],anchor=TOP);
                     cuboid([casebodytabxy[0],casebodytabxy[1]-800,100],anchor=TOP);
                 }
                 tag("remove") 
                     attach(LEFT,norot=1)
                     cuboid([60,casebodytabxy[1],100],anchor=LEFT+TOP);
             }
             // Body indent barriers
             tag("keep") attach(RIGHT+BOT,norot=1) left(190) back(340)
             cuboid([100,230,endcap_depth-200],anchor=RIGHT+TOP);

             tag("keep") attach(RIGHT+BOT,norot=1) left(190) fwd(200) 
             cuboid([100,480,endcap_depth-200],anchor=RIGHT+TOP);
             // Screw mounts for reset button backstop
             tag("keep") attach(BOT,norot=1) left(650) fwd(100) tube(h=200,id=60,od=150,anchor=TOP)
                left(400) back(450) tube(h=200,id=60,od=150);
             // Screw mounts for power switch backstop
             tag("keep") attach(BOT,norot=1) right(1100) fwd(150) tube(h=200,id=60,od=150,anchor=TOP)
                left(450) back(400) tube(h=200,id=60,od=150);
        }
        // UPS Board Support
        back(575) down(50) zflip() recolor("Cornsilk")
        pcb_support(ups_width,65,anchor=BOT);

        // RPI Board support
        fwd(390) down(49) zflip() recolor("Cornsilk")
        pcb_support(rpi3_width,85,lift=board_diff_len-50,tabH=100,anchor=BOT);
    }
    attachable(anchor,spin,orient,size=[endcap_width,endcap_height,endcap_depth+510])
    {
        down(80)
        panel_fan_powerswitch_reset_();
        children();
    }
}

module panel_oled_display(anchor=CENTER,spin=0,orient=UP)
{
    module panel_oled_display_() {
        diff()
        cuboid([ssd1306_128_64_length+100,ssd1306_128_64_width+100,150])  {
            tag("remove") {
                attach(BOT,norot=1) cuboid([ssd1306_128_64_length+30,ssd1306_128_64_width+30,101],anchor=BOT);
                attach(FRONT+TOP,norot=1) back(220) up(1) cuboid([1050+30,757+30,62], anchor=TOP+FRONT);
            }
            attach(TOP,norot=1)
            rect_tube(h=50,isize=[ssd1306_128_64_length,ssd1306_128_64_width],wall=150,rounding=100,anchor=TOP);
        }
    }
    attachable(anchor,spin,orient,size=[ssd1306_128_64_length+150,ssd1306_128_64_width+150,150]) {
        panel_oled_display_();
        children();
    }
}

module case_body(anchor=CENTER,spin=0,orient=UP)
{
    $fn=96;
    module case_body_()
    {
        diff()
         rect_tube(h=case_length,size=casebodyxy,wall=100,rounding=100)  {
         tag("remove") {
             attach(RIGHT,norot=1,overlap=1) cuboid([200,1060,case_length+5],anchor=RIGHT);
             *attach(BACK) cuboid([ssd1306_128_64_length+20,ssd1306_128_64_width+20,100], anchor=TOP);
            attach(BACK) cuboid([ssd1306_128_64_length+170,ssd1306_128_64_width+180,100],anchor=TOP);
         }
         // Display mount
         *attach(BACK) cuboid([ssd1306_128_64_length+100,ssd1306_128_64_width+100,150], rounding=100,edges="Z",anchor=BOT)
             tag("remove") {
                attach(BOT,norot=1) cuboid([ssd1306_128_64_length+30,ssd1306_128_64_width+30,101],anchor=BOT);
                attach(FRONT+TOP,norot=1) back(220) up(1) cuboid([1050+30,757+30,62], anchor=TOP+FRONT);
            }
         }
         // Screw mounts
         attach(TOP,norot=1) 
         grid_copies(n=2,size=holespacing)
         tube(h=case_length,id=60,od=150);

    }
    attachable(anchor,spin,orient,size=[2760,1260,case_length]) {
        down(case_length/2)
        case_body_();
        children();
    }
}

module body_indent(anchor=CENTER,spin=0,orient=UP)
{
    slop=20;
    depth=220+70;
    module body_indent_() {
        diff()
        cuboid([case_length,1040,depth]) {
            tag("remove") {
            attach(TOP+BACK+RIGHT,norot=1) fwd(70) up(1) left(300-85)
            cuboid([2400,600,depth-50],rounding=100,edges="Z",anchor=TOP+BACK+RIGHT);
            attach(BOT+BACK+RIGHT,norot=1) down(1) right(1+50) back(1)
            cuboid([250,600,depth-50],anchor=BOT+BACK+RIGHT);
            attach(BOT+FRONT,norot=1) back(50) down(1)
            cuboid([case_length+400,250,depth-50],anchor=BOT+FRONT);
            attach(BOT+BACK+LEFT,norot=1) fwd(70) down(1) left(50)
            cuboid([700,500,depth-50],anchor=BOT+BACK+LEFT);
            // Connector cutouts
            attach(BACK+RIGHT,norot=1) left(700+35-10) fwd(140) down(50)
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
            // Vents
            attach(TOP+FRONT,norot=1) back(150)
            xcopies(l=case_length-400,n=8) cyl(h=100,d=100,anchor=TOP);

            }
        }
    }
    attachable(anchor,spin,orient,size=[case_length,1040,depth])
    {
        body_indent_();
        children();
    }
}

module viewAll()
{
     panel_usb_ethernet()
     {
          attach(BOT,norot=1)  right(85) up(540) model_rpi3(anchor=RIGHT);
          attach(BOT) left(50) down(1475)  model_ups_board(anchor=LEFT);
          case_body(orient=RIGHT,anchor=TOP,spin=-90) {
              *attach(BOT) down(50+endcap_depth-100) zrot(180) panel_fan_powerswitch_reset(anchor=BOT);
              *attach(BACK) panel_oled_display(anchor=TOP);
          }
          attach(FRONT)
          down(100) zrot(180) body_indent(anchor=LEFT+TOP);
     }
}

module forViewing()
{
//    reset_button_surround();
//    fan_housing();
    panel_fan_powerswitch_reset();
    left(1050) fwd(60) down(250)
    reset_button();
    right(800) down(200)
    model_latching_pushbutton();

//    viewAll();
//    panel_oled_display();
//    case_body()
//    attach(BACK) up(200) panel_oled_display(anchor=BOT);
}

module forPrinting()
{
//    panel_fan_powerswitch_reset();
//      panel_usb_ethernet();
   case_body();
// body_indent();
//    panel_oled_display();
}

scale(ViewScale)
{
    forViewing();
//    forPrinting();
}
