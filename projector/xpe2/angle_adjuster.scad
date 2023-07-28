ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>
include <collars.scad>


module part1()
{
    $fn=96;
    tube(od=1600,id=1490,h=300, anchor=BOT) {
        attach(TOP,BOT) tabbed_accept_collar(anchor=CENTER,h=300);
        position(TOP) down(80)  tube(od=1500,id=1360,h=50,anchor=TOP);
    }
}

module part2()
{
    $fn=96;
    tabbed_collar(anchor=BOT)
    up(299) tube(od=1460,id=1360,h=200, anchor=BOT);
//    tube(od=1460,id=1360,h=300, anchor=BOT)
//    attach(BOT,TOP) tabbed_collar();
}

module forViewing()
{
    part1();
    down(340) part2();
}

module forPrinting()
{
    part1();
    right(1700) part2();
}

scale(ViewScale)
{
//    forViewing();
    forPrinting();
}
