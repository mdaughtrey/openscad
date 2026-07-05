ViewScale = [0.0254, 0.0254, 0.0254];
include <../../../BOSL2-master/std.scad>
include <../../../BOSL2-master/hinges.scad>
include <../../../models/nodes_and_edges.scad>
include <../../../models/model_esp32_devkit_v1.scad>
include <toggle_switch.scad>

$fn=64;

models=1;

esp32_holes = [
    [0, 0, 0], // 0
    [930, 0, 0], // 1
    [0, -1840, 0], // 2
    [930, -1840, 0], // 3
];
 
esp32_nodes = [
   [930/2, 0, 0], // 4
   [930/2, -1840, 0], // 5
];
 
esp32_edges = [
    [0,4],
    [2,5],
    [4,1,5],
    [5,3]
];

mcp23017_holes = [
    [0, 0, 0], // 1
    [1750, 0, 0], // 2
    [0, -1550, 0], // 3
    [1750, -1550, 0], // 3
];

mcp23017_nodes= [];

mcp23017_edges = [
    [0, 1, 2],
    [1, 3],
    [2, 3],
];

// module modname(anchor=CENTER,spin=0,orient=UP)
// {
//     module modname_()
//     {
//     }
//     attachable(anchor,spin,orient,size=)
//     {
//         modname_();
//         children();
//     }
// }

module model_mcp23017(anchor=CENTER,spin=0,orient=UP)
{
    module model_mcp23017_()
    {
        rmtag="rrr351q";
        diff(rmtag)
        cuboid([1900, 1750, 63], rounding=50, edges="Z")
        {
            tag(rmtag) position(TOP) up(1) grid_copies(size=[1750, 1550],n=2) cyl(d=80, h=65, anchor=TOP);
            position(TOP) cuboid([1380, 330, 150], anchor=BOT);
        }
    }
    attachable(anchor,spin,orient,size=[1900, 1750, 63+150])
    {
        model_mcp23017_();
        children();
    }
}

module bottom_panel(anchor=CENTER,spin=0,orient=UP)
{
    module bottom_panel_()
    {
        rmtag="rvrt3q142";
        diff(rmtag)
        {
            cuboid([3300, 4300, 100], edges="Z", rounding=100)
            tag(rmtag) down(1)
            {
                offset = 182/2+20;
                // Mounting esp32_holes - Left
                translate([offset, -offset, 0]) position(BOT+BACK+LEFT) cyl(d=200, h=51, anchor=BOT)
                position(TOP) down(1) cyl(d=100,h=52,anchor=BOT);
                translate([offset, offset, 0]) position(BOT+FRONT+LEFT) cyl(d=200, h=51, anchor=BOT)
                position(TOP) down(1) cyl(d=100,h=52,anchor=BOT);

                // Mounting esp32_holes - Right
                translate([-offset, -offset, 0]) position(BOT+BACK+RIGHT) cyl(d=200, h=51, anchor=BOT)
                position(TOP) down(1) cyl(d=100,h=52,anchor=BOT);
                translate([-offset, offset, 0]) position(BOT+FRONT+RIGHT) cyl(d=200, h=51, anchor=BOT)
                position(TOP) down(1) cyl(d=100,h=52,anchor=BOT);

                // Mounting esp32_holes - Center
                *translate([200, -offset, 0]) position(TOP+BACK) cyl(d=200, h=51, anchor=TOP)
                position(BOT) up(1) cyl(d=100,h=52,anchor=TOP);
                *translate([200, offset, 0]) position(TOP+FRONT) cyl(d=200, h=51, anchor=TOP)
                position(BOT) up(1) cyl(d=100,h=52,anchor=TOP);
            }
            // ESP32 Mount
            position(TOP+FRONT) back(150) 
            spacer(holes=esp32_holes,nodes=esp32_nodes,edges=esp32_edges, anchor=BOT+FRONT, upper_space=50)
            if (models)
            {
                position(TOP) up(50) model_esp32_devkit_v1(anchor=BOT, spin=90);
            }
            // MCP23017 Mount
            position(TOP+BACK) fwd(500) 
            spacer(holes=mcp23017_holes,nodes=mcp23017_nodes,edges=mcp23017_edges, anchor=BOT+BACK, upper_space=50)
            if (models)
            {
                recolor("grey")
                position(TOP) model_mcp23017(anchor=BOT);
            }
        }
    }
    attachable(anchor,spin,orient,size=[3300, 4300, 100])
    {
        bottom_panel_();
        children();
    }
}


module switch_box(anchor=CENTER,spin=0,orient=UP)
{
    module switch_box_()
    {
        rmtag="rv125";
        diff(rmtag)
        {
            cuboid([3300, 4300, 100], edges="Z", rounding=100)
            {
                // Switch Cutouts
                tag(rmtag) position(TOP) up(1)
                {
                    grid_copies(n=[3,3], spacing=[1000,1300]) 
                    {
                        cuboid([470, 1080, 110], anchor=TOP);
                        if (models)
                        {
                            tag("norm") down(300) recolor("cornflowerblue") toggle_switch();
                        }
                    }
                }
                %position(BOT) rect_tube(size=[3300, 4300], rounding=100, wall=100, h=1316, anchor=TOP)
                {
                    position(RIGHT+BOT) orient(anchor=RIGHT) 
                        knuckle_hinge(length=1000, segs=5, offset=300, arm_height=100,
                        pin_diam=200, knuckle_diam=400,anchor=BACK+BOT,spin=180);
                    offset = 182/2+20;
                    *tag(rmtag) left(200) position(TOP+RIGHT) cuboid([1500, 1980, 826], anchor=TOP+RIGHT);
                    // Mounting esp32_holes - Left
                    translate([offset, -offset, 0]) position(TOP+BACK+LEFT) cyl(d=182, h=816, anchor=TOP)
                    tag(rmtag) position(TOP) cyl(d=82, h=826, anchor=TOP);
                    translate([offset, offset, 0]) position(TOP+FRONT+LEFT) cyl(d=182, h=816, anchor=TOP)
                    tag(rmtag) position(TOP) cyl(d=82, h=826, anchor=TOP);

                    // Mounting esp32_holes - Right
                    translate([-offset, -offset, 0]) position(TOP+BACK+RIGHT) cyl(d=182, h=816, anchor=TOP)
                    tag(rmtag) position(TOP) cyl(d=82, h=826, anchor=TOP);
                    translate([-offset, offset, 0]) position(TOP+FRONT+RIGHT) cyl(d=182, h=816, anchor=TOP)
                    tag(rmtag) position(TOP) cyl(d=82, h=826, anchor=TOP);

                    // Mounting esp32_holes - Center
                    *translate([200, -offset, 0]) position(TOP+BACK) cyl(d=182, h=816, anchor=TOP)
                    tag(rmtag) position(TOP) cyl(d=82, h=826, anchor=TOP);
                    *translate([200, offset, 0]) position(TOP+FRONT) cyl(d=182, h=816, anchor=TOP)
                    tag(rmtag) position(TOP) cyl(d=82, h=826, anchor=TOP);
                }
            }
        }
    }
    attachable(anchor,spin,orient,size=[3300, 4300, 1416])
    {
        down(50) up(916/2)
        switch_box_();
        children();
    }
}


module forViewing()
{
    *switch_box()
    down(300)
     position(BOT) bottom_panel(anchor=TOP);
    toggle_switch();
}

module forPrinting()
{
//    switch_box();
    bottom_panel();
}

scale(ViewScale)
{
    forViewing();
//    forPrinting();
}
