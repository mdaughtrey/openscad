model_esp32_s3_wroomX = 2250;
model_esp32_s3_wroomY = 1100;
model_esp32_s3_wroomZ = 270;


module model_esp32_s3_wroom(anchor=CENTER,spin=0,orient=UP)
{
    module model_esp32_s2_wroom_()
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
    attachable(anchor,spin,orient,size=[model_esp32_s3_wroomX, model_esp32_s3_wroomY, model_esp32_s3_wroomZ])
    {
        down(100)
        model_esp32_s2_wroom_();
        children();
    }
}
