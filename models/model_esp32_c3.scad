esp32_c3_ai_X = 1770;
esp32_c3_ai_pcb_X = 1560;
esp32_c3_ai_Y = 1150;
esp32_c3_ai_Z = 160;

module model_esp32_c3(anchor=CENTER,spin=0,orient=UP,rmtag="asvc4_remove")
{
    X = esp32_c3_ai_X;
    Y = esp32_c3_ai_Y;
    Z = esp32_c3_ai_Z;
    module model_esp32_c3_()
    {
        diff(rmtag)
        cuboid([esp32_c3_ai_pcb_X, Y, 62])
        {
            // USB Connectors
            recolor("silver")
            attach(TOP+LEFT, norot=1) back(75+180) cuboid([290, 360, 130], anchor=BOT+LEFT);
            recolor("silver")
            attach(TOP+LEFT, norot=1) fwd(75+180) cuboid([290, 360, 130], anchor=BOT+LEFT);
            // ESP Module
            recolor("silver")
            attach(TOP+RIGHT, norot=1) cuboid([390, 520, 100], anchor=BOT+RIGHT);
            // Antenna
            recolor("gray")
            attach(TOP+RIGHT, norot=1) cuboid([200, 520, 30], anchor=BOT+LEFT);
        }
    }
    attachable(anchor,spin,orient,size=[X,Y,Z])
    {
        up(31)
        down((62+130)/2) left(100)
        model_esp32_c3_();
        children();
    }
}
