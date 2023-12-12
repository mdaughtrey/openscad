ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>


module collar_acceptor()
{
    rect_tube(h=500,size=1500,isize=1400,rounding=50);
}

module collar_inserter()
{
    rect_tube(h=500,size=1380,isize=1280,rounding=50)
    attach(TOP,overlap=1)
    rect_tube(h=100,size=1500,isize=1280,rounding=50,anchor=BOT);
}


module forViewing()
{
    collar_acceptor();
    up(300) recolor("cyan") collar_inserter();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
