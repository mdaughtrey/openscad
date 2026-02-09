include <../BOSL2-master/std.scad>

model_rpi_camera_pcbL = 980;
model_rpi_camera_pcbW = 950;
model_rpi_camera_pcbH = 60;

module model_rpi_camera(anchor=CENTER,spin=0,orient=UP,models=0)
{
    pcbL = model_rpi_camera_pcbL;
    pcbW = model_rpi_camera_pcbW;
    pcbH = model_rpi_camera_pcbH;

    module model_rpi_camera_()
    {
        rmtag="vtvdwrr23q";
        recolor("green")
        diff(rmtag)
        cuboid([pcbL, pcbW, pcbH])
        {
            // Mounting Holes
            tag(rmtag) position(BOT+FRONT) grid_copies(spacing=[820, 490], n=2) back(326) down(1) cyl(d=75,h=pcbH+2, anchor=BOT);
            if (models)
            {
                position(TOP+FRONT) recolor("silver") grid_copies(spacing=[820, 490], n=2) back(326) down(1) cyl(d=160,h=80, anchor=BOT);
            }
    
            // Header holes
            *tag(rmtag) position(BOT+BACK) grid_copies(spacing=[100, 100], n=[20,2]) fwd(90+50) down(1) cyl(d=40,h=pcbH+2, anchor=BOT);
            *tag(rmtag) position(BOT+BACK+RIGHT) grid_copies(spacing=[100, 100], n=[2,2]) left(380) fwd(90+250) down(1) cyl(d=40,h=pcbH+2, anchor=BOT);

            // Camera Module
            recolor("grey")
            position(LEFT+TOP+FRONT) back(240) back(390) right(340) cuboid([310, 310, 130], anchor=BOT+LEFT+BACK)
            {
                // Camera Module Cable
                recolor("gold")
                position(FRONT+BOT) cuboid([300, 300, 60], anchor=BOT+BACK);
                // Lens
                recolor("black")
                position(TOP) cyl(d=300,h=70,anchor=BOT);
            }

            // Connector
            recolor("ivory")
            position(BOT+BACK) back(20) cuboid([670, 195, 60], anchor=TOP+BACK);
        }
    }
    attachable(anchor,spin,orient,size=[pcbL, pcbW, pcbH])
    {
        up(pcbH/2)
        model_rpi_camera_();
        children();
    }
}
