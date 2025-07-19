include <../BOSL2-master/std.scad>

model_temp_humidity_sensor_x = 715;
model_temp_humidity_sensor_y = 545;
model_temp_humidity_sensor_z = 125;

module model_temp_humidity_sensor(anchor=CENTER,spin=0,orient=UP)
{
    module model_temp_humidity_sensor_()
    {
        rmtag = "2q35h";
        recolor("green")
        diff(rmtag)
        cuboid([model_temp_humidity_sensor_x, model_temp_humidity_sensor_y, 35])
        {
            // Cutouts
            tag(rmtag) position(LEFT+TOP+BACK) right(72) back(1) up(1) cuboid([92,77,37],anchor=LEFT+BACK+TOP);
            tag(rmtag) position(LEFT+TOP+FRONT) right(72) fwd(1) up(1) cuboid([92,77,37],anchor=LEFT+FRONT+TOP);
            tag(rmtag) position(RIGHT+TOP+BACK) back(1) right(1) up(1) cuboid([127,77,37],anchor=RIGHT+BACK+TOP);
            tag(rmtag) position(RIGHT+TOP+FRONT) fwd(1) right(1) up(1) cuboid([127,77,37],anchor=RIGHT+FRONT+TOP);

            // Holes
            tag(rmtag) position(LEFT+TOP) right(35) up(1) ycopies(n=4,spacing=75) cyl(d=40,h=37,anchor=TOP);

            // Humidity Sensor
            recolor("white")
            position(TOP+RIGHT) left(60) cuboid([80,100,45],anchor=BOT+RIGHT);

            // Chip
            recolor("black")
            position(BOT+RIGHT) left(160) cuboid([200,200,40],anchor=TOP+RIGHT);

        }
    }
    attachable(anchor,spin,orient,size=[model_temp_humidity_sensor_x,
        model_temp_humidity_sensor_y, model_temp_humidity_sensor_z])
    {
        model_temp_humidity_sensor_();
        children();
    }
}
