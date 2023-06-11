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
    diff() {
        cuboid([3000,3670,220]) {
            attach(TOP,norot=1) cuboid([3000,3400,170],anchor=BOT)
            attach(TOP,norot=1) cuboid([3000,3670,500],anchor=BOT);
            tag("remove") position(RIGHT+BOT) up(470) ycopies(n=5,l=1270) cuboid([300,80,300],anchor=BOT);
        }
    }
}

module battery_clip()
{
    diff() {
        cuboid([3000,3800,150]) {
            tag("remove") position(RIGHT) left(400) cuboid([3000,3430,152],anchor=RIGHT);
            tag("keep") position(RIGHT+TOP) cuboid([400,3800,90],anchor=RIGHT+BOT)
            // PCB tab holder surrounds
            position(TOP+RIGHT) ycopies(l=1270,n=5) {
                 tag("") cuboid([400,150,280],anchor=BOT+RIGHT)
                 tag("remove") up(10) left(1) position(LEFT+TOP) cuboid([300,62,433],anchor=TOP+LEFT);
            }
        }
    }

}

module forViewing()
{
    model_battery();
    up(200) right(450) battery_clip();
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
