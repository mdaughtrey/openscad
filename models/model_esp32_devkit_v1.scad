include <../BOSL2-master/std.scad>

model_esp32_devkit_v1_x = 2030;
model_esp32_devkit_v1_y = 1130;
model_esp32_devkit_v1_z = 62;

module model_esp32_devkit_v1(anchor=CENTER,spin=0,orient=UP)
{
    x = model_esp32_devkit_v1_x;
    y = model_esp32_devkit_v1_y;
    z = model_esp32_devkit_v1_z;
    rmtag="medv_remove";

    module model_esp32_devkit_v1_()
    {
        recolor("darkgray")
        diff(rmtag)
        cuboid([x, y, z])
        {
            tag(rmtag) position(BOT)
            down(1)
            grid_copies(size=[x-180, y-180], n=2)
                cyl(d=120, h=z+2, anchor=BOT);

            recolor("silver")
            {
                // USB Connector
                position(LEFT+TOP)  left(5) cuboid([225, 295, 80], anchor=LEFT+BOT);
//                position(LEFT+TOP) fwd(58+175) cuboid([292, 350, 130], anchor=LEFT+BOT);

                // Buttons
                position(LEFT+TOP+BACK) fwd(200)  left(5) cuboid([180, 120, 100], anchor=LEFT+BOT+BACK);
                position(LEFT+TOP+FRONT) back(200) cuboid([180, 120, 100], anchor=LEFT+BOT+FRONT);

                // WIFI Module
                recolor("lightgray")
                position(RIGHT+TOP) left(270) cuboid([700,620,125], anchor=RIGHT+BOT);
                // WIFI Antenna
                recolor("black")
                position(RIGHT+TOP) right(5) cuboid([246,700,30], anchor=RIGHT+BOT);

                // Pin holes
                tag(rmtag) position(BOT)
                down(1)
                grid_copies(size=[x-450, y-140], n=[15, 2])
                    cyl(d=30, h=z+2, anchor=BOT);

                // Pin Housing
                recolor("darkgrey")
                position(BOT+FRONT)
                cuboid([x-350, 100, 110], anchor=TOP+FRONT);
                recolor("darkgrey")
                position(BOT+BACK)
                cuboid([x-350, 100, 110], anchor=TOP+BACK);

                // Pins
                recolor("silver")
                position(BOT)
                grid_copies(size=[x-450, y-140], n=[15, 2])
                    cyl(d=30, h=330, anchor=TOP);

                // Components
//                position(TOP+LEFT) right(420)
//                cuboid([950, 664, 72], anchor=LEFT+BOT);
            }
        }
    }

    attachable(anchor,spin,orient,size=[x,y,z])
    {
        model_esp32_devkit_v1_();
        children();
    }
}
