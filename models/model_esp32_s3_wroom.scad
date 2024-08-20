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
                attach(LEFT+TOP, norot=1) back(300) cuboid([400, 400, 100], anchor=LEFT+BOT);
                attach(LEFT+TOP, norot=1) fwd(300) cuboid([400, 400, 100], anchor=LEFT+BOT);
                // WIFI Module
                recolor("lightgray")
                attach(RIGHT+TOP, norot=1) left(300) cuboid([1200,700,200], anchor=BOT);
                
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
