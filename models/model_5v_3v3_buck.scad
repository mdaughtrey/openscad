include <../BOSL2-master/std.scad>

model_5v_3v3_buck_length = 880;
model_5v_3v3_buck_width = 660;
model_5v_3v3_buck_height = 173;

module model_5v_3v3_buck(anchor=CENTER, spin=0, orient=UP)
{
    l = model_5v_3v3_buck_length;
    w = model_5v_3v3_buck_width;
    h = model_5v_3v3_buck_height;

    module model_5v_3v3_buck_()
    {
        diff("buck_remove") recolor("green")
        cuboid([l, w, 63])
        {
            // SMD Resistors
            recolor("black")
            attach(LEFT+TOP, norot=1) right(2) cuboid([50, 90, 50], anchor=LEFT+BOT);
            recolor("black")
            attach(RIGHT+TOP, norot=1) left(2) cuboid([50, 90, 50], anchor=RIGHT+BOT);
            // SS34
            recolor("black")
            attach(LEFT+TOP+BACK, norot=1) right(220) cuboid([160, 100, 80], anchor=LEFT+BOT+BACK);
            // MP1584
            recolor("black")
            attach(LEFT+TOP+BACK, norot=1) right(177) fwd(200) cuboid([200, 160, 50], anchor=LEFT+BOT+BACK);
            // 4R7
            recolor("gray")
            attach(RIGHT+TOP+BACK, norot=1) left(140) fwd(100) cuboid([250, 270, 110], anchor=RIGHT+BOT+BACK);
            // Pot
            recolor("gray")
            attach(RIGHT+TOP+FRONT, norot=1) left(180) back(50) cuboid([150, 120, 50], anchor=RIGHT+BOT+FRONT);
            tag("buck_remove") attach(BOT, norot=1)
            {
                grid_copies(size=[l-75,w-75], n=2) cyl(d=50,h=70,anchor=BOT);
                grid_copies(size=[l-75,w-275], n=2) cyl(d=50,h=70,anchor=BOT);

            }
        }
    }
    attachable(anchor,spin,orient,size=[l, w, h])
    {
        down(55)
        model_5v_3v3_buck_();
        children();
    }
}
