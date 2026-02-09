include <../BOSL2-master/std.scad>

model_rpi_zero_wireless_pcbL = 2560;
model_rpi_zero_wireless_pcbW = 1200;
model_rpi_zero_wireless_pcbH = 57;

module model_rpi_zero_wireless(anchor=CENTER,spin=0,orient=UP)
{
    pcbL = model_rpi_zero_wireless_pcbL;
    pcbW = model_rpi_zero_wireless_pcbW;
    pcbH = model_rpi_zero_wireless_pcbH;

    module model_rpi_zero_wireless_()
    {
        rmtag="vtr23q";
        recolor("green")
        diff(rmtag)
        cuboid([pcbL, pcbW, pcbH], rounding=100, edges="Z")
        {
            // Mounting Holes
            tag(rmtag) position(BOT) grid_copies(spacing=[2300, 900], n=2) down(1) cyl(d=100,h=pcbH+2, anchor=BOT);
    
            // Header holes
            tag(rmtag) position(BOT+BACK) grid_copies(spacing=[100, 100], n=[20,2]) fwd(90+50) down(1) cyl(d=40,h=pcbH+2, anchor=BOT);
            tag(rmtag) position(BOT+BACK+RIGHT) grid_copies(spacing=[100, 100], n=[2,2]) left(380) fwd(90+250) down(1) cyl(d=40,h=pcbH+2, anchor=BOT);

            // SD 
            recolor("silver")
            position(LEFT+TOP+BACK) fwd(280) left(100) cuboid([610, 480, 60], anchor=BOT+LEFT+BACK);

            // HDMI
            recolor("silver")
            position(LEFT+TOP+FRONT) fwd(15)  right(270) cuboid([440, 300, 130], anchor=BOT+LEFT+FRONT);

            // USBs
            recolor("silver")
            position(RIGHT+TOP+FRONT) fwd(50) left(280) cuboid([300, 220, 110], anchor=BOT+RIGHT+FRONT)
            position(LEFT) left(190) cuboid([300, 220, 110], anchor=RIGHT);

            // Camera Connector
            recolor("ivory")
            position(RIGHT+TOP+BACK) right(45) fwd(260) cuboid([195, 670, 60], anchor=BOT+RIGHT+BACK);

            // IC
            recolor("grey")
            position(LEFT+TOP+BACK) right(780) fwd(430) cuboid([480, 480, 55], anchor=BOT+LEFT+BACK);

            // Inductor
            recolor("grey")
            position(RIGHT+TOP+BACK) left(200) fwd(440) cuboid([160, 160, 65], anchor=BOT+RIGHT+BACK);

        }
    }
    attachable(anchor,spin,orient,size=[pcbL+100+45, pcbW, pcbH])
    {
        up(pcbH/2)
        model_rpi_zero_wireless_();
        children();
    }
}
