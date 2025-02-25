//ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>

module model_ld2410_presence_sensor(anchor=CENTER,spin=0,orient=UP)
{
    module model_ld2410_presence_sensor_()
    {
        cuboid([870, 630, 65], rounding=50, edges="Z")
        {
            // Chip on the front
            attach(TOP+FRONT, norot=1) back(100) cuboid([160, 160, 40], anchor=BOT+FRONT);
            // Connector
            attach(BOT+BACK, norot=1) cuboid([520, 100, 100], anchor=TOP+BACK);
        }
    }
    attachable(anchor,spin,orient,size=[100,100,100])
    {
        model_ld2410_presence_sensor_();
        children();
    }
}
