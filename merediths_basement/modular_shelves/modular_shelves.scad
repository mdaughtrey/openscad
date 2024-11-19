ViewScale = [0.0254, 0.0254, 0.0254];
include <../../BOSL2-master/std.scad>

columnW = 1500;
columnD = 750;
columnH = 1000;

shelfW = 24000;
shelfH = 756;
shelfD = 8000;

BRACE_W = columnW + 500;
BRACE_D = columnD + 500;
//CONNECTOR_UP=1;
//CONNECTOR_DOWN=2;
//CONNECTOR_LEFT=4;
//CONNECTOR_RIGHT=8;
//CONNECTOR_FRONT=16;
//CONNECTOR_BACK=32;

wallHorizW = 100;
wallVertW = 100;


module model_desk(anchor=CENTER,spin=0,orient=UP)
{
    mdW = 56000;
    mdD = (19+5/8)*1000;
    mdH = 1000;
    module model_desk_()
    {
        cuboid([mdW, mdD, mdH], anchor=CENTER);
    }
    attachable(anchor,spin,orient,size=[mdW, mdD, mdH])
    {
        model_desk_();
        children();
    }
}

module shelf_mount_corner(anchor=CENTER,spin=0,orient=UP, connectors=[])
{
    module shelf_mount_corner_(connectors)
    {
        diff("smc_remove")
        cuboid([BRACE_W, BRACE_D, wallHorizW])
        {
            if ("DOWN" == connectors[0] || "DOWN" == connectors[1])
            {
                tag("smc_remove") attach(RIGHT+BACK+TOP, norot=1)
                    move([-wallVertW, -wallVertW, 1])
                    cuboid([columnW+30, columnD+30, wallHorizW+2], anchor=RIGHT+BACK+TOP);
            }
            attach(norot=1, TOP+BACK) cuboid([BRACE_W, wallVertW, shelfH], anchor=BOT+BACK);
            attach(norot=1, TOP+RIGHT) cuboid([wallVertW, BRACE_D, shelfH], anchor=BOT+RIGHT)
            {
                attach(norot=1, TOP+RIGHT) cuboid([BRACE_W, BRACE_D, wallHorizW], anchor=BOT+RIGHT)
                {
                if ("UP" == connectors[0] || "UP" == connectors[1])
                {
                    tag("smc_remove")
                    {
                        attach(RIGHT+BACK+TOP, norot=1) move([-wallVertW, -wallVertW, 1])
                            cuboid([columnW+30, columnD+30, wallHorizW+2], anchor=RIGHT+BACK+TOP);
                        attach(BOT+LEFT,norot=1) right(300) cyl(d=170, h=wallHorizW, anchor=BOT);
                    }
                }
                }
            }
        }
    }
    attachable(anchor,spin,orient,size=[BRACE_W, BRACE_D, wallHorizW*2 + shelfH])
    {
        down(wallHorizW/2 + shelfH/2)
        shelf_mount_corner_(connectors);
        children();
    }
}


