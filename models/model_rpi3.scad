ViewScale = [0.0254, 0.0254, 0.0254];
include <../BOSL2-master/std.scad>

rpi3_width=2201;
rpi3_length=3350;

module model_rpi3()
{
    hole_indent=140;
    recolor("green")
    diff()
    cuboid([rpi3_length,rpi3_width,55], rounding=90, edges="Z") {
        tag("remove") 
            attach(BOT,norot=1) left((rpi3_length-2280)/2-hole_indent) grid_copies([2280,rpi3_width-hole_indent*2]) cyl(d=100,h=65,anchor=BOT);
        tag("keep") {
            // Ethernet
            attach(RIGHT+FRONT+TOP,norot=1) recolor("silver") back(100) right(75) cuboid([838,626,536],anchor=BOT+RIGHT+FRONT)
            // USB 
            attach(BACK+BOT+RIGHT,norot=1) recolor("silver") back(170) cuboid([680,520,630],anchor=BOT+FRONT+RIGHT)
            attach(BACK+BOT+RIGHT,norot=1) recolor("silver") back(190) cuboid([680,520,630],anchor=BOT+FRONT+RIGHT);
            // Header
            attach(BACK+TOP+LEFT,norot=1) right(280) fwd(50) recolor("dimgray") cuboid([2000,200,360], anchor=BOT+BACK+LEFT);
            // Antenna
            attach(BACK+TOP+LEFT,norot=1) right(20) fwd(330) recolor("silver") cuboid([80,210,56], anchor=BOT+BACK+LEFT);
            // Display Connector
            attach(TOP+LEFT,norot=1) right(50) recolor("dimgray") cuboid([150,880,235], anchor=BOT+LEFT);
            // Inductors
            attach(FRONT+TOP+LEFT,norot=1) right(110) back(310) recolor("dimgray") cuboid([158,158,70], anchor=BOT+LEFT+FRONT);
            attach(FRONT+TOP+LEFT,norot=1) right(335) back(630) recolor("dimgray") cuboid([158,158,70], anchor=BOT+LEFT+FRONT);
            // Diode
            attach(FRONT+TOP+LEFT,norot=1) right(470) back(255) recolor("dimgray") cuboid([210,140,70], anchor=BOT+LEFT+FRONT);
            // Power Connector
            attach(FRONT+TOP+LEFT,norot=1) right(250) fwd(50) recolor("silver") cuboid([300,220,100], anchor=BOT+LEFT+FRONT);
            // CPU + heatsink
            attach(FRONT+TOP+LEFT,norot=1) right(770) back(970) recolor("black") cuboid([555,555,50], anchor=BOT+LEFT+FRONT)
            attach(TOP,norot=1) recolor("silver") cuboid([555,555,220], anchor=BOT);
            // I/O controller
            attach(FRONT+TOP+RIGHT,norot=1) left(800) back(1120) recolor("black") cuboid([370,370,50], anchor=BOT+RIGHT+FRONT)
            attach(TOP,norot=1) recolor("silver") cuboid([370,370,180], anchor=BOT);
            // HDMI
            attach(FRONT+TOP+LEFT,norot=1) right(960) fwd(50) recolor("silver") cuboid([590,450,250], anchor=BOT+LEFT+FRONT);
            // Camera Connector
            attach(FRONT+TOP+LEFT,norot=1) right(1725) back(10) recolor("dimgray") cuboid([150,880,235], anchor=BOT+LEFT+FRONT);
            // Audio Connector
            attach(FRONT+TOP+RIGHT,norot=1) left(1100) fwd(100) recolor("dimgray") cuboid([275,580,230], anchor=BOT+FRONT+RIGHT);
            // Micro SD socket and card
            attach(BOT+LEFT,norot=1) left(100) recolor("lightgray") cuboid([600,470,60], anchor=TOP+LEFT);
            // GPU and heatsink
            attach(BOT+LEFT+FRONT,norot=1) right(1480) back(1070) recolor("dimgray") cuboid([480,480,20], anchor=TOP+LEFT+FRONT)
            attach(BOT,norot=1)  recolor("silver") cuboid([480,480,50], anchor=TOP);

        }

    }
}

// module forViewing()
// {
//     model_rpi3();
// //    ethernet();
// }
// 
// module forPrinting()
// {
// }
// 
// scale(ViewScale)
// {
//     forViewing();
// }
