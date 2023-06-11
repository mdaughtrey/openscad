ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>

module model_pcbtabs()
{
    linear_extrude(450)
    {
        translate([0, (-1734/2)+230-1, 0])
        square([65, 750], center=true);
        translate([423, (-1734/2)+230-1, 0])
        square([65, 750], center=true);
        translate([-423, (-1734/2)+230-1, 0])
        square([65, 750], center=true);
    }
}

module model_battery()
{
    color("grey")
    cuboid([6540,3670,220])
    position(TOP+LEFT) right(400) cuboid([315,1270,145],anchor=BOT+LEFT)
    position(BOT+RIGHT) cuboid([6450,x,220],anchor=TOP);
}

module forViewing()
{
    model_battery();
}

module forPrinting()
{
    clip();
}

scale(ViewScale)
{
//    model_boost_buck_converter();
    forViewing();
//    forPrinting();
}
