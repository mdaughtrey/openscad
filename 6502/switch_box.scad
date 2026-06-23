ViewScale = [0.0254, 0.0254, 0.0254];
include <../BOSL2-master/std.scad>
include <reset_switch.scad>

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

module bottom_panel(anchor=CENTER,spin=0,orient=UP)
{
    module bottom_panel_()
    {
        rmtag="rvrt3q142";
        diff(rmtag)
        {
            cuboid([3300, 1500, 100], edges="Z", rounding=100, anchor=TOP)
            tag(rmtag) up(1)
            {
                offset = 182/2+20;
                // Mounting Holes - Left
                translate([offset, -offset, 0]) position(TOP+BACK+LEFT) cyl(d=200, h=51, anchor=TOP)
                position(BOT) up(1) cyl(d=100,h=52,anchor=TOP);
                translate([offset, offset, 0]) position(TOP+FRONT+LEFT) cyl(d=200, h=51, anchor=TOP)
                position(BOT) up(1) cyl(d=100,h=52,anchor=TOP);

                // Mounting Holes - Right
                translate([-offset, -offset, 0]) position(TOP+BACK+RIGHT) cyl(d=200, h=51, anchor=TOP)
                position(BOT) up(1) cyl(d=100,h=52,anchor=TOP);
                translate([-offset, offset, 0]) position(TOP+FRONT+RIGHT) cyl(d=200, h=51, anchor=TOP)
                position(BOT) up(1) cyl(d=100,h=52,anchor=TOP);

                // Mounting Holes - Center
                translate([200, -offset, 0]) position(TOP+BACK) cyl(d=200, h=51, anchor=TOP)
                position(BOT) up(1) cyl(d=100,h=52,anchor=TOP);
                translate([200, offset, 0]) position(TOP+FRONT) cyl(d=200, h=51, anchor=TOP)
                position(BOT) up(1) cyl(d=100,h=52,anchor=TOP);
            }
        }
    }
    attachable(anchor,spin,orient,size=[3300, 1500, 100])
    {
        bottom_panel_();
        children();
    }
}

module switch_box(anchor=CENTER,spin=0,orient=UP)
{
    module switch_box_()
    {
        rmtag="rv135";
        diff(rmtag)
        {
            cuboid([3300, 1500, 100], edges="Z", rounding=100)
            {
                // Switch Cutouts
                tag(rmtag) position(TOP+RIGHT) up(1)
                {
                    left(300) cuboid([470, 1080, 110], anchor=TOP+RIGHT)
                    left(600) position(TOP) cuboid([470, 1080, 110], anchor=TOP);
                }
                position(BOT) rect_tube(size=[3300, 1500], rounding=100, wall=100, h=816, anchor=TOP)
                {
                    offset = 182/2+20;
                    tag(rmtag) right(200) position(TOP+LEFT) cuboid([1530, 2000, 826], anchor=TOP+LEFT);
                    // Mounting Holes - Left
                    translate([offset, -offset, 0]) position(TOP+BACK+LEFT) cyl(d=182, h=816, anchor=TOP)
                    tag(rmtag) position(TOP) cyl(d=82, h=826, anchor=TOP);
                    translate([offset, offset, 0]) position(TOP+FRONT+LEFT) cyl(d=182, h=816, anchor=TOP)
                    tag(rmtag) position(TOP) cyl(d=82, h=826, anchor=TOP);

                    // Mounting Holes - Right
                    translate([-offset, -offset, 0]) position(TOP+BACK+RIGHT) cyl(d=182, h=816, anchor=TOP)
                    tag(rmtag) position(TOP) cyl(d=82, h=826, anchor=TOP);
                    translate([-offset, offset, 0]) position(TOP+FRONT+RIGHT) cyl(d=182, h=816, anchor=TOP)
                    tag(rmtag) position(TOP) cyl(d=82, h=826, anchor=TOP);

                    // Mounting Holes - Center
                    translate([200, -offset, 0]) position(TOP+BACK) cyl(d=182, h=816, anchor=TOP)
                    tag(rmtag) position(TOP) cyl(d=82, h=826, anchor=TOP);
                    translate([200, offset, 0]) position(TOP+FRONT) cyl(d=182, h=816, anchor=TOP)
                    tag(rmtag) position(TOP) cyl(d=82, h=826, anchor=TOP);
                }
            }
        }
    }
    attachable(anchor,spin,orient,size=[3300, 1500, 100])
    {
        switch_box_();
        children();
    }
}


module forViewing()
{
    left(1500) cuboid([1530, 2000, 806])
    position(TOP+LEFT) left (200)  switch_box(anchor=BOT+LEFT);
    recolor("cornflowerblue")
    up(500) left(300) reset_switch();
    recolor("cornflowerblue")
    up(500) right(300) reset_switch();
}

module forPrinting()
{
//    switch_box();
    bottom_panel();
}

scale(ViewScale)
{
//    forViewing();
    forPrinting();
}
