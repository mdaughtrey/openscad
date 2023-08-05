//ViewScale = [0.0254, 0.0254, 0.0254];
include <../spring_collar.scad>

module testcoupling()
{
    $fn=96;
    tabsout()
    attach(TOP,BOT) tube(od=1460,id=1310,h=200)
    attach(TOP,BOT) tabsin();
}

module forViewing()
{
    testcoupling();
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
