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

module esp32_c3_holder(anchor=CENTER,spin=0,orient=UP)
{
    rmtag="qwv54_remove";
    module esp32_c3_holder_()
    {
        diff(rmtag)
        rect_tube(isize=[esp32_c3_ai_pcb_X+30, esp32_c3_ai_Y+30], wall=50, h=200)
        {
            // USB Connector Cutout
            tag(rmtag)
            attach(TOP+LEFT, norot=1) left(1) up(1) cuboid([100, esp32_c3_ai_Y-200, 150], 
                rounding=100, edges=[BACK+BOT, FRONT+BOT], anchor=TOP+LEFT);
            // Inner board support
            attach(BOT, norot=1) rect_tube(isize=[esp32_c3_ai_pcb_X-30, esp32_c3_ai_Y-30], wall=60, h=150, anchor=BOT);

            // Screw mounts
            attach(LEFT+FRONT+BOT, norot=1) tube(h=200, id=screwhole, od=200, anchor=BOT+FRONT+RIGHT);
            attach(LEFT+BACK+BOT, norot=1) tube(h=200, id=screwhole, od=200, anchor=BOT+BACK+RIGHT);

            attach(RIGHT+FRONT+BOT, norot=1) tube(h=200, id=screwhole, od=200, anchor=BOT+FRONT+LEFT);
            attach(RIGHT+BACK+BOT, norot=1) tube(h=200, id=screwhole, od=200, anchor=BOT+BACK+LEFT);
        }
    }
    attachable(anchor,spin,orient,size=[esp32_c3_ai_pcb_X+1030, esp32_c3_ai_Y+30, 200])
    {
        down(100)
        esp32_c3_holder_();
        children();
    }
}

module esp32_c3_holder_retainer()
{
    rmtag = "a4vq_remove";
    hide("hidden") tag("hidden")
    rect_tube(isize=[esp32_c3_ai_pcb_X+30, esp32_c3_ai_Y+30], wall=50, h=200)
    {
        // SW Screw mount
        attach(LEFT+FRONT+BOT, norot=1) tube(h=200, id=80, od=250, anchor=BOT+FRONT+RIGHT)
        tag("visible") 
        attach(TOP, norot=1) tube(h=70, id=100, od=250, anchor=BOT)
        attach(TOP, norot=1) tube(h=115, id=200, od=250, anchor=BOT);

        // NW Screw mount
        attach(LEFT+BACK+BOT, norot=1) tube(h=200, id=80, od=250, anchor=BOT+BACK+RIGHT)
        tag("visible") 
        attach(TOP, norot=1) tube(h=70, id=100, od=250, anchor=BOT)
        attach(TOP, norot=1) tube(h=115, id=200, od=250, anchor=BOT);

    }
    up(360) left(720+60)
    diff(rmtag)
    cuboid([500, esp32_c3_ai_Y+60+70, 50], rounding=200, edges=[RIGHT+BACK,RIGHT+FRONT])
    {
        tag(rmtag)
        {
            attach(BOT+LEFT+FRONT, norot=1) cyl(d=250, h=51, anchor=BOT+LEFT+FRONT);
            attach(BOT+LEFT+BACK, norot=1) cyl(d=250, h=51, anchor=BOT+LEFT+BACK);
            attach(LEFT+BOT, norot=1) down(1) cuboid([250, esp32_c3_ai_Y-200,52], anchor=LEFT+BOT, 
                rounding=100, edges=[RIGHT+BACK, RIGHT+FRONT]);
        }
            
    }
}
