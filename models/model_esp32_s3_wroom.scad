model_esp32_s3_wroom_dual_usbc_X = 2250;
model_esp32_s3_wroom_dual_usbc_Y = 1100;
model_esp32_s3_wroom_dual_usbc_Z = 270;

model_esp32_s3_wroom_devkit_v1_X = 2026;
model_esp32_s3_wroom_devkit_v1_Y = 1130;
model_esp32_s3_wroom_devkit_v1_Z = 185;


module model_esp32_s3_wroom_dual_usbc(anchor=CENTER,spin=0,orient=UP)
{
    module model_esp32_s3_wroom_dual_usbc_()
    {
        recolor("blue")
        cuboid([2250, 1100, 70])
        {
            recolor("silver")
            {
                // USB Connectors
                attach(LEFT+TOP, norot=1) back(58+175) cuboid([292, 350, 130], anchor=LEFT+BOT);
                attach(LEFT+TOP, norot=1) fwd(58+175) cuboid([292, 350, 130], anchor=LEFT+BOT);
                // WIFI Module
                recolor("lightgray")
                attach(RIGHT+TOP, norot=1) cuboid([700,620,125], anchor=RIGHT+BOT);
                // WIFI Antenna
                recolor("black")
                attach(RIGHT+TOP, norot=1) cuboid([246,700,30], anchor=LEFT+BOT);
                // Components
                attach(TOP+LEFT, norot=1) right(420)
                cuboid([950, 664, 72], anchor=LEFT+BOT);
                
            }
        }
    }
    attachable(anchor,spin,orient,size=[model_esp32_s3_wroom_dual_usbc_X,
        model_esp32_s3_wroom_dual_usbc_Y,
        model_esp32_s3_wroom_dual_usbc_Z])
    {
        down(100)
        model_esp32_s3_wroom_dual_usbc_();
        children();
    }
}

module model_esp32_s3_wroom_devkit_v1(anchor=CENTER,spin=0,orient=UP)
{
    module model_esp32_s3_wroom_devkit_v1_()
    {
        removetag="asdf_remove";
        recolor("blue")
        diff(removetag)
        cuboid([model_esp32_s3_wroom_devkit_v1_X, model_esp32_s3_wroom_devkit_v1_Y, 60], anchor=BOT)
        {
            tag(removetag) attach(BOT, norot=1)
            grid_copies(size=[
                model_esp32_s3_wroom_devkit_v1_X-200,
                model_esp32_s3_wroom_devkit_v1_Y-220],
                n=2) cyl(d=120,h=61,anchor=BOT);
            recolor("silver")
            {
                // USB Connector
                attach(LEFT+TOP, norot=1) cuboid([220, 290, 100], anchor=LEFT+BOT);
                // WIFI Module
                recolor("lightgray")
                attach(RIGHT+TOP, norot=1) left(280) cuboid([700,620,125], anchor=RIGHT+BOT);
                // WIFI Antenna
                *recolor("black")
                attach(RIGHT+TOP, norot=1) cuboid([246,700,30], anchor=LEFT+BOT);
                // Components
                *attach(TOP+LEFT, norot=1) right(420)
                cuboid([950, 664, 72], anchor=LEFT+BOT);
                
            }
        }
    }
    attachable(anchor,spin,orient,size=[model_esp32_s3_wroom_devkit_v1_X,
        model_esp32_s3_wroom_devkit_v1_Y, model_esp32_s3_wroom_devkit_v1_Z])
    {
        down(model_esp32_s3_wroom_devkit_v1_Z/2)
        model_esp32_s3_wroom_devkit_v1_();
        children();
    }
}
