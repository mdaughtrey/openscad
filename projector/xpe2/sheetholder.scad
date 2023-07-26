ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>
include <collars.scad>


module part1()
{
    tabbed_collar(BOT);
    $fn=96;
    up(299) diff() 
    cube([1600,1600,50],anchor=BOT) position(TOP) cube([1600,1600,200],anchor=BOT) {
        tag("remove") position(TOP) cube([1500,1500,200],anchor=TOP)
            position(BOT) cyl(d=1360,h=51,anchor=TOP);
    }
}

module part2()
{
    zflip() tabbed_accept_collar(TOP);
//    tabbed_collar(BOT);
    $fn=96;
    up(299) diff() 
    cube([1720,1720,50],anchor=BOT) position(TOP) cube([1720,1720,200],anchor=BOT) {
        tag("remove") position(TOP) cube([1620,1620,200],anchor=TOP)
            position(BOT) cyl(d=1360,h=51,anchor=TOP);
    }
}

module forViewing()
{
    part1();
    up(1000) zflip() recolor("cyan") part2();
}

module forPrinting()
{
    left(1000) part1();
    right(1000) part2();
}

scale(ViewScale)
{
//    forViewing();
    forPrinting();
}
