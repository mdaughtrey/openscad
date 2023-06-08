ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>

module model_aviation_connector_3pin()
{
    module base(h=357) {
        intersection() {
            cyl(r=458/2,h,$fn=96);
            cuboid([423,1000,h]);
        }
    }
    union() {
        base(357);
        rot_copies(n=3) down(186) xmove(75) cyl(r=30,h=186,$fn=96,anchor=TOP);
        up(357/2+71/2) cyl(r=583/2,h=71,$fn=96) {
            attach(TOP) base(197);
            position(BOT) cyl(r=663/2,h=137,$fn=6,anchor=TOP);
        }
    }
}

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
    position(BOT+RIGHT) cuboid([6450,x,220],anchor=TOP)
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
