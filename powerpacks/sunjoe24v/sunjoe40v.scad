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

module clip()
{
    module cutout(a=LEFT,d=0,l=0)
    {
        conv_hull() 
            cuboid([1000+l+d,100+d,101],anchor=a)
            position(RIGHT) fwd(50+d/2)
            cyl(r=25+d/2,100,$fn=96,anchor=LEFT);
    }
    diff() {
        cuboid([3000,2650,200], rounding=200,edges="Z")
        {
//            tag("remove")
//            {
//                *attach(LEFT+BOT) cuboid([3000,300,300]);
//                *attach(LEFT+BOT,norot=1) cuboid([2480,2050,160],anchor=LEFT+BOT)
//                *attach(LEFT+TOP,norot=1) cuboid([2480,2360,230],anchor=LEFT+BOT);
//                // Sprung tab cutout
//                *attach(LEFT+TOP,norot=1) right(230) cuboid([750,850,290],anchor=TOP+LEFT);
//                // PCB cutouts
//                *attach(RIGHT+BOT,norot=1) left(200) back(1570/2) cuboid([760,70,460],anchor=RIGHT+BOT+BACK)
//                *attach(BOT+RIGHT,norot=1) cuboid([200,70,100],anchor=LEFT+BOT);
//                *attach(RIGHT+BOT,norot=1) left(200) fwd(1570/2) cuboid([760,70,460],anchor=RIGHT+BOT+BACK)
//                *attach(BOT+RIGHT,norot=1) cuboid([200,70,100],anchor=LEFT+BOT);
//            }
          // Upper clip back
          attach(TOP+RIGHT,norot=1) back(2105/2) left(200) cuboid([976,86,135], anchor=BACK+RIGHT+BOT);
          attach(TOP+RIGHT,norot=1) back(2105/2) left(1730) cuboid([1000,86,135], anchor=BACK+RIGHT+BOT)
          attach(TOP+LEFT+BACK,norot=1) cuboid([2780,160,100], anchor=BOT+BACK+LEFT);

          // Upper clip front
          attach(TOP+RIGHT,norot=1) fwd(2105/2) left(200) cuboid([976,86,135], anchor=FRONT+RIGHT+BOT);
          attach(TOP+RIGHT,norot=1) fwd(2105/2) left(1730) cuboid([1000,86,135], anchor=FRONT+RIGHT+BOT)
          attach(TOP+LEFT+FRONT,norot=1) cuboid([2780,160,100], anchor=BOT+FRONT+LEFT);

*            position(RIGHT+BOT) housing_3pin();
        }
    }
}


module forPrinting()
{
    clip();
}

scale(ViewScale)
{
//    model_boost_buck_converter();
//    forViewing();
    forPrinting();
}
