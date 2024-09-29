model_i2c_muxX = 1250;
model_i2c_muxY = 850;
model_i2c_muxZ = 100;

$fn=96;

module model_i2c_mux(anchor=CENTER,spin=0,orient=UP)
{
    module model_i2c_mux_()
    {
        recolor("blue")
        diff("iox_remove")
        cuboid([model_i2c_muxX, model_i2c_muxY, 65])
        {
            recolor("black")
            {
                // Chips
                attach(LEFT+TOP, norot=1) right(460) cuboid([300, 280, 30], anchor=LEFT+BOT)
                {
                    // Resistors
                    attach(RIGHT+BOT, norot=1) right(55) cuboid([80, 30, 15], anchor=LEFT+BOT)
                    {
                        attach(BACK+BOT, norot=1) back(65) cuboid([80, 30, 15], anchor=FRONT+BOT);
                        attach(FRONT+BOT, norot=1) fwd(65) cuboid([80, 30, 15], anchor=BACK+BOT);
                    }
                    attach(LEFT+BOT, norot=1) left(65+40)
                    ycopies(60,n=4) cuboid([80, 30, 15]);
                }
//                attach(RIGHT+TOP, norot=1) left(210) cuboid([185, 175, 64], anchor=RIGHT+BOT);
            }
            // Holes
            tag("iox_remove")
            {
                // Header holes
                attach(LEFT+BACK+BOT,norot=1) fwd(55) right(600+5) down(1)
                xcopies(100, n=12) cyl(d=35,h=67,anchor=BOT);
                attach(LEFT+FRONT+BOT,norot=1) back(55) right(600+5) down(1)
                xcopies(100, n=12) cyl(d=35,h=67,anchor=BOT);
                *attach(RIGHT+BOT,norot=1) left(55) down(1)
                ycopies(100, n=5) cyl(d=35,h=67,anchor=BOT);
                // Mounting holes
                attach(RIGHT+BOT,norot=1) down(1) left(120) cyl(d=125,h=67,anchor=BOT);
                attach(LEFT+BOT,norot=1) down(1) right(120) cyl(d=125,h=67,anchor=BOT);
            }

        }
    }
    attachable(anchor,spin,orient,size=[model_i2c_muxX, model_i2c_muxY, model_i2c_muxZ])
    {
        down(100)
        model_i2c_mux_();
        children();
    }
}
