model_io_expanderX = 1270;
model_io_expanderY = 840;
model_io_expanderZ = 136;

$fn=96;

module model_io_expander(anchor=CENTER,spin=0,orient=UP)
{
    module model_io_expander_()
    {
        recolor("blue")
        diff("miox_remove")
        cuboid([model_io_expanderX, model_io_expanderY, 65])
        {
            recolor("black")
            {
                // Chips
                attach(LEFT+TOP, norot=1) right(150) cuboid([330, 380, 80], anchor=LEFT+BOT)
                {
                    // Transistors
                    attach(RIGHT+BOT, norot=1) right(70) back(15) cuboid([50, 110, 38], anchor=LEFT+BOT+FRONT);
                    attach(RIGHT+BOT, norot=1) right(70) fwd(15) cuboid([50, 110, 38], anchor=LEFT+BOT+BACK);
                }
                attach(RIGHT+TOP, norot=1) left(210) cuboid([185, 175, 64], anchor=RIGHT+BOT);
            }
            // Holes
            tag("miox_remove")
            {
                // Header holes
                attach(LEFT+BACK+BOT,norot=1) fwd(55) right(500+5) down(1)
                xcopies(100, n=10) cyl(d=35,h=67,anchor=BOT);
                attach(LEFT+FRONT+BOT,norot=1) back(55) right(500+5) down(1)
                xcopies(100, n=10) cyl(d=35,h=67,anchor=BOT);
                attach(RIGHT+BOT,norot=1) left(55) down(1)
                ycopies(100, n=5) cyl(d=35,h=67,anchor=BOT);
                // Mounting holes
                attach(RIGHT+BACK+BOT,norot=1) down(1) left(50) fwd(50) cyl(d=90,h=67,anchor=BOT);
                attach(RIGHT+FRONT+BOT,norot=1) down(1) left(50) back(50) cyl(d=90,h=67,anchor=BOT);
                attach(LEFT+BOT,norot=1) down(1) right(70) back(90+45) cyl(d=90,h=67,anchor=BOT);
                attach(LEFT+BOT,norot=1) down(1) right(70) fwd(90+45) cyl(d=90,h=67,anchor=BOT);
            }

        }
    }
    attachable(anchor,spin,orient,size=[model_io_expanderX, model_io_expanderY, model_io_expanderZ])
    {
        down(100)
        model_io_expander_();
        children();
    }
}
