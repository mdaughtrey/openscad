ViewScale = [0.0254, 0.0254, 0.0254];
include <../BOSL2-master/std.scad>

model_cables=1;

// module modname(anchor=CENTER,spin=0,orient=UP)
// {
//     module modname_()
//     {
//     }
//     attachable(anchor,spin,orient,size=)
//     {
//         modname_();
//         children();
//     }
// }

module model_usb_connector(anchor=CENTER,spin=0,orient=UP)
{
    module model_usb_connector_()
    {
        cuboid([353, 306, 125], rounding=50, except=[FRONT, BACK]);
    }
    attachable(anchor,spin,orient,size=[353, 306, 125])
    {
        model_usb_connector_();
        children();
    }
}

module model_usb_switch(anchor=CENTER,spin=0,orient=UP)
{
    module model_usb_switch_()
    {
        rmtag="qw4vq2w4";
        recolor("green")
        diff(rmtag)
        cuboid([2190, 1808, 48])
        {
            // Connectors
            recolor("silver")
            {
                attach(LEFT+BACK+TOP, norot=1) right(387) back(40) model_usb_connector(anchor=LEFT+BACK+BOT)
                if (model_cables)
                {
                    attach(BACK, norot=1) fwd(306) model_usb_cable(anchor=FRONT);
                }
                attach(RIGHT+BACK+TOP, norot=1) left(387) back(40) model_usb_connector(anchor=RIGHT+BACK+BOT)
                if (model_cables)
                {
                    attach(BACK, norot=1) fwd(306) model_usb_cable(anchor=FRONT);
                }
                attach(LEFT+FRONT+TOP, norot=1) right(387) fwd(40) model_usb_connector(anchor=LEFT+FRONT+BOT);
                attach(RIGHT+FRONT+TOP, norot=1) left(387) fwd(40) model_usb_connector(anchor=RIGHT+FRONT+BOT);
            }
            // Chips
            recolor("black")
            {
                // USBC Adjacent
                attach(LEFT+BACK+TOP, norot=1) right(115) fwd(252) cuboid([100, 169, 85], anchor=LEFT+BACK+BOT)
                attach(RIGHT+BOT, norot=1) right(20) cuboid([113, 125, 55], anchor=LEFT+BOT);
                attach(RIGHT+BACK+TOP, norot=1) left(115) fwd(252) cuboid([100, 169, 85], anchor=RIGHT+BACK+BOT)
                attach(LEFT+BOT, norot=1) left(20) cuboid([113, 125, 55], anchor=RIGHT+BOT);

                // Centerline
                attach(BACK+TOP, norot=1) fwd(125) cuboid([120, 120, 30], anchor=BACK+BOT);
                attach(BACK+TOP+LEFT, norot=1) fwd(560) right(885) cuboid([180, 100, 50], anchor=BACK+BOT+LEFT);
                attach(BACK+TOP+RIGHT, norot=1) fwd(560) left(885) cuboid([180, 100, 50], anchor=BACK+BOT+RIGHT);
                attach(BACK+TOP, norot=1) fwd(940) cuboid([176, 139, 40], anchor=BACK+BOT);

                // Right
                attach(RIGHT+BACK+TOP, norot=1) left(367) fwd(785) cuboid([290, 250, 73], anchor=BOT+BACK+RIGHT);

                // Left
                attach(LEFT+BACK+TOP, norot=1) right(77) fwd(800) cuboid([120, 52, 45], anchor=LEFT+BACK+BOT)
                attach(RIGHT+BACK+BOT, norot=1) right(137) cuboid([170, 202, 55], anchor=LEFT+BACK+BOT);
                attach(LEFT+BACK+TOP, norot=1) right(77) fwd(1050) cuboid([120, 52, 45], anchor=LEFT+BACK+BOT)
                attach(RIGHT+BACK+BOT, norot=1) right(137) cuboid([170, 202, 55], anchor=LEFT+BACK+BOT);
                attach(LEFT+FRONT+TOP, norot=1) right(115) back(227) cuboid([200, 187, 60], anchor=LEFT+FRONT+BOT);

                // Button
                attach(FRONT+TOP, norot=1) back(143) recolor("silver") cuboid([237, 237, 167], anchor=BOT+FRONT)
                attach(TOP, norot=1) recolor("black") cyl(d=135, h=150, anchor=BOT);

                // Holes
                tag(rmtag) attach(RIGHT+FRONT+TOP, norot=1)
                ycopies(spacing=100, n=8) left(170) back(390+350) cyl(d=35, h=48, anchor=TOP);
            }
        
        }
    }
    
    attachable(anchor,spin,orient,size=[2190, 1808, 48])
    {
        up(24)
        model_usb_switch_();
        children();
    }
}

module model_usb_cable(anchor=CENTER,spin=0,orient=UP)
{
    module model_usb_cable_()
    {
        recolor("silver)")
        model_usb_connector()
        recolor("grey")
        attach(BACK, norot=1)
        cuboid([487, 715, 256], rounding=50, except=[FRONT, BACK], anchor=FRONT)
        recolor("black")
        attach(BACK, norot=1)
        cuboid([487, 390, 256], rounding=50, except=[FRONT, BACK], anchor=FRONT);
    }
    
    attachable(anchor,spin,orient,size=[487, 1411, 256])
    {
        back(306/2)
        fwd(1411/2)
        model_usb_cable_();
        children();
    }
}


module case()
{
}

module forViewing()
{
//    model_usb_cable();
    model_usb_switch();
//    model_usb_connector();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
