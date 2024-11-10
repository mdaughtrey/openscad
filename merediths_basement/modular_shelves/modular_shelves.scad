ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>

columnW = 1500;
columnD = 1500;
columnH = 2000;

shelfW = 24000;
shelfH = 750;
shelfD = 8000;

BRACE_W = 2000;
BRACE_D = 2000;
//CONNECTOR_UP=1;
//CONNECTOR_DOWN=2;
//CONNECTOR_LEFT=4;
//CONNECTOR_RIGHT=8;
//CONNECTOR_FRONT=16;
//CONNECTOR_BACK=32;

wallHorizW = 100;
wallVertW = 100;


module shelf_mount_corner(anchor=CENTER,spin=0,orient=UP)
{
    module shelf_mount_corner_()
    {
        cuboid([BRACE_W, BRACE_D, wallHorizW])
        {
            attach(norot=1, TOP+BACK) cuboid([BRACE_W, wallVertW, shelfH], anchor=BOT+BACK);
            attach(norot=1, TOP+RIGHT) cuboid([wallVertW, BRACE_D, shelfH], anchor=BOT+RIGHT)
            attach(norot=1, TOP+RIGHT) cuboid([BRACE_W, BRACE_D, wallHorizW], anchor=BOT+RIGHT);
        }
    }
    attachable(anchor,spin,orient,size=[BRACE_W, BRACE_D, wallHorizW*2 + shelfH])
    {
        down(wallHorizW/2 + shelfH/2)
        shelf_mount_corner_();
        children();
    }
}


module brace(anchor=CENTER,spin=0,orient=UP, connectors=[])
{
    module brace_(connectors)
    {
        shelf_mount_corner()
        {
            for (c = [0:len(connectors)-1])
            {
                if (connectors[c] == "UP")
                {
                    attach(norot=1, TOP+BACK+RIGHT)
                         rect_tube(size=[columnW, columnD], h=columnH, wall=wallVertW, anchor=BOT+BACK+RIGHT);
                }
                if (connectors[c] == "DOWN")
                {
                    attach(norot=1, BOT+BACK+RIGHT) 
                        rect_tube(size=[columnW, columnD], h=columnH, wall=wallVertW, anchor=TOP+BACK+RIGHT);
                }
            }
        }
    }
    attachable(anchor,spin,orient,size=[BRACE_W, BRACE_D, wallHorizW])
    {
        brace_(connectors);
        children();
    }
}


module case()
{
}

module forViewing()
{
//    shelf_mount_corner();
    brace(connectors=["UP", "DOWN"]);
}

module forPrinting()
{
}

scale(ViewScale)
{
    forViewing();
}
