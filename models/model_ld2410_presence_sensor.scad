//ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>

model_ld2410_pcb_X = 870;
model_ld2410_pcb_Y = 630;
model_ld2410_Z = 122;

module model_ld2410_presence_sensor(anchor=CENTER,spin=0,orient=UP)
{
    module model_ld2410_presence_sensor_()
    {
        recolor("cornflowerblue")
        cuboid([model_ld2410_pcb_X, model_ld2410_pcb_Y, 65], rounding=50, edges="Z")
        {
            // Front Side
            // Chip 
            recolor("back") attach(TOP+FRONT, norot=1) back(100) cuboid([160, 160, 40], anchor=BOT+FRONT);
            // LED
            recolor("white") right(40) back(70) attach(TOP+FRONT+LEFT, norot=1)
                cuboid([130, 46, 25], anchor=BOT+LEFT+FRONT);

            // Back Side
            // Connector
            //attach(BOT+BACK, norot=1) cuboid([520, 100, 100], anchor=TOP+BACK);
            recolor("grey")
            attach(BOT+LEFT+FRONT, norot=1) right(110) back(58) cuboid([65,170,20], anchor=TOP+LEFT+FRONT);
            recolor("black")
            attach(BOT+LEFT+FRONT, norot=1) right(210) back(35) cuboid([80,100,40], anchor=TOP+LEFT+FRONT);

            recolor("grey")
            attach(BOT+LEFT+FRONT, norot=1) right(450) back(5) cuboid([150,150,20], anchor=TOP+LEFT+FRONT);
            recolor("black")
            attach(BOT+RIGHT+FRONT, norot=1) left(120) back(135) cuboid([140,140,40], anchor=TOP+RIGHT+FRONT);

            recolor("black")
            attach(BOT+RIGHT+BACK, norot=1) left(40) fwd(120) cuboid([180,155,80], anchor=TOP+RIGHT+BACK);

            



        }
    }
    attachable(anchor,spin,orient,size=[model_ld2410_pcb_X, model_ld2410_pcb_Y, model_ld2410_Z])
    {
        model_ld2410_presence_sensor_();
        children();
    }
}
