include <../BOSL2-master/std.scad>

module model_litheon_18v(anchor=CENTER,spin=0,orient=UP)
{
    module model_litheon_18v_()
    {
        // Body
        cuboid([3000,2850,100])
        attach(TOP+LEFT,norot=1) cuboid([550,2000,170],anchor=BOT+LEFT)
        {
            attach(RIGHT+BOT,norot=1) cuboid([2450,2000,215],anchor=LEFT+BOT);
            attach(TOP,norot=1) cuboid([550,2320,45],anchor=BOT)
            diff("ml_remove")
            attach(LEFT+TOP,norot=1) cuboid([3000,2320,200],anchor=LEFT+BOT)
            {
                // Sprung tab cutout
                attach(LEFT+TOP,norot=1) right(330) wedge([787,590,190],anchor=BOT+FRONT,spin=-90);
                tag("ml_remove")
                {
                    attach(RIGHT+TOP+BACK,norot=1) fwd(350) cuboid([430,72,200],anchor=RIGHT+TOP+BACK);
                    attach(RIGHT+TOP+FRONT,norot=1) back(350) cuboid([430,72,200],anchor=RIGHT+TOP+BACK);
                }
            }

        }
    }
    attachable(anchor,spin,orient,size=[3000,2850,775])
    {
        down(330-50)
        model_litheon_18v_();
        children();
    }
}