module brace(anchor=CENTER,spin=0,orient=UP, connectors=[])
{
    module brace_(connectors)
    {
        shelf_mount_corner(connectors)
        {
            for (c = [0:len(connectors)-1])
            {
                if (connectors[c] == "UP")
                {
                    attach(norot=1, TOP+BACK+RIGHT)
                         rect_tube(isize=[columnW+30, columnD+30], h=columnH, wall=wallVertW, anchor=BOT+BACK+RIGHT);
                }
                if (connectors[c] == "DOWN")
                {
                    attach(norot=1, BOT+BACK+RIGHT) 
                        rect_tube(isize=[columnW+30, columnD+30], h=columnH, wall=wallVertW, anchor=TOP+BACK+RIGHT);
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

module base_brace(anchor=CENTER,spin=0,orient=UP)
{
    module base_brace_()
    {
        diff()
        cuboid([BRACE_W, BRACE_D, wallHorizW])
        {
            tag("remove") attach(RIGHT+BACK+TOP, norot=1)
                move([-wallVertW, -wallVertW, 1])
                cuboid([columnW+30, columnD+30, wallHorizW+2], anchor=RIGHT+BACK+TOP);
            attach(norot=1, TOP+BACK+RIGHT)
                rect_tube(isize=[columnW+30, columnD+30], h=columnH, wall=wallVertW, anchor=BOT+BACK+RIGHT);
            attach(norot=1, BOT+BACK+RIGHT)
                cuboid([BRACE_W, wallVertW, 1000], anchor=TOP+BACK+RIGHT)
                tag("remove") attach(BACK)
                {
                    back(200) right(500) cyl(d=170, h=wallVertW+1, anchor=TOP);
                    fwd(200) left(500) cyl(d=170, h=wallVertW+1, anchor=TOP);
                }
            attach(norot=1, BOT+BACK+RIGHT)
                cuboid([wallVertW, BRACE_D, 1000], anchor=TOP+BACK+RIGHT)
            tag("remove") attach(RIGHT)
            {
                back(250) right(250) cyl(d=170, h=wallVertW+1, anchor=TOP);
                fwd(250) left(250) cyl(d=170, h=wallVertW+1, anchor=TOP);
            }
        }
    }
    attachable(anchor,spin,orient,size=[BRACE_W, BRACE_D, wallHorizW])
    {
        base_brace_();
        children();
    }
}

module top_brace(anchor=CENTER,spin=0,orient=UP)
{
    module top_brace_()
    {
//        diff()
//        cuboid([BRACE_W, BRACE_D, wallHorizW])
//        {
            diff("tb_remove")
            shelf_mount_corner(connectors=["DOWN"])
            {
                tag("tb_remove") attach(TOP) cyl(d=170, h=wallHorizW, anchor=TOP);
                attach(norot=1, BOT+BACK+RIGHT)
                    rect_tube(isize=[columnW+30, columnD+30], h=columnH, wall=wallVertW, anchor=RIGHT+BACK+TOP);
            }
//            attach(norot=1, BOT+BACK+RIGHT)
//                cuboid([BRACE_W, wallVertW, 1000], anchor=TOP+BACK+RIGHT)
//                tag("remove") attach(BACK)
//                {
//                    back(200) right(500) cyl(d=170, h=wallVertW+1, anchor=TOP);
//                    fwd(200) left(500) cyl(d=170, h=wallVertW+1, anchor=TOP);
//                }
//            attach(norot=1, BOT+BACK+RIGHT)
//                cuboid([wallVertW, BRACE_D, 1000], anchor=TOP+BACK+RIGHT)
//            tag("remove") attach(RIGHT)
//            {
//                back(250) right(250) cyl(d=170, h=wallVertW+1, anchor=TOP);
//                fwd(250) left(250) cyl(d=170, h=wallVertW+1, anchor=TOP);
//            }
//        }
    }
    attachable(anchor,spin,orient,size=[BRACE_W, BRACE_D, wallHorizW])
    {
        top_brace_();
        children();
    }
}


module side_brace(anchor=CENTER,spin=0,orient=UP)
{
    module base_brace_()
    {
        diff()
        cuboid([BRACE_W, BRACE_D, wallHorizW])
        {
            tag("remove") attach(BACK+TOP, norot=1)
                move([0, -wallVertW, 1])
                cuboid([columnW+30, columnD+30, wallHorizW+2], anchor=BACK+TOP);
            attach(norot=1, TOP+BACK)
                rect_tube(isize=[columnW+30, columnD+30], h=columnH, wall=wallVertW, anchor=BOT+BACK);
            attach(norot=1, BOT+BACK)
                cuboid([BRACE_W, wallVertW, 1000], anchor=TOP+BACK)
                tag("remove") attach(BACK)
                {
                    back(200) right(500) cyl(d=170, h=wallVertW+1, anchor=TOP);
                    fwd(200) left(500) cyl(d=170, h=wallVertW+1, anchor=TOP);
                }
            *attach(norot=1, BOT+BACK+RIGHT)
                cuboid([wallVertW, BRACE_D, 1000], anchor=TOP+BACK+RIGHT)
            tag("remove") attach(RIGHT)
            {
                back(250) right(250) cyl(d=170, h=wallVertW+1, anchor=TOP);
                fwd(250) left(250) cyl(d=170, h=wallVertW+1, anchor=TOP);
            }
        }
    }
    attachable(anchor,spin,orient,size=[BRACE_W, BRACE_D, wallHorizW])
    {
        base_brace_();
        children();
    }
}

module test_surround()
{
    rect_tube(isize=[columnW+30, columnD+30], h=columnH, wall=wallVertW, anchor=BOT+BACK+RIGHT);
}


module case()
{
}

module forViewing()
{
//    shelf_mount_corner();
    mirror([1,0,0])
    top_brace();
//    brace(connectors=["UP", "DOWN"]);
//    base_brace();
//    side_brace();
}

module forPrinting()
{
    test_surround();
}

scale(ViewScale)
{
    forViewing();
//    forPrinting();
}
